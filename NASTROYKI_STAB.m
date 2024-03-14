clc

%out.tout=[];

NumberRezhim=1 %4 - бесцельный режим,5 - целевой режим, 6 - разгрузка

Kanal=1;

tau=0.02; % минималное время импульса
dt=5;
DtR=pi/180;
RtD=1/DtR;

J1M=2; %момент инерции
J2M=2;
J3M=2;
%Момент инерции корпуса
J1K=6937;
J2K=6837;
J3K=1122; 

M1B=1e-5;
M2B=1e-6;
M3B=1e-5;

g_1M=M1B/J1K;
g_2M=M2B/J2K;
g_3M=M3B/J3K;

L01=0;
L02=0;
L03=0;
%Mu2

%МАХОВИКИ////
%ПАССИВНЫЙ РЕЖИМ.........................
if NumberRezhim==4
%Точность по режиму

Mu=1;
Mu1=350e-3;
Mu2=350e-3;
Mu3=350e-3;
yZV=0.1;
xZV=10;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;

%Канал крена
alpha_1M=0.9*Xmax1;
h_1M=0.2*alpha_1M;
k_1M=h_1M/(2*yZV);%20;
a_1M=Mu1/J1K;
x_0_1M=xZV*3;
y_0_1M=a_1M*tau/2;

%Канал курса
alpha_2M=0.9*Xmax2;
h_2M=0.2*alpha_2M;
k_2M=h_2M/(2*yZV);%20;
a_2M=Mu2/J2K;
x_0_2M=xZV*3;
y_0_2M=a_2M*tau/2;

%Канал тангажа
alpha_3M=0.9*Xmax3;
h_3M=0.2*alpha_3M;
k_3M=(h_3M/(2*yZV)); %10
a_3M=Mu3/J3K;
x_0_3M=xZV*3;
y_0_3M=a_3M*tau/2;
end

%ЦЕЛЕВОЙ РЕЖИМ.........................

if NumberRezhim==5
Mu=25e-3;
Mu1=25e-3;
Mu2=25e-3;
Mu3=5e-3;
    
xZV=0.09;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;
yZV=0.001;
%Канал крена
alpha_1M=0.9*Xmax1;
h_1M=0.2*alpha_1M;
k_1M=h_1M/(2*yZV);
a_1M=Mu1/J1K;
x_0_1M=xZV*3;
y_0_1M=a_1M*tau/2;

%Канал курса
alpha_2M=0.9*Xmax2;
h_2M=0.2*alpha_2M;
k_2M=h_2M/(2*yZV);
a_2M=Mu2/J2K;
x_0_2M=xZV*3;
y_0_2M=a_2M*tau/2;

%Канал тангажа
alpha_3M=0.9*Xmax3;
h_3M=0.2*alpha_3M;
k_3M=h_3M/(2*yZV);
a_3M=Mu3/J3K;
x_0_3M=xZV*3;
y_0_3M=a_3M*tau/2;


end

%Разгрузка маховика
if NumberRezhim==6
MuR=25e-3;
g_1M=g_1M+MuR/J1K;
g_2M=g_2M+MuR/J2K;
g_3M=g_3M+MuR/J3K;

Mu1=20;
Mu2=20;
Mu3=20;
    
xZV=30;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;
yZV=1;
%Канал крена
alpha_1M=0.9*Xmax1;
h_1M=0.2*alpha_1M;
k_1M=h_1M/(2*yZV);
a_1M=Mu1/J1K;
x_0_1M=xZV;
y_0_1M=yZV;

%Канал курса
alpha_2M=0.9*Xmax2;
h_2M=0.2*alpha_2M;
k_2M=h_2M/(2*yZV);
a_2M=Mu2/J2K;
x_0_2M=xZV;
y_0_2M=yZV;

%Канал тангажа
alpha_3M=0.9*Xmax3;
h_3M=0.2*alpha_3M;
k_3M=h_3M/(2*yZV);
a_3M=Mu3/J3K;
x_0_3M=xZV;
y_0_3M=yZV;

end


if Kanal==1
alpha_1M
h_1M
k_1M
a_1M
g_1M
x_0_1M
y_0_1M
end

if Kanal==2
alpha_2M
h_2M
k_2M
a_2M
g_2M
x_0_2M
y_0_2M
end

if Kanal==3
alpha_3M
h_3M
k_3M
a_3M
g_3M
x_0_3M
y_0_3M
end

