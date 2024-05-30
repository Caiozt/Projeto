<b>Projeto: Hair Cut</b> <br/>
Procedimento para o uso: <br/>
Para a utilização do aplicativo Hair Cut são necessários algumas mudanças manuais no código:  <br/>

<b>server.py:</b> <br/>
Para ativar o servidor local, é necessario executar o comando "python server.py" no terminal no software Visual Studio Code. <br/>
<br/>

<b>data.dart:</b> <br/>
Para enviar as informações corretamente para o banco de dados, é necessário executar o comando "ngrok http 80" no terminal do software Ngrok. <br/>
Além disso, é necessário atualizar as URLs no em "data.dart" nas linhas 7, 22, 37, 55, 73 e 97 para a URL gerada ao executar o comando "ngrok http 80"<br/>
Exemplo: <br/>
Forwarding                    https://cf4f-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app -> http://localhost:80 <br/>
Nesse caso a URL que deve ser copiada e colada para substituir a anterior é "https://cf4f-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app". <br/>
<br/>

<b>projeto-haircut-database.sql:</b> <br/>
Tratam-se dos comandos utilizados para criar o banco de dados que recebe as informações utilizadas no aplicativo Hair Cut. <br/>
É essencial executar essas instruções para que as informações tenham onde ser armazenadas. <br/>
É recomendado executá-las no MySQL Workbench. <br/>
É necessario que o banco de dados criado com a instrução CREATE DATABASE seja nomeado "haircut_full", exceto se for feita uma mudança no arquivo "config1.ini" na área "database", então será possivel escolher o nome. <br/>
Exemplo: <br/>
Se o comando executado for "CREATE DATABASE hair"<br/>
A seguinte mudança deve ser feita no config1.ini: <br/>
database=hair <br/>
<br/>

<b>arquivo_config_sql:</b><br/>
Aqui está localizado o arquivo .ini nomeado "config1.ini" que é usado para que seja realizada a execução dos comandos como SELECT e INSERT no banco de dados.<br/>
Ele deve ser atualizado para conter o host, user, password e database, corretos do usuário que deseja utilizar o programa. <br/>
A área password está vazia para que essa mudança seja feita.<br/>
<br/>


<b>HairCut.apk</b><br/>
Trata-se do arquivo .apk que pode ser baixado em um smartphone Android. Entretanto, com as mudanças supracitadas, é necessario criar outro arquivo .apk por meio do comando:<br/>
"flutter build apk --build-name=1.0 --build-number=1" em um  terminal adjacente (o terminal onde o código servidor local(server.py) está sendo executado não deve ser fechado). <br/>
Assim, será criado um novo arquivo .apk que poderá ser encontrado por meio do caminho: "app_haircut\build\app\outputs\flutter-apk". <br/>
Esse novo arquivo aparecerá sob o nome de "app-release.apk" nas pasta "flutter-apk".

