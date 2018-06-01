---
title: "Lecture18"
author: "Andrew Valadez"
date: "June 1, 2018"
output: 
  html_document: 
    keep_md: yes
---



##Section 1. Exploring the GDC online
Visit the NCI-GDC web portal and enter p53 into the search box.

Q1. How many Cases (i.e. patient samples) have been found to have p53 mutations?
4008

Q2. What are the top 6 misssense mutations found in this gene? 
HINT: Scroll down to the ‘TP53 - Protein’ section and mouse over the displayed plot. For example R175H is found in 156 cases.

chr17:g.7675088C>T	Substitution	Missense TP53 R175H	156 / 4,008
3.89%	
156 / 10,202
MO
TO
BE
	chr17:g.7673803G>A	Substitution	Missense TP53 R273C	125 / 4,008
3.12%	
125 / 10,202
MO
DH
PR
	chr17:g.7674220C>T	Substitution	Missense TP53 R248Q	121 / 4,008
3.02%	
121 / 10,202
MO
DH
PR
	chr17:g.7673802C>T	Substitution	Missense TP53 R273H	99 / 4,008
2.47%	
99 / 10,202
MO
TO
PO
	chr17:g.7674221G>A	Substitution	Missense TP53 R248W	90 / 4,008
2.25%	
90 / 10,202
MO
DH
PR
	chr17:g.7673776G>A	Substitution	Missense TP53 R282W	87 / 4,008
2.17%	
87 / 10,202


Q3. Which domain of the protein (as annotated by PFAM) do these mutations reside in?
PF00870 in the DNA binding domain

Q4. What are the top 6 primary sites (i.e. cancer locations such as Lung, Brain, etc.) with p53 mutations and how many primary sites have p53 mutations been found in? 
HINT: Clicking on the number links in the Cancer Distribution section will take you to a summary of available data accross cases, genes, and mutations for p53. Looking at the cases data will give you a ranked listing of primary sites.
Uterine, ovarian, lung, esophageal, rectum, head and neck squamous


Return to the NCI-GDC homepage and using a similar search and explore strategy answer the following questions:

Q5. What is the most frequentely mutated position associated with cancer in the KRas protein (i.e. the amino acid with the most mutations)?
Substitution	Missense KRAS G12D

Q6. Are KRas mutations common in Pancreatic Adenocarcinoma (i.e. is the Pancreas a common ‘primary site’ for KRas mutations?).
Yes ~75%

