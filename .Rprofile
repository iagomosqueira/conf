.libPaths(Sys.getenv("R_LIBS_USER"))

Sys.setenv(LANG="en_GB.UTF-8")
Sys.setenv(LC_ALL="en_GB.UTF-8")
Sys.setenv(R_KEEP_PKG_SOURCE="yes") 
Sys.setenv(R_COMPILE_PKGS=3) 
Sys.setenv(R_ENABLE_JIT=3) 
Sys.setenv('_R_CHECK_SYSTEM_CLOCK_' = 0)

options(Ncpus = 3)

options(future.rng.onMisuse = "ignore")

# REBUILD pkg library {{{
.mysetup <- function(...) {

options(repos=structure(c(CRAN="https://cloud.r-project.org/",
  FLR="https://flr.r-universe.dev")))

  # CRAN

  pkgs <- c("Rcpp", "devtools", "ggplot2", "data.table", "knitr", "rmarkdown",
    "testthat", "doParallel", "TMB", "RcppArmadillo", "patchwork", "bookdown",
    "ropenblas")

  install.packages(pkgs)

  # FLR

  install.packages(c("FLCore", "FLFishery", "ggplotFL", "FLasher", "FLBRP",
    "FLSRTMB", "a4adiags", "bbm", "FLa4a", "FLife", "FLXSA"))

  # GITHUB

  remotes::install_github(c("r4ss/r4ss", "jalvesaq/colorout"))

  remotes::install_github(paste("jabbamodel",
    c("JABBA", "ss3diags"), sep="/"))
  
  remotes::install_github(paste("Henning-Winker",
    c("JARA", "FLRef", "SPMpriors"), sep="/"))
} # }}}

# Test whether running under RStudio 
.isRStudio <- Sys.getenv("RSTUDIO") == "1"

# pkgs for r-vim {{{
if(interactive() & !.isRStudio) {
  suppressMessages(require(colorout))
    colorout::setOutputColors(stderror = 7, verbose=FALSE)
    colorout::setOutputColors256(stderror = 7, verbose=FALSE)
  suppressMessages(require(devtools))
  suppressMessages(require(ropenblas))
  suppressMessages(require(rmarkdown))
  suppressPackageStartupMessages(require(utils))
  suppressPackageStartupMessages(require(data.table))
  suppressPackageStartupMessages(require(TAF))

  # Invisible environment for functions
  .env <- new.env()

  #
  Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS="TRUE")

  # Aliases
  .env$su <- summary
  .env$he <- utils::head
  .env$lib <- base::library
  .env$un <- base::unique
  .env$DT <- data.table::data.table

  # Load into lost
  .env$lload <- function(file) {
    return(mget(load(file)))
  }

  # pushend
  .env$pushend <- function(msg) 
    pushoverr::pushover(paste(mnasg, Sys.time(), sep= " - "))

  # List objects and classes
  .env$lsa <- function() {
    obj_type <- function(x) class(get(x, envir = .GlobalEnv))
    foo = data.frame(sapply(ls(envir = .GlobalEnv), obj_type))
    if(length(foo) == 0)
      return(character(0))
    foo$object_name = rownames(foo)
    names(foo)[1] = "class"
    names(foo)[2] = "object"
    rownames(foo) <- NULL
    return(foo)
}

# List all functions in a package
.env$lsp <-function(package, all.names = FALSE, pattern) {
    package <- deparse(substitute(package))
    ls(
        pos = paste("package", package, sep = ":"),
        all.names = all.names,
        pattern = pattern
    )
}

# load echoes names of objects
  .env$load <- function (file, envir = parent.frame(), verbose = TRUE) {

    res <- base::load(file=file, envir=envir, verbose=verbose)
    if(verbose)
      message("Objects loaded: ", paste0(res, collapse=" "), "\n")
    invisible(res)
  }

# echo keywords
.env$keywords <- function()
  cat(readLines(file.path(R.home("doc"), "KEYWORDS")), sep = "\n")

# mpng
.env$mpng <- function(file, plot, width=1600, height=1400, res=200) {

  png(file=file, type="cairo", width=width, height=height, res=res)
  print(plot)
  dev.off()
invisible(TRUE)
}

# ht (head + tail)
.env$ht <- function(x) {
  print(head(x, 5))
  cat("-----\n")
  print(tail(x, 5))
}

.env$h <- head
.env$u <- unique

# RUN R code in Rmd
.env$chunks <- function(doc) {
  rfile <- tempfile()
  on.exit(unlink(rfile))
  knitr::purl(doc, output=rfile)
  sys.source(rfile, envir=globalenv())
}

# plot include_graphics image
.env$print.knit_image_paths <- function(x) {
  # TODO: Handle multiples figures
  grid::grid.newpage()
  grid::grid.raster(png::readPNG(x))
}

