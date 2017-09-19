%%%%%
% Stefan Tesanovic 2016/0675
%%%%%%

close all
clear all
clc

%%%%%
% Podesavanje programa
%%%%%%


h = msgbox({'Deo 1: Konvolucioni reverb - Upustvo za koriscenje programa'
'______________________________________________ '
'U glavnom komandnom prozoru ce se pojavljivati pitanja na koja je potrebno da odgovorite sa Y/N gde Y ima znacenje da, a N ne. Mozete koristiti mala ili velika slova. U slucaju da ste uneli pogresan odgovor, program ce vam ponoviti pitanje i traziti ispravan unos.'
'Podesavanja se sastoje iz nekoliko segmenata:'
'______________________________________________ '
'Segment 1: Ukljucivanje interaktivnosti programa'
'______________________________________________ '
'Da li zelite da program bude interaktivan? Y/N'
'______________________________________________ '
'Segment 2: Odabir originalnog signala'
'______________________________________________ '
' Potrebno je uneti broj 1 ili 2 u zavisnosti koji originalan signal zelite da ucitate'
' 1. signal je its_about_time'
' 2. signal je tasty_burger'
'______________________________________________ '
'Segment 3: Odabir impulsnog odziva'
'______________________________________________ '
' Potrebno je uneti broj 1, 2 ili 3 u zavisnosti koji impulsni odziv zelite da ucitate'
' 1. Uska ulica u Nemackoj'
' 2. Veliki kanjon Kolorada'
' 3. Dolina u Nemackoj'
'______________________________________________ '
'Segment 4: Odabir impulsnog odziva za tacku 2.'
'______________________________________________ '
' Potrebno je uneti broj 1, 2 ili 3 u zavisnosti toga koji impulsni odziv zelite da ucitate radi primene konvolucije na snimljeni signal'
' 1. Uska ulica u Nemackoj'
' 2. Veliki kanjon Kolorada'
' 3. Dolina u Nemackoj'
'______________________________________________ '
'Segment 5: Odabir signala za crtanje spektograma'
'______________________________________________ '
' Potrebno je uneti broj 1 ili 2 u zavisnosti od toga da li zelite da crtate spektogram signala iz prve ili druge tacke.'
' 1. Signali iz 1. tacke.'
' 2. Signali iz 2. tacke.'
'______________________________________________ '
'Segment 6: Odabir prozorske funkcije'
'______________________________________________ '
'Potrebno je uneti broj od 1 do 5 u zavisnosti koju prozorsku funkciju zelite da primenite:'
' 1. Pravougaona prozorska funkcija - boxcar(N).'
' 2. Trougaona prozorska funkcija - triang(N).'
' 3. Hanova prozorska funkcija - hanning(N).'
' 4. Hamingova prozorska funkcija - hamming(N).'
' 5. Blekmanova prozorska funkcija - blackman(N).'
'______________________________________________ '
'by Stefan Tesanovic, OE, 675/2016 '
},'Upustvo - za pokretanje','help');

flag = true;
while flag
    prompt = 'Da li zelite da program bude interaktivan? Y/N [Y]: ';
    strInter = input(prompt,'s');
    if isempty(strInter)
    strInter = 'N';
    end

    if ( (strInter=='Y') || (strInter=='y') || (strInter=='N') || (strInter=='n') )
        flag = false;
    end
end

if ( (strInter=='Y') || (strInter=='y')  )
    
    flag = true;
    while flag
        disp('Potrebno je ucitati originalan signal.');
        disp(' 1. signal je its_about_time');
        disp(' 2. signal je tasty_burger');
        prompt = 'Unesite broj 1 ili 2 za ucitavanje signala [1]: ';
        strOrg = input(prompt,'s');
        if isempty(strOrg)
        strOrg = '1';
        end

        if ( (strOrg=='1') || (strOrg=='2') )
            flag = false;
        end
    end
    
    flag = true;
    while flag
        disp('Potrebno je ucitati impulsni odziv.');
        disp(' 1. Uska ulica u Nemackoj');
        disp(' 2. Veliki kanjon Kolorada');
        disp(' 3. Dolina u Nemackoj');
        prompt = 'Unesite broj 1, 2 ili 3 za ucitavanje impulsnog odziva [1]: ';
        strImp = input(prompt,'s');
        if isempty(strImp)
        strImp = '1';
        end

        if ( (strImp=='1') || (strImp=='2') || (strImp=='3') )
            flag = false;
        end
    end
    
