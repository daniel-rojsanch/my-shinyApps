## The Beatles App

library(wordcloud2)
library(tidyverse)
library(tidytext)

## Funcion que nos ayudara 
"%!in%" <- Negate("%in%")

## Cargar todas las letras del grupo The Beatles
lyrics <- readLines("data/Songs.txt")
## Dividir el texto en palabras

## Poner nuestro texto que contiene todas la canciones the Beatles en una tabla
## la primera columna sera el numero del parrafo y la segunda tendra el texto

lyrics_theBeatles <- tibble(n = seq_along(lyrics),
                  texto = lyrics)

word_theBeatles <- lyrics_theBeatles %>%
  unnest_tokens(palabra, texto)

ignore <- c("i","you","he","she","it","we","they",
  "to","the","a","an","at","my","me","your","in",
  "with","of","this","that","all","for", "and", "but", "i'm",
  "don't","go","got","do","where","can","is","are","am","he's")

chidas <- word_theBeatles[word_theBeatles$palabra %!in% ignore,]

data <- table(chidas$palabra)
wordcloud2(data)




