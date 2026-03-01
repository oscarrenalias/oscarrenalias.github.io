# CV Rendering with Quarto

Source file: `content/cv/cv.qmd`

## Hugo-integrated output

To have `/cv` rendered with your Hugo layout and styles, generate markdown from the Quarto source into `content/cv/index.md`.

Run from repo root:

```bash
# Generate Hugo page content from Quarto source
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
```

## Downloadable artifacts

```bash
# Word download
quarto render content/cv/cv.qmd --to docx --output oscar-renalias-cv.docx
mkdir -p static/cv
mv oscar-renalias-cv.docx static/cv/oscar-renalias-cv.docx

# PDF download generated from the Word output
soffice --headless --convert-to pdf --outdir static/cv static/cv/oscar-renalias-cv.docx
```
