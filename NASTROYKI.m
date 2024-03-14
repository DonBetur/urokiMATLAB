clc
%clear
%out.tout=[];

%out.tout=[];


NumberRezhim=1
%1-демпфирование, 2-разворот, 3-разгрузка
%4 - бесцельный режим,5 - целевой режим, 6 - разгрузка
Kanal=1;

tau=0.02; % минималное время импульса для маховика
refT=5; % шаг дискретизации 
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

%Параметры двигателя
P=13.3; %Тяга
l1=0.4; %плечо
M1U=2*P*l1;
M2U=2*P*l1;
M3U=2*P*l1;

%Демпфирование
if NumberRezhim==1
stop=50
maxdt=0.001
a_1P=M1U/J1K
g_1P=M1B/J3K
x_0_1P=6
y_0_1P=1.2
k_1P=sqrt((2*a_1P*RtD*x_0_1P+y_0_1P^2)/(8*a_1P^2*RtD^2))

a_2P=M2U/J2K
g_2P=M2B/J3K
x_0_2P=6
y_0_2P=1
k_2P=sqrt((2*a_2P*RtD*x_0_2P+y_0_2P^2)/(8*a_2P^2*RtD^2))

a_3P=M3U/J3K
g_3P=M3B/J3K
x_0_3P=5
y_0_3P=1.2
k_3P=sqrt((2*a_3P*RtD*x_0_3P+y_0_3P^2)/(8*a_3P^2*RtD^2))

end

%РАЗВОРОТ
if NumberRezhim==2
stop=50
maxdt=0.001
a_1P=M1U/J1K
g_1P=M1B/J3K
x_0_1P=40
y_0_1P=0
k_1P=0.5*sqrt(x_0_1P/(a_1P*RtD))

a_2P=M2U/J2K
g_2P=M2B/J3K
x_0_2P=5;
y_0_2P=0;
k_2P=0.5*sqrt(x_0_2P/(a_2P*RtD))

a_3P=M3U/J3K
g_3P=M3B/J3K
x_0_3P=60
y_0_3P=0
k_3P=0.5*sqrt(x_0_3P/(a_3P*RtD))

end

%РАЗГРУЗКА
if NumberRezhim==3
stop=0.5
maxdt=0.0001
tmin=0.02;
Mmah=25e-3

a_1P=M1U/J1K
g_1P=(M1B+Mmah)/J3K
x_0_1P=0
y_0_1P=a_1P*RtD*tmin/2*10
k_1P=0.5*sqrt((y_0_1P^2)/(2*a_1P^2*RtD^2))

a_2P=M2U/J2K
g_2P=(M2B+Mmah)/J3K
x_0_2P=0
y_0_2P=a_2P*RtD*tmin/2*10
k_2P=0.5*sqrt((y_0_2P^2)/(2*a_2P^2*RtD^2))

a_3P=M3U/J3K
g_3P=(M3B+Mmah)/J3K
x_0_3P=0
y_0_3P=a_3P*RtD*tmin/2*10
k_3P=0.5*sqrt((y_0_3P^2)/(2*a_3P^2*RtD^2))

end

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

