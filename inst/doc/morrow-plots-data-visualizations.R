## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error = TRUE
)

## ----setup, include=FALSE-----------------------------------------------------
library(morrowplots)
library(dplyr)
library(ggplot2)

## ----preview------------------------------------------------------------------
head(morrowplots)

## ----subset-------------------------------------------------------------------
## name the new dataset mp corn for morrow plots corn
mpcorn <- 
  
  ## filter to only include rows where corn is TRUE and 'yield_bush' is not 'NA'
  dplyr::filter(morrowplots, corn == TRUE, !is.na(yield_bush))  %>% 
  
  ## change 'rotation' data type from double to factor
  dplyr::mutate(rotation = as.factor(rotation))

head(mpcorn)

## ----mpcorn smooth, fig.width=7, fig.height=4---------------------------------

## create a smooth line plot with 'year' on the x axis and 'yield_bush' on the y axis
## color code the lines by 'rotation'
## use line type to differentiate between treated and untreated corn
ggplot2::ggplot(data = mpcorn) +
  ggplot2::geom_smooth(ggplot2::aes(x= year, y = yield_bush, color = rotation, linetype = treated))+

  ## add title and subtitle
  ggplot2::labs(title = "Morrow Plots Corn Yield Trends in Bushels per Acre",
       subtitle = "Treated vs. untreated and by number of crops in rotation")+
  
  ## add one of the built-in themes
  ggplot2::theme_light()

## ----plot, fig.width=7, fig.height=6------------------------------------------

## create a faceted scatter plot with 'year' on the x axis and 'yield_bush' on the y axis
## color code by 'treated'
ggplot2::ggplot(data = mpcorn)+
  ggplot2::geom_point(ggplot2::aes(x= year, y = yield_bush, color = treated))+
  
  ## create a grid of related plots with facet_wrap
  ggplot2::facet_wrap(vars(plot_num), ncol = 1)+
  
  ## add title and subtitle
  ggplot2::labs(title = "Morrow Plots Corn Yields in Bushels per Acre",
       subtitle = "Treated vs. untreated by plot")+
  
  ## add one of the built-in themes
  ggplot2::theme_light()

## ----subplot treated, fig.width=7, fig.height=4-------------------------------
## create a faceted scatter plot with 'year' on the x axis and 'yield_bush' on the y axis
## color code by 'treated'
ggplot2::ggplot(data = dplyr::filter(mpcorn, plot_num == 5))+
  ggplot2::geom_point(ggplot2::aes(x= year, y = yield_bush, color = treated))+
  
  ## create a grid of related plots with facet_wrap
  ggplot2::facet_wrap(vars(plot), ncol = 4)+
  
  ## add title and subtitle
  ggplot2::labs(title = "Morrow Plots Corn Yields in Bushels per Acre",
       subtitle = "Plot 5 treated vs. untreated by subplot")+
  
  ## add one of the built-in themes
  ggplot2::theme_light()


## ----subplot treatment, fig.width=7, fig.height=4-----------------------------
## create a faceted scatter plot with 'year' on the x axis and 'yield_bush' on the y axis
## color code the lines by 'treated'
ggplot(data = filter(mpcorn, plot_num == 5)) +
  geom_point (aes(x= year, y = yield_bush, color = treatment)) +
  
  ## create a grid of related plots with facet_wrap
  facet_wrap(vars(plot), ncol = 4) +
  
  ## add title and subtitle
  ggplot2::labs(title = "Morrow Plots Corn Yields in Bushels per Acre",
       subtitle = "Plot 5 by subplot and treatment")+
  
  ## add one of the built-in themes
  ggplot2::theme_light()

