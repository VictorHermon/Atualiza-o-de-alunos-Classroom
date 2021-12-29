#!/bin/bash
gam="/home/victor_silva/bin/gam/gam"

echo Este script remove o aluno da classroom e insere, se necessรกrio, em outra turma
echo Forma de uso: $0 "(email do aluno)" "(email da classroom fecaf ou ser)" "(ANO do ser ou TURMA da fecaf)"
echo Se for informado apenas o email do aluno ele serรก removido das classroom
echo Exemplo SER: $0 '"victor.silva@fecaf.com.br"' '"classroom-2021@colegioser.com"' '"1ยบ ANO A EM MANHร"'
echo Exemplo FECAF: $0 '"victor.silva@fecaf.com.br"' '"classroom-2021.1@fecaf.com.br"' '"ADM.1NA"'
echo

if [ "$1" == "" ]; then echo "Faltou informar o email do aluno"; echo; exit; fi

id=$($gam print courses student $1 states ACTIVE | cut -d"," -f1 | grep -v "id")

for a in $id; do
	$gam course $a remove student $1;
done

if [ "$2" == "" ] || [ "$3" == "" ]; then echo 'FIM'; exit; fi

id2=$($gam print courses teacher $2 states ACTIVE | grep "$3" | cut -d"," -f1 | grep -v "id")

for a in $id2; do
        $gam course $a add student $1;
done

echo "FIM"
