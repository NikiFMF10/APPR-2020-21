# 2. faza: Uvoz podatkov

library(readr)
library(tidyr)
library(dplyr)
library(reshape2)

sl <- locale("sl", decimal_mark=",", grouping_mark=".")



# POTNIŠKI PREVOZ IN PROMET
potniski_promet <- read_csv2("podatki/Potniski_prevoz_in_promet.csv", col_names = c("Potniki(1000)", "Vrsta_prevoza", 2002:2018),
                    skip = 3, n_max = 8, na = "...",
                    locale=locale(encoding="Windows-1250"))
potniski_promet <- potniski_promet[,-1]

potniski_promet <- melt(potniski_promet, id.vars = "Vrsta_prevoza", measure.vars = names(potniski_promet)[-1],
               variable.name = "Leto", value.name = "Stevilo_potnikov",
               na.rm = TRUE)



# ŠTEVILO OSEBNIH IN SPECIALNIH AVTOMOBILOV GLEDE NA VRSTO GORIVA IN POGONA

pogon_in_goriva <- read_csv2("podatki/Prevozna_sredstva_glede_na_pogon_in_gorivo.csv", col_names = c("Leto","Osebni_in_specialni_avtomobili", "Vrsta_pogona", "Stevilo_osebnih_in_specialnih_avtomobilov"),
                   skip = 4, n_max=36,
                   locale = locale(encoding = "Windows-1250"))
pogon_in_goriva <- pogon_in_goriva[c(3,1,4)] %>% fill(2)

pogon_in_goriva <- filter(pogon_in_goriva, Vrsta_pogona !='NA')
pogon_in_goriva <- filter(pogon_in_goriva, Vrsta_pogona !='Vrsta pogona in goriva - SKUPAJ')


indeks <- dcast(pogon_in_goriva, Vrsta_pogona~Leto, value.var = 'Stevilo_osebnih_in_specialnih_avtomobilov' )
colnames(indeks) <- c("Vrsta_pogona", "a", "b", "c", "d")
indeks <- transform(indeks, Indeks1 = (b-a)*100/a)
indeks <- transform(indeks, Indeks2 = (c-b)*100/b)
indeks <- transform(indeks, Indeks3 = (d-c)*100/c)
indeks <- indeks[c(1,6,7,8)] 
colnames(indeks) <- c("Vrsta_pogona", 2017:2019)

indeks <- melt(indeks, id.vars = "Vrsta_pogona", measure.vars = names(indeks)[-1],
                variable.name = "Leto", value.name = "Indeks")



# POVPREČNA MESEČNA NETO PLAČA PO REGIJAH

neto_placa <- read_delim("podatki/Povprecna_mesecna_neto_placa_po_regijah.csv", delim = ";", col_names = c("Regija", 2007:2019),
                    skip=3, n_max=12, locale = locale(encoding = "Windows-1250"))
neto_placa$Regija <- gsub("Jugovzhodna Slovenija", "Jugovzhodna", neto_placa$Regija)

neto_placa <- neto_placa[c(1,2,3,4,5,6,7,9,10,8,11,12),]
neto_placa <- melt(neto_placa, id.vars = "Regija", measure.vars = names(neto_placa)[-1],
              variable.name = "Leto", value.name = "Neto_placa")

neto_placa2018 <- filter(neto_placa, Leto == '2018')
neto_placa2018 <- neto_placa2018[,-2]
neto_placa2010 <- filter(neto_placa, Leto == '2010')
neto_placa2010 <- neto_placa2010[,-1]



# ŠTEVILO UMRLIH V CESTNOPROMETNIH NESREČAH NA 10.000 REGISTRIRANIH MOTORNIH VOZIL

preminuli <- read_delim("podatki/Stevilo_umrlih_v_cestnoprometnih_nesrecah_na_10.000_registriranih_motornih_vozil.csv", delim=";", col_names = c("nekaj","Regija", 2002:2018),
                    skip=3, n_max=12, locale = locale(encoding = "Windows-1250"))
preminuli <- preminuli[,-1]
preminuli$Regija <- gsub("Jugovzhodna Slovenija", "Jugovzhodna", preminuli$Regija)
preminuli$Regija <- gsub("Spodnjeposavska", "Posavska", preminuli$Regija)
preminuli$Regija <- gsub("Notranjsko-kraška", "Primorsko-notranjska", preminuli$Regija)


preminuli <- melt(preminuli, id.vars = "Regija", measure.vars = names(preminuli)[-1],
              variable.name = "Leto", value.name = "Preminuli")
preminuli$Leto <- as.numeric(levels(preminuli$Leto))[preminuli$Leto]



# ŠTEVILO OSEBNIH AVTOMOBILOV NA 1000 PREBIVALCEV PO REGIJAH

osebni_avtomobili <-read_delim("podatki/Stevilo_osebnih_avtomobilov_na_1000_prebivalcev.csv", delim=";", col_names = c("nekaj","Regija", 2003:2019),
                        skip=3, n_max=12, locale = locale(encoding = "Windows-1250")) 
osebni_avtomobili <- osebni_avtomobili[,-1]
osebni_avtomobili$Regija <- gsub("Jugovzhodna Slovenija", "Jugovzhodna", osebni_avtomobili$Regija)
osebni_avtomobili$Regija <- gsub("Notranjsko-kraška", "Primorsko-notranjska", osebni_avtomobili$Regija)
osebni_avtomobili$Regija <- gsub("Spodnjeposavska", "Posavska", osebni_avtomobili$Regija)

osebni_avtomobili <- melt(osebni_avtomobili, id.vars = "Regija", measure.vars = names(osebni_avtomobili)[-1],
                   variable.name = "Leto", value.name = "Osebni_avtomobili")

osebni_avtomobili$Leto <- as.numeric(levels(osebni_avtomobili$Leto))[osebni_avtomobili$Leto]



# POVPREČNA STAROST OSEBNEGA AVTOMOBILA PO REGIJAH

povprecna_starost <- read_delim("podatki/Povprecna_starost_osebnih_avtomobilov.csv", delim=";", col_names = c("nekaj","Regija", 2003:2019),
                      skip=3, n_max=12, locale = locale(encoding = "Windows-1250"))
povprecna_starost <- povprecna_starost[,-1]
povprecna_starost$Regija <- gsub("Jugovzhodna Slovenija", "Jugovzhodna", povprecna_starost$Regija)
povprecna_starost$Regija <- gsub("Notranjsko-kraška", "Primorsko-notranjska", povprecna_starost$Regija)
povprecna_starost$Regija <- gsub("Spodnjeposavska", "Posavska", povprecna_starost$Regija)

povprecna_starost <- melt(povprecna_starost, id.vars = "Regija", measure.vars = names(povprecna_starost)[-1],
                variable.name = "Leto", value.name = "Povprecna_starost_avtomobila")

povprecna_starost2018 <- filter(povprecna_starost, Leto == '2018')