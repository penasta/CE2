##############################################
####### Aula CE2 - 20/08 - Prof. Thais #######
##############################################


## Loading packages
library(tidyverse)
#library(stringr)

###################################
## Exercício do slide Aula 02 #####
###################################
library(babynames)
library(nycflights13)
babynames %>%
  mutate(last = str_sub(name, -1),
         vowel = last %in% c("a", "e", "i", "o", "u", "y")) %>%
  group_by(year, sex) %>%
  summarise(p_vowel = weighted.mean(vowel, n)) %>%
  ggplot(aes(year, p_vowel, color=sex)) +
  geom_line()


###################################
####### Strings Basic #############
###################################

# Creating a string
string1 <- "This is a string"
string1

# Escape character:  \ 
double_quote <- "\""
double_quote
writeLines(double_quote)

# quiz: include a literal backslash
backslash <- "\\"
writeLines(backslash)

# quiz: write http:\\
text <- "http:\\\\"
text
writeLines(text)

# quiz: write "http:\\"
text <- " \"http:\\\\\" "
text
writeLines(text)

text <- ' "http:\\\\" '
text2 <- " 'http:\\\\' " 
writeLines(text)
writeLines(text2)


# Special characters
?"'"
x <- "\u00b5"
x

# Number of characters in a string
str_length(c("a", "R for data science", NA))
str_length(" ")

# Combine strings
str_c("x", "y", "z", sep = ", ")
str_c("x", "y", "z")
str_c("Turma-", c("a", "b", "c"), "-Prof.Thais")
?str_c

pessoas <- c(" Rafael", " Andre", " Mateus")
n <- length(pessoas)
birthday <- c(T, F, F)
for(i in 1:n){
writeLines(str_c("Good morning", pessoas[i], 
      if(birthday[i]) " and happy birthday", "!"))
}

# Vector collapse
vet1 <- c("x", "y", "z")
vet2 <- str_c(vet1, collapse = ", ") 
vet2
length(vet1)
length(vet2)

# Subsetting strings  
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
str_sub(x, 1, 1) <- "Ana"
x

x
str_to_lower(x)
?str_to_lower

dog <- "The quick brown dog"
str_to_upper(dog)
str_to_lower(dog)
str_to_title(dog)
str_to_sentence("the quick brown dog")



###################################
####### Regular expressions #######
###################################

## It is language that allow you to describe 
## patterns in strings
?regex
x <- c("apple", "banana", "pear")
str_view(x, "an")

str_view(x, ".a.")
str_view("bananana", ".a.")
str_view_all("bananana", ".a.")
# obs.: matches never overlap

# how do you match the character “.”?
x <- c("apple.", "banana", "pear")
str_view(x, ".")
str_view_all(x, ".")
str_view_all(x, "\\.") # reg. expr. \.
1. escrever um texto
2. ler o texto e tranformar em expressão regular
3. Interpretar a expressão regular

# how do you match the character “\”?
x <- c("apple\\", "banana", "pear")
writeLines(x)

str_view(x, "\\\\") # reg. exp. \\
## check the "match characters in cheatsheet"

# Anchor
x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")


# Character classes
x <- c("dog", "cat1", "cat2")
str_view_all(x, "[digit]")
str_view_all(x, "[:digit:]")
str_view_all(x, "[^digit]")
str_view_all(x, "[:^digit:]")
str_view_all(x, "[abc]")


# Look for a literal character that normally has special meaning in a regex
str_view(c("abc", "a.c", "a*c", "a c"), "a\\.c") 
str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")
1. texto: "a\\.c"
2. expressão regular: "a\.c"
3. padrão: a.c

# alternation
str_view(c("grey", "gray"), "gr(e|a)y")
str_view(c("grey", "gray"), "gre|ay")
str_view(c("grey", "gray"), "g(re|a)y")
1. grey
2. gay

# range
x <- c("apple", "banana", "pear")
str_view_all(x, "[a-i]")
str_view_all(x, "[aeiou]")
str_view_all(x, "[^aeiou]")

# Repetition
x <- "1888: MDCCCLXXXVIII"
str_view(x, "CC?") # 0/1
str_view(x, "CC+") # 1+
str_view(x, "CC*") # 0+
str_view(x, "CCC")

str_view(x, 'C[LX]+')
str_view(x, 'C{3}')
str_view(x, 'C{4,}')
str_view(x, 'C{1,2}')


###################################
####### Regexp usage ##############
###################################

# When you first look at a regexp, you’ll think a cat walked across your keyboard, 
# but as your understanding improves they will soon start to make sense.

# 1. Determine which strings match a pattern.
# 2. Find the positions of matches.
# 3. Extract the content of matches.
# 4. Replace matches with new values.
# 5. Split a string based on a match.

## 1. Detect matches and find positions of matches
library(tidyverse)

x <- c("apple", "banana", "pear")
str_detect(x, "e")

# How many common words start with t?
str_detect(words, "^t")
sum(str_detect(words, "^t"))
sum(!str_detect(words, "^t"))



# What proportion of common words end with a vowel?
head(words)
head(str_detect(words, "[aeiouy]$"))
mean(str_detect(words, "[aeiouy]$"))

x <- c("apple", "banana", "pear")
str_count(x, "a")

# On average, how many vowels per word?
mean(str_count(words, "[aeiouy]"))

# Quiz: Create a df and a column with # vowels and consonants
df <- tibble(
  word = words, 
  i = seq_along(word)
)

df <- df %>% 
  mutate(
    vowels = str_count(word, "[aeiouy]"),
    consonants = str_count(word, "[^aeiouy]")
  )


## 2. Extract matches

# find all sentences that contain a colour
colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|")
colour_match
sum(str_detect(sentences, colour_match))

has_colour <- str_subset(sentences, colour_match)
has_colour

colours <- c("\\bred", "orange", "yellow", "green", "blue", "purple\\b")
colour_match <- str_c(colours, collapse = "\\b|\\b")
colour_match
has_colour <- str_subset(sentences, colour_match)
has_colour

matches <- str_extract(has_colour, colour_match)
head(matches)
matches2 <- str_extract_all(has_colour, colour_match)
head(matches2)



## 3. Replace matches
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", 
                     "3" = "three"))

## 4. Split 

sentences %>%
  head(5) %>% 
  str_split(" ")

sentences %>%
  head(5) %>% 
  str_split(" ", simplify = T)


## Materials
# See string manipulation with stringr cheatsheet
https://stringr.tidyverse.org/#cheatsheet
  

  
## Exercises

# 1. From the words data: 
### a. Find all words that start or end with x.
### b. Find all words that start with a vowel and end with a consonant.

# 2. From the Harvard sentences data, extract:
### a. The first word from each sentence.
### b. All words ending in ing.


