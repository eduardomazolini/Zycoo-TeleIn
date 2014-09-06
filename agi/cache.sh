#!/bin/sh
cacheTime=`expr 60 \* 60 \* 24 \* 2`
now=`date +"%s"`
n=0

cacheResult=`grep -e "^$1.*" consulta.txt | sed -e 's/:/ /g'`
if [ -n "$cacheResult" ]
then
  for word in $cacheResult
  do
    n=`expr $n + 1`
    eval word$n="$word"
  done
  eval cacheResultConsult="$word1"
  eval cacheResultResult="$word2"
  eval cacheResultDate="$word3"
  expTime=`expr $cacheResultDate + $cacheTime`
  if [ $expTime -ge $now ]
  then
    valor=$cacheResultResult
  else
    grep -v -e "^$1" consulta.txt > temp.txt
    rm consulta.txt
    mv temp.txt consulta.txt
  fi
fi

if [ -z "$valor" ]
then
  valor=`wget -q -O -  http://consultanumero1.telein.com.br/sistema/consulta_numero.php?chave=xxxxxxxxxxxxxxxxxxxx&numero=$1`
  echo $1:$valor:$now >> consulta.txt
fi

echo $valor
