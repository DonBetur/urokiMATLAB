clc
clear
Geometry='astredwedge.mat';
NumberRezhim=5
%1-демпфирование, 
%2-разворот, 
%3-разгрузка  
%4 - бесцельный режим,
%5 - целевой режим, 
%6 - разгрузка
Kanal=0;


%Демпфирование
if NumberRezhim==1
stop=50
maxdt=4.0001
a_1=M1U/J1K
g_1=M1B/J1K
x_0_1=6
y_0_1=1.2
k_1=sqrt((2*a_1*RtD*x_0_1+y_0_1^2)/(8*a_1^2*RtD^2))

a_2=M2U/J2K
g_2=M2B/J2K
x_0_2=6
y_0_2=1
k_2=sqrt((2*a_2*RtD*x_0_2+y_0_2^2)/(8*a_2^2*RtD^2))

a_3=M3U/J3K
g_3=M3B/J3K
x_0_3=5
y_0_3=1.2
k_3=sqrt((2*a_3*RtD*x_0_3+y_0_3^2)/(8*a_3^2*RtD^2))

end

%РАЗВОРОТ
if NumberRezhim==2
stop=50
maxdt=0.001
a_1=M1U/J1K
g_1=M1B/J1K
x_0_1=40
y_0_1=0
k_1=0.5*sqrt(x_0_1/(a_1*RtD))

a_2=M2U/J2K
g_2=M2B/J2K
x_0_2=5;
y_0_2=0;
k_2=0.5*sqrt(x_0_2/(a_2*RtD))

a_3=M3U/J3K
g_3=M3B/J3K
x_0_3=60
y_0_3=0
k_3=0.5*sqrt(x_0_3/(a_3*RtD))
end

%РАЗГРУЗКА
if NumberRezhim==3
stop=0.5
maxdt=0.0001
tmin=0.02;
Mmah=25e-3

a_1=M1U/J1K
g_1=(M1B+Mmah)/J1K
x_0_1=0
y_0_1=0.8*L0/J1K*RtD
%y_0_1M=a_1M*RtD*tmin/2*10
k_1=0.5*sqrt((y_0_1^2)/(2*a_1^2*RtD^2))

a_2=M2U/J2K
g_2=(M2B+Mmah)/J2K
x_0_2=0
y_0_2=0.8*L0/J2K*RtD
%y_0_2M=a_2M*RtD*tmin/2*10
k_2=0.5*sqrt((y_0_2^2)/(2*a_2^2*RtD^2))

a_3=M3U/J3K
g_3=(M3B+Mmah)/J3K
x_0_3=0
y_0_3=0.8*L0/J3K*RtD
%y_0_3M=a_3M*RtD*tmin/2*10
k_3=0.5*sqrt((y_0_3^2)/(2*a_3^2*RtD^2))

end

%МАХОВИКИ////
%ПАССИВНЫЙ РЕЖИМ.........................
if NumberRezhim==4
%Точность по режиму
stop=1000;
maxdt=1;

M1U=350e-3;
M2U=350e-3;
M3U=350e-3;
yZV=0.01;
xZV=1;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;

%Канал крена
alpha_1=0.9*Xmax1
h_1=0.2*alpha_1
k_1=h_1/(2*yZV)%20;
a_1=M1U/J1K
x_0_1=xZV*3
y_0_1=a_1*tau/2

%Канал курса
alpha_2=0.9*Xmax2
h_2=0.2*alpha_2
k_2=h_2/(2*yZV)%20;
a_2=M2U/J2K
x_0_2=xZV*3
y_0_2=a_2*tau/2

%Канал тангажа
alpha_3=0.9*Xmax3
h_3=0.2*alpha_3
k_3=(h_3/(2*yZV)) %10
a_3=M3U/J3K
x_0_3=xZV*3
y_0_3=a_3*tau/2
end

%ЦЕЛЕВОЙ РЕЖИМ.........................

if NumberRezhim==5
stop=1000;
maxdt=0.1;

% Mu=25e-3;
% M1U=25e-3;
% M2U=25e-3;
% M3U=5e-3;
%     
xZV=0.9;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;
yZV=0.01;
%Канал крена
alpha_1=0.9*Xmax1
h_1=0.2*alpha_1
k_1=h_1/(2*yZV)
a_1=M1U/J1K
x_0_1=xZV*3
y_0_1=a_1*tau/2

%Канал курса
alpha_2=0.9*Xmax2
h_2=0.2*alpha_2
k_2=h_2/(2*yZV)
a_2=M2U/J2K
x_0_2=xZV*3
y_0_2=a_2*tau/2

%Канал тангажа
alpha_3=0.9*Xmax3
h_3=0.2*alpha_3
k_3=h_3/(2*yZV)
a_3=M3U/J3K
x_0_3=xZV*3
y_0_3=a_3*tau/2


end

%Разгрузка маховика
if NumberRezhim==6
stop=1000;
maxdt=0.1;

MuR=25e-3;
g_1=g_1+MuR/J1K;
g_2=g_2+MuR/J2K;
g_3=g_3+MuR/J3K;

M1U=20;
M2U=20;
M3U=20;
    
xZV=30;
Xmax3=xZV;
Xmax2=xZV;
Xmax1=xZV;
yZV=1;
%Канал крена
alpha_1=0.9*Xmax1;
h_1=0.2*alpha_1;
k_1=h_1/(2*yZV);
a_1=M1U/J1K;
x_0_1=xZV;
y_0_1=yZV;

%Канал курса
alpha_2=0.9*Xmax2;
h_2=0.2*alpha_2;
k_2=h_2/(2*yZV);
a_2=M2U/J2K;
x_0_2=xZV;
y_0_2=yZV;

%Канал тангажа
alpha_3=0.9*Xmax3;
h_3=0.2*alpha_3;
k_3=h_3/(2*yZV);
a_3=M3U/J3K;
x_0_3=xZV;
y_0_3=yZV;

end

if Kanal==1
alpha_1
h_1
k_1
a_1
g_1
x_0_1
y_0_1
end

if Kanal==2
alpha_2
h_2
k_2
a_2
g_2
x_0_2
y_0_2
end

if Kanal==3
alpha_3
h_3
k_3
a_3
g_3
x_0_3
y_0_3
end

YinitDeg = [y_0_1 y_0_3 y_0_2];
XinitDeg = [x_0_1 x_0_3 x_0_2];

YinitRad = YinitDeg*DtR
XinitRad = XinitDeg*DtR


M1B
M2B
M3B

M1U
M2U
M3U



