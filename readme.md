# Lista Cakebakery

01. Listar todos os clientes
02. Listar clientes que começam com "I"
03. Listar somente os primeiros 2 clientes que começam com "I"
04. Sortear 2 clientes
05. Listar somente clientes que não cadastraram endereços
06. Listar somente os clientes que moram no cassino
07. Listar somente clientes com mais de 2 endereços cadastrados
08. Listar pedidos feitos hoje
09. Listar pedidos feitos nas últimas 24h
10. Listar os itens de cada pedido
11. Listar os itens + descrição dos produtos de um determinado pedido
12. Listar clientes e seus pedidos
13. Listar clientes, seus pedidos e os itens de cada pedido
14. Listar a quantidade média por item (de todos os pedidos)
15. Calcular o total de cada pedido
16. Listar somente os pedidos feitos na última semana
17. Listar somente os pedidos feito hoje (hoje genérico)
18. Listar os pedidos (formatando as datas em dd/mm/yyyy)
19. Retornar somente o primeiro nome de cada cliente
20. Retornar os nomes em maiúsculo (de cada cliente)
21. Retornar clientes maiores de 18 anos
22. Qual a média etária de clientes
23. Gasto médio de clientes maiores de 18
24. Quais produtos nunca foram item? (nunca participaram de um pedido)
25. Qual produto apareceu mais vezes nos pedidos (qual pedido vendeu mais)? Se existir empate, mostrar todos os produtos "empatados" em 1º lugar
26. Atualizar as datas para 7 dias para trás
27. Mostrar clientes que realizaram pedidos sem repetir clientes
28. Mostrar o nome do cliente e seu bairro. Caso o bairro esteja em branco, mostrar a rua
29. Mostrar o nome + email para clientes com id < 10 e nome + cpf para id >= 10
30. Exibir produto mais vendido/menos vendido
31. Pedidos entregue no mesmo dia
32. Clientes que mais fizeram pedidos
33. Clientes que não fizeram nenhum pedido
34. Clientes com mais de 2 endereços cadastrados
35. Clientes que ainda não receberam nenhum pedido (sem entrega)
36. Clientes que tiveram pedidos com entrega atrasada (entrega realizada mas data da entrega != data do pedido)

# Lista Spotify

1. Adicione a coluna data_nascimento na tabela de usuários. Além disso, coloque uma cláusula CHECK permitindo somente anos de nascimento >= 1900.
2. Retorne os nomes dos usuários e suas datas de nascimento formatadas em dia/mês/ano. Para testar será preciso inserir ou atualizar as datas de nascimento de alguns usuários.
3. Delete usuários sem nome. 
4. Torne a coluna nome da tabela usuários obrigatória. 
5. Retorne os títulos de todos os álbuns em maiúsculo. 
6. Retorne somente os títulos dos 2 primeiros álbuns cadastrados. 
7. Retorne o nome e o email de todos os usuários separados por ponto-e-vírgula. 
8. Retorne músicas com duração entre 100 e 200 segundos. 
9. Retorne músicas que não possuem duração entre 100 e 200 segundos. 
10. Retorne artistas que possuem nome e nome artístico. 
11. Retorne, preferencialmente, o nome de todos os artistas. Caso um determinado artista não tenha cadastrado seu nome, retorne na mesma consulta seu nome artístico.
12. Retorne o título dos álbuns lançados em 2023. 
13. Retorne o nome das playlists que foram criadas hoje. 
14. Atualize todos os nomes dos artistas (nome e nome_artistico) para maiúsculo. 
15. Coloque uma verificação para a coluna duracao (tabela musica) para que toda duração tenha mais de 0 segundos.
16. Adicione uma restrição UNIQUE para a coluna email da tabela usuario. 
17. Retorne somente os artistas que o nome artístico começa com "Leo" (Ex: Leo Santana, Leonardo e etc.). 
18. Retorne o título dos álbuns que estão fazendo aniversário neste mês. 
19. Retorne o título dos álbuns lançados no segundo semestre do ano passado (de julho de 2022 a dezembro de 2022).
20. Retorne o título dos álbuns lançados nos últimos 30 dias. 
21. Retorne o título e o dia de lançamento (por extenso) de todos os álbuns. 
22. Retorne o título e o mês de lançamento (por extenso) de todos os álbuns. 
23. Retorne pelo menos um dos álbuns mais antigos. 
24. Retorne pelo menos um dos álbuns mais recentes. 
25. Liste os títulos das músicas de todos os álbuns de um determinado artista. 
26. Liste os títulos das músicas de um álbum de um determinado artista. 
27. Liste somente os nomes de usuários que possuem alguma playlist (cuidado! com a repetição). 
28. Liste artistas que ainda não possuem álbuns cadastrados. 
29. Liste usuários que ainda não possuem playlists cadastradas. 
30. Retorne a quantidade de álbuns por artista. 
31. Retorne a quantidade de músicas por artista. 
32. Retorne o título das músicas de uma playlist de um determinado usuário. 
33. Retorne a quantidade de playlist de um determinado usuário. 
34. Retone a quantidade de músicas por artista (de artistas que possuem pelo menos 2 músicas). 
35. Retorne os títulos de todos os álbuns lançados no mesmo ano em que o álbum mais antigo foi lançado. 
36. Retorne os títulos de todos os álbuns lançados no mesmo ano em que o álbum mais novo foi lançado. 
37. Retorne na mesma consulta os nomes de todos os artistas e de todos os usuários. Caso um determinado artista não tenha cadastrado seu nome, retorne seu nome artístico.
38. Retorne nomes das playlists com e sem músicas. 
39. Retorne a média da quantidade de músicas de todas as playlists. 
40. Retorne somente playlists que possuem quantidade de músicas maior ou igual a média. 

# Trabalho Medium

Construa Modelo Relacional e desenvolva algumas consultas SQL para um Portal para escritores de blogs (algo como Medium).

Neste sistema cada postagem (Post) possui um identificador único, um título, um texto e uma data/hora de publicação.

Cada post pode ser escrito por diversos autores que, por sua vez, pode escrever diversos posts. No momento que cada post é criado, é possível definir se o mesmo é compartilhado com os demais autores da plataforma - ou fica exclusivo para o autor-criador (deve existir um atributo booleano para esta finalidade). Cada autor tem um identificador único, um nome, um email e uma senha de acesso.

Além dos autores dos posts, há leitores que somente podem ter acesso as posts (publicações) por meio de um cadastro prévio. Cada leitor possui os mesmos atributos dos escritores mas devem cadastrar - além dos atributos herdados - seus endereços para que futuras correspondências promocionais sejam enviadas para o endereço cadastrado. Um leitor pode cadastrar diversos endereços. Cada endereço possui identificador único, um bairro, uma rua, um número, um complemento e um cep.

Exigências:
Modelo Relacional (1,0)
Implementação Física (script.sql) (1,0)

1. Informações de todos os leitores e autores (0,5)
2. Quantidade de autores envolvidos na escrita de cada Post (0,5)
3. O título de cada Post e o nome de cada autores envolvido na escrita de cada Post (0,5)
4. Listar os leitores com e sem endereços. Caso tenha endereço, coloque o endereço. Se não tiver, coloque "Sem endereço cadastrado" (0,5)
