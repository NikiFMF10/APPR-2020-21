# 2. faza: Uvoz podatkov

#sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi občine iz Wikipedije
#uvozi.obcine <- function() {
  #link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  #stran <- html_session(link) %>% read_html()
  #tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    #.[[1]] %>% html_table(dec=",")
  #for (i in 1:ncol(tabela)) {
    #if (is.character(tabela[[i]])) {
      #Encoding(tabela[[i]]) <- "UTF-8"
    #}
  #}
  #colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        #"ustanovitev", "pokrajina", "regija", "odcepitev")
  #tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  #tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  #tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  #for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    #if (is.character(tabela[[col]])) {
      #tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
    #}
  #}
  #for (col in c("obcina", "pokrajina", "regija")) {
    #tabela[[col]] <- factor(tabela[[col]])
  #}
  #return(tabela)
#}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#uvozi.druzine <- function(obcine) {
  #data <- read_csv2("podatki/druzine.csv", col_names=c("obcina", 1:4),
                    #locale=locale(encoding="Windows-1250"))
  #data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    #strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
  #data$obcina[data$obcina == "Sveti Jurij"] <- iconv("Sveti Jurij ob Ščavnici", to="UTF-8")
  #data <- data %>% pivot_longer(`1`:`4`, names_to="velikost.druzine", values_to="stevilo.druzin")
  #data$velikost.druzine <- parse_number(data$velikost.druzine)
  #data$obcina <- parse_factor(data$obcina, levels=obcine)
  #return(data)
#}

# Zapišimo podatke v razpredelnico obcine
#obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.


library(tidyr)
library(dplyr)
library(readr)

#RIVALSTVO DJOKOVIĆ - FEDERER