else 
    %Ne zelimo da nam program bude interaktivan
    strOrg = '1';
    strImp = '1';
end

%%%%%
% Tacka 1. 
%%%%%%

%Ucitavamo zeljeno signal i odgovarajuci impulsni odziv
%Ucitavanjem signala vidimo da je upitanju mono signal
if (strOrg=='1') 
    [x, Fx] = audioread('its_about_time.wav');
    nameSignal= 'Its about time';
elseif (strOrg=='2')
    [x, Fx] = audioread('tasty_burger.wav');
    nameSignal= 'Tasty burger';
end


%Ucitavanjem nekog od impulsnih odziva vidimo da su upitanju stereo signali
%i njih je potrebno da pretvorimo u mono signale. To je moguce uraditi na
%nakoliko nacina. Ja sam se opredelio za sledeci nacin:
% mono = (sound(:,1)+sound(:,2))/2;
if (strImp=='1') 
    [h, Fh] = audioread('IRs/01.wav');
    nameImpuls= ' 1. Uska ulica u Nemackoj';
elseif (strImp=='2')
    [h, Fh] = audioread('IRs/02.wav');
    nameImpuls= ' 2. Veliki kanjon Kolorada';
elseif (strImp=='3')
    [h, Fh] = audioread('IRs/03.wav');
    nameImpuls= ' 3. Dolina u Nemackoj';
end

hmono = (h(:,1)+h(:,2))/2;

tx = 1/Fx:1/Fx:length(x)/Fx;
th = 1/Fh:1/Fh:length(hmono)/Fh;

figure(1);
subplot(3,1,1), plot(tx,x);
title(['Originalni signal - ',nameSignal]),xlabel('t[s]'), ylabel('x(t) [V]');
subplot(3,1,2), plot(th,h);
title(['Impulsni odziv - ',nameImpuls,' / stereo']), xlabel('t[s]'), ylabel ('h(t) [V]');
subplot(3,1,3), plot(th,hmono);
title(['Impulsni odziv - ',nameImpuls, ' / mono']), xlabel('t[s]'), ylabel ('h(t) [V]');

%Sada nalazimo konvuluciju ova dva signala. Konvoluciju je moguce naci na
%dva nacina primenom fft(Diskretne furijerove transformacije) ili
%ugradjenom MATLAB funkcijom conv


N=length(x)+length(hmono)-1;
disp('Start fft.')
t0=clock;
for i=1:10
    X=fft(x,N);
    H=fft(hmono,N);
    Yfft=X.*H;
    yfft=ifft(Yfft);
end
vreme1=0.1*etime(clock,t0);
disp('End of fft.')
s1=sprintf('Vreme izvrsavanja fft metodom: %.5f s \n',vreme1);
disp(s1);

%Ukoliko zelimo da skaliramo amplitudu da bude izmedu intervala [a,b]
%Koristimo sledecu formulu x_scaled = (x-min(x))*(b-a)/(max(x)-min(x)) + a;
%U slucaju da su svi elementi pozitivni onda mozemo da koristimo metod da Y
%podelimo sa najvecim elementom iz matrice Y, y=y/max(y(:)) Ali kako se
%trazilo po apsolutnoj vrednosti da pripada intervalu [-1,1] taj metod nije
%moguce primeniti

yfftskal=(yfft-min(yfft))*2/(max(yfft)-min(yfft)) - 1;
audiowrite('reverb_rezultat1_fft_2016_0675.wav',yfftskal,Fx);

disp('Start conv.')
t0=clock;
%for i=1:10
    yconv=conv(x,hmono);
%end
vreme2=0.1*etime(clock,t0);
disp('End of conv.')
s2=sprintf('Vreme izvrsavanja conv funkcijom: %.5f s \n',vreme2);
disp(s2);
yconvskal=(yconv-min(yconv))*2/(max(yconv)-min(yconv)) - 1;
audiowrite('reverb_rezultat1_conv_2016_0675.wav',yconvskal,Fx);


tfft = 1/Fx:1/Fx:length(yfftskal)/Fx;
tconv = 1/Fx:1/Fx:length(yconvskal)/Fx;

figure(2);
subplot(211); plot(tfft,yfftskal);
title('Konvolucija fft y(t)[V]');
xlabel('t[s]'); ylabel('y(t)[V]');

