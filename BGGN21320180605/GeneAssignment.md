---
title: "GeneAssignment"
author: "Andrew Valadez"
date: "June 5, 2018"
output: 
  html_document: 
    keep_md: yes
---



#Question 7



```r
library(bio3d)
```




```r
degus <- read.fasta("data/talin1degus.fasta")
homosapian <- read.fasta("data/talin1homosapian.fasta")
mouse <- read.fasta("data/talin1mouse.fasta.txt")
nakedmolerat <- read.fasta("data/talin1nakedmolerat.fasta")
novelrat <- read.fasta("data/talin1novelrat.fasta")
spalax <- read.fasta("data/talin1spalax.fasta")
squirrel <- read.fasta("data/talin1squirrel.fasta.txt")
```


```r
combinedfastas <- seqbind(novelrat,homosapian,degus,nakedmolerat,mouse,spalax , squirrel)
```


```r
alignedseqs <- seqaln(aln = combinedfastas$ali, exefile = "muscle.exe", outfile = "alignedfile.fa", protein = TRUE)
```


```r
try2 <- read.fasta("alignedfile.fa")
```


```r
dim(try2$ali)
```

```
## [1]    7 2559
```


```r
try2score <- seqidentity(try2$ali)
```


```r
heatmap(try2score)
```

![](GeneAssignment_files/figure-html/unnamed-chunk-8-1.png)<!-- -->
