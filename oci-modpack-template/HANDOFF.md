# Handoff: fixes + additions for ChipWolf/oci-modpack-template

This folder is a **handoff bundle**, parked on a throwaway branch of the
`docker-minecraft-server` fork only because that's the one repo this
automated session can push to. It is **not** part of docker-minecraft-server
— copy these files into the real `oci-modpack-template` repo and delete this
branch.

## What's here and why

1. **CI fix (the failing `publish` workflow).** The scripts were originally
   committed through the GitHub API, which stores files as mode `100644`
   (non-executable). The workflows invoked `./scripts/…` directly, so every
   run died with "permission denied". These files invoke the scripts via
   `bash ./scripts/…` instead, which doesn't need the executable bit:
   - `.github/workflows/publish.yml`
   - `.github/workflows/test.yml`
   - `mise.toml`
   The scripts themselves are unchanged and are **not** included here.

2. **README additions.** `README.md` now has a plain-language
   "What's an OCI artifact? (60 seconds)" section with authoritative links
   (opencontainers.org + GitHub Packages docs), and embeds the three
   diagrams.

3. **Diagrams.** `docs/simple-tech-magic.svg`, `docs/layer-reuse-scales.svg`,
   `docs/zip-vs-oci.svg` — self-contained, light/dark-safe, referenced by the
   README.

## How to apply (from a clone of oci-modpack-template)

```sh
# from the root of your oci-modpack-template working copy, with this
# bundle checked out somewhere as $BUNDLE (the oci-modpack-template/ folder):
cp    "$BUNDLE/README.md" ./README.md
cp    "$BUNDLE/mise.toml" ./mise.toml
cp    "$BUNDLE/.github/workflows/publish.yml" .github/workflows/publish.yml
cp    "$BUNDLE/.github/workflows/test.yml"    .github/workflows/test.yml
mkdir -p docs && cp "$BUNDLE"/docs/*.svg docs/

# optional but recommended: make the scripts executable so `./scripts/…`
# also works locally (the bash invocation already makes CI pass regardless)
git update-index --chmod=+x scripts/build-and-push.sh scripts/verify.sh
chmod +x scripts/build-and-push.sh scripts/verify.sh

git add -A && git commit -m "ci: run scripts via bash; docs: OCI explainer + diagrams"
git push
```

Then watch the **publish** workflow go green, and (Actions → test → Run
workflow) confirm the pull/verify.

## Validation already done (locally, with real oras 1.2.2)

- `build-and-push.sh` + `verify.sh`: `shellcheck` clean; build auto-discovers
  `base` + packs and produces a single shared base layer (dedup).
- Real `oras push` → manifest has the correct `artifactType`
  (`application/vnd.itzg.minecraft.modpack.v1+json`) and layer media type
  (`…modpack.layer.v1.tar+gzip`); the shared base blob was stored once.
- Real `oras pull` → digest-matched extract placed base + overlay files
  correctly, exactly as `verify.sh` does it.
