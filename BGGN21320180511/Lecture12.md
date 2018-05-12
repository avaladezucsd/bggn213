---
title: "Lecture12"
author: "Andrew Valadez"
date: "May 11, 2018"
output: 
  html_document: 
    keep_md: yes
---



## Section1

Get the protien first 

```r
library(bio3d)
file <- get.pdb("1hsg")
```

```
## Warning in get.pdb("1hsg"): ./1hsg.pdb exists. Skipping download
```

Read the structure and trim out the protein and small molecule ligand from everything else 


```r
hiv <- read.pdb(file)
hiv
```

```
## 
##  Call:  read.pdb(file = file)
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

2 non protein resid values in this structure are HOH and MK1 (water and ligand )

lets get the ligand first

```r
ligand <- trim.pdb(hiv, "ligand")
ligand
```

```
## 
##  Call:  trim.pdb(pdb = hiv, "ligand")
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


now lets get the protein

```r
prot <- trim.pdb(hiv,"protein")
prot
```

```
## 
##  Call:  trim.pdb(pdb = hiv, "protein")
## 
##    Total Models#: 1
##      Total Atoms#: 1514,  XYZs#: 4542  Chains#: 2  (values: A B)
## 
##      Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
## 
##      Non-protein/nucleic Atoms#: 0  (residues: 0)
##      Non-protein/nucleic resid values: [ none ]
## 
##    Protein sequence:
##       PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
##       QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
##       ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
##       VNIIGRNLLTQIGCTLNF
## 
## + attr: atom, helix, sheet, seqres, xyz,
##         calpha, call
```


now lets write those to a file

```r
write.pdb(prot, file="1hsg-protein.pdb")
write.pdb(ligand,"1hsg_ligand.pdb")
```

cool that sends it over into your folder 

couldn't get Auto dock tools to work on pc , went to a mac with it already downloaded adn opened it from there.

Normally the strucutre has H atoms on it but visualizing in adt we dont really see them there, so we need to add them in 

ok so now we have the pdbqt file that has the h atoms and positions and stuff about them. 

ok we made a config.txt file that will basically lock in where the potential binding for the protein will be.

#Section2 Docking ligands into HIV-1 protease




Process docking result for viewing in VMD



```r
library(bio3d)
res <- read.pdb("all.pdbqt", multi=TRUE)
write.pdb(res, "results.pdb")
```




so then put in your reults with your og pdb file


```r
ori <- read.pdb("ligand.pdbqt")
```
get root mean square distance



```r
rmsd(ori, res)
```

```
##  [1]  0.649  4.206 11.110 10.529  4.840 10.932 10.993  3.655 10.996 11.222
## [11] 10.567 10.372 11.019 11.338  8.390  9.063  8.254  8.978
```


How would you determine the RMSD for heavy atoms only (i.e. non hydrogen atoms)?
HINT: The atom.select() function will be of help here along with the selection string “noh” for no
hydrogens




```r
inds <-  atom.select(ori, "noh")
rmsd(ori$xyz[,inds$xyz], res$xyz[, inds$xyz])
```

```
##  [1]  0.506  4.310 11.022 10.359  4.781 10.956 10.918  3.704 10.905 10.994
## [11] 10.432 10.328 10.846 11.208  8.324  8.935  8.272  8.870
```



