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

CREATE TABLE public.sala (
    id serial PRIMARY KEY,
    nome text NOT NULL,
    capacidade integer CHECK(capacidade > 0)
);

CREATE TABLE externo.sessao (
    id serial PRIMARY KEY,
    filme_id integer REFERENCES filme (id),
    sala_id integer REFERENCES sala (id),
    data date NOT NULL,
    hora time NOT NULL  
);

CREATE TABLE externo.telespectador (
    id serial PRIMARY KEY,
    cpf character(11) UNIQUE,
    nome text NOT NULL
);

CREATE TABLE externo.ingresso (
    id serial PRIMARY KEY,
    telespectador_id integer REFERENCES telespectador (id),
    sessao_id integer REFERENCES sessao (id),
    valor_ingresso real,
    corredor character(1) NOT NULL,
    poltrona integer CHECK(poltrona > 0),
    valor_pago real
);