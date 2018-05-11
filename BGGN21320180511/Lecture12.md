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




