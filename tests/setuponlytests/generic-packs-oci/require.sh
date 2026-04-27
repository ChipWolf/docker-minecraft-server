#!/bin/bash
# This test exercises the install-oci-pack subcommand of mc-image-helper.
# Until a release of mc-image-helper that includes the subcommand is
# pinned in the Dockerfile, the test must be opted into by pointing
# MC_HELPER_LOCAL at a locally-built distribution directory, e.g.
#
#   MC_HELPER_LOCAL=$(pwd)/../../mc-image-helper/build/install/mc-image-helper \
#     bash tests/setuponlytests/test.sh generic-packs-oci
[[ -n "${MC_HELPER_LOCAL:-}" && -d "${MC_HELPER_LOCAL}" ]]
