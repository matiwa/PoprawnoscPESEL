program PoprawnoscPESEL;

uses
SysUtils;

var
PESEL : array [0..10] of Integer;
poprawnosc : boolean;
ciagPESEL : String;
nazwaMiesiaca : String;

function zwrocRokUrodzenia(): integer;
var
rok : integer;
miesiac : integer;
begin

rok := 10 * PESEL[0];
rok := rok + PESEL[1];
miesiac := 10 * PESEL[2];
miesiac := miesiac + PESEL[3];
if (miesiac > 80) and (miesiac < 93) then
rok := rok + 1800
else if (miesiac > 0) and (miesiac < 13) then
rok := rok + 1900
else if (miesiac > 20) and (miesiac < 33) then
rok := rok + 2000
else if (miesiac > 40) and (miesiac < 53) then
rok := rok + 2100
else if (miesiac > 60) and (miesiac < 73) then
rok := rok + 2200;
result := rok;
end;

function zwrocMiesiacUrodzenia(): integer;
var
miesiac : integer;
begin
miesiac := 10 * PESEL[2];
miesiac := miesiac + PESEL[3];
if (miesiac > 80) and (miesiac < 93) then
miesiac := miesiac -80
else if (miesiac > 20) and (miesiac < 33) then
miesiac := miesiac - 20
else if (miesiac > 40) and (miesiac < 53) then
miesiac := miesiac - 40
else if (miesiac > 60) and (miesiac < 73) then
miesiac := miesiac - 60;
result := miesiac;
end;

function zwrocDzienUrodzenia(): integer;
var
dzien : integer;
begin
dzien := 10 * PESEL[4];
dzien := dzien + PESEL[5];
result := dzien;
end;

function zwrocPlec(): string;
begin
if (poprawnosc) then
if (PESEL[9] mod 2 = 1) then
result := 'Mezczyzna'
else
result := 'Kobieta'
else
result := '---'
end;

function sprawdzSumeKontrolna(): boolean;
var
suma : integer;
begin
suma := 1 * PESEL[0] +
3 * PESEL[1] +
7 * PESEL[2] +
9 * PESEL[3] +
1 * PESEL[4] +
3 * PESEL[5] +
7 * PESEL[6] +
9 * PESEL[7] +
1 * PESEL[8] +
3 * PESEL[9];
suma := suma mod 10;
suma := 10 - suma;
suma := suma mod 10;

if (suma = PESEL[10]) then
result := true
else
result := false;
end;

function sprawdzMiesiac(): boolean;
var
miesiac : integer;
begin
miesiac := zwrocMiesiacUrodzenia();
if (miesiac > 0) and (miesiac < 13) then
result := true
else
result := false;
end;

function przestepny(rok: integer): boolean;
begin
if (rok mod 4 = 0) and (rok mod 100 <> 0) or (rok mod 400 = 0) then
result := true
else
result := false;
end;

function  sprawdzDzien(): boolean;
var
rok : integer;
miesiac : integer;
dzien : integer;
begin
rok := zwrocRokUrodzenia();
miesiac := zwrocMiesiacUrodzenia();
dzien := zwrocDzienUrodzenia();
if ((dzien >0) and (dzien < 32) and
((miesiac = 1) or (miesiac = 3) or (miesiac = 5) or
(miesiac = 7) or (miesiac = 8) or (miesiac = 10) or
(miesiac = 12))) then
result := true
else if ((dzien >0) and (dzien < 31) and
((miesiac = 4) or (miesiac = 6) or (miesiac = 9) or
(miesiac = 11))) then
result := true
else if (((dzien >0) and (dzien < 30) and (przestepny(rok))) or
((dzien >0) and (dzien < 29) and not(przestepny(rok)))) then
result := true
else
result := false;
end;

procedure zweryfikujPESEL(numerPesel: String);
var
i : integer;
begin

if (length(numerPesel) <> 11) then
poprawnosc := false
else
begin
for i := 0 to 10  do
PESEL[i] := StrToInt(numerPesel[i+1]);
if (sprawdzSumeKontrolna()) and (sprawdzMiesiac()) and (sprawdzDzien()) then
poprawnosc := true
else
poprawnosc := false;
end;
end;

function zwrocNazweMiesiaca(numerMiesiaca: integer): string;
begin
if numerMiesiaca = 1 then result := 'styczen';
if numerMiesiaca = 2 then  result := 'luty';
if numerMiesiaca = 3 then  result := 'marzec';
if numerMiesiaca = 4 then  result := 'kwiecien';
if numerMiesiaca = 5 then  result := 'maj';
if numerMiesiaca = 6 then  result := 'czerwiec';
if numerMiesiaca = 7 then  result := 'lipiec';
if numerMiesiaca = 8 then  result := 'sierpien';
if numerMiesiaca = 9 then  result := 'wrzesien';
if numerMiesiaca = 10 then  result := 'pazdziernik';
if numerMiesiaca = 11 then  result := 'listopad';
if numerMiesiaca = 12 then  result := 'grudzien';
end;

begin
write('Wprowadz PESEL: ');
readln(ciagPESEL);

zweryfikujPESEL(ciagPESEL);

writeln();

if poprawnosc then
begin
writeln('PESEL: poprawny');
writeln();
writeln('Data urodzenia: '+IntToStr(zwrocDzienUrodzenia())+' '+zwrocNazweMiesiaca(zwrocMiesiacUrodzenia())+' '+IntToStr(zwrocRokUrodzenia()));
writeln();
writeln('Plec: ' + zwrocPlec());
end
else
begin
writeln('PESEL: niepoprawny');
end;
readln();
end.
