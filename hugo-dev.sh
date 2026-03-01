#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

if ! command -v quarto >/dev/null 2>&1; then
  echo "Error: quarto is required to build CV content before Hugo."
  exit 1
fi

# Prevent stale static HTML from shadowing the Hugo-rendered /cv page.
perl -e 'unlink q{static/cv/index.html};'

# Always refresh the Hugo CV page from the single-source Quarto document.
(
  cd content/cv
  quarto render cv.qmd --to gfm --output cv.generated.md
)
{
  echo '---'
  echo 'title: "Curriculum Vitae"'
  echo '---'
  echo
  echo '&#x2B07; [PDF version](/cv/oscar-renalias-cv.pdf) | [Word version](/cv/oscar-renalias-cv.docx)'
  echo
  awk 'BEGIN{removed=0} !removed && /^# / {removed=1; next} {print}' content/cv/cv.generated.md
} > content/cv/index.md
rm -f content/cv/cv.generated.md

# Optionally refresh downloadable artifacts for CV.
if [[ "${BUILD_CV_DOWNLOADS:-0}" == "1" ]]; then
  quarto render content/cv/cv.qmd --to docx --output oscar-renalias-cv.docx
  mkdir -p static/cv
  mv oscar-renalias-cv.docx static/cv/oscar-renalias-cv.docx

  if command -v soffice >/dev/null 2>&1; then
    soffice --headless --convert-to pdf --outdir static/cv static/cv/oscar-renalias-cv.docx
    if [[ -f static/cv/oscar-renalias-cv.doc.pdf && ! -f static/cv/oscar-renalias-cv.pdf ]]; then
      mv static/cv/oscar-renalias-cv.doc.pdf static/cv/oscar-renalias-cv.pdf
    fi
  else
    echo "Warning: BUILD_CV_DOWNLOADS=1 but soffice is not available; skipping PDF conversion."
  fi
fi

hugo "$@"
