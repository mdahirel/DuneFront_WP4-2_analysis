# BART models and evaluations

In the course of running the code in `R/`, various files will be saved here (see deliverable report for full details):

- `BART_[genus]_[species]_metrics.csv` files contain a series of performance metrics calculating on both training and testing sets, and reduced / full models, for each species (see code in `R/` and deliverable report);

- `BART_[genus]_[species]_varimp.csv` contain information about variable importance for both reduced and full models;

- `BART_[genus]_[species]_partials_reducedmodel.RDS`: saved copies of the partial plots obtained through `embarcadero` for each reduced model.