subplot(212);plot(tconv,yconvskal);
title('Konvolucija conv y(t)[V]');
xlabel('t[s]'); ylabel('y(t)[V]');

%%%%%
% Tacka 2. 
%%%%%%

%snimanje zvucne sekvence trajanja dve sekunde
rec_time = 2; %vreme snimanja
Fs = 44100;
recObj = audiorecorder(Fs, 16, 1); %help audiorecorder
top_freq = 1500;	%gornja ucestanost za prikaz spektra

disp('Start recording.')
recordblocking(recObj, rec_time);
disp('End of Recording.');
disp(' ');

%dohvatamo snimljeni signal
xRec = getaudiodata(recObj);
%snimamo simljeni signal
audiowrite('reverb_rezultat2_snimak_2016_0675.wav',xRec,Fs);


if ( (strInter=='Y') || (strInter=='y')  )
    
    flag = true;
    while flag
        disp('Potrebno je ucitati impulsni odziv.');
        disp(' 1. Uska ulica u Nemackoj');
        disp(' 2. Veliki kanjon Kolorada');
        disp(' 3. Dolina u Nemackoj');
        prompt = 'Unesite broj 1, 2 ili 3 za ucitavanje impulsnog odziva [2]: ';
        strImpRec = input(prompt,'s');
        if isempty(strImpRec)
        strImpRec = '2';
        end

        if ( (strImpRec=='1') || (strImpRec=='2') || (strImpRec=='3') )
            flag = false;
        end
    end
    
else 
    %Ne zelimo da nam program bude interaktivan
    strImpRec = '2';
end

if (strImpRec=='1') 
    [hRec, Fhrec] = audioread('IRs/01.wav');
    nameImpuls= ' 1. Uska ulica u Nemackoj';
elseif (strImpRec=='2')
    [hRec, Fhrec] = audioread('IRs/02.wav');
    nameImpuls= ' 2. Veliki kanjon Kolorada';
elseif (strImpRec=='3')
    [hRec, Fhrec] = audioread('IRs/03.wav');
    nameImpuls= ' 3. Dolina u Nemackoj';
end

hmonoRec = (hRec(:,1)+hRec(:,2))/2;

Nrec=length(xRec)+length(hmonoRec)-1;

XRec=fft(xRec,Nrec);
HRec=fft(hmonoRec,Nrec);
YRec=XRec.*HRec;
yRec=ifft(YRec);

%U Tacki 2 ne stoji da li signal treba da se skalira ili ne, ali moja 
yRecskal=(yRec-min(yRec))*2/(max(yRec)-min(yRec)) - 1;
audiowrite('reverb_rezultat2_fft_2016_0675.wav',yRecskal,Fs);

tRecX = 1/Fs:1/Fs:length(xRec)/Fs;
tRecH = 1/Fs:1/Fs:length(hRec)/Fs;
tRecY = 1/Fs:1/Fs:length(yRecskal)/Fs;

figure(3);
subplot(3,1,1), plot(tRecX,xRec);
title(['Originalni signal - ',nameSignal]),xlabel('t[s]'), ylabel('x(t)[V]');
subplot(3,1,2), plot(tRecH,hmonoRec);
title(['Impulsni odziv - ',nameImpuls,' / mono']), xlabel('t[s]'), ylabel ('h(t)[V]');
subplot(3,1,3), plot(tRecY,yRecskal);
title('Signal nakon fft '), xlabel('t[s]'), ylabel ('y(t)[V]');

%%%%%
% Tacka 3. 
%%%%%%


if ( (strInter=='Y') || (strInter=='y')  )
    
    flag = true;
    while flag
        disp(' ');
        disp('Potrebno je uneti broj 1 ili 2 u zavisnosti od toga da li zelite da crtate spektogram signala iz prve ili druge tacke.');
        disp(' 1. Spektogram odabranog signala, odabranog impulsa i rezultata dobijenog fft.');
        disp(' 2. Spektogram snimljenog signala, odabranog impulsa i rezultata dobijenog fft.');
        prompt = 'Unesite broj 1 ili 2. [1]: ';
        strSpec = input(prompt,'s');
        if isempty(strSpec)
        strSpec = '1';
        end

        if ( (strSpec=='1') || (strSpec=='2') )
            flag = false;
        end
    end
    
else 
    %Ne zelimo da nam program bude interaktivan
    strSpec = '1';
