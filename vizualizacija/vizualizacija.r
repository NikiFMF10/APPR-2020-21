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
                             "SVN_adm1", mapa = 'zemljevid', encoding = "UTF-8")

zemljevid$NAME_1 <- c("Gorenjska", "Goriška","Jugovzhodna", "Koroška", "Primorsko-notranjska", "Obalno-kraška", "Osrednjeslovenska", "Podravska", "Pomurska", "Savinjska", "Posavska", "Zasavska")

zemljevid <- fortify(zemljevid)         



# 1.ZEMLJEVID: POVPREČNO NETO PLAČA V LETU 2018

zemljevid_neto_placa <- ggplot() + geom_polygon(data=left_join(zemljevid, neto_placa2018, by=c("NAME_1"="Regija")),
                                           aes(x=long, y=lat, group=group, fill=Neto_placa)) +
  geom_line() + 
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  guides(fill=guide_colorbar(title="Plača")) +
  ggtitle("Povprečna neto plača po regijah leta 2018") +
  labs(x = " ") +
  labs(y = " ") +
  scale_fill_gradient(low = "white", high = "red",
                      space = "Lab", na.value = "#e0e0d1", guide = "black",
                      aesthetics = "fill")



# 2.ZEMLJEVID: POVPREČNA STAROST OSEBNEGA AVTOMOBILA GLEDE NA REGIJO

zemljevid_povprecna_starost <- ggplot() + geom_polygon(data=left_join(zemljevid, povprecna_starost2018, by=c("NAME_1"= "Regija")),
                                             aes(x=long, y=lat, group=group, fill=Povprecna_starost_avtomobila)) +
  geom_line() + 
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  guides(fill=guide_colorbar(title="Povprečna starost avtomobila")) +
  ggtitle("Povprečna starost avtomobila po regijah leta 2018") +
  labs(x = " ") +
  labs(y = " ") +
  scale_fill_gradient(low = "white", high = "red",
                      space = "Lab", na.value = "#e0e0d1", guide = "black",
                      aesthetics = "fill")


cor(povprecna_starost2018$Povprecna_starost_avtomobila, neto_placa2018$Neto_placa)


osebni_avtomobili1 <- filter(osebni_avtomobili, Leto=='2018')

zemljevid_osebni_avtomobili <- ggplot() + geom_polygon(data=left_join(zemljevid, osebni_avtomobili1, by=c("NAME_1"= "Regija")),
                                                aes(x=long, y=lat, group=group, fill=Osebni_avtomobili)) +
  geom_line() + 
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  guides(fill=guide_colorbar(title="Število avtomobilov")) +
  ggtitle("Število avtomobilov na 1000 prebivalcev leta 2018") +
  labs(x = " ") +
  labs(y = " ") +
  scale_fill_gradient(low = "white", high = "red",
                      space = "Lab", na.value = "#e0e0d1", guide = "black",
                      aesthetics = "fill")