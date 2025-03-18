# Pre-processed data for DuneFront WP4.2

This folder contains the species records and site data used in DuneFront WP4.2, _after_ pre-processing to:

- select only sandy coastal sites;

- estimate relevant environmental variables at these sites;

- extract records of target species at these sandy sites, either split by day (for occupancy models) or aggregated over the entire decade (for classical SDM approaches).

The _raw_ unprocessed data are not included in this archive due to size; for an overview of the steps between raw and pre-processed data, as well as external links to access the raw data, see the associated DuneFront deliverable report.

There are four files in this folder:

- `DuneFront_WP4.2_predictors_v1.3_sandy.gpkg`: a geopackage file containing site information. Each "site" is a 1 km² grid cell from the [GHSL](https://human-settlement.emergency.copernicus.eu/) rasters, converted into polygon. Only coastal sandy polygons were kept (for how we defined "sandy" and "coastal", see deliverable report). For each polygon, a series of relevant environmental variables are included; again see deliverable report.

-  `DuneFront_WP4.2_formatted_occurrences_classicalSDM.csv`: a `csv file` containing for each sandy site (IDed by the combination of `row_index` and `col_index`, which refers to `DuneFront_WP4.2_predictors_v1.3_sandy.gpkg`) and information on whether a focal species was recorded or not during the 2015-2024 decade of interest (`[genus]_[species]` columns). Only sites in which at least one of the focal species was recorded is included. In addition of columns describing whether a focal species was recorded, the table included columns `list_length` (number of species seen at this site) and `N_observations` (number of records of any species);

-  `DuneFront_WP4.2_formatted_occurrences_occdet.csv`: similarly to the previous file, a `csv` file containing information about species occurrences. However, instead of aggregating all data across the decade, data are split so that one row = one visit (defined as all records at one site on one day). Only recorded visits are included (i.e. site-day combination with at least one record of _any_ species, not just focal). `list_length` and `N_observations` refer here to the information _per visit_,  `_alltime` variants of both are also included, which map back to the columns in `DuneFront_WP4.2_formatted_occurrences_classicalSDM.csv`;

-  `DuneFront_WP4.2_species_groups.csv`: for each of the focal species, whether they belong to one of the three broad categories mentioned in the DuneFront project submission: dune-building species, conservation interest, non-native species.

