<b>Projeto: Hair Cut</b> <br/>
Procedimento para o uso: <br/>
Para a utilização do aplicativo Hair Cut são necessários algumas mudanças manuais no código:  <br/>

server.py: <br/>
Para ativar o servidor local, é necessario executar o comando "python server.py" no terminal no software Visual Studio Code. <br/>
<br/>

data.dart: <br/>
Para enviar as informações corretamente para o banco de dados, é necessário executar o comando "ngrok http 80" no terminal do software Ngrok. <br/>
Além disso, é necessário atualizar as URLs no em "data.dart" nas linhas 7, 22, 37, 55, 73 e 97 para a URL gerada ao executar o comando "ngrok http 80"<br/>
Exemplo: <br/>
Forwarding                    https://cf4f-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app -> http://localhost:80 <br/>
Nesse caso a URL que deve ser copiada e colada para substituir a anterior é "https://cf4f-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app". <br/>
<br/>

projeto-haircut-database.sql:<br/>
Tratam-se dos comandos utilizados para criar o banco de dados que recebe as informações utilizadas no aplicativo Hair Cut. <br/>
É essencial executar essas instruções para que as informações tenham onde ser armazenadas. <br/>
É recomendado executá-las no MySQL Workbench <br/>
É necessario que o banco de dados criado com a instrução CREATE DATABASE seja nomeado "haircut_full", exceto se for feita uma mudança no arquivo "config1.ini" na área "database", então será possivel escolher o nome. <br/>
Exemplo: 
Se o comando executado for "CREATE DATABASE hair"
O seguinte mudança deve ser feita no config1.ini: 
database=hair <br/>
<br/>

arquivo_config_sql:
Aqui está localizado o arquivo .ini nomeado "config1.ini" que é usado para que seja realizada a execução dos comandos como SELECT e INSERT no banco de dados.<br/>
Ele deve ser atualizado para conter o host, user, password e database, corretos do usuário que deseja utilizar o programa. <br/>
A área password está vazia para que essa mudança seja feita<br/>
<br/>



