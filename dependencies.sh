#!/usr/bin/env sh
set -eu

cd "$(dirname "$0")"
Rscript dependencies.R
