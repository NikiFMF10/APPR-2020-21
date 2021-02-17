# Analiza podatkov s programom R, 2020/21

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2020/21

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/NikiFMF10/APPR-2020-21/master?urlpath=shiny/APPR-2020-21/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/NikiFMF10/APPR-2020-21/master?urlpath=rstudio) RStudio

## Analiza cestnega prometa v Sloveniji

V svoji projektni nalogi bom preučil nekatere ključne stvari cestnega prometa v Sloveniji.

Analiziral bom, katera prevozna sredstva ljudje uporabljajo in kako se to razlikuje skozi daljše časovno obdobje. Poleg tega bom prikazal količinsko razliko uporabljenih cestnih vozil po regijah tudi skozi leta, prav tako pa pogledal porast uporabe osebnih in specialnih avtomobilov na alternativne vire goriva v skrajnih letih. Podobno si bom prizadeval v najdbi povezave med povprečno starostjo osebnih avtomobilov in povprečno mesečno neto plačo po regijah ter preveriti to spremembo med plačo in starostjo osebnega avtomobila v nekem daljšem časovnem intervalu. Za nameček bom pogledal še, kako se spreminja število umrlih v cestnoprometnih nesrečah na 10.000 registriranih motornih vozil po posameznih regijah. Ob pomoči analize podatkov bom izsledil navezo med deležem potnikov in prometnih nesreč, glede na uporabo določenih prevoznih sredstev.

Cilji moje proučitve bodo opažanje sprememb različnih prevoznih sredstev, število umrlih, povprečni delež osebnih avtomobilov in povprečna starost le teh skozi leta. Nekatere spremembe bodo prikazane glede na regije v Sloveniji.

#### Tabele:
Tabela 1 (potniski promet: Število potnikov v različnih prevoznih sredstvih):

- `Vrsta_prevoza` - spremenljivka: prevozno sredstvo
- `Leto` - spremenljivka: leto
- `Potniki` - meritev: število potnikov v 1000

Tabela 2 (pogon in goriva: Število osebnih in specialnih avtomobilov glede na vrsto goriva in pogona):

- `Vrsta_pogona` - spremenljivka: Vrsta pogona osebnih avtomobilov   
- `Leto` - spremenljivka: leto
- `Stevilo_avtomobilov` - meritev: število avtomobilov v prometu

Tabela 3 (preminuli: Število umrilih v cestnoprometnih nesrečah na 10.000 regitriranih motornih vozil po regijah):

- `Regija` - spremenljivka: regija
- `Leto` - spremenljivka: leto
- `Umrli` - meritev: število umrlih na 10.000 registriranih motornih vozil

Tabela 4 (osebni avtomobili: Število osebnih avtomobilov na 1000 prebivalcev po regijah):

- `Regija` - spremenljivka: regija
- `Leto` - spremenljivka: leto
- `Avtomobili` - meritev: število avtomobilov na 1000 prebivalcev

Tabela 5 (starost avtomobilov: Povprečna starost osebnih avtomobilov po regijah):

- `Regija` - spremenljivka: regija
- `Leto` - spremenljivka: leto
- `Preminuli` - meritev: povprečna starost avtomobila


##### Viri:
* [Statistični urad Republike Slovenije] (https://pxweb.stat.si/SiStat/sl/Podrocja/Index/48/transport)


## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `rgeos` - za podporo zemljevidom
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `tidyr` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `tmap` - za izrisovanje zemljevidov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-202021)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
