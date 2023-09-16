DROP DATABASE IF EXISTS cakebakery;

CREATE DATABASE cakebakery;

\c cakebakery;

CREATE TABLE cliente (
    id serial primary key,
    email character varying (100) unique,
    nome character varying (60),
    cpf character(11) unique,
    data_nascimento date
);

INSERT INTO cliente (cpf, nome, email) VALUES 
('11111111111', 'IGOR AVILA PEREIRA', 'igor.pereira@riogrande.ifrs.edu.br'),
('22222222222', 'MÁRCIO JOSUÉ RAMOS TORRES', 'marcio.torres@riogrande.ifrs.edu.br'),
('33333333333', 'CIBELE SINOTI', 'cibele.sinoti@riogrande.ifrs.edu.br');

INSERT INTO cliente (cpf, nome, email) VALUES ('44444444444', 'BETITO', 'betito@riogrande.ifrs.edu.br');

CREATE TABLE endereco (
    id serial primary key,
    cliente_id integer references cliente (id),
    bairro text,
    cep character(8),
    rua text,
    nro text,
    principal boolean DEFAULT false
);
INSERT INTO endereco (cliente_id, bairro, cep, rua, nro, principal) VALUES
(1, 'CASSINO', '96969696', 'AV. RIO GRANDE', '100', FALSE),
(1, 'CENTRO', '89898989', 'LUIZ LOREA', '201A', TRUE),
(3, 'FRAGATA', '56565656', 'RUA DO FRAGATA', '2', TRUE);


INSERT INTO endereco (cliente_id, cep, rua, nro, principal) VALUES
(4,  '56565656', 'RUA DO cassino', '2', TRUE);

CREATE TABLE pedido (
    id serial primary key,
    data_hora timestamp default current_timestamp,
    cliente_id integer references cliente(id)
);
INSERT INTO pedido (cliente_id) VALUES
(1),
(3);
INSERT INTO pedido (data_hora, cliente_id) VALUES
('10/09/2023', 2);

CREATE TABLE entrega (
    id serial primary key,
    pedido_id integer references pedido (id),
    endereco_id integer references endereco (id),
    data_hora timestamp,
    valor money
);

INSERT INTO entrega (pedido_id, endereco_id, valor) VALUES
(1, 2, 7),
(2, 3, 50);

CREATE TABLE produto (
    id serial primary key,
    descricao text,
    valor money,
    estoque integer
);
INSERT INTO produto (descricao, valor, estoque) VALUES
('PÃO DE QUEIJO', 3, 100),
('BISCOITO DE AMENDOIM', 7, 300);


CREATE TABLE item (
    id serial primary key,
    pedido_id integer references pedido (id),
    qtde integer,
    produto_id integer references produto (id)
);

INSERT INTO item (pedido_id, produto_id, qtde) VALUES
(1, 1, 10),
(1, 2, 20),
(2, 1, 10),
(2, 2, 10);

UPDATE item SET qtde = 5 where id = 1;

-- listar todos os clientes
-- SELECT * FROM cliente;

-- listar clientes que começam com I
-- cakebakery=# Select * from cliente where upper(nome) LIKE 'I%';
-- cakebakery=# Select * from cliente where nome ILIKE 'I%';

-- mostrar endereços de clientes que tenham o nome começando com I
-- cakebakery=# SELECT bairro, rua, cep, nro FROM cliente INNER JOIN endereco on (cliente.id = endereco.cliente_id) WHERE nome ILIKE 'I%';

-- mostrar clientes os primeiros 2 clientes ordenados alfabeticamente que comecam com 'I'
-- cakebakery=# SELECT * FROM cliente WHERE nome ILIkE 'I%' order by nome limit 2 ;

-- sortear 2 clientes
-- cakebakery=# select * from cliente order by random() limit 2;

-- clientes sem endereco
-- 1)
-- cakebakery=# SELECT id, nome from CLIENTE
-- EXCEPT
-- SELECT cliente.id, cliente.nome FROM cliente INNER JOIN endereco on (cliente.id = endereco.cliente_id);
-- 2)
-- cakebakery=# SELECT * FROM cliente WHERE id NOT IN (select endereco.cliente_id from endereco);
-- 3)
-- cakebakery=# SELECT * FROM cliente LEFT JOIN endereco ON (cliente.id = endereco.cliente_id) where endereco.cliente_id IS NULL;

