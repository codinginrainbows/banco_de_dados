DROP DATABASE IF EXISTS spotify;

CREATE DATABASE spotify;

\c spotify;

CREATE SCHEMA administrativo;
SET search_path TO public, administrativo;

CREATE TABLE usuario (
    id serial primary key,
    nome text not null,
    email text unique,
    senha text not null,
    data_nascimento date check(extract(year from data_nascimento) >= 1900)
);

CREATE TABLE playlist (
    id serial primary key,
    nome text,
    data_hora timestamp default current_timestamp,
    usuario_id integer references usuario (id) ON DELETE CASCADE    
);

CREATE TABLE administrativo.artista (
    id serial primary key,
    nome text not null,
    nome_artistico character varying(60)    
);


CREATE TABLE administrativo.album (
    id serial primary key,
    titulo text,
    data_lancamento date,
    artista_id integer references artista (id)
);


CREATE TABLE administrativo.musica (
    id serial primary key,
    titulo text not null,
    duracao integer check(duracao > 0), 
    album_id integer references album (id)
);

CREATE TABLE playlist_musica (
    playlist_id integer references playlist (id) ON DELETE CASCADE,
    musica_id integer references musica (id),
    primary key (playlist_id, musica_id)
);

INSERT INTO usuario (nome,email,senha, data_nascimento)
VALUES
  ('Maya Donaldson','adipiscing@icloud.ca','massa.', '1900-01-01'),
  ('Cyrus Mcmillan','feugiat.lorem@google.com','laoreet,', '2000-02-02'),
  ('Alexander Dunn','donec.felis@protonmail.net','magna', '2010-03-03'),
  ('Iola Schwartz','in@google.edu','pellentesque.','2020-10-01'),
  ('Alan Flowers','enim.curabitur@protonmail.org','Nam', '1987-11-11');
  
  
  INSERT INTO playlist (nome,data_hora, usuario_id)
VALUES
  ('Jennifer Fischer','2024-08-08 17:38:23',1),
  ('Erich Cochran','2022-09-17 23:39:11',1),
  ('Rama Prince','2024-06-21 03:56:55',1),
  ('Wallace Schneider','2023-03-13 09:30:59',1),
  ('Amal Johnson','2023-08-23 06:48:23',1);
  
 
 INSERT INTO artista (nome,nome_artistico)
VALUES
  ('Mechelle Rodriquez','Nehru Butler'),
  ('Hedley Duke','Forrest Mckinney'),
  ('Autumn Miller','Keefe Hansen'),
  ('Rashad Martin','Ursa Buck'),
  ('Gareth Anthony','Belle Peters');
   
  
  INSERT INTO album (titulo,data_lancamento, artista_id)
VALUES
  ('Colton','2023-05-18', 1),
  ('Cyrus','2022-12-13', 2),
  ('Samson','2023-09-04',3),
  ('Damian','2022-07-07', 4),
  ('Elliott','2024-12-14',1);
  

INSERT INTO musica (titulo,duracao, album_id)
VALUES
  ('Farmer',542,1),
  ('White',237,1),
  ('Houston',206, 4),
  ('Waller',495, 2),
  ('Pennington',512,3);  
  
INSERT INTO playlist_musica (playlist_id, musica_id) VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,3),
(4,1);

  
  
-- SELECT nome, to_char(data_nascimento, 'DD/MM/YYYY') as data_nascimento_formatada FROM usuario;
  
-- SELECT upper(titulo) from album;

-- SELECT upper(titulo) from album order by id LIMIT 2;

-- SELECT nome || ';' || email as usuario_csv from usuario;

-- SELECT * FROM musica WHERE duracao between 100 and 300;


-- select * from artista where nome is not null and nome_artistico is not null;

-- SELECT coalesce(nome, nome_artistico, 'sem nada') as nome from artista;

-- select titulo, data_lancamento, nome from album inner join artista on (album.artista_id = artista.id) where extract(year from data_lancamento) = 2023;

-- select * from playlist where cast(data_hora as date) = CURRENT_DATE;

-- ALTER TABLE musica ADD CONSTRAINT duracao CHECK (duracao > 0);


-- SELECT * FROM artista where nome_artistico ILIKE 'k%';

