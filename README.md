# About 
This work present homework number 1, part 1 for the school year 2016/2017 in [Digital Signal Processing](http://tnt.etf.rs/~oe3dos/) in the 3rd year, Department of Electronics, School of Electrical Engineering, University of Belgrade.

# About the homework number 1 in Serbian
Cilj prvog domaćeg zadatka je da studenti samostalno probaju osnovne metode frekvencijske analize signala korišćenjem diskretne Furijeove transformacije i da na realnim primerima uoče prednosti brzih algoritama za izračunavanje diskretne Furijeove transformacije u primeni izračunavanja konvolucije, kao i da ovladaju elementarnim korišćenjem programskog paketa MATLAB u digitalnoj obradi signala.

Domaći zadatak se sastoji iz četiri dela. Prvi deo domaćeg zadatka predstavlja primenu diskretne Furijeove transformacije za izračunavanje konvolucije prilikom emulacije reverberacije zvuka. Drugi deo domaćeg zadatka je poređenje različitih prozorskih funkcija u frekvencijskoj analizi signala. Treći deo zahteva crtanje spektrograma i identifikaciju matematičkog oblika signala iz odbiraka koji su dati. Četvrti i poslednji deo se odnosi na frekvencijsku analizu realnog muzičkog signala.

# Text of the task in Serbian

Reverberacija predstavlja prisustvo zvuka u zatvorenom prostoru i posle prestanka njegovog emitovanja usled kontinualne refleksije o zidove, tavanicu, pod i sl. Popularan naziv je još i eho. Takođe, reverberacija nastaje i u drugim uslovima gde se zvuk odbija od određenih objekata, npr. u uskim ulicama, kanjonima i sl. Ona se može emulirati i za zvukove snimljene u uslovima u kojima nema refleksije zvuka ili je ona malo izražena, npr. u gluvim sobama muzičkih studija. Emulacija reverberacije se postiže obradom zvučnog signala koja se naziva konvolucioni reverb.

Konvolucioni reverb koristi prethodno snimljen impulsni odziv prostora za koji se želi emulirati reverberacija čistog zvučnog signala iz, na primer, gluve sobe. Konvolucijom originalnog signala sa impulsnim odzivom prostora dobija se signal koji je vrlo sličan signalu koji bi se dobio u situaciji da je isti zvuk sniman u tom prostoru. Prilikom snimanja impulsnog odziva, impulsna pobuda je obično pucanj iz pištolja ili drvena klapna.

U prilogu ovog fajla, u direktorijumu deo1, nalaze se dva .wav fajla govornih sekvenci snimljenih u uslovima bez velike refleksije zvuka. Dodatno u direktorijumu deo1/IRs se nalaze tri .wav fajla snimljenih impulsnih odziva na različitim lokacijama. Fotografije koje idu uz fajlove su prikazi lokacija na kojima su snimljeni navedeni impulsni odzivi. Potrebno je napisati MATLAB skriptu koja realizuje sledeće funkcije:

1. Učitati originalni signal i impulsni odziv po izboru i prikazati njihove vremenske oblike na istoj slici jedan ispod drugog. Izračunati njihovu konvoluciju i rezultat skalirati tako da mu maksimalna vrednost po apsolutnoj vrednosti ne prelazi 1. Tako skaliran signal, korišćenjem naredbe audiowrite, smestiti u novi fajl sa imenom reverb_rezultat1_godinaupisa-brojindeksa.wav (npr. reverb_rezultat1_2014-0550.wav). Konvoluciju izračunati korišćenjem diskretne Furijeove transformacije i ugrađene MATLAB funkcije fft. Uporediti vreme izvršavanja ovog metoda i vreme izvršavanja ugrađene MATLAB funkcije conv.

2. U MATLAB-u snimiti neku zvučnu sekvencu trajanja do 2 sekunde, odabrati jedan od ponuđenih impulsnih odziva i rezultat konvolucionog reverba smestiti u fajl sa imenom reverb_rezultat2_godinaupisa-brojindeksa.wav.

3. Nacrtati spektrograme oba ulazna i izlaznog signala primenom proizvoljne prozorske funkcije.

4. Popuniti šablon za izveštaj odgovarajućim rezultatima i odgovoriti na postavljena pitanja.

MATLAB skriptu nazvati reverb_godinaupisa-brojindeksa.m. U kodu komentarima jasno naznačiti koji deo koda se odnosi na koji deo zadatka.

Sve vremenske ose u ovoj tački treba da budu u sekundama. Neophodno je obeležiti sve ose odgovarajućim oznakama/tekstom.

# Some screenshot

![1](https://user-images.githubusercontent.com/16638876/30587332-0d7dbdb2-9d33-11e7-9892-01f60c920132.png)

![2](https://user-images.githubusercontent.com/16638876/30587338-120e3b54-9d33-11e7-9128-bc7e01967297.png)

![3](https://user-images.githubusercontent.com/16638876/30587342-16bb018c-9d33-11e7-99df-db3fabebb3f6.png)
