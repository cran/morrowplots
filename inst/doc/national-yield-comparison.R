## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error = TRUE
)

## ----setup, message=FALSE-----------------------------------------------------
library(morrowplots)
library(dplyr)
library(ggplot2)

## -----------------------------------------------------------------------------
head(morrowplots)

## ----subset-------------------------------------------------------------------
## name the new dataset mp3 for plot 3
mp3 <- 
  
  ## filter to only include rows where 'plot_num' is 3 and 'yield_bush' is not 'NA'
  dplyr::filter(morrowplots, plot_num == 3, !is.na(yield_bush))  %>% 

  ## condense the filtered data and group it first by 'year' and then by 'treated'
  dplyr::group_by(year, treated) %>% 

  ## calculate the average 'yield_bush' for each grouping
  ## and put that average in a new field called 'mp_ave'
  dplyr::summarise(mp_ave = mean(yield_bush))

head(mp3)

## ----mp3 line, fig.width=7----------------------------------------------------

ggplot2::ggplot(data = mp3) +
  ggplot2::geom_line(ggplot2::aes(x= year, y = mp_ave, color = treated))

## ----mp3 smooth, fig.width=7--------------------------------------------------

ggplot2::ggplot(data = mp3) +
  ggplot2::geom_smooth(ggplot2::aes(x= year, y = mp_ave, color = treated))

## ----get NASS data from github------------------------------------------------

## If you chose Option 1: Download NASS data yourself, replace the URL with your file name, and path if necessary
NASS <- read.csv("https://github.com/SandiCal/morrowplots/raw/main/vignettes/NASS_data.csv")


## ----add NASS-----------------------------------------------------------------

## remove everything from NASS except 'Year' and 'Value'
NASS <- dplyr::select(NASS, year = Year, nat_ave = Value)

## join mp3 and NASS data by 'year'
mp3_NASS <-
  mp3 %>% 
  dplyr::left_join(NASS, by = "year")

head(mp3_NASS)

## ----plot both, fig.width=7---------------------------------------------------

ggplot2::ggplot(data = mp3_NASS) +
  
  ## mp_ave color coded by 'treated'
  ggplot2::geom_smooth(ggplot2::aes(x= year, y = mp_ave, color = treated))+
  
  ## add nat_ave as a dashed black line in the same graph
  ggplot2::geom_smooth(ggplot2::aes(x= year, y = nat_ave), linetype = "dashed", color = "black")+
  
  ## add title and subtitle
  ggplot2::labs(title = "Morrow Plots Continuous Corn Yield Trends in Bushels per Acre",
       subtitle = "Compared to the U.S. national average (dashed line)"
       )+
  
  ## add one of the built-in themes
  ggplot2::theme_light()
  

