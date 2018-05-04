---
title: "Bioinformatics Class 7"
output: 
  html_document: 
    keep_md: yes
---



# Functions again

We can source any file of R code with the 'source'() function


```r
source("http://tinyurl.com/rescale-R")
```

```
## Warning in file(filename, "r", encoding = encoding): "internal" method
## cannot handle https redirection to: 'https://bioboot.github.io/bggn213_f17/
## class-material/rescale.R'
```

```
## Warning in file(filename, "r", encoding = encoding): "internal" method
## failed, so trying "libcurl"
```

let's make sure things are here

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
rescale(c(1:10, "string"))
```

Let's check if 'rescale2()' does any better


```r
rescale2(c(1:10, "string"))
```



## Function for finding  missing values in two datasets

Write a 'both_na()' function to do this...

```r
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE  TRUE
```

Function determines which positions are NA

```r
which( is.na(x) )
```

```
## [1] 3 5
```

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

Now want to write function that finds at what position both series x and y are NA, sum will give total amount of positions where this is true. 

```r
sum( is.na(x) & is.na(y))
```

```
## [1] 1
```

My first function can start from this snippet :-)


```r
both_na2 <- function(x, y) {
  ##Check for NA elements in both input vectors and don't allow
    if(length(x) != length(y)) {
   stop("Input x and y should be the same length")
    }
  sum( is.na(x) & is.na(y) )
}
```


```r
x <-  c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)
```



```r
function(x,y) {
  ##Check for NA elements in both input vectors and don't allow
    if(length(x) != length(y)) {
   stop("Input x and y should be the same length")
    }
  sum( is.na(x) & is.na(y))
}
```

```
## function(x,y) {
##   ##Check for NA elements in both input vectors and don't allow
##     if(length(x) != length(y)) {
##    stop("Input x and y should be the same length")
##     }
##   sum( is.na(x) & is.na(y))
## }
```




```r
both_na3 <- function(x, y) {
  if(length(x) != length(y)) {
    stop("Input x and y should be vectors of the same length")
  }
  na.in.both <- ( is.na(x) & is.na(y) )
  na.number  <- sum(na.in.both)
  na.which   <- which(na.in.both)
  message("Found ", na.number, " NA's at position(s):", 
          paste(na.which, collapse=", ") ) 
  return( list(number=na.number, which=na.which) )
}
```


```r
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)

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





## And a last function that is actually useful


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

We can try the 'intersect()' function and the '%in%' functions


```r
intersect(x,y)
```

```
## [1] "gene2" "gene3"
```

```r
x %in% y
```

```
## [1] FALSE  TRUE  TRUE
```

We can use logical output in '%in%' to get at our data


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


Let's put these together as columns of a matrix



```r
cbind( x[ x %in% y ], y[ y %in% x ] )
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```



```r
cbind(c("Hello", "Help"), c("Please", "Me"))
```

```
##      [,1]    [,2]    
## [1,] "Hello" "Please"
## [2,] "Help"  "Me"
```


Make new function

```r
gene_intersect <- function(x, y) { 
   cbind( x[ x %in% y ], y[ y %in% x ] )
}

gene_intersect(x,y)
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```

Let's try with data.frame input rather than vectors


```r
gene_intersect2 <- function(df1, df2) { 
   cbind( df1[ df1$IDs %in% df2$IDs, ], 
          df2[ df2$IDs %in% df1$IDs, "exp"] )
}
```


```r
gene_intersect2(df1, df2)
```

```
##     IDs exp df2[df2$IDs %in% df1$IDs, "exp"]
## 2 gene2   1                               -2
## 3 gene3   1                                1
```




