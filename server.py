import http.server
import socketserver
import mysql.connector
import json
import configparser
import traceback

class MyRequestHandler(http.server.BaseHTTPRequestHandler):
    last_cnpj = None
    last_nome_organizacao = None
    last_senha_organizacao = None
    last_id_agendamento = None
    last_id_usuario = None
    last_cpf = None
    last_nomeU = None
    last_senhaU = None
    last_horario = None
    last_dia = None

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', '*')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.send_header('Access-Control-Max-Age', '86400')
        self.end_headers()

    def handle_response(self, status_code, message):
        self.send_response(status_code)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps({"message": message}).encode('utf-8'))

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
    
        response_data = {}
    
        if self.last_cpf is not None:
            response_data['cpf'] = self.last_cpf
            response_data['id_usuario'] = self.last_id_usuario
            response_data['nomeU'] = self.last_nomeU
            response_data['senhaU'] = self.last_senhaU

        if self.last_cnpj is not None:
            response_data['cnpj'] = self.last_cnpj
            response_data['nome_organizacao'] = self.last_nome_organizacao
            response_data['senha_organizacao'] = self.last_senha_organizacao

        if self.last_horario is not None:
            response_data['id_agendamento'] = self.last_id_agendamento
            response_data['horario'] = self.last_horario
            response_data['dia'] = self.last_dia

        self.wfile.write(json.dumps(response_data).encode('utf-8'))

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)

        try:
            config = configparser.ConfigParser()
            caminho_config = "C:\\Users\\rober\\Downloads\\arquivo_config_sql\\config1.ini"
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

            if 'cnpj' in data and 'nome_organizacao' in data and 'senha_organizacao' in data:
                self.last_cnpj = data['cnpj']
                self.last_nome_organizacao = data['nome_organizacao']
                self.last_senha_organizacao = data['senha_organizacao']

                cursor.execute("SELECT cnpj FROM organizacao WHERE cnpj = %s", (data['cnpj'],))
                existing_organization = cursor.fetchone()
                if existing_organization:
                    self.handle_response(409, "Organização já existe")
                else:
                    sql = "INSERT INTO organizacao (cnpj, nome_organizacao, senha_organizacao) VALUES (%s, %s, %s)"
                    val = (data['cnpj'], data['nome_organizacao'], data['senha_organizacao'])
                    print("Consulta SQL da Organização:", sql)
                    print("Valores da Organização:", val)
                    cursor.execute(sql, val)
                    self.handle_response(201, "Registro de organização feito com sucesso")
            
            elif 'cpf' in data and 'nomeU' in data and 'senhaU' in data:
                self.last_cpf = data['cpf']
                self.last_nomeU = data['nomeU']
                self.last_senhaU = data['senhaU']
                cursor.execute("SELECT cpf FROM usuario WHERE cpf = %s", (data['cpf'],))
                existing_usuario = cursor.fetchone()

                if existing_usuario:
                    self.handle_response(409, "Usuário já existe")
                else:
                    sql = "INSERT INTO usuario (cpf, nomeU, senhaU) VALUES (%s, %s, %s)"
                    val = (data['cpf'], data['nomeU'], data['senhaU'])
                    print("Consulta SQL do Usuário:", sql)
                    print("Valores do Usuário:", val)
                    cursor.execute(sql, val)
                    self.handle_response(201, "Registro de usuário feito com sucesso")
                
            elif 'login_usuario' in data:
                cpf = data['login_usuario']['cpf']
                senhaU = data['login_usuario']['senhaU']

                cursor.execute("SELECT cpf FROM usuario WHERE cpf = %s AND senhaU = %s", (cpf, senhaU))
                usuario = cursor.fetchone()

                if usuario:
                    self.handle_response(200, "Login de usuário realizado com sucesso")
                else:
                    self.handle_response(401, "CPF ou senha de usuário incorretos")

            elif 'login_organizacao' in data:
                cnpj = data['login_organizacao']['cnpj']
                senha_organizacao = data['login_organizacao']['senha_organizacao']

                cursor.execute("SELECT cnpj FROM organizacao WHERE cnpj = %s AND senha_organizacao = %s", (cnpj, senha_organizacao))
                organization = cursor.fetchone()

                if organization:
                    self.handle_response(200, "Login de organização realizado com sucesso")
                else:
                    self.handle_response(401, "CNPJ ou senha de organização incorretos")

            elif 'agendamento' in data:
                horario = data['agendamento']['horario']
                dia  = data['agendamento']['dia']

                cursor.execute("SELECT horario FROM agendamento WHERE horario = %s AND dia = %s", (horario, dia))
                agendamento_existe = cursor.fetchone()

                if agendamento_existe:
                    self.handle_response(200, "Agendamento já existe para esse horário")
                else:
                    sql = "INSERT INTO agendamento (horario, dia) VALUES (%s, %s)"
                    val = (horario, dia)
                    print("Consulta SQL do Agendamento:", sql)
                    print("Valores do Agendamento:", val)
                    cursor.execute(sql, val)
                    self.handle_response(201, "Agendamento feito com sucesso")

            else:
                raise ValueError("dados errados")

            db.commit()
            cursor.close()
            db.close()
        
        except json.decoder.JSONDecodeError:
            self.handle_response(400, "Erro ao decodificar JSON nos dados recebidos")
        
        except mysql.connector.Error as e:
            self.handle_response(330, f"Erro ao acessar o banco de dados: {str(e)}")

        except Exception as x:
            self.handle_response(550, f"Erro interno no servidor: {str(x)}")


if __name__ == '__main__':
    PORT = 80
    with socketserver.TCPServer(("0.0.0.0", PORT), MyRequestHandler) as httpd:
        print("Servidor rodando na porta", PORT)
        httpd.serve_forever()
