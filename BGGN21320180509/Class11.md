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

when uploading to github and if you want it to include the rmd in a way where it looks prettier, click the gear icon then go to output options, keep markdown source file. ok. now knit again this will make the .md intermediate folder and then you can go in ahead and commit and push onto git. 


##Using Bio3d

```r
library(bio3d)
```

Read in our  HIV-Pr structure


```r
pdb <- read.pdb("1hsg")
```

```
##   Note: Accessing on-line PDB file
```

```r
pdb
```

```
## 
##  Call:  read.pdb(file = "1hsg")
## 
##    Total Models#: 1
##      Total Atoms#: 1686,  XYZs#: 5058  Chains#: 2  (values: A B)
## 
##      Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
## 
##      Non-protein/nucleic Atoms#: 172  (residues: 128)
##      Non-protein/nucleic resid values: [ HOH (127), MK1 (1) ]
## 
##    Protein sequence:
##       PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
##       QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
##       ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
##       VNIIGRNLLTQIGCTLNF
## 
## + attr: atom, xyz, seqres, helix, sheet,
##         calpha, remark, call
```



Q6. How many amino acid residues are there in this pdb object and what are the two nonprotein
residues? 
198


Note that the attributes (+ attr:) of this object are listed on the last couple of lines. To find the
attributes of any such object you can use

```r
attributes(pdb)
```

```
## $names
## [1] "atom"   "xyz"    "seqres" "helix"  "sheet"  "calpha" "remark" "call"  
## 
## $class
## [1] "pdb" "sse"
```

Print a subset of $atom data for the first two atoms


```r
head(pdb$atom)
```

```
##   type eleno elety  alt resid chain resno insert      x      y     z o
## 1 ATOM     1     N <NA>   PRO     A     1   <NA> 29.361 39.686 5.862 1
## 2 ATOM     2    CA <NA>   PRO     A     1   <NA> 30.307 38.663 5.319 1
## 3 ATOM     3     C <NA>   PRO     A     1   <NA> 29.760 38.071 4.022 1
## 4 ATOM     4     O <NA>   PRO     A     1   <NA> 28.600 38.302 3.676 1
## 5 ATOM     5    CB <NA>   PRO     A     1   <NA> 30.508 37.541 6.342 1
## 6 ATOM     6    CG <NA>   PRO     A     1   <NA> 29.296 37.591 7.162 1
##       b segid elesy charge
## 1 38.10  <NA>     N   <NA>
## 2 40.62  <NA>     C   <NA>
## 3 42.64  <NA>     C   <NA>
## 4 43.40  <NA>     O   <NA>
## 5 37.87  <NA>     C   <NA>
## 6 38.40  <NA>     C   <NA>
```
 Note that individual $atom records can also be accessed like this

```r
pdb$atom[1:2, c("eleno","elety", "x","y","z")]
```

```
##   eleno elety      x      y     z
## 1     1     N 29.361 39.686 5.862
## 2     2    CA 30.307 38.663 5.319
```
Which allows us to do the following
J

```r
plot.bio3d(pdb$atom$b[pdb$calpha], sse=pdb, typ="l", ylab="B-factor")
```

