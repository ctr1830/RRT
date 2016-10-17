(* ::Package:: *)

(* ::Title:: *)
(*Caso 1: Cola M/M/1*)


(* ::Section:: *)
(*Desarrollar un sistema generador de n\[UAcute]meros aleatorios basados en un generador lineal congruencial mixto que siga una distribuci\[OAcute]n uniforme entre [0, 1]:*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*Module[{varstatic=888},RandomData[]:=(varstatic=Mod[(314159269*varstatic+453806245),2.^31])/2^31]*)


(* ::Input:: *)
(*RandomData[]*)


(* ::Input:: *)
(*Histogram[Table[RandomData[],{50000}]]*)


(* ::Section:: *)
(*Implementar el m\[EAcute]todo de transformada inversa para obtener una distribuci\[OAcute]n aleatoria exponencial de tiempo entre llegadas. Representar en un histograma los valores obtenidos*)


(* ::Input:: *)
(*RandomExp[lamda_]:=-(1/lamda)*Log[RandomData[]] *)


(* ::Text:: *)
(*Lo que nos devuelve RandomExp es el tiempo de duraci\[OAcute]n de cada paquete o tiempo entre paquetes*)


(* ::Input:: *)
(*Histogram[Table[RandomExp[100],{50000}]]*)


(* ::Input:: *)
(*Histogram[Table[RandomExp[100],{50000}],50,"CDF"]*)


(* ::Input:: *)
(*nmax=1000;*)
(*lambda=20;*)
(*mu=11;*)


(* ::Text:: *)
(*Tiempo entre llegadas (InterArrivalsTime)*)


(* ::Input:: *)
(*Inter[lambda_,max_]:= Table[RandomExp[lambda],{max}]*)
(*InterArrivalsTime=Inter[lambda,nmax];*)
(*Length[InterArrivalsTime]==nmax*)


(* ::Text:: *)
(*A continuaci\[OAcute]n calculamos el tiempo entre servicios*)


(* ::Input:: *)
(**)
(*ServiceTime=Inter[mu,nmax];*)


