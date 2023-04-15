library(rmarkdown)
library(tidyverse)
library(png)
library(grid)

 
 
# R Laboratorinis darbas: duomenų vizualizacija

#| Variantas | ecoActCode |
#|------------- | ------------- |
#|20   | 11111111111 |

knitr::opts_chunk$set(echo = TRUE)

### 1. Užduotis


#Atsakymas:

img <- readPNG("img/rplot1.png")
 grid.raster(img)
 

#Išvados:

### 2. Užduotis

#Atsakymas:
img2 <- readPNG("img/rplot2.png")
 grid.raster(img2)


#Išvados:


### 3. Užduotis

#Atsakymas:

img3 <- readPNG("img/rplot3.png")
 grid.raster(img3)

#Išvados:


### 4. Užduotis

#Shiny R aplikacijos nuotrauka:

img4 <- readPNG("img/Pavyzdys.png")
 grid.raster(img4)
