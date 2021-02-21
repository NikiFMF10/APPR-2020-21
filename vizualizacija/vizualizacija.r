# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(ggvis)
library(dplyr)
library(rgdal)
library(mosaic)
library(maptools)
library(ggmap)
library(mapproj)
library(munsell)



# 1.graf POTNIŠKI PREVOZ IN PROMET

graf_potniski_promet <- ggplot(data = potniski_promet, mapping = aes(x=Leto, y=Stevilo_potnikov, group=Vrsta_prevoza, color=Vrsta_prevoza)) +
  geom_line(stat = "identity", position = position_dodge(width = NULL)) +
  theme(axis.text.x = element_text(angle = 90, size = 8)) +
  labs(y='Stevilo potnikov(1000)', color='Vrsta prevoza') +
  theme(legend.text = element_text(size=8)) + 
  ggtitle("Potniški prevoz in promet") 



# 2.graf ŠTEVILO UMRLIH V CESTNOPROMETNIH NESREČAH NA 10.000 REGISTRIRANIH MOTORNIH VOZIL PO REGIJAH

graf_preminuli <- ggplot(data = filter(preminuli, Regija == 'Pomurska' | Regija == 'Podravska' |
                                      Regija == 'Koroška' | Regija == 'Savinjska' | Regija == 'Zasavska' |
                                      Regija == 'Posavska' | Regija == 'Jugovzhodna' | Regija == 'Osrednjeslovenska' |
                                      Regija == 'Gorenjska' | Regija == 'Primorsko-notranjska' |
                                      Regija == 'Goriška' | Regija == 'Obalno-kraška'),
                      mapping = aes(x=Leto, y=Preminuli, color=Regija)) +
                      ggtitle('Število umrlih v cestnoprometnih nesrečah na 10.000 registriranih motornih vozil') +
                      geom_point() +
                      facet_wrap(Regija~., ncol=3) +
                      theme(axis.text.x = element_text(angle = 90, size = 6))



# 3.graf POVPREČNA STAROST OSEBNIH AVTOMOBILOV PO REGIJAH

graf_povprecna_starost <- ggplot(data = povprecna_starost, mapping = aes(x=Regija, y=Povprecna_starost_avtomobila, fill=factor(Leto))) +
  geom_bar(stat = 'identity', position = 'dodge') +
  labs(y = 'Povprecna starost avtomobila') +
  theme(axis.text.x = element_text(angle = 90, size = 8)) +
  ggtitle("Povprečna starost osebnih avtomobilov po regijah")



# 4.graf INDEKS ŠTEVILA OSEBNIH IN SPECIALNIH AVTOMOBILOV GLEDE NA VRSTO GORIVA IN POGONA

graf_pogon_in_gorivo <- ggplot(data=indeks, mapping = aes(x=Leto, y=Indeks, group=Vrsta_pogona, color=Vrsta_pogona))+
  geom_line(stat = 'identity') +
  theme(axis.text.x = element_text(angle = 90, size = 8)) +
  theme(legend.text = element_text(size=8)) + 
  ggtitle("Indeks števila avtomobilov glede na vrsto goriva in pogona") +
  labs(color='Vrsta goriva in pogona')



# Uvozimo zemljevid.

zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", mapa = "zemljevid", encoding = "UTF-8")
 
