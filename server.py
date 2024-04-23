import http.server
import socketserver
import mysql.connector
import json
import configparser

class MyRequestHandler(http.server.BaseHTTPRequestHandler):
    last_cnpj = None
    last_nome_organização = None
    last_senha_organização = None
    last_cpf = None
    last_nomeU = None
    last_senhaU = None


    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        response_content = b"<html><body><h1>Hello, world!</h1>"

        if self.last_cpf is not None:
           response_content += f"<p>Último CPF recebido: {self.last_cpf}</p>".encode('utf-8')
           response_content += f"<p>Último Nome de Usuário recebido: {self.last_nomeU}</p>".encode('utf-8')
           response_content += f"<p>Última Senha de Usuario recebida: {self.last_senhaU}</p>".encode('utf-8')
           response_content += b"</body></html>"
           self.wfile.write(response_content)

        #verifica se chegaram dados
        if self.last_cnpj is not None:
            response_content += f"<p>Último CNPJ recebido: {self.last_cnpj}</p>".encode('utf-8')
            response_content += f"<p>Último Nome da Organização recebido: {self.last_nome_organização}</p>".encode('utf-8')
            response_content += f"<p>Última Senha da Organização recebida: {self.last_senha_organização}</p>".encode('utf-8')
            response_content += b"</body></html>"
            self.wfile.write(response_content)

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)

        try:
            #inicializa configparser
            config = configparser.ConfigParser()

            #escreve o caminho para um arquivo .ini no seu pc para não ter que pôr a senha etc do Mysql nesse codigo.
            caminho_config = "C:\\Users\\rober\\Downloads\\arquivo_config_sql\\config.ini"
        

            config.read(caminho_config)


            host = config['mysql']['host']
            user = config['mysql']['user']
            password = config['mysql']['password']
            database = config['mysql']['database']

            db = mysql.connector.connect(
                host=host,
                user=user,
                password=password,
                database=database
            )
            print("Conexão com o banco de dados estabelecida com sucesso.")

            cursor = db.cursor()

            data = json.loads(post_data.decode('utf-8'))
            print("Dados recebidos:", data)

            if 'cnpj' in data and 'nome_organização' in data and 'senha_organização' in data:
                self.last_cnpj = data['cnpj']
                self.last_nome_organização = data['nome_organização']
                self.last_senha_organização = data['senha_organização']

                sql = "INSERT INTO organização (cnpj, nome_organização, senha_organização) VALUES (%s, %s, %s)"
                val = (data['cnpj'], data['nome_organização'], data['senha_organização'])
                print("Consulta SQL da Organização:", sql)
                print("Valores da Organização:", val)

            elif 'cpf' in data and 'nomeU' in data and 'senhaU' in data:
                self.last_cpf = data['cpf']
                self.last_nomeU = data['nomeU']
                self.last_senhaU = data['senhaU']

           
                sql = "INSERT INTO user (cpf, nomeU, senhaU) VALUES (%s, %s, %s)"
                val = (data['cpf'], data['nomeU'], data['senhaU'])
                print("Consulta SQL do Usuário:", sql)
                print("Valores do Usuário:", val)

            else:
                raise ValueError("dados errados")

            cursor.execute(sql, val)

            #commit
            db.commit()

            cursor.close()
            db.close()

            #envia resposta de sucesso
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({"message": "Registro feito com sucesso"}).encode('utf-8'))
        
        except json.decoder.JSONDecodeError:
            self.send_response(400)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({"error": "Erro ao decodificar JSON nos dados recebidos"}).encode('utf-8'))
        
        except mysql.connector.Error as e:
            self.send_response(500)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({"error": f"Erro ao acessar o banco de dados: {str(e)}"}).encode('utf-8'))

        except Exception as e:
            #exceções não previstas, envia resposta de erro comum
            self.send_response(500)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({"error": f"Erro interno no servidor: {str(e)}"}).encode('utf-8'))

if __name__ == '__main__':
    PORT = 80
    with socketserver.TCPServer(("0.0.0.0", PORT), MyRequestHandler) as httpd:
        print("Servidor rodando na porta", PORT)
        httpd.serve_forever()
