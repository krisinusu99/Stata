/* importowanei pliku z danymi */
/*/import excel "C:\Users\krysk\OneDrive\Pulpit\Wesele_2024\Nasze_weselne_zdjecia\Kazi Sirajul Islam Data in Excel.xlsx", sheet("Sheet1") firstrow clear*/
/*zmiana nazw na bardziej skojarzone z opisem*/
rename RegardsGreenICTadoptionasCo Green_Adv

rename FirmisgettingpressurefromC reg_pressure

rename GettingpressurefromSuppliers supplier_pressure

rename Gettingpressurefrommajorcus customer_pressure

rename GettingPressurefromourownst staff_pressure

rename hasitsbrandimageforenvironm brand_reputation

rename IsitselfsensitivetotheEnvir env_sensitivity

/* sprawdzanie rozkładu zmiennej zależnej */

tabulate Green_Adv

/* Budowa Modelu ologit */

ologit Green_Adv Gender Age Education CompanyEquity Experience reg_pressure supplier_pressure customer_pressure staff_pressure FirmsfollowstherigidnessofE brand_reputation env_sensitivity Ourfirmsmaincompetitorsget Ourfirmsareperceivedfavourab GreenICTisanopportunityfor firmsfollowworldsrenownedGr haspolicytouseenergyefficie toinstallsoftwaretomakemate Productdistributionanddeliver weinstallsoftwaretoreduceha wetransformourbusinessproces wehavetoolstosubstitutetrav Ourfirmemphasizesonenvironme CSRfacilitatestheGreenICTpr WeusereliableandrepairableI ShiftsPCstoperformothertask sparepartsaresoldthroughint Disposetheobsoleteitemsthrou wehaverecyclingactivitiesfor 
estimates store full_model

/*zapisywanie wyników w pełnej wersji dla testu porównania*/
/* zastosowanie podejścia stepwise dla p- value 5% */
stepwise, pr(0.05): ologit Green_Adv Gender Age Education CompanyEquity Experience reg_pressure supplier_pressure customer_pressure staff_pressure FirmsfollowstherigidnessofE brand_reputation env_sensitivity Ourfirmsmaincompetitorsget Ourfirmsareperceivedfavourab GreenICTisanopportunityfor firmsfollowworldsrenownedGr haspolicytouseenergyefficie toinstallsoftwaretomakemate Productdistributionanddeliver weinstallsoftwaretoreduceha wetransformourbusinessproces wehavetoolstosubstitutetrav Ourfirmemphasizesonenvironme CSRfacilitatestheGreenICTpr WeusereliableandrepairableI ShiftsPCstoperformothertask sparepartsaresoldthroughint Disposetheobsoleteitemsthrou wehaverecyclingactivitiesfor 
/* Zapisanie wyników dla modelu zredukowanego */
estimates store reduced_model
/* Kolejny krok to test założenia rownoleglosci w modelu ologi - efekt zmiennych obhjaśniających stały dla wszystkich progów zmiennej zależnej */
oparallel
/*Testy wskazują na problem jak test Brant, Score i LR. Dwa spośród nich (Woelfe - Gould i Wald) nie wskazują aby doszło do odstępstwa. Spośrod tych co wskazuja na problem test Brant i Score sa wrazliwe gdy mamy do czynienia z nieliniowymi zaleznosciami. Bardziej konserwatywne sa testy Walda i Wolfe - Gould. Z wszytswkich testów wymienionych to test Likelihood ratio jesr najmocniejszy - wymaga dopasowania pełnego i zredukowanego modelu.*/



lrtest full_model reduced_model
/* porównanie modelu długiego i krótkiego - kryterium pojemnosci informacyjnej */
estimates stats full_model reduced_model
/* Wyniki nalezy interperetować wartosciami AIC i BIC. Niższe wartosci otrzymano dla zredukowanego modelu więc stosowanie uproszczonego modelu, więc widać zasadność stosowania go - bo wybieramy zawsze niższe wartości AIC i BIC.*/


 
/*podsumowanie wynikow */

esttab full_model,se star (* 0.10 ** 0.05 *** 0.01) replace using wyniki_ologit.rtf
esttab reduced_model,se star (* 0.10 ** 0.05 *** 0.01) replace using wyniki_ologit.rtf
/* wyniki ostateczne modelu są zapisane do pliku wyniki_ologit.doc - są to te 4 zmienne istotne statystyczne będące w modelu zredukowanym*/
outreg2 using wyniki_ologit.doc,  replace