# Definition Of Done

For substantive book work:

1. Confirm source files changed where intended.
2. Preserve chunk labels, captions, citations, and relative paths.
3. If a production-data interface changed, confirm its owning build command,
   unit, and intended use are current in `data_construction/README.md`.
4. For a new or substantially revised figure or table, confirm it uses
   registered production data whenever reasonably possible and documents any
   exception.
5. Run the owning data-build command and inspect its row, key, and merge
   checks.
6. If render dependencies are uncertain, run the repo's dependency checker.
7. Render with the included render script for the user's platform.
8. Check `output/book.pdf` or `output/index.html`.
9. Check generated maps in `book/_reports/`. Confirm they include the expected figure/table numbers, owners, labels, captions, and source paths.
10. Check for accidental debug output and for observations hidden by display
    choices or stale output.
11. Report what changed and whether the data build and render verification
    passed.
