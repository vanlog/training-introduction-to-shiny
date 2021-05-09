library(shinydashboard)
library(readr)
library(ggplot2)
library(dplyr)
library(futile.logger)
library(DT)

flog.info("Loading data...")

# df <- read_csv("../data/marvel-vs-dc.csv") %>%
#   mutate(Company = factor(Company),
#          Release = as.integer(Release),
#          Id = as.integer(Id),
#          Metascore = as.integer(Metascore))
