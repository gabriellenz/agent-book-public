"""Create a small Markdown inventory of PDFs in book/literature.

This helper intentionally does not extract full PDF text. Its job is to help an
agent decide what to inspect next without filling the context window.
"""

from __future__ import annotations

import datetime as _dt
from pathlib import Path


def main() -> None:
    script = Path(__file__).resolve()
    book_root = script.parents[1]
    lit_dir = book_root / "literature"
    out_path = lit_dir / "inventory.md"

    pdfs = sorted(lit_dir.glob("*.pdf"))
    lines = [
        "# Literature Inventory",
        "",
        f"Generated: {_dt.date.today().isoformat()}",
        "",
        "| PDF | Size KB | Note file |",
        "| --- | ---: | --- |",
    ]

    if not pdfs:
        lines.append("| _No PDFs found_ |  |  |")
    else:
        for pdf in pdfs:
            note = pdf.with_suffix(".md")
            note_text = note.name if note.exists() else ""
            size_kb = round(pdf.stat().st_size / 1024)
            lines.append(f"| `{pdf.name}` | {size_kb} | `{note_text}` |")

    out_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Wrote {out_path}")


if __name__ == "__main__":
    main()
