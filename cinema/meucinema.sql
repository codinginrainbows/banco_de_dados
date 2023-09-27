DROP DATABASE IF EXISTS meucinema; 
CREATE DATABASE meucinema;

\c meucinema;

CREATE SCHEMA interno;
CREATE SCHEMA externo;

SET search_path TO public, interno, externo;

CREATE TABLE externo.filme (
    id serial PRIMARY KEY,
    titulo text NOT NULL,
    duracao integer CHECK(duracao > 0)
);

INSERT INTO externo.filme (titulo, duracao) VALUES
    ('Matrix', 150),
    ('O Poderoso Chefão', 175),
    ('Star Wars: Uma Nova Esperança', 121),
    ('O Senhor dos Anéis: A Sociedade do Anel', 178);

CREATE TABLE public.sala (
    id serial PRIMARY KEY,
    nome text NOT NULL,
    capacidade integer CHECK(capacidade > 0)
);

INSERT INTO public.sala (nome, capacidade) VALUES
    ('Sala 1', 100),
    ('Sala 2', 80),
    ('Sala 3', 120),
    ('Sala 4', 90);

CREATE TABLE externo.sessao (
    id serial PRIMARY KEY,
    filme_id integer REFERENCES filme (id),
    sala_id integer REFERENCES sala (id),
    data date NOT NULL,
    hora time NOT NULL  
);

INSERT INTO externo.sessao (filme_id, sala_id, data, hora) VALUES
    (1, 1, '2023-09-10', '15:00'),
    (2, 2, '2023-08-11', '16:30'),
    (3, 3, '2023-09-12', '19:15'),
    (3, 3, '2023-09-12', '19:15'),
    (3, 3, '2023-09-12', '19:15'),
    (4, 3, '2023-09-12', '19:15'),
    (4, 4, '2023-09-13', '20:45');

CREATE TABLE externo.telespectador (
    id serial PRIMARY KEY,
    cpf character(11) UNIQUE,
    nome text NOT NULL
);

INSERT INTO externo.telespectador (cpf, nome) VALUES
    ('11122233344', 'Maria Silva'),
    ('22233344455', 'João Santos'),
    ('33344455566', 'Ana Pereira'),
    ('44455566677', 'Pedro Oliveira');

CREATE TABLE externo.ingresso (
    id serial PRIMARY KEY,
    telespectador_id integer REFERENCES telespectador (id),
    sessao_id integer REFERENCES sessao (id),
    valor_ingresso real,
    corredor character(1) NOT NULL,
    poltrona integer CHECK(poltrona > 0),
    valor_pago real
);

INSERT INTO externo.ingresso (telespectador_id, sessao_id, valor_ingresso, corredor, poltrona, valor_pago) VALUES
    (1, 1, 25.50, 'A', 5, 25.50),
    (1, 4, 30, 'B', 8, 30),
    (1, 2, 30, 'A', 8, 30),
    (2, 2, 30, 'B', 8, 30),
    (3, 3, 28, 'C', 12, 28),
    (3, 3, 28, 'D', 12, 28),
    (4, 2, 28, 'C', 12, 28),
    (4, 3, 28, 'B', 12, 28),
    (2, 2, 28, 'C', 12, 28),
    (4, 4, 34.25, 'D', 9, 32.75);

CREATE TABLE interno.setor (
    id serial PRIMARY KEY,
    descricao text,
    valor_por_hora real
);

INSERT INTO interno.setor (descricao, valor_por_hora) VALUES
    ('Bilheteria', 50.00),
    ('Concessão', 30.00),
    ('Limpeza', 20.00),
    ('Manutenção', 40.00);

CREATE TABLE interno.funcionario (
    id serial PRIMARY KEY,
    nome text,
    setor_id integer REFERENCES setor (id)
);

INSERT INTO interno.funcionario (nome, setor_id) VALUES
    ('Carlos Oliveira', 1),
    ('Ana Sousa', 2),
    ('Paulo Santos', 3),
    ('Marta Fernandes', 1);

CREATE TABLE interno.turno (
    sala_id integer REFERENCES sala (id),
    funcionario_id integer REFERENCES funcionario (id),
    data_hora_entrega timestamp DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida timestamp
);

INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_saida) VALUES
    (1, 1, '2023-09-10 20:00'),
    (2, 2, '2023-09-11 21:30'),
    (3, 3, '2023-09-12 23:00'),
    (4, 4, '2023-09-13 22:15');

--2) SELECT telespectador.nome, telespectador.cpf, count(*) FROM telespectador INNER JOIN ingresso ON (telespectador.id = ingresso.telespectador_id) INNER JOIN sessao ON (ingresso.sessao_id = sessao.id) WHERE EXTRACT(month FROM sessao.data) = EXTRACT(month FROM CURRENT_DATE) GROUP BY nome, cpf;

--4) CREATE VIEW aleatorio AS SELECT nome, data FROM telespectador INNER JOIN ingresso ON (telespectador.id = ingresso.telespectador_id) INNER JOIN sessao ON (sessao.id = ingresso.sessao_id) WHERE sessao.data = CURRENT_DATE ORDER BY random() LIMIT 1;

--5) SELECT filme.titulo AS filme, count(*) AS ingressos FROM filme INNER JOIN sessao ON (filme.id = sessao.filme_id) INNER JOIN ingresso ON (sessao.id = ingresso.sessao_id) GROUP BY titulo ORDER BY count(*) DESC;

--6) CREATE VIEW movie AS SELECT sala.nome as sala, filme.titulo as filme, telespectador.nome as cliente, TO_CHAR(sessao.data, 'dd/mm/yyyy') as dia, sessao.hora as horario, ingresso.corredor, ingresso.poltrona FROM telespectador INNER JOIN ingresso ON (telespectador.id = ingresso.telespectador_id) INNER JOIN sessao ON (sessao.id = ingresso.sessao_id) INNER JOIN filme ON (filme.id = sessao.filme_id) INNER JOIN sala ON (sala.id = sessao.sala_id);