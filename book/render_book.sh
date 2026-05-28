#!/usr/bin/env sh
set -u

cd "$(dirname "$0")/.."
Rscript book/render_book.R
status=$?

if [ -f "output/book.pdf" ] || [ -f "output/index.html" ]; then
  exit 0
fi

exit "$status"
