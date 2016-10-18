(* ::Package:: *)

(* ::Title:: *)
(*Caso 0: Ejercicios Extra*)


(* ::Subtitle:: *)
(*Codificaci\[OAcute]n RSA*)


(* ::Input:: *)
(*EncriptadoRSA[mensaje_,ClavePublica_,numero_]:=PowerMod[mensaje,ClavePublica,numero];*)
(*DescifradoRSA[MensajeCodificado_,ClavePrivada_,numero_]:=PowerMod[MensajeCodificado,ClavePrivada,numero];*)
(**)


(* ::Text:: *)
(*Generamos los n\[UAcute]meros primos que nos van a ser necesarios para codificar el mensaje*)
(**)


(* ::Input:: *)
(*P=RandomPrime[{2^31,2^32}]*)
(*Q=RandomPrime[{2^31,2^32}]*)


(* ::Input:: *)
(*Numero=P*Q;*)


(* ::Input:: *)
(*X=(P-1)(Q-1);*)


(* ::Text:: *)
(**)
(**)
(*Mensaje que vamos a codificar M=1234567890*)
(**)


(* ::Input:: *)
(*M=1234567890;*)


(* ::Text:: *)
(**)
(**)
(*Elegimos un n\[UAcute]mero primo menor que X y que no sea divisor exacto de X, esa ser\[AAcute] la clave p\[UAcute]blica*)
(**)


(* ::Input:: *)
(*ClavePublica=8599;*)


(* ::Text:: *)
(**)
(**)
(*Calculamos la clave privada (d) tal que al multiplicarla por la p\[UAcute]blica (e) menos 1, sea divisible por X o en otras palabras, que ((p*q)-1)/X sea igual a un n\[UAcute]mero entero*)
(**)


(* ::Input:: *)
(*k=EulerPhi[Numero];*)
(*For[y=0,y<k && !IntegerQ[ClavePrivada=(1+k*y)/ClavePublica],y++];*)
(*ClavePrivada*)


(* ::Text:: *)
(**)
(**)
(*Codificamos*)
(**)


(* ::Input:: *)
(*MensajeCodificado=EncriptadoRSA[M,ClavePublica,Numero]*)


(* ::Text:: *)
(**)
(**)
(*Decodificamos y comprobamos que el resultado es el mismo que el mensaje que codificamos*)
(**)


(* ::Input:: *)
(*Resultado=DescifradoRSA[MensajeCodificado,ClavePrivada, Numero]*)
