


-- 10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)

SELECT software_houses.*
FROM software_houses
INNER JOIN videogames
ON software_houses.id = videogames.software_house_id
where videogames.release_date = (SELECT MIN(videogames.release_date) from videogames)





-- 9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)

SELECT players.name
FROM tournaments
INNER JOIN tournament_videogame
ON tournament_videogame.tournament_id = tournaments.id
INNER JOIN videogames
ON videogames.id = tournament_videogame.videogame_id
INNER JOIN award_videogame
ON award_videogame.videogame_id = videogames.id
INNER JOIN awards
on awards.id = award_videogame.award_id
INNER JOIN player_tournament
ON player_tournament.tournament_id = tournaments.id
INNER JOIN players
ON players.id = player_tournament.player_id
WHERE tournaments.year = 2019 AND award_videogame.YEAR = 2018 AND awards.id = 5



-- 8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)

SELECT tournaments.city AS città, videogames.name AS videogioco
FROM tournaments
INNER JOIN tournament_videogame
ON tournament_videogame.tournament_id = tournaments.id
INNER JOIN videogames
ON videogames.id = tournament_videogame.videogame_id
INNER JOIN award_videogame
ON award_videogame.videogame_id = videogames.id
INNER JOIN awards
on awards.id = award_videogame.award_id
WHERE award_videogame.year = 2018 AND awards.id = 1;








-- 7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)

SELECT DISTINCT videogames.name
FROM videogames
INNER JOIN tournament_videogame
ON tournament_videogame.videogame_id = videogames.id
INNER JOIN tournaments
ON tournament_videogame.tournament_id = tournaments.id
INNER JOIN player_tournament
ON player_tournament.tournament_id = tournament_videogame.tournament_id
INNER JOIN players
ON players.id = player_tournament.player_id
WHERE players.name LIKE 'S%';





-- 6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
SELECT distinct categories.name,  pegi_labels.name, videogames.name
from categories
inner join category_videogame
on category_videogame.category_id = categories.id
inner join videogames
on videogames.id =  category_videogame.videogame_id
inner join pegi_label_videogame
on pegi_label_videogame.videogame_id = videogames.id
inner join pegi_labels
on pegi_labels.id = pegi_label_videogame.pegi_label_id
inner join reviews
on reviews.videogame_id = videogames.id
where rating BEtween 4 and 5



-- 5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
SELECT awards.name, software_houses.name
from awards
inner join award_videogame
on award_videogame.award_id = awards.id
inner join videogames 
on videogames.id = award_videogame.videogame_id
inner join software_houses
on videogames.software_house_id = software_houses.id






-- 4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
SElect distinct software_houses.*
from software_houses
inner join videogames
on videogames.software_house_id = software_houses.id
where year(videogames.release_date) > 2020





-- 3- Mostrare le categorie di ogni videogioco (1718)
select categories.name as categoria, videogames.name as videogioco
from categories
inner join category_videogame
ON category_videogame.category_id = categories.id
inner join videogames
on videogames.id = category_videogame.videogame_id





-- 2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)

SELECT distinct videogames.name
FROM videogames
inner join tournament_videogame
on tournament_videogame.videogame_id =  videogames.id 
inner join tournaments
on tournaments.id = tournament_videogame.tournament_id
where tournaments.year = 2016




-- 1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)

SELECT DISTINCT players.*
FROM players
INNER JOIN reviews
ON reviews.player_id = players.id





-- QUERY CON JOIN


-- 6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
SELECT DISTINCT videogame_id, AVG(rating) AS media
from reviews
GROUP BY videogame_id
order by media desc;





-- 5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)

SELECT device_id, COUNT(videogame_id) as videogame
FROM device_videogame
group by device_id;








-- 4- Mostrare il numero di videogiochi rilasciati ogni anno (11)

SELECT YEAR(release_date) as anno, COUNT(id) AS rilasci
FROM videogames
GROUP BY YEAR(release_date);





-- 3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)

SELECT pegi_label_id, COUNT(videogame_id)
FROM pegi_label_videogame
GROUP BY pegi_label_id;





--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)

SELECT videogame_id, COUNT(id)
FROM reviews
GROUP BY videogame_id;



--1- Contare quante software house ci sono per ogni paese (3)

SELECT COUNT(id), country
FROM software_houses
GROUP BY country;



--Query con group by ^


--12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)

SELECT COUNT(id)
FROM videogames
WHERE software_house_id = 1 
and YEAR(release_date) = 2018;






--11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)

SELECT count(id), AVG(rating)
FROM reviews
WHERE videogame_id = 412



--10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, mostrandoli una sola volta (443)

SELECT distinct videogame_id
FROM reviews
WHERE rating = 5;


-- 9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
SELECT *
FROM videogames
WHERE year(release_date) = 2020;




-- 8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)

SELECT *
FROM reviews
WHERE rating BETWEEN 2 AND 4;




-- 7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)

SELECT DISTINCT videogame_id
FROM category_videogame
WHERE category_id = 2
OR category_id = 6;


-- 6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)

SELECT *
FROM awards
WHERE description like '%facere%';


-- 5- Contare quanti tornei ci sono stati nell'anno 2015 (9)

SELECT count(id)
FROM tournaments
WHERE year = 2015;


-- 4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)

SELECT * 
FROM reviews
WHERE player_id = 800


-- 3- Selezionare tutti i giocatori il cui nome finisce per 'a' (220)

 SELECT * 
 FROM players 
 WHERE name like '%a';
 
-- 2- Selezionare tutti i giocatori della citta di 'Rogahnland' (2)

 SELECT * 
 FROM players 
 WHERE city = 'Rogahnland';





-- 1- Selezionare tutte le software house americane (3)

 SELECT * 
 FROM software_houses 
 WHERE country = 'united States';