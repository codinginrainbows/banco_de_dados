DROP DATABASE IF EXISTS medium;

CREATE DATABASE medium;

\c medium;

CREATE TABLE post (
    id serial primary key,
    titulo text NOT NULL,
    texto text NOT NULL,
    data_hora timestamp default current_date,
    publico boolean NOT NULL
);

INSERT INTO post (titulo, texto, publico) VALUES
('Odeio Java', 'texto odeio java', FALSE),
('Amo Java', 'texto amo java', FALSE),
('TI é legal', 'texto TI é legal', FALSE);

CREATE TABLE autor (
    id serial primary key,
    nome text NOT NULL,
    email text NOT NULL,
    senha text
);

INSERT INTO autor (nome, email, senha) VALUES
('Gabriel', 'gabriel@email.com', '123'),
('Fulano', 'fulano@email.com', '321'),
('Ciclano', 'ciclano@email.com', '000');

CREATE TABLE publicacao (
    post_id integer references post (id),
    autor_id integer references autor (id),
    primary key (post_id, autor_id)
);

INSERT INTO publicacao (post_id, autor_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 2),
(3, 3);

CREATE TABLE leitor (
    id serial primary key,
    nome text NOT NULL,
    email text NOT NULL,
    senha text NOT NULL
);

INSERT INTO leitor (nome, email, senha) VALUES
('Leitor 1', 'leitor1@email.com', '123'),
('Leitor 2', 'leitor2@email.com', '321'),
('Leitor 3', 'leitor3@email.com', '000');

CREATE TABLE endereco (
    id serial primary key,
    leitor_id integer references leitor (id),
    bairro text NOT NULL,  
    numero text NOT NULL,
    rua text NOT NULL,
    cep character(8) NOT NULL
);

INSERT INTO endereco (bairro, numero, rua, cep, leitor_id) VALUES
('Cidade Nova', '846', 'Av. Portugal', '96211041', 1),
('Navegantes', '101', 'Rua Padre Cacique', '84110052', 3);

-- 1. SELECT 'autor' AS Tipo, id as codigo, nome, email FROM autor UNION ALL SELECT 'leitor' AS Tipo, id as codigo, nome, email FROM leitor;

-- 2. SELECT id AS codigo, titulo AS titulo_do_post, COUNT(*) AS qtde_de_autores FROM post INNER JOIN publicacao ON id = post_id GROUP BY id, titulo;

-- 3. SELECT titulo as post, STRING_AGG(nome, ', ') AS nomes_dos_autores FROM post INNER JOIN publicacao ON id = post_id INNER JOIN autor ON autor_id = autor.id GROUP BY titulo;

-- 4. SELECT nome AS leitor, CASE WHEN endereco.id IS NOT NULL THEN CONCAT(rua, ', ', numero, ', ', bairro, ', ', cep) ELSE 'sem endereco cadastrado' END AS endereco FROM leitor LEFT JOIN endereco ON leitor.id = leitor_id;