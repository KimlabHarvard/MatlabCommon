clf;
hold off;

scaleFactor=1;

data.biasVoltageList=squeeze(data.sampleVoltage(1,1,:))
figure(1)
k_B=1.38064852e-23;
e=1.60217662e-19;
tempIndexList=[2 3 4 5];
tempList=[5 10 15 20];
JNList=data.power(tempIndexList,1,1);
myFit=fit(tempList',JNList,'poly1');
gain=myFit.p1/(4*k_B)
T_noise=myFit.p2/myFit.p1
%scaleFactor=1/gain;
scaleFactor=1

offset=0;
%offset=T_noise*gain;%%%
data.power=data.power;
cStart=1e-6;
%cStart=0;%%%


plot(data.biasVoltageList,squeeze(data.power(tempIndexList,1,:))*scaleFactor,'o')
xlabel('V_{bias} (V)');
ylabel('Noise Power (Watts)');

hold on;
v=data.biasVoltageList;
a=1e-10;
c=1.16e-6;
%plot(v,a*v.*coth((5.802261027303315e+03)*v/5)+c);


%5K
myFitType=fittype(sprintf('%e*v*f*(coth(v*(5.802261027303315e+03)/5))+c',gain*2*e),'dependent',{'y'},'independent',{'v'},'coefficients',{'f','c'});
%myFitType=fittype(sprintf('%e*v*f*(coth(v*(5.802261027303315e+03)/5))+c',2*e),'dependent',{'y'},'independent',{'v'},'coefficients',{'f','c'});
myFitOptions=fitoptions('Method','NonlinearLeastSquares','StartPoint',[.6,cStart]);
xData=[1e-20; data.biasVoltageList(2:end)];
yData=squeeze(data.power(2,1,:))*scaleFactor;
myFit1=fit(xData,yData,myFitType,myFitOptions);
hold on;
plot(myFit1);

%10K
myFitType=fittype(sprintf('%e*v*f*(coth(v*(5.802261027303315e+03)/10))+c',gain*2*e),'dependent',{'y'},'independent',{'v'},'coefficients',{'f','c'});
myFitOptions=fitoptions('Method','NonlinearLeastSquares','StartPoint',[1,cStart]);
xData=[1e-20; data.biasVoltageList(2:end)];
yData=squeeze(data.power(3,1,:))*scaleFactor;
myFit2=fit(xData,yData,myFitType,myFitOptions);
hold on;
plot(myFit2);

%15K
myFitType=fittype(sprintf('%e*v*f*(coth(v*(5.802261027303315e+03)/15))+c',gain*2*e),'dependent',{'y'},'independent',{'v'},'coefficients',{'f','c'});
myFitOptions=fitoptions('Method','NonlinearLeastSquares','StartPoint',[1,cStart]);
xData=[1e-20; data.biasVoltageList(2:end)];
yData=squeeze(data.power(4,1,:))*scaleFactor;
myFit3=fit(xData,yData,myFitType,myFitOptions);
hold on;
plot(myFit3);

%20K
myFitType=fittype(sprintf('%e*v*f*(coth(v*(5.802261027303315e+03)/20))+c',gain*2*e),'dependent',{'y'},'independent',{'v'},'coefficients',{'f','c'});
myFitOptions=fitoptions('Method','NonlinearLeastSquares','StartPoint',[1,cStart]);
xData=[1e-20; data.biasVoltageList(2:end)];
yData=squeeze(data.power(5,1,:))*scaleFactor;
myFit4=fit(xData,yData,myFitType,myFitOptions);
hold on;
plot(myFit4);

[myFit1.f, myFit2.f, myFit3.f, myFit4.f]

legend('5K, F=0.972', '10K, F=0.971', '15K, F=0.982', '20K, F=0.990')
xlabel('V_{bias} (V)');
ylabel('Noise Power (W)');

handaxes2 = axes('position', [0.28 0.62 0.25 0.25]);
plot(myFit,[5 10 15 20], JNList, 'o');
%set(handaxes2, 'box', 'off');
xlabel('T(K)'); ylabel('Johnson Noise (W)');
legend off;


