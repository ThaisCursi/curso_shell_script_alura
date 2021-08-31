	#!/bin/bash

CAMINHO_BACKUP=/home/thais/backup_amazon
cd $CAMINHO_BACKUP
data=$(date +%F)
if [ ! -d $data ]
then
	mkdir $data
fi

tabelas=$(mysql -u root -p mutillidae -e "show tables;" | grep -v Tables)
for tabela in $tabelas
do
	mysqldump -u root -p mutillidae $tabela > $CAMINHO_BACKUP/$data/$tabela.sql
done

aws s3 sync $CAMINHO_BACKUP s3://cursoshellscript