#preberemo datoteko
Djokovic.Federer.rivalstvo <- read_csv('podatki/Djokovic-Federer-rivalstvo.csv',
                                       locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()
#obdržimo nekatere stolpce
ObdržiStolpce <- c('date', 'tournament', 'surface', 'round', 'winner_name', 'score', 'h2hWL')

#dobimo
Djokovic.Federer.rivalstvo <- Djokovic.Federer.rivalstvo[ , ObdržiStolpce]

#definiramo nove stolpce
stolpci.rivalstvo <- c('Datum', 'Turnir', 'Podlaga', 'Runda', 'Zmagovalec', 'Rezultat', 'Medsebojno')

#preimenujemo stolpce
colnames(Djokovic.Federer.rivalstvo) <- stolpci.rivalstvo



#RIVALSTVO DJOKOVIĆ - MURRAY

#preberemo datoteko
Djokovic.Murray.rivalstvo <- read_csv('podatki/Djokovic-Murray-rivalstvo.csv',
                                       locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()
#obdržimo nekatere stolpce
ObdržiStolpce <- c('date', 'tournament', 'surface', 'round', 'winner_name', 'score', 'h2hWL')

#dobimo
Djokovic.Murray.rivalstvo <- Djokovic.Murray.rivalstvo[ , ObdržiStolpce]

#definiramo nove stolpce
stolpci.rivalstvo <- c('Datum', 'Turnir', 'Podlaga', 'Runda', 'Zmagovalec', 'Rezultat', 'Medsebojno')

#preimenujemo stolpce
colnames(Djokovic.Murray.rivalstvo) <- stolpci.rivalstvo



#RIVALSTVO DJOKOVIĆ - NADAL

#preberemo datoteko
Djokovic.Nadal.rivalstvo <- read_csv('podatki/Djokovic-Nadal-rivalstvo.csv',
                                       locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()
#obdržimo nekatere stolpce
ObdržiStolpce <- c('date', 'tournament', 'surface', 'round', 'winner_name', 'score', 'h2hWL')

#dobimo
Djokovic.Nadal.rivalstvo <- Djokovic.Nadal.rivalstvo[ , ObdržiStolpce]

#definiramo nove stolpce
stolpci.rivalstvo <- c('Datum', 'Turnir', 'Podlaga', 'Runda', 'Zmagovalec', 'Rezultat', 'Medsebojno')

#preimenujemo stolpce
colnames(Djokovic.Nadal.rivalstvo) <- stolpci.rivalstvo



#RIVALSTVO MURRAY - FEDERER

#preberemo datoteko
Murray.Federer.rivalstvo <- read_csv('podatki/Murray-Federer-rivalstvo.csv',
                                       locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()
#obdržimo nekatere stolpce
ObdržiStolpce <- c('date', 'tournament', 'surface', 'round', 'winner_name', 'score', 'h2hWL')

#dobimo
Murray.Federer.rivalstvo <- Murray.Federer.rivalstvo[ , ObdržiStolpce]

#definiramo nove stolpce
stolpci.rivalstvo <- c('Datum', 'Turnir', 'Podlaga', 'Runda', 'Zmagovalec', 'Rezultat', 'Medsebojno')

#preimenujemo stolpce
colnames(Murray.Federer.rivalstvo) <- stolpci.rivalstvo



#RIVALSTVO NADAL - FEDERER

#preberemo datoteko
Nadal.Federer.rivalstvo <- read_csv('podatki/Nadal-Federer-rivalstvo.csv',
                                       locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()
#obdržimo nekatere stolpce
ObdržiStolpce <- c('date', 'tournament', 'surface', 'round', 'winner_name', 'score', 'h2hWL')

#dobimo
Nadal.Federer.rivalstvo <- Nadal.Federer.rivalstvo[ , ObdržiStolpce]

#definiramo nove stolpce
stolpci.rivalstvo <- c('Datum', 'Turnir', 'Podlaga', 'Runda', 'Zmagovalec', 'Rezultat', 'Medsebojno')

#preimenujemo stolpce
colnames(Nadal.Federer.rivalstvo) <- stolpci.rivalstvo



#RIVALSTVO NADAL - MURRAY

#preberemo datoteko
Nadal.Murray.rivalstvo <- read_csv('podatki/Nadal-Murray-rivalstvo.csv',
                                    locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()
#obdržimo nekatere stolpce
ObdržiStolpce <- c('date', 'tournament', 'surface', 'round', 'winner_name', 'score', 'h2hWL')

#dobimo
Nadal.Murray.rivalstvo <- Nadal.Murray.rivalstvo[ , ObdržiStolpce]

#definiramo nove stolpce
stolpci.rivalstvo <- c('Datum', 'Turnir', 'Podlaga', 'Runda', 'Zmagovalec', 'Rezultat', 'Medsebojno')

#preimenujemo stolpce
colnames(Nadal.Murray.rivalstvo) <- stolpci.rivalstvo



#PREGLED DJOKOVIĆEVEGA USPEHA SKOZI KARIERO

#preberemo datoteko
Djokovic.turnirji <- read_csv('podatki/Djokovic-turnirji.csv',
                                    locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()

#definiramo nove stolpce
stolpci.turnirji <- c('Ime turnirja', 'Udeležba', 'Sezone', 'Najboljši rezultat', 'Zadnji rezultat', 
                       'Zmage/Porazi', 'Število pokalov', 'Zmage v %')

#preimenujemo stolpce
colnames(Djokovic.turnirji) <- stolpci.turnirji



#PREGLED FEDERERJEVEGA USPEHA SKOZI KARIERO

#preberemo datoteko
Federer.turnirji <- read_csv('podatki/Federer-turnirji.csv',
                              locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()

#definiramo nove stolpce
stolpci.turnirji <- c('Ime turnirja', 'Udeležba', 'Sezone', 'Najboljši rezultat', 'Zadnji rezultat', 
                      'Zmage/Porazi', 'Število pokalov', 'Zmage v %')

#preimenujemo stolpce
colnames(Federer.turnirji) <- stolpci.turnirji



#PREGLED NADALOVEGA USPEHA SKOZI KARIERO

#preberemo datoteko
Nadal.turnirji <- read_csv('podatki/Nadal-turnirji.csv',
                              locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()

#definiramo nove stolpce
stolpci.turnirji <- c('Ime turnirja', 'Udeležba', 'Sezone', 'Najboljši rezultat', 'Zadnji rezultat', 
                      'Zmage/Porazi', 'Število pokalov', 'Zmage v %')

#preimenujemo stolpce
colnames(Nadal.turnirji) <- stolpci.turnirji



#PREGLED MURRAYEVEGA USPEHA SKOZI KARIERO

#preberemo datoteko
Murray.turnirji <- read_csv('podatki/Murray-turnirji.csv',
                              locale = locale(encoding = 'Windows-1250')) %>% as.data.frame()

#definiramo nove stolpce
stolpci.turnirji <- c('Ime turnirja', 'Udeležba', 'Sezone', 'Najboljši rezultat', 'Zadnji rezultat', 
                      'Zmage/Porazi', 'Število pokalov', 'Zmage v %')

#preimenujemo stolpce
colnames(Murray.turnirji) <- stolpci.turnirji