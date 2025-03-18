# BART suitability maps

In the course of running the code in `R/01-BART_SDMs.qmd`, the deliverable maps will be saved here (see deliverable report for full details) under `DuneFront-WP4_[genus]_[species]_reduced_models.gpkg` (for reduced models) or `DuneFront-WP4_[genus]_[species]_unreduced_models.gpkg` (for full models).

These are geopackages which each contain 7 layers, named as `[genus]_[species]_[scenario]_[period]`: 

- `[scenario]` can be one of 4, `ssp126`, `ssp370`, `ssp585`(SSP1-RCP2.6, SSP3-RCP7.0, SSP5-RCP8.5), or `present`;

- `[period]` can be one of 3, `present`, `2041-2070` or `2071-2100`.

For each layer the following data columns are available:

- `species`;

- `post_mean`: posterior mean prediction at this site;

- `post_lower`: lower limit of the 95% credible interval of the prediction at this site;

- `post_upper`: upper limit of the 95% credible interval of the prediction at this site;

- `post_width`: `post_upper` - `post_lower`, width of the 95% credible interval, a measure of uncertainty;

- `threshold`: species- and model-specific values that can be used to discretize predictions into binaryh 0/1. Thresholds are taken from the `embarcadero::summary()` function and are based on (i) maximizing the True Skill Statistic (ii) on training data (iii) using only posterior means.

In addition, running `R/01b-BART_making_no-analog_maps.qmd` will save `DuneFront-WP4_no-analog_maps.gpkg` in this folder too. This geopackage contains logical columns with names structured as `no_analog_[variable]_[periodstart]_[scenario]`, where:

- `[scenario]` is as above;

- `[periodstart]` can be 2041 or 2071;

- `[variable]` one of  `any`, `tas` (average annual mean temperature), `tasmin` (average minimal temperature of coldest month), `tasmax` (average maximal temperature of warmest month) or `pr` (average annual precipitation).