![](Class11_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


Q7. What type of R object is pdb$atom? HINT: You can always use the str() function to get a
useful summery of any R object.


```r
str(pdb$atom)
```

```
## 'data.frame':	1686 obs. of  16 variables:
##  $ type  : chr  "ATOM" "ATOM" "ATOM" "ATOM" ...
##  $ eleno : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ elety : chr  "N" "CA" "C" "O" ...
##  $ alt   : chr  NA NA NA NA ...
##  $ resid : chr  "PRO" "PRO" "PRO" "PRO" ...
##  $ chain : chr  "A" "A" "A" "A" ...
##  $ resno : int  1 1 1 1 1 1 1 2 2 2 ...
##  $ insert: chr  NA NA NA NA ...
##  $ x     : num  29.4 30.3 29.8 28.6 30.5 ...
##  $ y     : num  39.7 38.7 38.1 38.3 37.5 ...
##  $ z     : num  5.86 5.32 4.02 3.68 6.34 ...
##  $ o     : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ b     : num  38.1 40.6 42.6 43.4 37.9 ...
##  $ segid : chr  NA NA NA NA ...
##  $ elesy : chr  "N" "C" "C" "O" ...
##  $ charge: chr  NA NA NA NA ...
```
It is a data frame

 Print a summary of the coordinate data in $xyz

```r
pdb$xyz
```

```
## 
##    Total Frames#: 1
##    Total XYZs#:   5058,  (Atoms#:  1686)
## 
##     [1]  29.361  39.686  5.862  <...>  30.112  17.912  -4.791  [5058] 
## 
## + attr: Matrix DIM = 1 x 5058
```

Examine row and column dimensions

```r
dim(pdb$xyz)
```

```
## [1]    1 5058
```

Print coordinatesfor the first two atoms

```r
pdb$xyz[1,atom2xyz(1:2)]
```

```
## [1] 29.361 39.686  5.862 30.307 38.663  5.319
```

The Bio3D atom.select() function is arguably one of the most challenging for newcomers to
master. It is however central to PDB structure manipulation and analysis. At its most basic, this
function operates on PDB structure objects (as created by read.pdb()) and returns the
numeric indices of a selected atom subset. These indices can then be used to access the
$atom and $xyz attributes of PDB structure related objects.
For example to select the indices for all C-alpha atoms we can use the following command:



Select all c alpha atoms returnin their indices

```r
ca.inds <- atom.select(pdb,"calpha")
ca.inds 
```

```
## 
##  Call:  atom.select.pdb(pdb = pdb, string = "calpha")
## 
##    Atom Indices#: 198  ($atom)
##    XYZ  Indices#: 594  ($xyz)
## 
## + attr: atom, xyz, call
```

Print details of first few atoms

```r
head(pdb$atom[ca.inds$atom, ])
```

```
##    type eleno elety  alt resid chain resno insert      x      y     z o
## 2  ATOM     2    CA <NA>   PRO     A     1   <NA> 30.307 38.663 5.319 1
## 9  ATOM     9    CA <NA>   GLN     A     2   <NA> 30.158 36.492 2.199 1
## 18 ATOM    18    CA <NA>   ILE     A     3   <NA> 29.123 33.098 3.397 1
## 26 ATOM    26    CA <NA>   THR     A     4   <NA> 29.774 30.143 1.062 1
## 33 ATOM    33    CA <NA>   LEU     A     5   <NA> 27.644 27.003 1.144 1
## 41 ATOM    41    CA <NA>   TRP     A     6   <NA> 30.177 24.150 1.279 1
##        b segid elesy charge
## 2  40.62  <NA>     C   <NA>
## 9  41.30  <NA>     C   <NA>
## 18 34.13  <NA>     C   <NA>
## 26 30.14  <NA>     C   <NA>
## 33 30.12  <NA>     C   <NA>
## 41 30.82  <NA>     C   <NA>
```

and the xyz coordinates

```r
head(pdb$xyz[,ca.inds$xyz])
```

```
## [1] 30.307 38.663  5.319 30.158 36.492  2.199
```


In addition to the common selection strings (such as ‘calpha’ ‘cbeta’ ‘backbone’ ‘protein’
‘notprotein’ ‘ligand’ ‘water’ ‘notwater’ ‘h’ and ‘noh’) various individual atom properties can be
used for selection



select chain a

```r
a.inds <- atom.select(pdb,chain = "A")
```

select c alphas of chain a


```r
ca.inds <- atom.select(pdb,"calpha", chain = "A")
```

combine multiple criteria and return where they intersect


```r
cab.inds <- atom.select(pdb, elety = c("CA","CB"), chain = "A", resno = 10:20)
```
Q8. Use the Bio3D write.pdb() function to write out a new C-alpha atom only PDB file for
viewing in VMD.


```r
inds.ligand <- atom.select(pdb,"ligand")
inds.protein <- atom.select(pdb,"protein")
inds.protein
```

```
## 
##  Call:  atom.select.pdb(pdb = pdb, string = "protein")
## 
##    Atom Indices#: 1514  ($atom)
##    XYZ  Indices#: 4542  ($xyz)
## 
## + attr: atom, xyz, call
```
check we have what we want


```r
#pdb$atom[inds.ligand$atom]
```



```r
#head(pdb$atom[inds.protein$atom])
```


```r
#pdb.protein <- trim.pdb(pbd, inds = inds.protein)
pdb.ligand <- trim.pdb(pdb, inds = inds.ligand)
pdb.ligand
```

```
## 
##  Call:  trim.pdb(pdb = pdb, inds = inds.ligand)
## 
##    Total Models#: 1
##      Total Atoms#: 45,  XYZs#: 135  Chains#: 1  (values: B)
## 
##      Protein Atoms#: 0  (residues/Calpha atoms#: 0)
##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
## 
##      Non-protein/nucleic Atoms#: 45  (residues: 1)
##      Non-protein/nucleic resid values: [ MK1 (1) ]
## 
## + attr: atom, helix, sheet, seqres, xyz,
##         calpha, call
```

```r
write.pdb(pdb.ligand,file="1hsvligand.pdb")
```

