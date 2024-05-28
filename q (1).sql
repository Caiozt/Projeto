CREATE TABLE agendamento (
  id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
  horario VARCHAR(25),
  dia VARCHAR(25)
);

CREATE TABLE usuario (
  id_usuario INT,
  cpf VARCHAR(25), 
  nomeU VARCHAR(25),
  senhaU VARCHAR(25),
  FOREIGN KEY (id_usuario) REFERENCES agendamento(id_agendamento)
);
  
CREATE TABLE organizacao (
  cnpj VARCHAR(30),
  nome_organizacao VARCHAR(30),
  senha_organizacao VARCHAR(30)
);