-- SELECT * FROM album where extract(month from data_lancamento) = extract(month from current_date) and extract(year from data_lancamento) != extract(year from current_date);

-- SELECT * FROM album WHERE data_lancamento between CURRENT_DATE - INTERVAL '30 days' and CURRENT_DATE;



/*
SELECT titulo, 
    CASE
       WHEN EXTRACT(dow from data_lancamento) = 0 THEN 'Domingo'
       WHEN EXTRACT(dow from data_lancamento) = 1 THEN 'Segunda'
       WHEN EXTRACT(dow from data_lancamento) = 2 THEN 'Terça'
       WHEN EXTRACT(dow from data_lancamento) = 3 THEN 'Quarta'
       WHEN EXTRACT(dow from data_lancamento) = 4 THEN 'Quinta'
       WHEN EXTRACT(dow from data_lancamento) = 5 THEN 'Sexta'                                                                      
       WHEN EXTRACT(dow from data_lancamento) = 6 THEN 'Sábado'       
    END AS dia_semana
FROM album;
*/

/* 
SELECT titulo as album, TO_CHAR(data_lancamento, 'dd-mm-yyyy') as lancamento, CASE WHEN EXTRACT(dow FROM data_lancamento) = 1 THEN 'SEGUNDA-FEIRA' WHEN EXTRACT(dow FROM data_lancamento) = 2 THEN 'TERCA-FEIRA' WHEN EXTRACT(dow FROM data_lancamento) = 3 THEN 'QUARTA-FEIRA' WHEN EXTRACT(dow FROM data_lancamento) = 4 THEN 'QUINTA-FEIRA' WHEN EXTRACT(dow FROM data_lancamento) = 5 THEN 'SEXTA-FEIRA' ELSE 'FINAL DE SEMANA' END AS dia FROM album;
*/

-- SELECT musica.titulo FROM artista inner join album on (artista.id = album.artista_id) inner join musica on (album.id = musica.album_id) where artista.id = 1;

-- SELECT DISTINCT usuario.id,  usuario.nome FROM usuario inner join playlist on (usuario.id = playlist.usuario_id) ORDER BY usuario.id;


/* SELECT artista.id, artista.nome FROM artista EXCEPT SELECT artista.id, artista.nome FROM artista inner join album on (artista.id = album.artista_id); */

/* select * from artista where id not in (select artista.id from artista inner join album on (artista.id = album.artista_id));
*/

/* select artista.id, artista.nome from artista left join album on (artista.id = album.artista_id) where album.artista_id is null;
*/

/* SELECT artista.id, artista.nome, count(*) as qtde_album FROM artista inner join album on (artista.id = album.artista_id) GROUP BY artista.id;
*/


/* SELECT usuario.id, usuario.nome, count(*) as qtde FROM usuario inner join playlist on (usuario.id = playlist.usuario_id) GROUP BY usuario.id;
*/

/*
 SELECT usuario.id, usuario.nome, count(*) as qtde FROM usuario inner join playlist on (usuario.id = playlist.usuario_id) GROUP BY usuario.id;
*/

/*
-- titulos de album lancados no mesmo ano que o album mais antigo SELECT titulo from album where extract(year from data_lancamento) = (SELECT extract(year from data_lancamento) FROM album ORDER BY data_lancamento asc limit 
*/

/*
-- titulos de album lancados no mesmo ano que o album mais novo SELECT titulo from album where extract(year from data_lancamento) = (SELECT extract(year from data_lancamento) FROM album ORDER BY data_lancamento desc limit 1);
*/

/* select playlist.id, playlist.nome, count(*) from playlist inner join playlist_musica on (playlist.id = playlist_musica.playlist_id) group by playlist.id HAVING count(*) >= (select (cast((select count(*) from playlist_musica) as real))/(cast((select count(*) from playlist) as real)));
*/

/*
-- com view CREATE VIEW playlist_com_mais_igual_a_media AS select playlist.id, playlist.nome, count(*) from playlist inner join playlist_musica on (playlist.id = playlist_musica.playlist_id) group by playlist.id HAVING count(*) &gt;= (select (cast((select count(*) from playlist_musica) as real))/(cast((select DISTINCT count(id) from playlist) as real)));
-- uso  select * from playlist_com_mais_igual_a_media;

*/