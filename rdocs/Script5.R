if (!require("pacman")) install.packages("pacman")
p_load(tidyverse)

x <- c("apple","banana","pear")
str_detect(x,"e")

str_detect(words,"^t")
sum(str_detect(words,"^t"))
sum(!str_detect(words,"^t"))

# What proportion of common words end with a vowel?
head(words)
head(str_detect(words,'[aeiou]$'))
mean(str_detect(words,"[aeiou]$"))

# --------------------------------------------------------------------------- #

str_count(x,"a")

# On average, how many vowels per word?
mean(str_count(words,"[aeiouy]"))
tail(words)

# Quiz: Create a df and a column with # vowels and consonants

df <- tibble(
  word = words,
  i = seq_along(word)
)

df <- df %>%
  mutate(vowels = str_count(word,"[aeiouy]")) %>%
  mutate(consonants = str_count(words,"[^aeiouy]"))

# 2. Extract matches

# find all sentences that contain a colour
sentences
colours <- c("\\bred\\b","\\borange\\b","\\byellow\\b","\\bgreen\\b","\\bblue\\b","\\bpurple\\b")

colours_match <- str_c(colours, collapse = "|")
colours_match

has_colour <- str_subset(sentences, colours_match)
has_colour

matches <- str_extract(has_colour, colours_match)
matches

matches2 <- str_extract_all(has_colour, colours_match)
matches2


























