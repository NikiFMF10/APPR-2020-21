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


igralci <- c('Djokovic'='Novak Djokovic',
             'Nadal'='Rafael Nadal',
             'Murray'='Andy Murray',
             'Federer'='Roger Federer')

runde <- c('R128', 'R64', 'R32', 'R16', 'QF', 'SF', 'F', 'W', 'BR', 'S', 'G', 'RR')

turnirji <- lapply(names(igralci), function(igralec)
  sprintf('podatki/%s-turnirji.csv', igralec) %>%
    read_csv(locale=locale(encoding='Windows-1250')) %>%
    mutate(Igralec=igralci[igralec])) %>% bind_rows() %>%
  separate(wonLost, c("Zmage", "Porazi"), sep="-") %>%
  transmute(Igralec=factor(Igralec), Turnir=factor(name),
            Udelezba=eventCount, Sezone=seasons,
            NajboljsiRezultat=parse_factor(bestResult, levels=runde, ordered=TRUE),
            ZadnjiRezultat=parse_factor(lastResult, levels=runde, ordered=TRUE),
            Zmage=parse_number(Zmage), Porazi=parse_number(Porazi), Pokali=titles,
            DelezZmag=parse_number(wonPct))

rivalstvo <- lapply(1:3, function(i)
  lapply((i+1):4, function(j)
    sprintf('podatki/%s-%s-rivalstvo.csv', names(igralci[i]), names(igralci[j])) %>%
      read_csv(locale=locale(encoding='Windows-1250')) %>% group_by(date, round) %>% # začasno združimo,
      mutate(Porazenec=setdiff(igralci[c(i, j)], winner_name)) %>% ungroup()) %>% # da lahko dobimo poraženca
    bind_rows()) %>% bind_rows() %>%
  separate(h2hWL, c("ZmageZmagovalca", "ZmagePorazenca"), sep="-") %>%
  transmute(Datum=date, Turnir=factor(tournament), Podlaga=factor(surface),
            Runda=parse_factor(round, levels=runde, ordered=TRUE),
            Zmagovalec=factor(winner_name), Porazenec=factor(Porazenec),
            Rezultat=score, ZmageZmagovalca=parse_number(ZmageZmagovalca),
            ZmagePorazenca=parse_number(ZmagePorazenca))

udelezbe <- strapply(turnirji$Sezone, "([0-9]{4})(?:-([0-9]{4}))?",
                     function(a, b, ...) as.integer(a):as.integer(ifelse(b == "", a, b)))
udelezba <- turnirji[lapply(1:nrow(turnirji),
                            . %>% rep(length(udelezbe[[.]]))) %>% unlist(),
                     c("Igralec", "Turnir")] %>% data.frame(Sezona=unlist(udelezbe))