(* ::Input:: *)
(*AccumSeries[InterArrivals_]:=Module[{t=0},t+=#&/@InterArrivals]*)


(* ::Input:: *)
(*ArrivalsTime=AccumSeries[InterArrivalsTime];*)


(* ::Input:: *)
(*ArrivalsTime[[2]]<ArrivalsTime[[3]]*)


(* ::Text:: *)
(*Calculamos Departures Time como el tiempo de la salida del servidor:*)


(* ::Input:: *)
(*FuncionSalida[llegadas_,servicio_]:=Module[{n=0,tiempo=0},(n++;If[tiempo<=#,tiempo=#+servicio[[n]],tiempo+=servicio[[n]]])&/@llegadas]*)


(* ::Input:: *)
(*DeparturesTime=FuncionSalida[ArrivalsTime,ServiceTime];*)


(* ::Text:: *)
(*A continuaci\[OAcute]n se representa el n\[UAcute]mero de usuarios en el sistema*)


(* ::Input:: *)
(*ListPlot[{ArrivalsTime,DeparturesTime},PlotStyle->{Blue,Red}]*)


(* ::Text:: *)
(*Ahora preparamos un array para su presentaci\[OAcute]n {tiempo, n}*)


(* ::Input:: *)
(*For[n=1;ArrivalsTime2={},n<=nmax,n++,ArrivalsTime2=Insert[ArrivalsTime2,{ArrivalsTime[[n]],n-1},n]]*)


(* ::Input:: *)
(*For[n=1;DeparturesTime2={},n<=nmax,n++,DeparturesTime2=Insert[DeparturesTime2,{DeparturesTime[[n]],n-1},n]]*)


(* ::Input:: *)
(*ListPlot[{ArrivalsTime2,DeparturesTime2},PlotStyle->{Blue,Red}]*)


(* ::Input:: *)
(*ArrivalsTime2=Insert[ArrivalsTime2,{0,0},1];*)
(*DeparturesTime2=Insert[DeparturesTime2,{0,0},1];*)
(*ListLinePlot[{ArrivalsTime2,DeparturesTime2},PlotStyle->{Blue,Red}]*)


(* ::Text:: *)
(*Generamos las listas con puntos intermedios*)


(* ::Input:: *)
(*PointsStairStepA[]:=For[n=1;ArrivalsStep={{0,0}},n<nmax,n++,ArrivalsStep=Insert[ArrivalsStep,{ArrivalsTime2[[n]][[1]],ArrivalsTime2[[n+1]][[2]]},2*n];ArrivalsStep=Insert[ArrivalsStep,ArrivalsTime2[[n+1]],2*n+1]]*)


(* ::Input:: *)
(*PointsStairStepD[]:=For[n=1;DeparturesStep={{0,0}},n<nmax,n++,DeparturesStep=Insert[DeparturesStep,{DeparturesTime2[[n]][[1]],DeparturesTime2[[n+1]][[2]]},2*n];DeparturesStep=Insert[DeparturesStep,DeparturesTime2[[n+1]],2*n+1]]*)


(* ::Input:: *)
(*PointsStairStepA[]*)


(* ::Input:: *)
(*PointsStairStepD[]*)


(* ::Input:: *)
(*ListLinePlot[{ArrivalsStep,DeparturesStep},PlotStyle->{Blue,Red}]*)


(* ::Input:: *)
(*minwin=10*)


(* ::Input:: *)
(*maxwin=100;*)


(* ::Input:: *)
(*Manipulate[ListLinePlot[{ArrivalsStep[[origen;;origen+win]],DeparturesStep[[origen;;origen+win]]},PlotStyle->{Blue,Red}],{origen,1,nmax,1},{win,minwin,maxwin,1}]*)


(* ::Input:: *)
(*Cola[llega_,sale_]:=For[il=1;is=1;ic=1;col=0;tiempo=0;UsersStepStair={},*)
(*ic<=2*nmax,ic++,*)
(*If[il>nmax,tiempo=sale[[is]],tiempo=Min[llega[[il]],sale[[is]]]];If[tiempo!=sale[[is]],il++;col++,is++;col--];*)
(*;UsersStepStair=Insert[UsersStepStair,{tiempo,col},ic]]*)
(*Cola[ArrivalsTime,DeparturesTime]*)


(* ::Input:: *)
(*PointsStairStepU[]:=For[n=1;UsersStep={{0,0},{UsersStepStair[[1]][[1]],0}},n<nmax,n++,UsersStep=Insert[UsersStep,UsersStepStair[[n]],2*n+1];UsersStep=Insert[UsersStep,{UsersStepStair[[n+1]][[1]],UsersStepStair[[n]][[2]]},2*n+2]]*)


(* ::Input:: *)
(*PointsStairStepU[]*)


(* ::Input:: *)
(*Manipulate[Show[ListLinePlot[UsersStep[[origen;;origen+win]]]],{origen,1,nmax,1},{win,minwin,maxwin,1}]*)


(* ::Section:: *)
(*Representar el tiempo de espera normalizado por "mu" para diferentes valores de "p". Hacerlo con la curva te\[OAcute]rica y representar los puntos obtenidos en las simulaciones.*)


(* ::Input:: *)
(*Tenormalizado[x_]:=1/(1-x)*)


(* ::Input:: *)
(*Temr[Departure_,Arrivals_]:=\!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(nmax\)]\(\((Departure[\([\)\(i\)\(]\)] - Arrivals[\([\)\(i\)\(]\)])\)/nmax\)\)*)


(* ::Input:: *)
(*Temr0=Temr[DeparturesTime,ArrivalsTime]*)


(* ::Input:: *)
(*Temr0=Temr[DeparturesTime,ArrivalsTime]*)


(* ::Input:: *)
(*mu1=10;*)


(* ::Input:: *)
(*lambda1=8.9;*)


(* ::Input:: *)
(*InterArrivals1=Inter[lambda1,nmax];*)


(* ::Input:: *)
(*ServiceTime1=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime1=AcumSeries[InterArrivals1];*)


(* ::Input:: *)
(*DeparturesTime1=FuncionSalida[ArrivalsTime1,ServiceTime1];*)


(* ::Input:: *)
(*Temr1=Temr[DeparturesTime1,ArrivalsTime1]*)


(* ::Input:: *)
(*lambda2=7.9;*)


(* ::Input:: *)
(*InterArrivals2=Inter[lambda2,nmax];*)


(* ::Input:: *)
(*ServiceTime2=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime2=AcumSeries[InterArrivals2];*)


(* ::Input:: *)
(*DeparturesTime2=FuncionSalida[ArrivalsTime2,ServiceTime2];*)


(* ::Input:: *)
(*Temr2=Temr[DeparturesTime2,ArrivalsTime2]*)


(* ::Input:: *)
(*lambda3=6.9;*)


(* ::Input:: *)
(*InterArrivals3=Inter[lambda3,nmax];*)


(* ::Input:: *)
(*ServiceTime3=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime3=AcumSeries[InterArrivals3];*)


(* ::Input:: *)
(*DeparturesTime3=FuncionSalida[ArrivalsTime3,ServiceTime3];*)


(* ::Input:: *)
(*Temr3=Temr[DeparturesTime3,ArrivalsTime3]*)


(* ::Input:: *)
(*lambda4=5.9;*)


(* ::Input:: *)
(*InterArrivals4=Inter[lambda4,nmax];*)


(* ::Input:: *)
(*ServiceTime4=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime4=AcumSeries[InterArrivals4];*)


(* ::Input:: *)
(*DeparturesTime4=FuncionSalida[ArrivalsTime4,ServiceTime4];*)


(* ::Input:: *)
(*Temr4=Temr[DeparturesTime4,ArrivalsTime4]*)


(* ::Input:: *)
(*lambda5=4.9;*)


(* ::Input:: *)
(*InterArrivals5=Inter[lambda5,nmax];*)


(* ::Input:: *)
(*ServiceTime5=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime5=AcumSeries[InterArrivals5];*)


(* ::Input:: *)
(*DeparturesTime5=FuncionSalida[ArrivalsTime5,ServiceTime5];*)


(* ::Input:: *)
(*Temr5=Temr[DeparturesTime5,ArrivalsTime5]*)


(* ::Input:: *)
(*lambda6=3.9;*)


(* ::Input:: *)
(*InterArrivals6=Inter[lambda6,nmax];*)


(* ::Input:: *)
(*ServiceTime6=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime6=AcumSeries[InterArrivals6];*)


(* ::Input:: *)
(*DeparturesTime6=FuncionSalida[ArrivalsTime6,ServiceTime6];*)


(* ::Input:: *)
(*Temr6=Temr[DeparturesTime6,ArrivalsTime6]*)


(* ::Input:: *)
(*lambda7=2.9;*)


(* ::Input:: *)
(*InterArrivals7=Inter[lambda7,nmax];*)


(* ::Input:: *)
(*ServiceTime7=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime7=AcumSeries[InterArrivals7];*)


(* ::Input:: *)
(*DeparturesTime7=FuncionSalida[ArrivalsTime7,ServiceTime7];*)


(* ::Input:: *)
(*Temr7=Temr[DeparturesTime7,ArrivalsTime7]*)


(* ::Input:: *)
(*lambda8=1.9;*)


(* ::Input:: *)
(*InterArrivals8=Inter[lambda8,nmax];*)


(* ::Input:: *)
(*ServiceTime8=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime8=AcumSeries[InterArrivals8];*)


(* ::Input:: *)
(*DeparturesTime8=FuncionSalida[ArrivalsTime8,ServiceTime8];*)


(* ::Input:: *)
(*Temr8=Temr[DeparturesTime8,ArrivalsTime8]*)


(* ::Input:: *)
(*lambda9=0.9;*)


(* ::Input:: *)
(*InterArrivals9=Inter[lambda9,nmax];*)


(* ::Input:: *)
(*ServiceTime9=Inter[mu1,nmax];*)


(* ::Input:: *)
(*ArrivalsTime9=AcumSeries[InterArrivals9];*)


(* ::Input:: *)
(*DeparturesTime9=FuncionSalida[ArrivalsTime9,ServiceTime9];*)


(* ::Input:: *)
(*Temr9=Temr[DeparturesTime9,ArrivalsTime9]*)


(* ::Input:: *)
(*Show[Plot[Tenormalizado[x],{x,0,1},AxesOrigin->{0,0}],Graphics[{PointSize[Large],Red,Point[{{lambda/mu,Temr0*mu},{lambda1/mu1,Temr1*mu1},{lambda2/mu1,Temr2*mu1},{lambda3/mu1,Temr3*mu1},{lambda4/mu1,Temr4*mu1},{lambda5/mu1,Temr5*mu1},{lambda6/mu1,Temr6*mu1},{lambda7/mu1,Temr7*mu1},{lambda8/mu1,Temr8*mu1},{lambda9/mu1,Temr9*mu1}}]}]]*)


(* ::Section:: *)
(*Representar las probabilidades de estado "pn" de la cola M/M/1 te\[OAcute]ricas, as\[IAcute] como las obtenidas por simulaci\[OAcute]n para diferentes puntos de ensayo. Comprobar si esta distribuci\[OAcute]n coincide con la visualizada seg\[UAcute]n la propiedad PASTA en los tiempos de llegada*)


(* ::Input:: *)
(*ProbEst[n_,ro_]:=((1-ro)*ro^n)*)


(* ::Input:: *)
(*DiscretePlot[ProbEst[x,lambda/mu],{x,0,23,1}]*)


(* ::Input:: *)
(*DiscretePlot[{ProbEst[x,lambda/mu],ProbEst[x,lambda1/mu1],ProbEst[x,lambda2/mu1],ProbEst[x,lambda3/mu1],ProbEst[x,lambda4/mu1],ProbEst[x,lambda5/mu1],ProbEst[x,lambda6/mu1],ProbEst[x,lambda6/mu1],ProbEst[x,lambda7/mu1],ProbEst[x,lambda8/mu1],ProbEst[x,lambda9/mu1]},{x,0,23,1}]*)
