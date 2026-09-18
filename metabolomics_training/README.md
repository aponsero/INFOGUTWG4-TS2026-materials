# Introduction to Metabolomics Data

This repository contains the slides, detailed session guide and demonstration data for a 70-minute introductory metabolomics session.

## Repository contents

- `index.qmd`: landing page for participants
- `slides/metabolomics_introduction.qmd`: 20-slide Reveal.js presentation
- `slides/custom.scss`: presentation styling
- `session/metabolomics_session_guide.qmd`: complete teaching guide
- `data/acids.csv`: targeted HPLC organic-acid dataset
- `data/data_dictionary.csv`: variable descriptions and analytical metadata

## Requirements

- Quarto
- R
- The R package `tidyverse`

Install the required R package with:

```r
install.packages("tidyverse")
```

## Render the complete project

From the repository root, run:

```bash
quarto render
```

Quarto writes the rendered website, session guide and slides to `docs/`. The `docs/` directory can be published directly with GitHub Pages.

## Before teaching

Confirm the measurement units, clarify what R1 and R2 represent, and update the data dictionary or session text accordingly.
