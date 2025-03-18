prep_data_bart <- function(data,
                           Yvar, Xvars, biasvars,
                           threshold = 500, seed = 42) {
  # check if enough detections
  detections <- data |>
    dplyr::filter(!!rlang::parse_expr(Yvar) == 1) |>
    mutate(detection = 1)
  Ndetections <- dim(detections)[1]
  if (Ndetections < threshold) stop("not enough detections for this species")

  # because we're working with a very sparse 2D grid with coastlines, 
  # we cheat and "compress" it to a smaller fake raster to avoid too much NAs that slow things to a crawl
  tt <- data |>
    as_tibble() |>
    select(
      row_index, col_index,
      any_of(Yvar), any_of(Xvars), any_of(biasvars)
    ) |>
    na.omit() |>
    mutate(x = row_number(), y = 1, .before = 0) |>
    mutate(y = case_when(x > (max(x) / 2) ~ 2, TRUE ~ y))

  envData <- terra::rast(tt |> select(-c(row_index, col_index, any_of(Yvar), any_of(biasvars))), type = "xyz")

  # determining the resolution to use
  rpc <- rastPCA(envData, stand = TRUE, naMask = TRUE)
  PCA_var <- cumsum(rpc$pca$sdev^2 / sum(rpc$pca$sdev^2))

  dt <- na.omit(as.data.frame(rpc$PCs[[c("PC1", "PC2")]], xy = TRUE))
  dt <- sf::st_as_sf(dt, coords = c("PC1", "PC2"))

  myRes <- USE::optimRes(
    sdf = dt,
    grid.res = c(1:10),
    perc.thr = 20,
    showOpt = TRUE,
    cr = 5
  )

  optires_USE <- myRes$Opt_res

  # now that we have the resolution, we can start the USE procedure proper 

  myPres <- tt |>
    select(detection = any_of(Yvar), x, y) |>
    filter(detection == 1) |>
    st_as_sf(coords = c("x", "y"))

  set.seed(seed)

  myGrid.psAbs <- USE::paSampling(
    env.rast = envData,
    pres = myPres,
    thres = 0.75,
    H = NULL,
    grid.res = as.numeric(myRes$Opt_res),
    # n.tr = 5,
    prev = 1,
    sub.ts = FALSE, ## we will do the split manually because the way it decides the # of pseudo abs val does not look logical
    # no way to specify the size of the split for instance, and the training set has already all N needed
    # n.ts=5,
    plot_proc = FALSE,
    verbose = FALSE
  )

  index_Pabs_keep <- tt |>
    filter((x %in% myGrid.psAbs$x) & (y %in% myGrid.psAbs$y)) |>
    select(row_index, col_index)

  result <- tt |>
    select(detection = any_of(Yvar), any_of(Xvars), any_of(biasvars), row_index, col_index) |>
    mutate(focal_species = Yvar, .before = 0) |>
    filter(detection == 1 | paste(row_index, col_index) %in% paste(index_Pabs_keep$row_index, index_Pabs_keep$col_index))

  return(
    list(
      result = result,
      PCA_var = PCA_var
    )
  )
}
