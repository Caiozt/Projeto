create database hair_cut;
use hair_cute;

create table usuarios(
	idUsuario int primary key auto_increment,
    Nome varchar(50) not null,
    email varchar(50) not null,
    cpf int not null,
    senha varchar(20) not null,
    telefone int not null
);

desc usuarios;

create table organizacoes(
	idOrganizacao int primary key auto_increment,
    NomeOrganizacao varchar(50) not null,
    cnpj int not null,
	Senha varchar(20) not null,
    idFuncionario int,
    foreign key (idFuncionario) references funcionarios(idFuncionario)
);

desc organizacoes;

create table funcionarios(
	idFuncionario int primary key auto_increment,
    Nome varchar(50) not null,
    Idade int not null,
    Setor varchar(20) not null,
    Cargo varchar(40) not null
);

desc funcionarios;

create table categorias(
	idCategoria int primary key auto_increment,
    Nome varchar(50) not null,
	Descricao varchar(400) 
);

desc categorias;

create table pedidos(
	idPedido int primary key auto_increment,
    dtPedido date not null,
    total int not null,
    idUsuario int,
    foreign key (idUsuario) references usuarios(idUsuario)
);

desc pedidos;

create table produtos(
	idProdutos int primary key auto_increment,
    Nome varchar(50) not null,
    precoProduto numeric(10,2) not null,
    Estoque int not null,
    Tamanho varchar(10),
    Descricao varchar(400),
    foreign key (Descricao) references categorias(Descricao)
);
drop table produtos;
desc produtos;

create table servicos(
	idServico int primary key auto_increment,
    precoServico numeric(10,2) not null,
    nome varchar(50) not null,
    descricao varchar(400),
    foreign key (descricao) references categorias(descricao)
);

desc servicos;

create table agendamentos(
	idAAgendamentos int primary key auto_increment,
    horario datetime,
    idUsuario int,
    idServico int,
    foreign key (idUsuario) references usuarios(idUsuario),
    foreign key (idServico) references servicos(idServicos)
);

desc agendamentos;

create table DetalhesDosPedidos(
	idDetalhes int primary key auto_increment,
    quantidade int not null,
    idPedido int,
    idUsuario int,
    precoProduto int,
    foreign key (idPedido) references pedidos(idPedido),
    foreign key (idUsuario) references usuarios(idUsuario),
    foreign key (precoProduto) references produtos(precoProduto)
);

desc DetalhesDosPedidos;