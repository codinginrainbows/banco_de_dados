DROP DATABASE IF EXISTS cinema; 
CREATE DATABASE cinema;

\c cinema;

CREATE SCHEMA interno;
CREATE SCHEMA externo;

SET search_path TO public, interno, externo;

CREATE TABLE externo.telespectador (
    id serial primary key,
    cpf character(11) unique,
    nome text not null
);

CREATE TABLE externo.filme (
    id serial primary key,
    titulo text not null,
    duracao integer check (duracao > 0)
);

CREATE TABLE public.sala (
    id serial primary key,
    nome text not null,
    capacidade integer check (capacidade > 0)
);

CREATE TABLE externo.sessao (
    id serial primary key,
    filme_id integer references filme (id),
    sala_id integer references  sala (id),
    data date not null,
    hora time not null
);

CREATE TABLE externo.ingresso (
    id serial primary key,
    telespectador_id integer references telespectador (id),
    sessao_id integer references sessao (id),
    valor_ingresso real,
    corredor character(1) not null,
    poltrona integer check (poltrona > 0),
    valor_pago real
);


CREATE TABLE interno.setor (
    id serial primary key,
    descricao text,
    valor_por_hora real
);  

CREATE TABLE interno.funcionario (
    id serial primary key,
    nome text not null,
    setor_id integer references setor (id)
);

CREATE TABLE interno.turno (
    sala_id integer references sala (id),
    funcionario_id integer references funcionario (id),
    data_hora_entrada timestamp default current_timestamp,
    data_hora_saida timestamp check (data_hora_saida > data_hora_entrada),
    primary key (sala_id, funcionario_id, data_hora_entrada)
);


INSERT INTO externo.telespectador (cpf, nome) 
VALUES ('11111111111','Maria Oliveira'),
('22222222222', 'Pedro Santos'),
('33333333333', 'Ana Silva'),
('44444444444', 'Lucas Souza'),
('55555555555','Isabela Almeida');

INSERT INTO externo.filme (titulo, duracao)
VALUES ('Ação Explosiva', 120),
('Comédia Louca', 90),
('Drama Intenso', 150),
('Aventuras Mágicas', 110),
('Suspense Misterioso', 140);

INSERT INTO public.sala (nome, capacidade)
VALUES ('Sala A', 80),
('Sala B', 100),
('Sala C', 60),
('Sala D', 120),
('Sala E', 90);

INSERT INTO externo.sessao (filme_id, sala_id, data, hora)
VALUES (1, 1, '2023-08-28', '18:00:00'),
(2, 2, '2023-08-28', '20:30:00'),
(3, 3, '2023-08-29', '15:00:00'),
(4, 4, '2023-08-29', '18:30:00'),
(5, 5, '2023-08-30', '16:45:00');

-- Ingresso 1
INSERT INTO externo.ingresso (telespectador_id, sessao_id, valor_ingresso, corredor, poltrona, valor_pago)
VALUES 
(1, 1, 12.5, 'B', 10, 12.5),
(2, 2, 15.0, 'C', 5, 15.0),
(1, 2, 15.0, 'C', 6, 15.0),
(3, 3, 10.0, 'A', 8, 10.0),
(4, 4, 13.0, 'D', 15, 13.0),
(4, 4, 13.0, 'D', 16, 13.0),
(5, 5, 11.5, 'E', 20, 11.5);

-- Setor 1
INSERT INTO interno.setor (descricao, valor_por_hora)
VALUES ('Limpeza', 20.0),
('Bilheteria', 25.0),
('Atendimento ao Cliente', 22.5),
('Tecnologia da Informação', 30.0),
('Segurança', 18.0);

-- Funcionário 1
INSERT INTO interno.funcionario (nome, setor_id)
VALUES ('Carlos Silva', 1),
('Ana Rodrigues', 2),
('Rafael Oliveira', 3),
('Mariana Santos', 4),
('Paulo Almeida', 5);

