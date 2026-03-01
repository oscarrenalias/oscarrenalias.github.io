# CV Rendering with Quarto

Source file: `content/cv/cv.qmd`

## Hugo-integrated output

To have `/cv` rendered with your Hugo layout and styles, generate markdown from the Quarto source into `content/cv/index.md`.

Run from repo root:

```bash
# Generate Hugo page content from Quarto source
quarto render content/cv/cv.qmd --to gfm -o content/cv/cv.generated.md
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
# PDF download
quarto render content/cv/cv.qmd --to pdf --output-dir static/cv --output oscar-renalias-cv.pdf

# Word download
quarto render content/cv/cv.qmd --to docx --output-dir static/cv --output oscar-renalias-cv.docx
```
