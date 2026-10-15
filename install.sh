#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
sha256sum --check SHA256SUMS

# JitPack collects artifacts from the local Maven repository. Copying the
# already-built files avoids downloading a Maven plugin just to install them.
maven_repository="${ALIVE_REPORTER_MAVEN_REPOSITORY:-${HOME}/.m2/repository}"
artifact_directory="${maven_repository}/com/github/code-rebooter/alive-reporter-dist/1.0.1"
artifact_name='alive-reporter-dist-1.0.1'
mkdir -p -- "$artifact_directory"
cp -- alive-reporter.aar "$artifact_directory/${artifact_name}.aar"
cp -- alive-reporter.pom "$artifact_directory/${artifact_name}.pom"
