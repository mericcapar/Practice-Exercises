/*
Ex1C – Workbench Readiness Check
Name: Meric Capar   Date: 10/20/2026
Q1: The tile shows localhost, port 3306, and it logs in as root.
Q2: The plus icon next to MySQL connections create a new connect.
Q3: 1-Navigator, 2-Information, 3-Query Editor, 4- Output, 5-SQL Additions. I believe we will use all of them in this course.
Q4: Login User: root, Port: 3306, MySQL Server Version: 26.7.
Q5: Server Status and Client Connections 
Q6: actor_id is smallint unsigned and PK means primary key.
Q7: actor_id,film_id,last_update so it has 3 columns. It has 2 foreign keys. One is fk_film_actor_actor and the other is fk_film_actor_film.
Q8: A new tab opened showing the film_actor rows, and the Output pane logged the query.
Q9: 200 rows were returned. It is under the output.
Q10:The first three succeeded. actr failed with Error Code 1146: Table 'sakila.actr' doesn't exist.
Q11:It shows each record as a text block instead of a table.
Q12:AKROYD
Q13: 3 actors   
Q14: VARCHAR(45)
*/

USE sakila;
SELECT * FROM actor;
SELECT * FROM sakila.film;
SELECT * FROM actr;