end



nfft =4096;

if ( (strInter=='Y') || (strInter=='y')  )
    
    flag = true;
    while flag
        disp(' ');
        disp('Potrebno je uneti broj u zavisnosti koju prozorsku funkciju zelite da primenite:');
        disp(' 1. Pravougaona prozorska funkcija - boxcar(N).');
        disp(' 2. Trougaona prozorska funkcija - triang(N).');
        disp(' 3. Hanova prozorska funkcija - hanning(N).');
        disp(' 4. Hamingova prozorska funkcija - hamming(N).');
        disp(' 5. Blekmanova prozorska funkcija - blackman(N).');
        prompt = 'Unesite broj od 1 do 5 za odabir prozorske funkcije [1]:';
        strWind = input(prompt,'s');
        if isempty(strWind)
        strWind = '1';
        end

        if ( (strWind=='1') || (strWind=='2') || (strWind=='3')|| (strWind=='4')|| (strWind=='5'))
            flag = false;
        end
    end
    
else 
    %Ne zelimo da nam program bude interaktivan
    strWind = '1';
end

if (strWind=='1')
    ws = boxcar(nfft);
    nameWIn= ' boxcar(N)';
end
if (strWind=='2')
    ws = triang(nfft);
    nameWIn= ' triang(N)';
end
if (strWind=='3')
    ws = hanning(nfft);
    nameWIn= ' hanning(N)';
end
if (strWind=='4')
    ws = hamming(nfft);
    nameWIn= ' hamming(N)';
end
if (strWind=='5')
    ws = blackman(nfft);
    nameWIn= ' blackman(N)';
end


preklapanje=3/4*nfft;

if (strSpec=='1')

    %Spektogram ucitanog ulaznog signala
    [B_x,f_x,t_x] = spectrogram(x, ws, preklapanje, nfft, Fx);
    B_xdB = 20*log10(abs(B_x));
    
    %Spektogram ucitanog impulsnog odziva
    [B_h,f_h,t_h] = spectrogram(hmono, ws, preklapanje, nfft, Fh);
    B_hdB = 20*log10(abs(B_h));
    
    %Spektogram ucitanog impulsnog odziva
    [B_y,f_y,t_y] = spectrogram(yfftskal, ws, preklapanje, nfft, Fx);
    B_ydB = 20*log10(abs(B_y));
    
    figure(4);
    imagesc(t_x, f_x, abs(B_xdB));
    title(['Spectrogram signala ',nameWIn]);
    axis('xy');xlabel('t[s]');ylabel('f[Hz]');

    figure(5);
    imagesc(t_h, f_h, abs(B_hdB));
    title(['Spectrogram impulsnog odziva ',nameWIn]);
    axis('xy');xlabel('t[s]');ylabel('f[Hz]');

    figure(6);
    imagesc(t_y, f_y, abs(B_ydB));
    title(['Spectrogram izlaznog signala ',nameWIn]);
    axis('xy');xlabel('t[s]');ylabel('f[Hz]');
    
else
    %Spektogram snimlnenog ulaznog signala
    [B_x,f_x,t_x] = spectrogram(xRec, ws, preklapanje, nfft, Fs);
    B_xdB = 20*log10(abs(B_x));
    
    %Spektogram ucitanog impulsnog odziva
    [B_h,f_h,t_h] = spectrogram(hmonoRec, ws, preklapanje, nfft, Fhrec);
    B_hdB = 20*log10(abs(B_h));
    
    %Spektogram ucitanog impulsnog odziva
    [B_y,f_y,t_y] = spectrogram(yRecskal, ws, preklapanje, nfft, Fs);
    B_ydB = 20*log10(abs(B_y));
    
    figure(4);
    imagesc(t_x, f_x, abs(B_xdB));
    title(['Spectrogram signala ',nameWIn]);
    axis('xy');xlabel('t[s]');ylabel('f[Hz]');

    figure(5);
    imagesc(t_h, f_h, abs(B_hdB));
    title(['Spectrogram impulsnog odziva ',nameWIn]);
    axis('xy');xlabel('t[s]');ylabel('f[Hz]');

    figure(6);
    imagesc(t_y, f_y, abs(B_ydB));
    title(['Spectrogram izlaznog signala ',nameWIn]);
    axis('xy');xlabel('t[s]');ylabel('f[Hz]');
    
end




