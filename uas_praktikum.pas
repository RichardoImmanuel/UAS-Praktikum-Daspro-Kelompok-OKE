program KalkulatorNutrisiHarian;

//6. Menggunakan Record
type
    TKebutuhan = record
        Kalori, Protein, Lemak, Karbo: real;
    end;

    TMakanan = record
        Nama: string[30];
        K100, P100, L100, C100: real; // K=Kalori, P=Protein, L=Lemak, C=Karbo per 100g
        Porsi: real; // Porsi yang dimakan (gram)
    end;

//3. Menggunakan Array
const
    MAX_ITEM = 15;
var
    Daftar: array[1..MAX_ITEM] of TMakanan;
    N: integer; // Jumlah makanan yang diinput
    Target: TKebutuhan;
    Total: TKebutuhan;

//2. Minimal menggunakan 4 Fungsi/Prosedur

// Procedure 1: Input target
procedure SetTarget;
begin
    writeln('--- Target Harian (per gram) ---');
    write('Kalori (kcal): '); readln(Target.Kalori);
    write('Protein (g): '); readln(Target.Protein);
    write('Lemak (g): '); readln(Target.Lemak);
    write('Karbohidrat (g): '); readln(Target.Karbo);
    writeln;
end;

//Procedure 2: Input Konsumsi (menggunakan Looping)
procedure InputData;
var
    i: integer;
    Lanjut: char;
begin
    N := 0;
    writeln('--- Input Makanan yang Dikonsumsi ---');
    
    //5. Menggunakan Perulangan (while loop)
    i := 1;
    while (i <= MAX_ITEM) do
    begin
        write('Input makanan (Y/T)? '); readln(Lanjut);
        if upcase(Lanjut) = 'T' then break;
        
        writeln('Data Makanan ke-', i);
        write('Nama: '); readln(Daftar[i].Nama);
        write('K/100g: '); readln(Daftar[i].K100);
        write('P/100g: '); readln(Daftar[i].P100);
        write('L/100g: '); readln(Daftar[i].L100);
        write('C/100g: '); readln(Daftar[i].C100);
        write('Porsi (gram): '); readln(Daftar[i].Porsi);
        
        N := i;
        i := i + 1;
    end;
    writeln;
end;

//Function 3: Hitung total nutrisi
procedure HitungTotal;
var
    i: integer;
    Faktor: real;
begin
    Total.Kalori := 0; Total.Protein := 0; Total.Lemak := 0; Total.Karbo := 0;

    //5. Menggunakan Perulangan (for loop)
    for i := 1 to N do
    begin
        Faktor := Daftar[i].Porsi / 100.0;
        Total.Kalori := Total.Kalori + (Daftar[i].K100 * Faktor);
        Total.Protein := Total.Protein + (Daftar[i].P100 * Faktor);
        Total.Lemak := Total.Lemak + (Daftar[i].L100 * Faktor);
        Total.Karbo := Total.Karbo + (Daftar[i].C100 * Faktor);
    end;
end;

//Procedure 4: Menampilkan dan menganalisis hasil
procedure TampilAnalisis;
var
    StatusK: string;
begin
    writeln('=================================');
    writeln('       LAPORAN AKHIR NUTRISI     ');
    writeln('=================================');
    
    writeln('Target | Total Konsumsi');
    writeln('---------------------------------');
    writeln('K: ', Target.Kalori:0:0, ' kcal | ', Total.Kalori:0:2, ' kcal');
    writeln('P: ', Target.Protein:0:0, ' g  | ', Total.Protein:0:2, ' g');
    writeln('L: ', Target.Lemak:0:0, ' g  | ', Total.Lemak:0:2, ' g');
    writeln('C: ', Target.Karbo:0:0, ' g  | ', Total.Karbo:0:2, ' g');
    writeln('---------------------------------');
    
    //Menggunakan Operasi Kondisi (If-Else)
    if Total.Kalori > Target.Kalori then
        StatusK := 'KELEBIHAN KALORI'
    else if Total.Kalori < Target.Kalori * 0.9 then
        StatusK := 'DEFISIT KALORI'
    else
        StatusK := 'KALORI SESUAI';
        
    writeln('STATUS: ', StatusK);
    
    //If-Else lanjutan Protein
    if Total.Protein < Target.Protein * 0.8 then
        writeln('SARAN: Tingkatkan asupan protein hari ini!');
    
    writeln('=================================');
end;

begin
    SetTarget;
    InputData;
    HitungTotal;
    TampilAnalisis;

    readln;
end.