-- LISTANDO OS CASSINEIROS
-- cakebakery=# select * from cliente inner join endereco on (cliente.id = endereco.cliente_id) where UPPER(bairro) = 'CASSINO';

-- listar clientes que tenham pelo menos 2 enderecos cadastrados
-- cakebakery=# SELECT cliente.id, cliente.nome, count(*) FROM cliente inner join endereco on (cliente.id = endereco.cliente_id) group by cliente.id, cliente.nome HAVING count(*) >= 2;

-- formatar a data e conversao de tipo (cast)
-- cakebakery=# SELECT pedido.id, to_char(cast(data_hora as date), 'dd/mm/yyyy'), cliente.nome FROM pedido INNER JOIN cliente ON (pedido.cliente_id = cliente.id) where cast(data_hora as date) = CURRENT_DATE; 

-- usar interval para data e hora
-- cakebakery=# SELECT * FROM pedido WHERE data_hora >= CURRENT_TIMESTAMP - INTERVAL '24 hours'  and  data_hora <= CURRENT_TIMESTAMP order by data_hora desc;

-- itens de um determinado pedido
-- cakebakery=# SELECT pedido.id, produto.descricao, item.qtde, produto.valor, item.qtde * produto.valor as total  FROM pedido INNER JOIN item ON (pedido.id = item.pedido_id) INNER JOIN produto on (produto.id = item.produto_id) where pedido.id = 1;

-- total de um pedido
-- cakebakery=# SELECT pedido.id, sum(item.qtde * produto.valor) as total  FROM pedido INNER JOIN item ON (pedido.id = item.pedido_id) INNER JOIN produto on (produto.id = item.produto_id) where pedido.id = 1 group by pedido.id;

-- pedidos da ultima semana
-- cakebakery=# SELECT * FROM pedido where cast(data_hora as date) >= CURRENT_date - INTERVAL '7 days' and  cast(data_hora as date) <= CURRENT_DATE;

-- pedidos feito hoje
-- cakebakery=# SELECT * FROM pedido where cast(data_hora as date) = CURRENT_daTE;
-- caso quisesse exibir os nomes
-- cakebakery=# SELECT data_hora, cliente.nome FROM pedido inner join cliente on (pedido.cliente_id = cliente.id)  where cast(data_hora as date) = CURRENT_daTE order by cliente_id;

-- listar os pedidos com a data formatada
-- cakebakery=# SELECT pedido.id, to_char(data_hora, 'dd/mm/yyyy HH24:MI:SS') as data_formatada, cliente_id FROM pedido;

-- SOMENTE O primeiro nome dos clientes
-- cakebakery=# SELECT SUBSTRING(nome FROM  1 FOR POSITION(' ' in nome)) FROM cliente;

-- todo o nome em maiusculo
-- cakebakery=# SELECT UPPER(nome) FROM cliente;

-- 1ª letra de cada palavra em maiusculo
-- cakebakery=# SELECT initcap(nome) FROM cliente;

-- formas de calcular a idade
-- cakebakery=# SELECT (CURRENT_DATE - data_nascimento)/365 FROM cliente;
-- cakebakery=# SELECT EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) FROM cliente;

-- filtrar clientes com mais de 18 anos
-- cakebakery=# select * from cliente where EXTRACT(YEAR FROM AGE(data_nascimento)) >= 18;

-- a media etaria dos clientes
-- cakebakery=# SELECT CAST(AVG(EXTRACT(YEAR FROM AGE(data_nascimento))) AS NUMERIC(8,1)) as media from cliente;

-- cakebakery=# select avg(t.total) from (SELECT cliente.id, cliente.nome, cast(sum(item.qtde * produto.valor) as numeric) as total FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) inner join item on (item.pedido_id = pedido.id) inner join produto on (produto.id = item.produto_id) where EXTRACT(YEAR FROM AGE(data_nascimento)) >= 18 group by cliente.id, cliente.nome) as t; 

