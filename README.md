# Renalias.net

Converting my personal site to a "positioning hub". Make it a concise, high‑signal hub for who I am, what I've done over the years, and what I'm working on at the moment.
​
Intended structure:
* Home: 1–2 paragraphs summarizing your role and focus, mirroring the refined LinkedIn headline and About narrative.
* Posts: long-form articles written by me on topics that are relevant to/based on my work, across 4 key topics:
    * AI‑driven transformation
    * Cloud‑native modernization
    * Platform engineering
    * Technology leadership
* Talks & presentations: a curated list of major talks, decks, and posts with a few lines of context for each.
* Contact & profiles: my CV, links to LinkedIn, GitHub, Slideshare

This intended structure does not necessarily imply separate top-level sections in the side, e.g., there could be a longer front page with a navigation on the side of the page that reveals the right content.

# How to build and run

Site is built on Hugo as a static site generator, deployed to GitHub pages via GitHub workflows.

## Local development

1. Install Hugo Extended (recommended via Homebrew):
   ```bash
   brew install hugo
   ```
2. Start the local dev server:
   ```bash
   hugo server -D
   ```
3. Open `http://localhost:1313`.

## Write content

- Home page: `content/_index.md`
- Articles: `content/articles/*.md`
- Talks: `content/talks/*.md`
- Contact block: `content/contact-footer.md`
- New article:
  ```bash
  hugo new articles/my-article.md
  ```

## Deploy to GitHub Pages

1. Push this repo to GitHub on branch `main`.
2. In GitHub repository settings:
   - `Settings -> Pages -> Build and deployment`
   - Source: `GitHub Actions`
3. Push to `main` to trigger `.github/workflows/hugo.yml`.

## Notes

- `hugo.toml` is set to `https://renalias.net/`; update if your final Pages/custom-domain URL differs.
- Templates are intentionally minimal and can be replaced by a theme next.
