# R files to run DuneFront WP4.2 models

This folder contains the code (in R/ [Quarto](https://quarto.org/) format) needed to go from the files in `data` to the outputs and plots shown and discussed in the deliverable report, including the species maps. Files starting with `01` refer to the Bayesian Additive Regression Tree models, files starting with `02` to the occupancy models (see deliverable report for details). `select_pseudo_absences_USE` is a custom-made function used in BART models.

- `01-BART_SDMs.qmd`: contains code to generate BART SDMs along with their performance metrics, and to convert them into species-specific suitability maps for present and future conditions (the latter with caveats expressed in the deliverable report);

- `01b-BART_making_no-analog_maps.qmd`: code to generate no-analog maps, i.e. maps pointing out where future climatic conditions are expected to be beyond the range observed in present-day data;

- `01c-BART-plots.qmd`: code to generate, using the BART models in `output`, the corresponding non-map plots in the deliverable report;

- `02-occdet_SDMs.qmd`: code to create occupancy models investigating the responses of the focal species to urbanization

- `02b-occdet_plots.qmd`: code to generate, using the BART models in `output`, the corresponding non-map plots in the deliverable report;

- `select_pseudo_absences_USE.R`: A custom-made function used in `01-BART_SDMs.qmd` to streamline the selection of pseudo-absences