---
title: "Bioinformatics Class 7"
author: "Andrew Valadez"
date: "April 25, 2018"
output:
  html_document: 
    keep_md: yes
  pdf_document: default
---



# Functions again

We can source any file of R code with the 'source'() function.

alt control i gives the insert shortcut

```r
source("http://tinyurl.com/rescale-R")
```

have the rescale thing and when try to open it will have spectacles and that means it is read only function 
take x find range and will have an answer

Lets make sure things are here
ls will list things in envrionment

```r
ls()
```

```
##  [1] "both_na"         "both_na2"        "both_na3"       
##  [4] "df1"             "df2"             "df3"            
##  [7] "gene_intersect"  "gene_intersect2" "gene_intersect3"
## [10] "gene_intersect4" "rescale"         "rescale2"
```


Check our rescale function is working 

```r
rescale(1:10)
```

```
##  [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667
##  [8] 0.7777778 0.8888889 1.0000000
```


```r
rescale( c(1:10,"tacobell"))
```

no real help out of the error message, how do we catch these kind of things to fail ealry and fail largely?

introduce warning() and stop() 
warning will continue running the fx stop will just terminate the action of the fx 
 
lets use that approach to fail early and largely

adding rescale
if function if whatever in parenthese is true then will go through the rest of it
so if true will go inside if to the stop 
x is our input here the fx is numeric and has an exclamation mark

is .numeric tests to see if input is all numbers , the input in script with the string tacobell


```r
function(x, na.rm=TRUE, plot=FALSE, ...) {
  # Our rescale function from lecture 10

  if( !is.numeric(x) ) {
    stop("Input x should be numeric", call.=FALSE)
  }
  
  rng <-range(x, na.rm=TRUE)

  answer <- (x - rng[1]) / (rng[2] - rng[1])
  if(plot) { 
    plot(answer, ...) 
  }

  return(answer)
}
```

```
## function(x, na.rm=TRUE, plot=FALSE, ...) {
##   # Our rescale function from lecture 10
## 
##   if( !is.numeric(x) ) {
##     stop("Input x should be numeric", call.=FALSE)
##   }
##   
##   rng <-range(x, na.rm=TRUE)
## 
##   answer <- (x - rng[1]) / (rng[2] - rng[1])
##   if(plot) { 
##     plot(answer, ...) 
##   }
## 
##   return(answer)
## }
```



```r
is.numeric(c(1:10,"tacobell"))
```

```
## [1] FALSE
```

this is false it isnt numbers in fx had exclamation mark flips it so makes false true


```r
!is.numeric((c(1:10,"tacobell")))
```

```
## [1] TRUE
```

lets open rescale2 again
call.=false is good to not overcomplicate why it failed 
lets test it though
rescale gave error with tacobell

```r
function(x, na.rm=TRUE, plot=FALSE, ...) {
  # Our rescale function from lecture 10

  if( !is.numeric(x) ) {
    stop("Input x should be numeric", call.=FALSE)
  }
  
  rng <-range(x, na.rm=TRUE)

  answer <- (x - rng[1]) / (rng[2] - rng[1])
  if(plot) { 
    plot(answer, ...) 
  }

  return(answer)
}
```

```
## function(x, na.rm=TRUE, plot=FALSE, ...) {
##   # Our rescale function from lecture 10
## 
##   if( !is.numeric(x) ) {
##     stop("Input x should be numeric", call.=FALSE)
##   }
##   
##   rng <-range(x, na.rm=TRUE)
## 
##   answer <- (x - rng[1]) / (rng[2] - rng[1])
##   if(plot) { 
##     plot(answer, ...) 
##   }
## 
##   return(answer)
## }
```


```r
rescale2(c(1:10,"tacobell"))
```
woohoo gave message did its job much more helpful message than something else, if want to debug stuff can go through show traceback 

if try to compile document with error messages when you try to knit will say you have error in code so to be able to compile one way to do it is put comment character to ignore #, or another way is after the r at the top  write eval=FALSE and will keep code chunk in but not run it . 



We want to write a function, called both_na(),
that counts how many positions in two input
vectors, x and y, both have a missing value


always start w a simple definition of the problem will make you curse less at your function, make x and y two simple vectors , x and y have some missing values

```r
# Lets define an example x and y
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3, 4)
```

so google it and stackoverflow where ppl arent very friendly so don't really post questions there unless you have thick skin, not a place for ppl without thick skin, questions posted by others are good to check out though, is.na function looks like it was talked about a few times so look it up in console

cool so it says which positions in vector are missing lets try it



```r
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE  TRUE
```
 so gives a logical vector for true and false
 
 now lets do y

```r
is.na(y)
```

```
## [1]  TRUE FALSE  TRUE FALSE FALSE
```
 so now we can access the elements of it
 
 also had a which function in stack overflow which well tell you which are true
 

```r
which(is.na(x))
```

```
## [1] 3 5
```
 
cool so the third and fifth position are true if put exclamation it would give the opposite 

quick tangent on if else fx