Q6. What is the ‘TGCA project’ with the most KRas mutations?
TCGA-LUAD	Lung Adenocarcinoma	Lung	158 / 567 (27.87%

Q7. What precent of cases for this ‘TGCA project’ have KRas mutations and what precent of cases have p53 mutations? 
HINT: Placing your mouse over the project bar in the Cancer Distribution panel will bring up a tooltip with useful summary data.
P53: 	Lung	299 / 567 (52.73%)	
KRas: 	Lung	158 / 567 (27.87%)	

Q8. How many TGCA Pancreatic Adenocarcinoma cases (i.e. patients from the TCGA-PAAD project) have RNA-Seq data available?
185 Cases with 740 files

By now it should be clear that the NCI-GDC is a rich source of both genomic and clinical data for a wide range of cancers. For example, at the time of writing there are 4,434 files associated with Pancreatic Adenocarcinoma and 11,824 for Colon Adenocarcinoma. These include RNA-Seq, WXS (whole exome sequencing), Methylation and Genotyping arrays as well as well as rich metadata associated with each case, file and biospecimen.




##Section 2. The GenomicDataCommons R package


```r
#source("https://bioconductor.org/biocLite.R")
#biocLite("GenomicDataCommons")
```


```r
#biocLite("maftools")
```


```r
library(GenomicDataCommons)
```

```
## Loading required package: magrittr
```

```
## 
## Attaching package: 'GenomicDataCommons'
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```r
library(maftools)
```

Now lets check on GDC status:

```r
GenomicDataCommons::status()
```

```
## $commit
## [1] "53012d00624a8dcf06b6ad47c31b51017094f517"
## 
## $data_release
## [1] "Data Release 11.0 - May 21, 2018"
## 
## $status
## [1] "OK"
## 
## $tag
## [1] "1.14.1"
## 
## $version
## [1] 1
```

##Section 3. Querying the GDC from R

We will typically start our interaction with the GDC by searching the resource to find data that we are interested in investigating further. In GDC speak is is called “Querying GDC metadata”. Metadata here refers to the extra descriptive information associated with the actual patient data (i.e. ‘cases’) in the GDC.

For example: Our query might be ‘find how many patients were studied for each major project’ or ‘find and download all gene expression quantification data files for all pancreatic cancer patients’. We will answer both of these questions below.

The are four main sets of metadata that we can query with this package, namely cases(), projects(), files(), and annotations(). We will start with cases() and use an example from the package associated publication to answer our first question above (i.e. find the number of cases/patients across different projects within the GDC):



```r
#cases_by_project <- cases() %>%
 # facet("project.project_id") %>%
#  aggregations()
#head(cases_by_project)
```


```r
#xplot <- cases_by_project$project.project_id$key
#yplot <- cases_by_project$project.project_id$doc_count
#mycol <- rep.int("lightblue",length(xplot))
#ind <- match("TCGA-PAAD",xplot)
#prob easieer to remember this instead of match
#which(xplot=="TCGA-PAAD")
#mycol[ind] <- "red"

#par(mar=c(7.5,4,1.26,0))
#barplot(yplot, names.arg = xplot, log = "y", ylim=c(2,10000), col=mycol, las=2)
```

Continue Rest here
https://bioboot.github.io/bggn213_S18/class-material/lecture18_part1_BGGN213_S18/

##BGGN-213, Lecture 18 (Part 2)
Designing a personalized cancer vaccine

Notes: To identify somatic mutations in a tumor, DNA from the tumor is sequenced and compared to DNA from normal tissue in the same individual using variant calling algorithms.

Comparison of tumor sequences to those from normal tissue (rather than ‘the human genome’) is important to ensure that the detected differences are not germline mutations.

To identify which of the somatic mutations leads to the production of aberrant proteins, the location of the mutation in the genome is inspected to identify non-synonymous mutations (i.e. those that fall into protein coding regions and change the encoded amino acid).

##Section 1. Protein sequences from healthy and tumor tissue

The following sequences resulted from such an NGS analysis of patient healthy and tumor tissue. You can also download these sequences (namedP53_wt and P53_mutant) as the following FASTA format sequence file lecture18_sequences.fa.



```r
library(bio3d)
```



```r
seqs <- read.fasta("lecture18_sequences (1).fa")
```

So we read the sequences 
Then we want to align them and see which of these are different in the mutant 



```r
#3try <- seqaln(seqs)
#try$call
```


```r
#biocLite("msa")
```


```r
#library(msa)
```



```r
##alignmaybe <- msa("lecture18_sequences (1).fa", type = "protein")
#alignmaybe
```



```r
#msaPrettyPrint(alignmaybe, output="asis", y=c(164, 213),
#subset=c(1:2), showNames="none", showLogo="none",
#consensusColor="ColdHot", showLegend=FALSE,
#askForOverwrite=FALSE)
```



```r
#source("https://bioconductor.org/biocLite.R")
#biocLite("Biostrings")
```


```r
#library(Biostrings)
```




```r
#protein = readDNAStringSet("lecture18_sequences (1).fa")
#stringDist(dna, method="hamming")
```


```r
matseq <- conserv(seqs)
```


```r
mutationpoints <- which(matseq<1)
mutationpoints
```

```
##   [1]  41  65 213 259 260 261 262 263 264 265 266 267 268 269 270 271 272
##  [18] 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289
##  [35] 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306
##  [52] 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323
##  [69] 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340
##  [86] 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357
## [103] 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374
## [120] 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391
## [137] 392 393
```

```r
gaps <- gap.inspect(seqs)
mutationpoints <- mutationpoints[mutationpoints %in% gaps$f.inds]
```


```r
seqs$ali[mutationpoints]
```

```
## [1] "D" "S" "Y" "L"
```


```r
## Make a "names" label for our output sequences (one per mutant)
mutant.names <- paste0(seqs$ali["P53_wt",mutationpoints],
                       mutationpoints,
                       seqs$ali["P53_mutant",mutationpoints])

mutant.names
```

```
## [1] "D41L"  "R65W"  "R213V" "D259V"
```

```r
## [1] "D41L"  "R65W"  "R213V" "D259V"
```

```r
## Sequence positions surounding each mutant site
start.position <- mutationpoints - 8
end.position <-  mutationpoints + 8

# Blank matrix to store sub-sequences
store.seqs <- matrix("-", nrow=length(mutationpoints), ncol=17)
rownames(store.seqs) <- mutant.names

## Extract each sub-sequence
for(i in 1:length(mutationpoints)) {
  store.seqs[i,] <- seqs$ali["P53_mutant",start.position[i]:end.position[i]]
}

store.seqs
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13]
## D41L  "S"  "P"  "L"  "P"  "S"  "Q"  "A"  "M"  "L"  "D"   "L"   "M"   "L"  
## R65W  "D"  "P"  "G"  "P"  "D"  "E"  "A"  "P"  "W"  "M"   "P"   "E"   "A"  
## R213V "Y"  "L"  "D"  "D"  "R"  "N"  "T"  "F"  "V"  "H"   "S"   "V"   "V"  
## D259V "I"  "L"  "T"  "I"  "I"  "T"  "L"  "E"  "V"  "-"   "-"   "-"   "-"  
##       [,14] [,15] [,16] [,17]
## D41L  "S"   "P"   "D"   "D"  
## R65W  "A"   "P"   "P"   "V"  
## R213V "V"   "P"   "Y"   "E"  
## D259V "-"   "-"   "-"   "-"
```


```r
## Output a FASTA file for further analysis
write.fasta(seqs=store.seqs, ids=mutant.names, file="subsequences.fa")
```

To prioritize which of the mutations in a tumor should be included in a vaccine, they can be scanned for those resulting in mutated peptides that bind HLA molecules of the patient with high affinity. This is done using HLA binding algorithms generated using machine learning algorithms trained on large sets of experimentally determined peptide:HLA binding data. We will here use algorithms developed as part of the Immune Epitope Database (IEDB) project hosted at the La Jolla Institute for Allergy and Immunology.

See: IEDB HLA binding prediction website http://tools.iedb.org/mhci/.
