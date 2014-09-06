#!/bin/sh
GetVar=/var/lib/asterisk/agi-bin/func/AgiGetVar
NoOp=/var/lib/asterisk/agi-bin/func/AgiNoOp
Verbose=/var/lib/asterisk/agi-bin/func/AgiVerbose
SetVar=/var/lib/asterisk/agi-bin/func/AgiSetVar
. $GetVar
$NoOp Consulta TeleIn
telein=`/var/lib/asterisk/agi-bin/cache.sh $1`
$Verbose Resposta TeleIn $telein
cod=`expr "$telein" : '\(.*\)#'`
if [ $cod -ge 98 ]; then
	oper=Falha
elif [ $cod -eq 20 ]; then
	oper=VIVO
elif [ $cod -eq 21 ]; then
	oper=CLARO
elif [ $cod -eq 41 ]; then
	oper=TIM
elif [ $cod -eq 31 ]; then
	oper=OI
elif [ $cod -eq 78 ]; then
	oper=NEXTELR
elif [ $cod -eq 77 ]; then
	oper=NEXTELC
else
	oper=OUTRO
fi
$NoOp Operadora: $oper
$SetVar OPERADORA $oper