-- cakebakery=# SELECT SUM(item.qtde * produto.valor)/(SELECT count(*) FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) WHERE EXtract(year from age(data_nascimento)) >= 18) AS MEDIA FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) inner join item on (item.pedido_id = pedido.id) inner join produto on (produto.id = item.produto_id) where extract(year from age(data_nascimento)) >= 18;

-- produto que n foi vendido (que n apareceu em nenhum pedido)
-- cakebakery=# select * from produto where id not in (select item.produto_id from item);

-- cakebakery=# SELECT produto.descricao FROM pedido inner join item on (pedido.id = item.pedido_id) inner join produto on (item.produto_id = produto.id) group by produto.descricao HAVING count(*) = (SELECT count(*) from pedido inner join item on (pedido.id = item.pedido_id) group by item.produto_id ORDER BY count(*) DESC limit 1);

-- SELECT item.produto_id, produto.descricao, SUM(item.qtde) from item inner join produto on (produto.id = item.produto_id) group by item.produto_id, produto.descricao having sum(item.qtde) = (select sum(item.qtde) from item group by item.produto_id order by sum(item.qtde) desc limit 1);

-- cliente que fizeram pedido
-- cakebakery=# SELECT cliente.nome FROM cliente WHERE id in (SELECT pedido.cliente_id FROM pedido);

-- clientes que fizeram pedido sem repetir o nome de cada cliente
-- cakebakery=# SELECT DISTINCT cliente.nome from cliente inner join pedido on (cliente.id = pedido.cliente_id);


-- cakebakery=# SELECT cliente.nome, coalesce(bairro,rua, 'nem bairro, nem rua') as end FROM cliente inner join endereco on (cliente.id = endereco.cliente_id);


/*SELECT cliente.nome,
    CASE
        WHEN bairro IS NOT NULL THEN bairro
        WHEN rua IS NOT NULL THEN rua
        ELSE 'nem bairro, nem rua'            
    END    
FROM cliente inner join endereco on (cliente.id = endereco.cliente_id);*/

/*
SELECT nome, 
    CASE
        WHEN id < 2 THEN email 
        WHEN id >= 2 THEN cpf
    END
   FROM cliente order by nome desc;

SELECT * FROM (
SELECT nome, email FROM cliente where id < 2
UNION
SELECT nome, cpf FROM cliente where id >= 2
) as t order by t.nome desc;
*/

/*

SELECT produto.id, produto.descricao, sum(item.qtde)
    FROM produto inner join item on (produto.id = item.produto_id)
GROUP by produto.id having sum(item.qtde) = (SELECT sum(item.qtde)
    FROM produto inner join item on (produto.id = item.produto_id)
GROUP by produto.id ORDER BY sum(item.qtde) DESC LIMIT 1);

*/

-- cakebakery=# SELECT to_char(cast(pedido.data_hora as date), 'DD/MM/YYYY') AS dia, count(*) as qtde from pedido group by pedido.data_hora;


/*
SELECT cliente.id, cliente.nome, count(pedido.id) FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) GROUP BY cliente.id, cliente.nome HAVING count(pedido.id) = (SELECT count(pedido.id) FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) GROUP BY cliente.id ORDER BY count(*) DESC LIMIT 1);

*/

-- cakebakery=# Select * from cliente where id not in (select pedido.cliente_id from pedido);

-- cakebakery=# Select * from cliente left join pedido on (cliente.id = pedido.cliente_id) where pedido.cliente_id is null;

-- SELECT cliente.id, cliente.nome, cliente.email FROM cliente EXCEPT SELECT cliente.id, cliente.nome, cliente.email FROM cliente inner join pedido on (cliente.id = pedido.cliente_id);


-- SELECT * FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) where cliente.id not in (Select cliente.id FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) inner join entrega on (entrega.pedido_id = pedido.id));


-- SELECT * FROM cliente inner join pedido on (cliente.id = pedido.cliente_id) INNER JOIN entrega ON (entrega.pedido_id = pedido.id) where entrega.data_hora is null or cast(entrega.data_hora as date) !=  CURRENT_DATE;