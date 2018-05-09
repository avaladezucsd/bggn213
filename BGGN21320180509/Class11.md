---
title: "Class11"
author: "Andrew Valadez"
date: "May 9, 2018"
output: 
  html_document: 
    keep_md: yes
---



## Section11

https://bioboot.github.io/bimm143_S18/class-material/lecture11-BIMM143_S18.pdf

Q1: What proportion of PDB entries does X-ray crystallography account for? What proportion of
structures are protein?

 125421/140109
[1] 0.8951673

Q2: Type HIV in the search box on the home page and determine how many HIV-1 protease
structures are in the current PDB?

118 Protease structures


oh look it has a csv file

```r
p <- read.csv("Data Export Summary.csv", row.names = 1)
```
now lets get do the math with the csv data

```r
percent <- (p$Total/ sum(p$Total)) * 100
names(percent) <-  row.names(p)
percent
```

```
##               X-Ray                 NMR Electron Microscopy 
##         89.51673340          8.71321614          1.51239392 
##               Other        Multi Method 
##          0.16986775          0.08778879
```