```r
z <- 10
if(z>5){
  print("More tacos")
} else{
  print("less tacos")
}
```

```
## [1] "More tacos"
```


boolean means true = 1 false =0


```r
sum(is.na(x))
```

```
## [1] 2
```
so adds up how many na's we have happy day
so need to look at snippets together to have x and y


```r
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE  TRUE
```

```r
is.na(y)
```

```
## [1]  TRUE FALSE  TRUE FALSE FALSE
```
these are just printing on top of each other but want to know when it is true in both 

```r
is.na(x) & is.na(y)
```

```
## [1] FALSE FALSE  TRUE FALSE FALSE
```
this & will give you everything that is true for both

if wanted to know how many can wrap it in sum fx

```r
sum(is.na(x) & is.na(y))
```

```
## [1] 1
```
so only one position has missing values


oh look i found the or funciton its the long line thing 


```r
is.na(x) | is.na(y)
```

```
## [1]  TRUE FALSE  TRUE FALSE  TRUE
```

first funciton can start from snippet 

```r
both_na <-  function(x,y){
  sum(is.na(x) & is.na(y))
}
```


test it 


```r
both_na(x,y)
```

```
## [1] 1
```

try to idiot proof the function is impossible so there is eejit proofing , try it w diff vectors


```r
x <- c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)
```



```r
both_na(x,y1)
```

```
## [1] 2
```


```r
both_na(x,y2)
```

```
## Warning in is.na(x) & is.na(y): longer object length is not a multiple of
## shorter object length
```

```
## [1] 3
```

well it gave a pretty bad error message
"longer object length is not a multiple of shorter object length[1] 3" 
you figure someone could figure out there life from that but it did do the recycling only on the last 3 from y2 so all got all 3 na's so got sum 3

pull up both_na2 fx

```r
both_na2 <- function(x, y) {
  ## Check for NA elements in both input vectors and don't allow re-cycling 
  if(length(x) != length(y)) {
    stop("Input x and y should be vectors of the same length", call.=FALSE)
  }
  sum( is.na(x) & is.na(y) )
}
```



lets figure out these lines of code now we see this != 
 for example 4==(2+2) this tests equivalency and will get a true, the 4!= (2+2) will give false and 4!=(2+4) will give a true

lets try with both_na2

```r
both_na2(x,y2)
```
Error: Input x and y should be vectors of the same length

cool much better and more useful message 


lets do both_na3 now 

```r
both_na3 <- function(x, y) {
  ## Print some info on where NA's are as well as the number of them 
  if(length(x) != length(y)) {
    stop("Input x and y should be vectors of the same length", call.=FALSE)
  }
  na.in.both <- ( is.na(x) & is.na(y) )
  na.number  <- sum(na.in.both)
  na.which   <- which(na.in.both)

  message("Found ", na.number, " NA's at position(s):", 
          paste(na.which, collapse=", ") ) 
  
  return( list(number=na.number, which=na.which) )
}
```

so have same bit of code na.in.both will give the false and true vector, then calculate how many are there and whcih position they are in
then message will write these in the order 
then return a list with a number = how many are there and which , using useful stuff , no comments in it though not done all error checking good enough and reasonable for task 

lets use og x and y


```r
# Lets define an example x and y
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3, 4)
```



```r
both_na3(x,y)
```

```
## Found 1 NA's at position(s):3
```

```
## $number
## [1] 1
## 
## $which
## [1] 3
```

could also do 

```r
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3, 4)
ans <- both_na3(x,y)
```

```
## Found 1 NA's at position(s):3
```

then can use ans$ to access which and number parts of list


# And a last function that is useful
Follow along where find common genes in 2 data sets have df1 and df2 with genes in it and has diff names and expressions
start even simpler with vectors x and y dr1$IDs is x and df2$IDs is y 

```r
x <- df1$IDs
y <- df2$IDs
x
```

```
## [1] "gene1" "gene2" "gene3"
```

```r
y
```

```
## [1] "gene2" "gene4" "gene3" "gene5"
```
gene 2 and gene 3 are in both you can see
so search for existing functionalyity to get us started found function intersect can look at help for intersect
in the see also part they have %in% and that is like related fucntion

so lets just try what we got 

```r
intersect(x,y)
```

```
## [1] "gene2" "gene3"
```
cool so it worked , and so you want genes in both to cross it want the row numbers and so want to knowexpression and annotations want to merge the lists together, gives answer but not the indexes to give the row position and such 
lets try the %in%

returns a vector of the positons of the table wherer comomn things are 



```r
x %in% y
```

```
## [1] FALSE  TRUE  TRUE
```
checks by going through each element of x to see if in y

```r
y %in% x
```

```
## [1]  TRUE FALSE  TRUE FALSE
```
so get same idea but goes through more this time because goes through each element of y 


we can now use cbind() that will combine  will take inputs of same length and ti would put them together 

xxx -cbind-----> xx
+xxx             xx
                 xx
            
thats the idea above

we can use logiacl output of %in% to get at our matching data 


```r
x[x %in% y]
```