.env$s4trace <- function(method, signature)
  trace(method, browser, exit=browser, signature=signature)

.env$unstrace <- function(method, signature)
  untrace(method, signature=signature)

.env$setdebug <- function() {
  handlers(global=FALSE)
  plan(sequential)
}

.env$viewxl <- function(.data){
  if(interactive()){
    tmp <- tempfile(fileext = ".csv")
    data.table::fwrite(.data, tmp)
    browseURL(tmp, browser = "localc")
  }
}

# httpgd
.env$explore <- function() {
  
  suppressMessages(library(httpgd))
  suppressMessages(hgd())
  hgd_browse(browser=paste0('chromium --window-size=800,600 --window-position="2,2" --app=', hgd_url()))
}

# Attach env
suppressMessages(attach(.env))

# ECHO getwd
message("pwd: ", getwd())

# ECHO getwd
message("tmp: ", tempdir())

# ECHO pid
message("pid: ", Sys.getpid())

# own ggplot theme
.my_theme <- ggplot2::theme_light() + ggplot2::theme(
  # strip TEXT black
  strip.text = ggplot2::element_text(colour="black"),
  # strip FILL gray90
  strip.background = ggplot2::element_rect(fill="gray90"),
  # LEGEND at bottom
  legend.position="bottom",
  # plot MARGINS
  plot.margin = ggplot2::margin(6, 12, 6, 6, "pt")
  )

# ggplot default theme
ggplot2::theme_set(.my_theme)

} # }}}

# DEFAULT progressr handler

if (interactive() && requireNamespace("progressr", quietly = TRUE)) {
  ## Enable global progression updates
  if (getRversion() >= "4.0.0") progressr::handlers(global = TRUE)
 
  ## In RStudio Console, or not?
  if (Sys.getenv("RSTUDIO") == "1" && !nzchar(Sys.getenv("RSTUDIO_TERM"))) {
    options(progressr.handlers = progressr::handler_rstudio)
  } else {
    options(progressr.handlers = progressr::handler_progress)
  }
}
 
# better error traceback
# https://renkun.me/2020/03/31/a-simple-way-to-show-stack-trace-on-error-in-r/
options(error = function() {
  calls <- sys.calls()
  if (length(calls) >= 2L) {
    sink(stderr())
    on.exit(sink(NULL))
    cat("Backtrace:\n")
    calls <- rev(calls[-length(calls)])
    for (i in seq_along(calls)) {
      cat(i, ": ", deparse(calls[[i]], nlines = 1L), "\n", sep = "")
    }
  }
  if (!interactive()) {
    q(status = 1)
  }
})

options(error=quote(dump.frames("testdump", TRUE)))
options(error=NULL)

# History
if (interactive()) {
  .Last <- function() try(savehistory("~/.Rhistory"))
}

# CRAN
options(repos=structure(c(CRAN="https://cloud.r-project.org/",
  FLR="https://flr.r-universe.dev")))

# A4
options(papersize = "a4")

# tab
options(tab.width = 2)

# width
options(width = 80)

# deparse
options(deparse.max.lines = 2)

# prompt
options(prompt="> ", digits=4, show.signif.stars=FALSE)

# help in vim
options(pager = "vimpager")

# editor
options(editor="neovim")

# max.print
# options(max.print = 220)

# devtools options
options(devtools.name = "Iago Mosqueira", 
        devtools.desc.author = "person('Iago', 'Mosqueira',
          email='iago@mosqueira.eu', role = c('aut', 'cre'))",
        devtools.desc.license = "EUPL")

# rmarkdown
options(rmarkdown.html_vignette.check_title = FALSE)

# ICES SAG token
cat("# Standard Graphs personal access token",
  "03736615-3d7a-47f7-8862-04b6cd7edb25",
  sep = "\n",
  file = "~/.Renviron_SG")

# codecov.io token
# 46313f68-8723-40a6-b0e4-063f95c0945a
Sys.setenv(CODECOV_TOKEN = "46313f68-8723-40a6-b0e4-063f95c0945a")

# SETUP

# sudo apt install libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev

if (interactive()) {
  invisible(addTaskCallback(local({
    last <- .GlobalEnv$.Random.seed
    
    function(...) {
      curr <- .GlobalEnv$.Random.seed
      if (!identical(curr, last)) {
        msg <- "TRACKER: .Random.seed changed"
        if (requireNamespace("crayon", quietly=TRUE)) msg <- crayon::blurred(msg)
        message(msg)
        last <<- curr
      }
      TRUE
    }
  }), name = "RNG tracker"))
}

#
options(nvimcom.verbose = 0)