-- Turno 1
INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida)
VALUES (1, 1, '2023-08-28 08:00:00', '2023-08-28 16:00:00'),
(2, 2, '2023-08-28 14:00:00', '2023-08-28 22:00:00'),
(3, 3, '2023-08-29 09:00:00', '2023-08-29 17:00:00'),
(4, 4, '2023-08-29 12:00:00', '2023-08-29 20:00:00'),
(5, 5, '2023-08-30 10:00:00', '2023-08-30 18:00:00');


-- 2)
--SELECT cpf, nome, count(*) FROM externo.telespectador inner join
--externo.ingresso on (externo.telespectador.id = externo.ingresso.telespectador_id) inner join externo.sessao on (externo.sessao.id = externo.ingresso.sessao_id) where extract(month from sessao.data) = extract(month from current_date) and extract(year from sessao.data) = extract(year from current_date) group by cpf, nome;


-- 3) 

/*SELECT 
    tabela.sala_id as sala, 
    cast(tabela.soma_ingressos_vendidos as real)/cast((select count(*) from sessao where sessao.sala_id = tabela.sala_id) as real) as media 
    
FROM (SELECT sala.id as sala_id, count(*) AS soma_ingressos_vendidos from sala inner join sessao on (sala.id = sessao.sala_id) inner join ingresso on (ingresso.sessao_id = sessao.id) where sessao.data <= CURRENT_Date AND sessao.data >= current_Date - interval '7 days' group by sala.id) as tabela

where 
    cast(tabela.soma_ingressos_vendidos as real)/cast((select count(*) from sessao where sessao.sala_id = tabela.sala_id) as real) >=2;

-- by flavio
SELECT s.id, s.nome, COUNT(i.id)/COUNT(DISTINCT se.id) AS media_ingressos
FROM externo.ingresso i
 JOIN externo.sessao se ON se.id = i.sessao_id
 JOIN sala s ON s.id = se.sala_id
 WHERE se.data BETWEEN current_date - INTERVAL '7 day' AND current_date
 GROUP BY s.id, s.nome
 HAVING COUNT(i.id) / COUNT(DISTINCT se.id) >= 2;

*/


-- 4) CREATE VIEW sorteia AS SELECT * FROM externo.telespectador order by random() limit 1;
-- uso: SELECT * FROM sorteia;


-- 5) select externo.filme.id, externo.filme.titulo, count(*) from externo.filme inner join externo.sessao on (externo.filme.id = externo.sessao.filme_id) inner join externo.ingresso on (externo.ingresso.sessao_id = externo.sessao.id) where extract(year from externo.sessao.data) = extract(year from current_date) group by externo.filme.id having count(*) = (select count(*) from externo.filme inner join externo.sessao on (externo.filme.id = externo.sessao.filme_id) inner join externo.ingresso on (externo.ingresso.sessao_id = externo.sessao.id) where extract(year from externo.sessao.data) = extract(year from current_date) group by externo.filme.id order by count(*) desc limit 1) order by titulo;

-- 6) CREATE VIEW tudo AS SELECT public.sala.nome AS sala_nome, externo.filme.titulo, externo.telespectador.nome as telespectador_nome, to_char(externo.sessao.data, 'dd/mm/yyyy') as data, externo.sessao.hora, externo.ingresso.corredor,  externo.ingresso.poltrona FROM externo.telespectador inner join externo.ingresso on (externo.telespectador.id = externo.ingresso.telespectador_id) inner join externo.sessao on (externo.sessao.id = externo.ingresso.sessao_id) inner join public.sala on (externo.sessao.sala_id = public.sala.id) inner join externo.filme on (externo.filme.id = externo.sessao.filme_id) order by externo.ingresso.id;


-- 7) 

--SELECT CASE 
--        WHEN CAST(interno.turno.data_hora_entrada as time) BETWEEN '08:00' AND '12:00' THEN 'manha' 
--        WHEN CAST(interno.turno.data_hora_entrada as time) BETWEEN '13:30' AND '17:30' THEN 'tarde'
--        WHEN CAST(interno.turno.data_hora_entrada as time) BETWEEN '19:00' AND '23:00' THEN 'noite'
--        END as turno_de_trabalho,        
--        count(*) as qtde FROM interno.turno 
--    WHERE extract(year from interno.turno.data_hora_entrada) = extract(year from current_date)
--    group by turno_de_trabalho;