```
## [1] "gene2" "gene3"
```

```r
y[y %in% x]
```

```
## [1] "gene2" "gene3"
```


```r
cbind(x[x %in% y], y[y %in% x])
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```



```r
cbind(c("hello", "help"), c("please","me"))
```

```
##      [,1]    [,2]    
## [1,] "hello" "please"
## [2,] "help"  "me"
```

or funnier to me use rbind

```r
rbind(c("hello", "help"), c("please","me"))
```

```
##      [,1]     [,2]  
## [1,] "hello"  "help"
## [2,] "please" "me"
```
;)

lets do function though



```r
gene_intersect <- function(x,y){
    cbind(x[x %in% y], y[y %in% x])
  
}
```


```r
gene_intersect(x,y)
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```
cool it worked we got somewhere 
but we want to work with inputs we work w in real life obviously


```r
gene_intersect2 <- function(df1, df2) { 
   cbind( df1[ df1$IDs %in% df2$IDs, ], 
          df2[ df2$IDs %in% df1$IDs, "exp"] )
}
```



```r
gene_intersect2(df1,df2)
```

```
##     IDs exp df2[df2$IDs %in% df1$IDs, "exp"]
## 2 gene2   1                               -2
## 3 gene3   1                                1
```

also prints out the exp value not very pretty code fucntion it is very hardwired for this function though , written explicitly for this column name so it can be better
looks good though , this is our skateboard not a tesla but gets us down the road


our input$ids column may change name


```r
gene.columns="IDs"
gene.columns
```

```
## [1] "IDs"
```


```r
gene_intersect3 <- function(df1, df2, gene.colname="IDs") { 
   cbind( df1[ df1[,gene.colname] %in% df2[,gene.colname], ], 
          exp2=df2[ df2[,gene.colname] %in% df1[,gene.colname], "exp"] )
}
```



```r
gene_intersect3(df1,df2)
```

```
##     IDs exp exp2
## 2 gene2   1   -2
## 3 gene3   1    1
```

what it returns looks pretty but the code is ugly almost there! too long and too hard to read


```r
gene_intersect4 <- function(df1, df2, gene.colname="IDs") { 

  df1.name <- df1[,gene.colname]
  df2.name <- df2[,gene.colname]

  df1.inds <- df1.name %in% df2.name
  df2.inds <- df2.name %in% df1.name

   cbind( df1[ df1.inds, ], 
          exp2=df2[ df2.inds, "exp"] )
}
```

this code is more obviously correct because you see youll get name and then youll get indecideds and then you will combine them 


```r
gene_intersect4(df1,df2)
```

```
##     IDs exp exp2
## 2 gene2   1   -2
## 3 gene3   1    1
```

cool pretty and such
we have df3 as well

```r
df3
```

```
##     IDs exp
## 1 gene2  -2
## 2 gene2  NA
## 3 gene5   1
## 4 gene5   2
```

```r
df1
```

```
##     IDs exp
## 1 gene1   2
## 2 gene2   1
## 3 gene3   1
```


```r
gene_intersect4(df1, df3)
```

```
## Warning in data.frame(..., check.names = FALSE): row names were found from
## a short variable and have been discarded
```

```
##     IDs exp exp2
## 1 gene2   1   -2
## 2 gene2   1   NA
```

want to add warning message because came with a warning message 

so do 

```r
merge(df1,df2, by="IDs")
```

```
##     IDs exp.x exp.y
## 1 gene2     1    -2
## 2 gene3     1     1
```

testing shit here ignore


```r
x <- taco
sprintf("%s", x)
```

```r
taco <- "9"
x <- taco
y=paste(x)
y
```

```
## [1] "9"
```


installing a package then you have to load it up using library 
install using install.package


bioconductor is separate from cran like an orchestra deal here is have much higher interplay between packages , basically interlinked packages, has tigheter depnedency on other packages can install package and can go off and get 10 to 1 other packages will take a little while want to control for versions 
bioconductor software repsoitory fo r packages has like 1.5k packages main plus things of it is it makes it easy to do reproducible research which is big deal because having reproducability crisis 80% of them cant be reproduced need to be reproducible especially in a field like genomics so when using htese packages will reproduce and see if we get same results , not do it all in house and get gene x and y because nobody else has access to that code , 

going to use google doc using main packages he uses how does it owrk 
is there documentation
is there a web presence where can find more info 
does it have heartbeat is it alive and living most of these projects exist on version contrl repositories like github and bitbucket ppl who fix bugs will do it on these sites are ppl asking questions is there contribution and answers on these sites that way you are not suffering alone in silence ,

```r
library(tidyverse)
```

```
## -- Attaching packages ----------------------------------------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 2.2.1     v purrr   0.2.4
## v tibble  1.4.2     v dplyr   0.7.4
## v tidyr   0.8.0     v stringr 1.3.0
## v readr   1.1.1     v forcats 0.3.0
```

```
## -- Conflicts -------------------------------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```



```r
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()
```

![](Class_7_files/figure-html/unnamed-chunk-54-1.png)<!-- -->

