clc
%clear
Geometry='astredwedge.mat';
NumberRezhim=5
%1-демпфирование, 
%2-разворот, 
%3-разгрузка  
%4 - бесцельный режим,
%5 - целевой режим, 
%6 - разгрузка
Kanal=0;
Iant = [ %Тензор инерии для раскрытой антены
    0.01988, 0.000240, 0.000082;
    0.000240, 0.006538,-0.000034;
    0.000082,-0.000034, 0.020682];

Iparant = [ %Тензор инерции для раскрытой антены и паруса
    0.026673, 0.000243, 0.000082;
    0.000243, 0.012976,-0.000034;
    0.000082,-0.000034, 0.020682];


tau=0.02; % минималное время импульса для маховика
refT=0.1; % шаг дискретизации 
DtR=pi/180;
RtD=1/DtR;

J1M=2; %момент инерции
J2M=2;
J3M=2;
%Момент инерции корпуса
J1K=6937;
J2K=6837;
J3K=1122; 

J1Knew=10000;
J2Knew=6837;
J3Knew=1122; 

M1B=1e-5;
M2B=1e-6;
M3B=1e-5;

g_1M=M1B/J1K;
g_2M=M2B/J2K;
g_3M=M3B/J3K;

L0=10;
L01=10;
L02=10;
L03=10;

%Параметры двигателя
P=13.3; %Тяга
l1=0.4; %плечо
M1U=2*P*l1;
M2U=2*P*l1;
M3U=2*P*l1;

alpha_1M=0;
alpha_2M=0;
alpha_3M=0;
h_1M=0;
h_2M=0;
h_3M=0;

%Демпфирование
if NumberRezhim==1
stop=50
maxdt=4.0001
a_1M=M1U/J1K
g_1M=M1B/J1K
x_0_1M=6
y_0_1M=1.2
k_1M=sqrt((2*a_1M*RtD*x_0_1M+y_0_1M^2)/(8*a_1M^2*RtD^2))

a_2M=M2U/J2K
g_2M=M2B/J2K
x_0_2M=6
y_0_2M=1
k_2M=sqrt((2*a_2M*RtD*x_0_2M+y_0_2M^2)/(8*a_2M^2*RtD^2))

a_3M=M3U/J3K
g_3M=M3B/J3K
x_0_3M=5
y_0_3M=1.2
k_3M=sqrt((2*a_3M*RtD*x_0_3M+y_0_3M^2)/(8*a_3M^2*RtD^2))

end

%РАЗВОРОТ
if NumberRezhim==2
stop=50
maxdt=0.001
a_1M=M1U/J1K
g_1M=M1B/J1K
x_0_1M=40
y_0_1M=0
k_1M=0.5*sqrt(x_0_1M/(a_1M*RtD))

a_2M=M2U/J2K
g_2M=M2B/J2K
x_0_2M=5;
y_0_2M=0;
k_2M=0.5*sqrt(x_0_2M/(a_2M*RtD))

a_3M=M3U/J3K
g_3M=M3B/J3K
x_0_3M=60
y_0_3M=0
k_3M=0.5*sqrt(x_0_3M/(a_3M*RtD))

end

%РАЗГРУЗКА
if NumberRezhim==3
stop=0.5
maxdt=0.0001
tmin=0.02;
Mmah=25e-3

a_1M=M1U/J1K
g_1M=(M1B+Mmah)/J1K
x_0_1M=0
y_0_1M=0.8*L0/J1K*RtD
%y_0_1M=a_1M*RtD*tmin/2*10
k_1M=0.5*sqrt((y_0_1M^2)/(2*a_1M^2*RtD^2))

a_2M=M2U/J2K
g_2M=(M2B+Mmah)/J2K
x_0_2M=0
y_0_2M=0.8*L0/J2K*RtD
%y_0_2M=a_2M*RtD*tmin/2*10
k_2M=0.5*sqrt((y_0_2M^2)/(2*a_2M^2*RtD^2))

a_3M=M3U/J3K
g_3M=(M3B+Mmah)/J3K
x_0_3M=0
y_0_3M=0.8*L0/J3K*RtD
%y_0_3M=a_3M*RtD*tmin/2*10
k_3M=0.5*sqrt((y_0_3M^2)/(2*a_3M^2*RtD^2))

end

%МАХОВИКИ////
%ПАССИВНЫЙ РЕЖИМ.........................
if NumberRezhim==4
%Точность по режиму
stop=5000;
maxdt=1;

M1U=350e-3;
M2U=350e-3;
M3U=350e-3;
yZV=0.1;
xZV=10;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;

%Канал крена
alpha_1M=0.9*Xmax1
h_1M=0.2*alpha_1M
k_1M=h_1M/(2*yZV)%20;
a_1M=M1U/J1K
x_0_1M=xZV*3
y_0_1M=a_1M*tau/2

%Канал курса
alpha_2M=0.9*Xmax2
h_2M=0.2*alpha_2M
k_2M=h_2M/(2*yZV)%20;
a_2M=M2U/J2K
x_0_2M=xZV*3
y_0_2M=a_2M*tau/2

%Канал тангажа
alpha_3M=0.9*Xmax3
h_3M=0.2*alpha_3M
k_3M=(h_3M/(2*yZV)) %10
a_3M=M3U/J3K
x_0_3M=xZV*3
y_0_3M=a_3M*tau/2
end

%ЦЕЛЕВОЙ РЕЖИМ.........................

if NumberRezhim==5
stop=5000;
maxdt=0.1;

Mu=25e-3;
M1U=25e-3;
M2U=25e-3;
M3U=5e-3;
    
xZV=0.09;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;
yZV=0.001;
%Канал крена
alpha_1M=0.9*Xmax1
h_1M=0.2*alpha_1M
k_1M=h_1M/(2*yZV)
a_1M=M1U/J1K
x_0_1M=xZV*3
y_0_1M=a_1M*tau/2

%Канал курса
alpha_2M=0.9*Xmax2
h_2M=0.2*alpha_2M
k_2M=h_2M/(2*yZV)
a_2M=M2U/J2K
x_0_2M=xZV*3
y_0_2M=a_2M*tau/2

%Канал тангажа
alpha_3M=0.9*Xmax3
h_3M=0.2*alpha_3M
k_3M=h_3M/(2*yZV)
a_3M=M3U/J3K
x_0_3M=xZV*3
y_0_3M=a_3M*tau/2


end

%Разгрузка маховика
if NumberRezhim==6
stop=5000;
maxdt=0.1;

MuR=25e-3;
g_1M=g_1M+MuR/J1K;
g_2M=g_2M+MuR/J2K;
g_3M=g_3M+MuR/J3K;

M1U=20;
M2U=20;
M3U=20;
    
xZV=30;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;
yZV=1;
%Канал крена
alpha_1M=0.9*Xmax1;
h_1M=0.2*alpha_1M;
k_1M=h_1M/(2*yZV);
a_1M=M1U/J1K;
x_0_1M=xZV;
y_0_1M=yZV;

%Канал курса
alpha_2M=0.9*Xmax2;
h_2M=0.2*alpha_2M;
k_2M=h_2M/(2*yZV);
a_2M=M2U/J2K;
x_0_2M=xZV;
y_0_2M=yZV;

%Канал тангажа
alpha_3M=0.9*Xmax3;
h_3M=0.2*alpha_3M;
k_3M=h_3M/(2*yZV);
a_3M=M3U/J3K;
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

