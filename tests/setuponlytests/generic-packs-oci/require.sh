#!/bin/bash
# This test exercises the install-oci-pack subcommand of mc-image-helper.
# Until that subcommand ships in an itzg/mc-image-helper release, CI skips
# this test unless MC_HELPER_LOCAL points at a local install layout, e.g.
# after building ChipWolf/mc-image-helper branch feat/install-oci-pack-oras-sdk:
#
#   (cd ../mc-image-helper && ./gradlew installDist)
#   MC_HELPER_LOCAL=$(pwd)/../../mc-image-helper/build/install/mc-image-helper \
#     bash tests/setuponlytests/test.sh generic-packs-oci
[[ -n "${MC_HELPER_LOCAL:-}" && -d "${MC_HELPER_LOCAL}" ]]
