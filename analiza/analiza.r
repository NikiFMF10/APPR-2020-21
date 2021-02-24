# 4. faza: Analiza podatkov

# 1.regresijska premica: ŠTEVILO UMRLIH V CESTNOPROMETNIH NESREČAH NA 10.000 REGISTRIRANIH MOTORNIH VOZIL V NASLEDNJIH LETIH

grupa <- group_by(preminuli, Leto)
preminuli_Slovenija <- summarise(grupa, Stevilo=(sum(Preminuli, na.rm = TRUE)))
preminuli_Slovenija <- transform(preminuli_Slovenija, Stevilo = (Stevilo / 12))
preminuli_Slovenija$Stevilo <- round(preminuli_Slovenija$Stevilo, digits=2)
prileganje <- lm(data = preminuli_Slovenija, Stevilo ~ Leto )
m <- data_frame(Leto=seq(2019,2023,1))
predvidevanje <- mutate(m, Stevilo=predict(prileganje,m))
predvidevanje$Stevilo <- round(predvidevanje$Stevilo, digits = 2)

graf_regresijska_premica_preminulih <- ggplot(preminuli_Slovenija, aes(x=Leto, y=Stevilo)) +
  geom_smooth(method=lm, fullrange = TRUE, color = 'blue') +
  geom_point(data=predvidevanje, aes(x=Leto, y=Stevilo), color='red', size=2) +
  geom_point() +
  labs(title='Predvidevanje števila smrti v prometu v naslednjih letih', y="Stevilo")



# 2.regresijska premica: ŠTEVILO OSEBNIH AVTOMOBILOV NA 1000 PREBIVALCEV V PRIHODNOSTI
oseb_avto <- group_by(osebni_avtomobili,Leto)
oseb_avto1 <- summarise(oseb_avto, Stevilo=sum(Osebni_avtomobili, na.rm=TRUE))
oseb_avto_regije <- transform(oseb_avto1, Stevilo = Stevilo / 12)
oseb_avto_regije$Stevilo <- round(oseb_avto_regije$Stevilo, digits=2)
prileganje <- lm(data = oseb_avto_regije, Stevilo ~ Leto )
n <- data_frame(Leto=seq(2020,2024,1))
predvidevanje_oseb_avto <- mutate(n, Stevilo=predict(prileganje, n))

graf_regresijske_premice_oseb_avto <- ggplot(oseb_avto_regije, aes(x=Leto, y=Stevilo)) +
  geom_smooth(method=lm, fullrange = TRUE, color = 'blue') +
  geom_point(data=predvidevanje_oseb_avto, aes(x=Leto, y=Stevilo), color='red', size=2) +
  geom_point() +
  labs(title='Predvidevanje števila osebnih avtomobilov na 1000 prebivalcev v prometu v prihodnosti', y="Stevilo")



# Cluster regij: ŠTEVILO UMRLIH V CESTNOPROMETNIH NESREČAH

# Preminuli
grup <- group_by(preminuli, Regija)
preminuli_sum <- summarise(grup, vsote=sum(Preminuli, na.rm = TRUE))

preminuli_e <- dcast(preminuli, Regija~Leto, value.var = 'Preminuli' )
preminuli_e <- left_join(preminuli_e, preminuli_sum, by = 'Regija')
preminuli_e <- preminuli_e[order(preminuli_e$vsote, decreasing = FALSE),]
preminuli_b <- preminuli_e[,-19]
preminuli_b <- preminuli_b[,-1]

n <- 5
fit <- hclust(dist(scale(preminuli_b)))
skupine <- cutree(fit, n)

cluster <- mutate(preminuli_e, skupine)
cluster <- cluster[,-2:-19]
colnames(cluster) <- c("Regija", "Preminuli")

# zemljevid

Regije <- unique(zemljevid$NAME_1)
Regije <- as.data.frame(Regije, stringsAsFactors=FALSE) 
names(Regije) <- "Regija"
skupaj <- left_join(Regije, cluster, by="Regija")


zemljevid_cluster_preminuli <- ggplot() + geom_polygon(data=left_join(zemljevid, skupaj, by=c("NAME_1"="Regija")),
                                                   aes(x=long, y=lat, group=group, 
                                                       fill=factor(Preminuli))) +
  geom_line() +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  guides(fill=guide_colorbar(title="Skupine")) +
  ggtitle('Razvrstitev regij v skupine glede na število preminulih v cestnoprometnih nesrečah na 10.000 registriranih motornih vozil') +
  labs(x = " ") +
  labs(y = " ") +
  scale_fill_brewer(palette="YlOrRd", na.value = "#e0e0d1") 



#SHINY

graf.regije <- function(regija){
  ggplot(preminuli %>% filter(Regija %in% regija)) + aes(x=Leto, y=Preminuli, group=Regija, color=Regija) +
    geom_line() + geom_point()+ xlab("Leto") + ylab("Število preminulih") +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))
}

graf_osebni_avto <- function(cifra) {
  ggplot(osebni_avtomobili %>% filter(Leto==cifra), aes(x=Regija, y=Osebni_avtomobili, fill=factor(Regija))) + 
    ylim(0, 650) + geom_bar(stat = "identity") +
    xlab("Regija") + ylab("Število osebnih avtomobilov") +   
    theme(axis.text.x = element_text(angle = 90, size = 8)) +
    labs(fill='Regija')
  
}
