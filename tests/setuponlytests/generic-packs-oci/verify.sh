# File only in the shared base layer; presence confirms layer 1 was applied.
mc-image-helper assert fileExists config/common.properties
# File only in the per-pack overlay layer; presence confirms layer 2 was
# applied after layer 1.
mc-image-helper assert fileExists config/tech.toml
