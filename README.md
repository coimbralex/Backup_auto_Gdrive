# Introdução

Script de backup automatizado que tem como objetivo armazenar backups em uma pasta do google drive utilizando a ferramenta Rclone no sistema Linux

# Requisitos

Tem como requisito uma conta ja criada no Google Drive e a instalação do Rclone. 

Neste exemplo o backup esta configurado para ser realizado todos os dias as 11:20hrs

## Recomendação

Não utilize o Google Drive para armazenar arquivos sensíveis sem algum tipo de criptografia. 


## 1)Instalação do Rclone

```
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```

## 2)Configuração do Rclone

```
$ rclone config
  
  No remotes found - make a new one
  n) New remote
  s) Set configuration password
  q) Quit config
  n/s/q>    
```
 Tecle n (para iniciar uma nova configuração e digite o nome de sua preferencia para o drive, em nosso caso será criado com o nome de Gdrive)
 
 Em seguida escolha o numero correspondente ao storage que vc irá utilizar. Em nosso caso vai ser escolhido o número 18 > Google Drive.
```
Option client_id.
Google Application Client Id
Setting your own is recommended.
See https://rclone.org/drive/#making-your-own-client-id for how to create your own.
If you leave this blank, it will use an internal key which is low performance.
Enter a value. Press Enter to leave empty.
client_id>  
```
Pressione Enter para client_id> vazio. 
 
```
Option client_secret.
OAuth Client Secret.
Leave blank normally.
Enter a value. Press Enter to leave empty.
client_secret> 
```
Pressione Enter para client_secret> vazio. 

```
Option scope.
Scope that rclone should use when requesting access from drive.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
 1 / Full access all files, excluding Application Data Folder.
   \ (drive)
 2 / Read-only access to file metadata and file contents.
   \ (drive.readonly)
   / Access to files created by rclone only.
 3 | These are visible in the drive website.
   | File authorization is revoked when the user deauthorizes the app.
   \ (drive.file)
   / Allows read and write access to the Application Data folder.
 4 | This is not visible in the drive website.
   \ (drive.appfolder)
   / Allows read-only access to file metadata but
 5 | does not allow any access to read or download file content.
   \ (drive.metadata.readonly)
```
Insira 1 para permitir acesso total
 
```
Option service_account_file.
Service Account Credentials JSON file path.
Leave blank normally.
Needed only if you want use SA instead of interactive login.
Leading `~` will be expanded in the file name as will environment variables such as `${RCLONE_CONFIG_DIR}`.
Enter a value. Press Enter to leave empty.
service_account_file>
```
Enter para service_account_file> vazio

```
Edit advanced config?
y) Yes
n) No (default)
y/n> 
```
Insira n para default
```
Use web browser to automatically authenticate rclone with remote?
 * Say Y if the machine running rclone has a web browser you can use
 * Say N if running rclone on a (remote) machine without web browser access
If not sure try Y. If Y failed, try N.

y) Yes (default)
n) No
y/n> 
```
Insira y para autenticar na conta do seu drive pelo navegador
A janela do navegador irá abrir para fazer o login e dar permissão.
```
5>NOTICE: If your browser doesn't open automatically go to the following link: http://127.0.0.1:53682/auth?state=SZIo4VL_xsGY41ew7FAMEA
<5>NOTICE: Log in and authorize rclone for access
<5>NOTICE: Waiting for code...
<5>NOTICE: Got code
Configure this as a Shared Drive (Team Drive)?

y) Yes
n) No (default)
y/n>
```
Insira n para default

```
Keep this "gdrive3" remote?
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d>
```
Insira y para configuração default

Para listar os drives configurados no momento:

```
$ rclone listremotes

```
O drive criado deve aparecer.

Agora vc precisa criar uma pasta onde irão ser montados os arquivos para a sincronização com o drive e dar permissoes.
```
$ mkdir ~/Backups
$ chmod 775 ~/Backups
```
Vincular o Gdrive com a pasta Backups

```
$ rclone mount Gdrive: ~/Backups
``` 

## 3) Crie o script exe_bkp.sh e cole o código do repositório (aqui sera utilizado o editor nano)

```
$ nano exe_bkp.sh
```
## 4)Configure o crontab para a hora e frequencia que deseja para o backup 

```
$ crontab - e
```

Inclua a seguinte descrição para a realização do backup todos os dias as 11:20hrs da manhã.

20 11 * * * /home/usuario/./exe_bkp.sh



