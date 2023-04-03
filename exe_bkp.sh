#!/bin/bash

###VARIAVEIS###

#Diretorio de origem de onde será feito o backup.
backup_origem="/home/usuario/Documentos"

#Diretorio de destino para onde sera enviado o backup.
backup_destino="/home/usuario/Backups"

#Formato do arquivo de data.
formato_data=$(date "+%d-%m-%Y")

#Arquivo onde sera enviado o backup compactado.
nome_arquivo_bkp="backup-$formato_data.tar.gz"

###VERIFICAÇÃO SE O DISCO ESTA MONTADO###
if ! mountpoint -q -- "$backup_destino"; then
	printf "[$formato_data] DIRETORIO DESTINO SENDO MONTADO!\n"
	rclone mount --allow-non-empty Gdrive: ~/Backups &
	sleep 5
fi
printf "Diretorio montado no Gdrive\n"
###EXECUÇÃO DO BACKUP###
tar -czSpf "$backup_destino/$nome_arquivo_bkp" "$backup_origem"
	printf "backup realizado com sucesso\n"
###MANTER APENAS BACKUPS DOS ULTIMOS 5 DIAS###
find "$backup_destino" -mtime +5 -delete &
	sleep 360
###DESMONTA O DIRETORIO APOS 6 MINUTOS	
fusermount -u ~/Backups	
