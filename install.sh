#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
sha256sum --check SHA256SUMS
mvn --batch-mode org.apache.maven.plugins:maven-install-plugin:3.1.4:install-file \
  -Dfile=alive-reporter.aar \
  -DpomFile=alive-reporter.pom \
  -DgeneratePom=false
