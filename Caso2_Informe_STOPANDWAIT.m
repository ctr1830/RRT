(* ::Package:: *)

(* ::Title:: *)
(*Caso 2: STOP & WAIT Informe*)


(* ::Subtitle:: *)
(*Definici\[OAcute]n de funciones*)


(* ::Text:: *)
(*Definici\[OAcute]n de funciones aleatorias para utilizarlas despu\[EAcute]s como tasa de llegadas y/o de servicio*)


(* ::Input:: *)
(*Needs["drawTx`"];*)
(*Module[{RndNumber = 4406,a=314159269,c=453806245,m=2^31},*)
(*RandomData[]:=N[(RndNumber =Mod[(a RndNumber+c),m])/(m-1)];*)
(*RandomExp[rate_]:=(-Log[RandomData[]]/rate);*)
(*GetRndNumber[]:=RndNumber*)
(*]*)


(* ::Text:: *)
(*Se definen funciones para la inicializaci\[OAcute]n de los par\[AAcute]metros, de manera que se puedan machacar despu\[EAcute]s. Se crean las variables que se van a usar m\[AAcute]s tarde. La funci\[OAcute]n SetIniPar machaca las variables inicializadas antes. La funci\[OAcute]n PacketArrivalGenTimePeriod genera un tipo de paquete que no tiene en cuenta errores. Con una tasa de llegadas acumulativa (Accumtime).*)
(**)
(*La funci\[OAcute]n SetAttributes, contiene un argumento de tipo HoldAll permitiendo que la funci\[OAcute]n PacketArrivalsGenTimePeriod despu\[EAcute]s al inicializarla podamos que por cada paquete genere un Random de manera que el tiempo no sea el mismo en cada iteraci\[OAcute]n sino que vaya cambiando en el tiempo.*)


(* ::Input:: *)
(*Module[{tp=0.01,tack=0.05,winMod=8,nsec=0},*)
(*SetIniPar[tP_,tAck_,nSec_]:=(tp=tP;tack=tAck;nsec=nSec;SetIniParDraw[tp,tack];{tp,tack,winMod});*)
(*GetIniPar[]:={tp,tack,winMod};*)
(*PacketArrivalsGenTimePeriod[lambdaArr_ ,muServ_,lastTime_,iniTime_:0]:=NestWhileList[ {(acumTime+=lambdaArr),muServ,nsec++,0,0}&,{acumTime=iniTime+lambdaArr,muServ,nsec++,0,0},(#[[1]] <lastTime )&]*)
(*;*)
(*SetAttributes[PacketArrivalsGenTimePeriod,HoldAll];*)


(* ::Text:: *)
(*PacketArrivalsGenTimePeriod es la tasa de llegadas del paquete, b\[AAcute]sicamente cuanto dura la simulaci\[OAcute]n *)
(**)
(*El NestWhileList bucle que permite la generaci\[OAcute]n de paquetes de llegada.*)
(**)
(*FifoPacketTxSW lo que hace es calcular los tiempos de los paquetes en los que no tiene en cuenta las retransmisiones.*)
(**)
(*GetPacketRTxSW es para hacer paquetes con retransmisiones.*)


(* ::Input:: *)
(**)
(*FifoPacketTxSW[arrivals_,pcomb_]:=*)
(*Module[{checkTime,nrTx},checkTime=arrivals[[1,1]];*)
(**)
(*SetCheckTimeSW[time_]:=(checkTime=time);*)
(**)
(*GetDepartureSW[arr_]:=*)
(*Module[{ret=arr[[1]]},(If[checkTime>=arr[[1]],ret=checkTime;checkTime+=arr[[2]],checkTime=arr[[1]]+arr[[2]]];checkTime+=2 tp+tack;ret)*)
(*];*)
(**)
(*GetPacketRTxSW[pck_,perror_]:=({GetDepartureSW[pck],pck[[2]],pck[[3]],If[RandomData[]<=perror,1,0],pck[[5]]+1});*)
(**)
(*Flatten[Map[(NestWhileList[(GetPacketRTxSW[#,pcomb]&),GetPacketRTxSW[#,pcomb],(#[[4]]==1)&])&,arrivals],1]*)
(*];*)
(*LaunchSimTxSW[tasa_,tp_,p_,time_,lambda_]:=(SetIniPar[tp,0,0];FifoPacketTxSW[PacketArrivalsGenTimePeriod[tasa,lambda,time,0],p]);*)
(*SetAttributes[LaunchSimTxSW,HoldAll];*)
(*]*)


(* ::Subtitle:: *)
(*Ejecuci\[OAcute]n de funciones (Ejemplos)*)


(* ::Text:: *)
(*En este primer ejemplo fijamos que el tiempo de Ack sea 0,05 y los n\[UAcute]meros de secuencia sean 0 y con una tiempo de llegada de 0.01 al destino*)


(* ::Input:: *)
(*SetIniPar[0.01,0.05,0];*)
(**)
(*PacketsTx=FifoPacketTxSW[PacketArrivalsGenTimePeriod[RandomExp[1.5],RandomExp[2.5],20,0],.2];*)
(*Manipulate[*)
(*Show[DrawWin[tw,ww,10], Map[(DrawPacketTx[#])&,SelectPacketInWin[PacketsTx]]]*)
(**)
(*,{tw,0,30},{ww,0.01,10}*)
(*]*)
(**)
(**)


(* ::Text:: *)
(*Se puede observar como los tiempos entre paquetes siguen una distribuci\[OAcute]n aleatoria y tal como se defini\[OAcute] no se tienen en cuenta los errores en transmisi\[OAcute]n de los paquetes ni en recepci\[OAcute]n.*)
