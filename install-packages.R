## Create the personal library if it doesn't exist. Ignore a warning if the directory already exists.
dir.create(Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
## Install multiple packages.
install.packages(c("dplyr","jsonlite","knitr","markdown","plyr","RColorBrewer","Rcpp","reshape2","rmarkdown","scales","shiny","shinyBS","shinydashboard","stringi","stringr","tidyr","webshot","xtable","yaml","ggplot2","webshot","shinyBS","shinydashboard","plotly"), Sys.getenv("R_LIBS_USER"), repos ="http://cran.case.edu")
