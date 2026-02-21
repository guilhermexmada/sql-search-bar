create database sqlsearch;
use sqlsearch;

# criando tabela clientes
create table clientes(
	id int primary key auto_increment,
    nome varchar(150) not null,
    cpf varchar(20) unique not null,
    dt_nasc date,
    tel varchar(20) not null,
    estado varchar(100) not null,
    cidade varchar(100) not null,
    cep int(15) not null,
    bairro varchar(100) not null,
    rua varchar(100) not null,
    num int(5) not null,
    status enum("ativo","inativo")
);
# criando tabela vendedores
create table vendedores(
	id int primary key auto_increment,
    nome varchar(150) not null,
    cnpj varchar(20) unique not null,
    dt_inclusao date not null,
    tel varchar(20) not null,
    estado varchar(100) not null,
    cidade varchar(100) not null,
    cep int(15) not null,
    bairro varchar(100) not null,
    rua varchar(100) not null,
    num int(5) not null,
    status enum("ativo","inativo")
);

# criando tabela produtos
create table produtos(
	id int primary key auto_increment,
    id_cliente int,
    id_vendedor int,
    constraint fk_id_cliente foreign key (id_cliente) references clientes(id),
    constraint fk_id_vendedor foreign key (id_vendedor) references vendedores(id),
    nome varchar(150) not null,
    tipo varchar(100),
    preco float(10,2) not null,
    quant int(5),
    validade date,
    status_compra enum("vendido","pendente","reembolsado"),
    status enum("ativo","inativo")
);

# populando tabela clientes
insert into clientes (nome,cpf,dt_nasc,tel,estado,cidade,cep,bairro,rua,num,status) values 
("Arnaldo Fritz","12345678900","1999-02-17","5513000004444","São Paulo","Sorocaba",18013280,"Avenida Jabuticaba","Rua dos Guarda-Chuvas",50,"ativo"),
("Bianca Bishop","99988877711","2001-01-20","5513000005555","Rio de Janeiro","Rio de Janeiro",20315107,"Bairro Aprumado","Rua Tupi Guarani",71,"ativo"),
("César Augusto","32165498700","1972-12-15","5513323231414","Pernambuco","Olinda",99180822,"Bairro Joinha","Rua Enclave",100,"ativo"),
("Daniela Dinner","12897235490","1988-05-09","5513121213636","Mato Grosso","Cuiabá",12344321,"Avenida João de Barro","Rua Verbo To Be",88,"ativo"),
("Erick Jacquan","00099988833","2001-03-30","5513908761436","Amazonas","Borba",77771111,"Bairro Lacoste","Rua Alagada",101,"ativo");

# populando tabela vendedores
insert into vendedores (nome,cnpj,dt_inclusao,tel,estado,cidade,cep,bairro,rua,num,status) values
("Amanda Vetores","55566633311","2025-10-10","5513988997667","São Paulo","Ribeirão Preto",12344444,"Bairro Baobá","Rua dos Crentes",50,"ativo"),
("Breno Jordans","32145698701","2023-02-28","5513863312233","Rio Grande do Sul","Porto Alegre",08083214,"Avenida Solar","Rua Endireitada",31,"ativo"),
("Cammie Martins","50006130055","2024-07-12","5513315513551","Bahia","Iraquara",90000001,"Bairro Pernada","Rua Dog Mau",15,"ativo"),
("Dominique Toronto","50006174741","2020-06-23","5513442223377","São Paulo","Bertioga",13014260,"Avenida Azul","Rua Flórida Mayhem",44,"ativo"),
("Esmeralda da Silva","31300098922","2009-12-30","5513953721095","Ceará","Tabuleiro do Norte",80002384,"Avenida Morrão","Rua Predileta",99,"ativo");

# populando tabela produtos
insert into produtos (id_vendedor,id_cliente,nome,tipo,preco,quant,validade,status_compra,status) values
(1,4,"Escova","Higiene",12.89,2,"2028-02-21","vendido","ativo"),
(1,4,"Chapéu","Roupa",65.50,2,"2028-02-02","vendido","ativo"),
(1,4,"Pente","Higiene",9.90,1,"2030-05-10","vendido","ativo"),
(2,5,"Ventilador","Eletrodoméstico",150.00,2,"2032-09-01","pendente","ativo"),
(5,5,"Carregador","Eletrônico",50.89,1,"2027-11-03","pendente","ativo"),
(3,4,"Saia","Roupa",33.00,1,"2028-04-05","vendido","ativo"),
(2,4,"Fone de Ouvido","Eletrônico",22.00,1,"2027-01-25","vendido","ativo"),
(3,5,"Sofá","Mobília",600.00,3,"2040-03-30","reembolsado","ativo"),
(3,6,"Escrivaninha","Mobília",345.50,1,"2035-01-01","pendente","ativo"),
(3,7,"Panela","Utensílio",33.00,6,"2030-06-26","vendido","ativo"),
(3,8,"Garfo","Utensílio",4.99,4,"2027-01-03","vendido","ativo"),
(4,8,"Colher","Utensílio",3.25,4,"2027-01-03","vendido","ativo"),
(4,4,"Antena Bluetooth","Eletrônico",12.50,2,"2027-08-16","pendente","ativo"),
(4,4,"Violão","Instrumento",320.00,1,"2026-09-19","pendente","ativo"),
(5,7,"Lupa","Utensílio",5.25,1,"2026-12-12","vendido","ativo"),
(1,6,"Etiqueta","Papelaria",10.99,3,"2026-07-21","pendente","ativo"),
(5,4,"Caneta","Papelaria",7.89,2,"2027-03-09","vendido","ativo"),
(1,8,"Borracha","Papelaria",3.89,2,"2027-03-09","vendido","ativo"),
(4,7,"Liquidificador","Eletrodoméstico",89.90,1,"2029-12-15","vendido","ativo"),
(5,8,"Aspirador de Pó","Eletrodoméstico",120.00,1,"2029-10-24","pendente","ativo");

# criando view para exibir todas as compras finalizadas
create view vw_vendas_completas as
select 
clientes.nome as cliente,
vendedores.nome as vendedor,
produtos.nome as produto,
produtos.status_compra
from produtos 
join clientes on id_cliente = clientes.id
join vendedores on id_vendedor = vendedores.id
where status_compra = "vendido";

# criando view para exibir todas as compras pendentes ou reembolsadas
create view vw_vendas_incompletas as
select 
clientes.nome as cliente,
vendedores.nome as vendedor,
produtos.nome as produto,
produtos.status_compra
from produtos 
join clientes on id_cliente = clientes.id
join vendedores on id_vendedor = vendedores.id
where status_compra = "pendente" || status_compra = "reembolsado";

# criando function para somar o valor total vendido
delimiter //
create function totalVendido()
returns decimal(10,2)
begin
	declare total decimal(10,2);
    select sum(preco * quant) into total from produtos where status_compra != "reembolsado";
    return ifnull(total,0);
end // 
delimiter ;

# select totalVendido(); 

# criando function para 