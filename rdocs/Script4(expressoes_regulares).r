# ---------------------- Expressões regulares ------------------------------- #

if (!require("pacman")) install.packages("pacman")
p_load(tidyverse,htmlwidgets)

# --------------------------------------------------------------------------- #

?regex

# --------------------------------------------------------------------------- #

x <- c("apple","banana","pear")

str_view(x,"an")

str_view(x,".a.")

str_view_all("bananana",".a.")

# --------------------------------------------------------------------------- #

x <- c("apple.","banana","pear")

str_view(x,".")

str_view_all(x,".")

str_view_all(x,"\.")

str_view_all(x,"\\.")

# --------------------------------------------------------------------------- #

x <- c("apple\\","banana","pear")

writeLines(x)

str_view(x,"\\\\")

# --------------------------------------------------------------------------- #

x <- c("apple","banana","pear")



# --------------------------------------------------------------------------- #

x <- c("dog","cat1","cat2")

str_view_all(x,"[digit]")

str_view_all(x,"[:digit:]")

str_view_all(x,"[^digit]")

str_view_all(x,"[:^digit]:")

str_view_all(x,"[abc]")

# --------------------------------------------------------------------------- #

str_view(c("grey","gray"),"gr(e|a)y")

str_view(c("grey","gray"),"g(re|a)y")

# --------------------------------------------------------------------------- #

x <- c("apple","banana","pear")
str_view_all(x,"[a-i]")

str_view_all(x,"[aeiou]")

str_view_all(x,"[^aeiou]")

# --------------------------------------------------------------------------- #

x <- "1888: MDCCCLVVVVIII"

str_view(x,"CC?")

str_view(x,"CC+")

str_view(x,"CC*")

str_view(x,"CCC")

str_view(x,"C[LX]+")

str_view(x,"C{3}")

str_view(x,"C{4,}")

str_view(x,"C{1,2}")

# --------------------------------------------------------------------------- #