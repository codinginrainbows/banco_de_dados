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
