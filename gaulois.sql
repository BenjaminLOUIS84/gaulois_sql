--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- REQUETES SQL EXERCICE GAULOIS
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--Etape 1 Créer la Base de données et les tables 
--Etape 2 Lier les tables avec les Clés étrangères
--Etape 3 Peupler la base de données avec INSERT INTO "table" () VALUES 
--Etape 4 Requêtes SQL

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--4
--A partir du script SQL Gaulois fourni par votre formateur, écrivez et exécutez les requêtes SQL suivantes:

--1. Nom des lieux qui finissent par 'um'.

SELECT l.nom_lieu
FROM lieu l
WHERE l.nom_lieu LIKE '%um'

--2. Nombre de personnages par lieu (trié par nombre de personnages décroissant).

SELECT l.nom_lieu, COUNT(p.id_personnage) AS nombre_personnage
FROM personnage p, lieu l
WHERE l.id_lieu = p.id_lieu
GROUP BY l.nom_lieu
ORDER BY nombre_personnage DESC 

--3. Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage.

SELECT p.nom_personnage, s.nom_specialite, p.adresse_personnage, l.nom_lieu
FROM personnage p, specialite s, lieu l
WHERE s.id_specialite = p.id_specialite
AND p.id_lieu = l.id_lieu
ORDER BY l.nom_lieu

--4. Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant).

SELECT s.nom_specialite, COUNT(p.id_personnage) AS nombre_personnage
FROM specialite s, personnage p
WHERE p.id_specialite = s.id_specialite
GROUP BY s.nom_specialite
ORDER BY nombre_personnage DESC

--5. Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa).

SELECT b.nom_bataille, b.date_bataille, l.nom_lieu
FROM bataille b, lieu l
WHERE b.id_lieu = l.id_lieu
ORDER BY b.date_bataille DESC

--6. Nom des potions + coût de réalisation de la potion (trié par coût décroissant).

SELECT  p.nom_potion, SUM(i.cout_ingredient*c.qte) AS prix
FROM potion p, composer c, ingredient i
WHERE p.id_potion = c.id_potion
GROUP BY p.nom_potion
ORDER BY prix DESC

--7. Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.

SELECT i.nom_ingredient, i.cout_ingredient, c.qte, p.nom_potion
FROM ingredient i, composer c, potion p
WHERE p.id_potion = c.id_potion
AND i.id_ingredient = c.id_ingredient
AND p.nom_potion = "Santé"

--8. Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'.

SELECT p.nom_personnage, SUM(pc.qte) AS qte_tot, b.nom_bataille
FROM personnage p, prendre_casque pc, bataille b
WHERE b.nom_bataille = "Bataille du village gaulois"
AND p.id_personnage = pc.id_personnage
GROUP BY p.nom_personnage, b.nom_bataille
HAVING (qte_tot)>20
ORDER BY qte_tot DESC

--9. Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit).

SELECT p.nom_personnage,  SUM(b.dose_boire) AS qnt_tot_consommée
FROM personnage p, boire b
WHERE p.id_personnage = b.id_personnage
GROUP BY p.nom_personnage
ORDER BY qnt_tot_consommée DESC

--10. Nom de la bataille où le nombre de casques pris a été le plus important.

SELECT b.nom_bataille, pc.qte
FROM bataille b, prendre_casque pc
WHERE b.id_bataille = pc.id_bataille
ORDER BY pc.qte DESC
LIMIT 1

--11. Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)

SELECT tc.nom_type_casque, SUM(c.id_casque) AS total_type, SUM(c.cout_casque) AS cout_total_type
FROM type_casque tc, casque c
WHERE tc.id_type_casque = c.id_type_casque
GROUP BY tc.nom_type_casque
ORDER BY total_type, cout_total_type

--12. Nom des potions dont un des ingrédients est le poisson frais.

SELECT p.nom_potion, c.qte, i.nom_ingredient
FROM potion p , ingredient i, composer c
WHERE i.nom_ingredient = "Poisson frais"
AND p.id_potion = c.id_potion
AND i.id_ingredient = c.id_ingredient

--13. Nom du / des lieu(x) possédant le plus d'habitants, en dehors du village gaulois.

SELECT l.nom_lieu, SUM(p.id_lieu) AS nombre_hab
FROM lieu l, personnage p
WHERE l.id_lieu = p.id_lieu
GROUP BY l.nom_lieu
ORDER BY nombre_hab DESC
LIMIT 7


--14. Nom des personnages qui n'ont jamais bu aucune potion.



--15. Nom du / des personnages qui n'ont pas le droit de boire de la potion 'Magique'.

























































--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--INFORMATIONS--
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `autoriser_boire` 
(
  `id_potion` int(11) NOT NULL,
  `id_personnage` int(11) NOT NULL,
  PRIMARY KEY (`id_potion`,`id_personnage`),
  KEY `FK_AUTO_PERSO` (`id_personnage`),
  CONSTRAINT `FK_AUTO_PERSO` FOREIGN KEY (`id_personnage`) REFERENCES `personnage` (`id_personnage`),
  CONSTRAINT `FK_AUTO_POTION` FOREIGN KEY (`id_potion`) REFERENCES `potion` (`id_potion`)
)
--3
INSERT INTO `autoriser_boire` (`id_potion`, `id_personnage`) VALUES
	(1, 4),
	(9, 5),
	(1, 6),
	(12, 6),
	(1, 7),
	(3, 7),
	(7, 7),
	(1, 8),
	(1, 9),
	(1, 10),
	(1, 12),
	(13, 12),
	(1, 13),
	(2, 13),
	(4, 13),
	(6, 13),
	(10, 13),
	(13, 14),
	(1, 15),
	(4, 17),
	(6, 19),
	(6, 20),
	(1, 22),
	(5, 23),
	(1, 24),
	(1, 25),
	(3, 25),
	(11, 26),
	(8, 30),
	(8, 32),
	(11, 32),
	(5, 33),
	(14, 33),
	(15, 33),
	(1, 34),
	(9, 35),
	(1, 36),
	(7, 39),
	(14, 42),
	(1, 44);


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `bataille` (

  `id_bataille` int(11) NOT NULL AUTO_INCREMENT,
  `nom_bataille` varchar(50) COLLATE utf8_bin NOT NULL,
  `date_bataille` date NOT NULL,
  `id_lieu` int(11) NOT NULL,
  PRIMARY KEY (`id_bataille`),
  KEY `FK_BATAILLE_LIEU` (`id_lieu`),
  CONSTRAINT `FK_BATAILLE_LIEU` FOREIGN KEY (`id_lieu`) REFERENCES `lieu` (`id_lieu`)
)
--3
INSERT INTO `bataille` (`id_bataille`, `nom_bataille`, `date_bataille`, `id_lieu`) VALUES
	(1, 'Bataille du village gaulois', '0050-11-30', 1),
	(2, 'Anniversaire d\'Obélix', '0050-07-08', 2),
	(3, 'Raid gaulois sur Petibonum', '0050-04-25', 5),
	(4, 'Siège d\'Alesia', '0052-05-01', 16),
	(5, 'Bataille de Gergovie', '0052-03-26', 17),
	(6, 'Rapt de druides', '0050-01-22', 7),
	(7, 'Raid gaulois sur Aquarium', '0050-08-06', 4),
	(8, 'Bagarre du siècle', '0050-02-25', 8),
	(9, 'Attaque de la banque postale', '0050-06-30', 12),
	(10, 'Raid gaulois sur Laudanum', '0050-09-20', 3),
	(11, 'Attaque du bateau pirate', '0050-03-10', 10),
	(12, 'Invasion de la Bretagne', '0050-04-04', 10),
	(13, 'Bataille des cinq armées', '0050-09-21', 18),
	(14, 'Percée de Divodurum', '0050-01-30', 11),
	(15, 'Embuscade de la rue Tabaga', '0050-04-02', 9);

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `boire` (

  `id_potion` int(11) NOT NULL,
  `id_personnage` int(11) NOT NULL,
  `date_boire` date NOT NULL,
  `dose_boire` int(5) NOT NULL,
  PRIMARY KEY (`id_potion`,`id_personnage`),
  KEY `FK_BOIRE_PERSO` (`id_personnage`),
  CONSTRAINT `FK_BOIRE_PERSO` FOREIGN KEY (`id_personnage`) REFERENCES `personnage` (`id_personnage`),
  CONSTRAINT `FK_BOIRE_POTION` FOREIGN KEY (`id_potion`) REFERENCES `potion` (`id_potion`)
) 
--3
INSERT INTO `boire` (`id_potion`, `id_personnage`, `date_boire`, `dose_boire`) VALUES
	(1, 4, '0050-06-05', 2),
	(1, 6, '0050-05-01', 2),
	(1, 8, '0050-02-24', 9),
	(1, 9, '0050-06-21', 1),
	(1, 10, '0050-05-31', 3),
	(1, 13, '0050-01-20', 2),
	(1, 15, '0050-07-12', 1),
	(1, 22, '0050-04-30', 3),
	(1, 36, '0050-04-30', 3),
	(2, 13, '0050-02-01', 12),
	(3, 7, '0050-10-10', 2),
	(4, 13, '0050-01-02', 5),
	(4, 17, '0050-04-10', 5),
	(5, 23, '0050-08-21', 2),
	(5, 33, '0050-10-12', 7),
	(6, 16, '0050-07-02', 1),
	(6, 19, '0050-09-01', 12),
	(6, 20, '0050-09-01', 12),
	(7, 39, '0050-09-09', 20),
	(8, 32, '0050-03-02', 8),
	(9, 5, '0050-01-01', 38),
	(9, 9, '0050-02-01', 7),
	(9, 35, '0050-03-06', 14),
	(10, 13, '0050-04-15', 20),
	(11, 32, '0050-10-02', 5),
	(12, 6, '0050-03-02', 6),
	(13, 14, '0050-10-04', 3),
	(14, 42, '0050-09-30', 3);


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `casque` (
  `id_casque` int(11) NOT NULL AUTO_INCREMENT,
  `nom_casque` varchar(50) COLLATE utf8_bin NOT NULL,
  `cout_casque` float NOT NULL,
  `id_type_casque` int(11) NOT NULL,
  PRIMARY KEY (`id_casque`),
  KEY `FK_CASQUE_TYPECASQUE` (`id_type_casque`),
  CONSTRAINT `FK_CASQUE_TYPECASQUE` FOREIGN KEY (`id_type_casque`) REFERENCES `type_casque` (`id_type_casque`)
) 
--3
INSERT INTO `casque` (`id_casque`, `nom_casque`, `cout_casque`, `id_type_casque`) VALUES
	(1, 'Villanovien', 865, 1),
	(2, 'Negau', 498, 1),
	(3, 'Corinthien', 765, 2),
	(4, 'Spangenhelm', 1200, 4),
	(5, 'Italo-celtique', 660, 1),
	(10, 'Weisenau', 50, 1),
	(11, 'Impérial-gaulois', 200, 1),
	(12, 'Gallois', 540, 4),
	(13, 'Wisigoth', 631, 4),
	(14, 'Ostrogoth', 743, 4),
	(15, 'A cornes', 2900, 3),
	(16, 'Veksø', 7820, 3),
	(17, 'Enkomi', 3140, 3),
	(18, 'Haguenau', 140, 1),
	(19, 'Picte', 160, 3),
	(20, 'Athénien', 452, 2),
	(21, 'Spartiate', 901, 2),
	(22, 'Phrygien', 840, 2),
	(23, 'Hoplite', 600, 2);


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `composer` (
  `id_potion` int(11) NOT NULL,
  `id_ingredient` int(11) NOT NULL,
  `qte` int(5) NOT NULL,
  PRIMARY KEY (`id_potion`,`id_ingredient`),
  KEY `FK_COMPOSER_INGREDIENT` (`id_ingredient`),
  CONSTRAINT `FK_COMPOSER_INGREDIENT` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`),
  CONSTRAINT `FK_COMPOSER_POTION` FOREIGN KEY (`id_potion`) REFERENCES `potion` (`id_potion`)
) 
--3
INSERT INTO `composer` (`id_potion`, `id_ingredient`, `qte`) VALUES
	(1, 4, 2),
	(1, 5, 20),
	(1, 23, 4),
	(1, 24, 6),
	(2, 10, 6),
	(2, 25, 1),
	(3, 9, 78),
	(3, 23, 3),
	(3, 25, 1),
	(4, 15, 1),
	(5, 3, 4),
	(6, 8, 2),
	(6, 17, 3),
	(7, 2, 41),
	(7, 24, 5),
	(8, 6, 7),
	(9, 1, 48),
	(9, 10, 3),
	(9, 19, 15),
	(10, 11, 40),
	(11, 21, 50),
	(12, 18, 3),
	(13, 10, 10),
	(13, 26, 2),
	(14, 16, 3);


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id_ingredient` int(11) NOT NULL AUTO_INCREMENT,
  `nom_ingredient` varchar(50) COLLATE utf8_bin NOT NULL,
  `cout_ingredient` float NOT NULL,
  PRIMARY KEY (`id_ingredient`)
) 
--3
INSERT INTO ingredient (id_ingredient, nom_ingredient, cout_ingredient) VALUES
	(1, 'Petit pois', 0.5),
	(2, 'Haricot vert', 1),
	(3, 'Queue de crevette', 7),
	(4, 'Homard', 12),
	(5, 'Gui', 3),
	(6, 'Salsepareille', 6.5),
	(7, 'Miel', 4.5),
	(8, 'Grenouille', 10),
	(9, 'Bave de crapaud', 16.5),
	(10, 'Carotte', 1),
	(11, 'Prune', 3),
	(12, 'Ver de terre', 1),
	(13, 'Feuille de thé', 11),
	(14, 'Courgette', 2),
	(15, 'Poudre de perlimpimpin', 42),
	(16, 'Champignon', 3.5),
	(17, 'Aile de chauve-souris', 9),
	(18, 'Plume de paon', 15),
	(19, 'Persil', 0.5),
	(20, 'Romarin', 0.5),
	(21, 'Cervoise', 4),
	(22, 'Millepertuis', 2),
	(23, 'Huile de roche', 30),
	(24, 'Poisson frais', 6),
	(25, 'Edelweiss', 80),
	(26, 'Poisson pas frais', 1);


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `lieu` (
  `id_lieu` int(11) NOT NULL AUTO_INCREMENT,
  `nom_lieu` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_lieu`)
)
--3
INSERT INTO lieu (id_lieu, nom_lieu) VALUES
	(1, 'Village gaulois'),
	(2, 'Babaorum'),
	(3, 'Laudanum'),
	(4, 'Aquarium'),
	(5, 'Petibonum'),
	(6, 'Rotomagus'),
	(7, 'Forêt des Carnutes'),
	(8, 'Lutèce'),
	(9, 'Condate'),
	(10, 'En mer'),
	(11, 'Divodurum'),
	(12, 'Lugdunum'),
	(13, 'Gesocribate'),
	(14, 'Massilia'),
	(15, 'Nicae'),
	(16, 'Alesia'),
	(17, 'Gergovie'),
	(18, 'Village belge');

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `personnage` (
  `id_personnage` int(11) NOT NULL AUTO_INCREMENT,
  `nom_personnage` varchar(80) COLLATE utf8_bin NOT NULL,
  `adresse_personnage` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `image_personnage` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT 'indisponible.jpg',
  `id_lieu` int(11) NOT NULL,
  `id_specialite` int(11) NOT NULL,
  PRIMARY KEY (`id_personnage`),
  KEY `FK_VILLAGEOIS_LIEU` (`id_lieu`),
  KEY `FK_VILLAGEOIS_SPEC` (`id_specialite`),
  CONSTRAINT `FK_VILLAGEOIS_LIEU` FOREIGN KEY (`id_lieu`) REFERENCES `lieu` (`id_lieu`),
  CONSTRAINT `FK_VILLAGEOIS_SPEC` FOREIGN KEY (`id_specialite`) REFERENCES `specialite` (`id_specialite`)
)
--3
INSERT INTO personnage (id_personnage, nom_personnage, adresse_personnage, image_personnage, id_lieu, `id_specialite`) VALUES
	(4, 'Astérix', 'Au fond à droite', 'indisponible.jpg', 1, 1),
	(5, 'Obélix', 'Carrière de menhir', 'indisponible.jpg', 1, 5),
	(6, 'Assurancetourix', 'Hutte dans l\'arbre', 'indisponible.jpg', 1, 2),
	(7, 'Panoramix', 'Près de la cascade', 'indisponible.jpg', 1, 3),
	(8, 'Abraracourcix', 'Hutte du chef', 'indisponible.jpg', 1, 4),
	(9, 'Ordralfabétix', 'Poissonnerie', 'indisponible.jpg', 1, 7),
	(10, 'Cétautomatix', 'Forge', 'indisponible.jpg', 1, 6),
	(11, 'Plantaquatix', 'Tout près des fleurs', 'indisponible.jpg', 1, 15),
	(12, 'Bonemine', 'Hutte du chef', 'indisponible.jpg', 1, 16),
	(13, 'Agecanonix', 'Centre du village', 'indisponible.jpg', 1, 1),
	(14, 'Falbala', 'Rue Tabaga', 'indisponible.jpg', 9, 17),
	(15, 'Tragicomix', 'Rue Tabaga', 'indisponible.jpg', 9, 1),
	(16, 'Amérix', 'Avenue Avuhavaincu', 'indisponible.jpg', 9, 15),
	(17, 'Pneumatix', 'Route Elkrief', 'indisponible.jpg', 6, 8),
	(18, 'Plaintcontrix', 'Impasse Hémanque', 'indisponible.jpg', 8, 15),
	(19, 'Vanendfaillevesix', 'Hutte majeure', 'indisponible.jpg', 18, 1),
	(20, 'Gueuselambix', 'Hutte du chef', 'indisponible.jpg', 18, 4),
	(21, 'Antibiotix', 'Place du marché', 'indisponible.jpg', 9, 13),
	(22, 'Changélédix', 'Port', 'indisponible.jpg', 13, 11),
	(23, 'Zérozérosix', '', 'indisponible.jpg', 8, 14),
	(24, 'Analgésix', NULL, 'indisponible.jpg', 1, 9),
	(25, 'Arrièreboutix', NULL, 'indisponible.jpg', 1, 9),
	(26, 'Goudurix', 'Rue Tilante', 'indisponible.jpg', 8, 17),
	(27, 'Homéopatix', 'Boulevard Hicelle', 'indisponible.jpg', 8, 15),
	(28, 'Océanonix', 'Rue Tilante', 'indisponible.jpg', 8, 1),
	(29, 'Alambix', 'Magasin de vins et charbon', 'indisponible.jpg', 17, 17),
	(30, 'Bainpublix', 'Magasin de vins et charbon', 'indisponible.jpg', 17, 17),
	(31, 'Vercingétorix', 'Hutte du chef', 'indisponible.jpg', 17, 4),
	(32, 'Septantesix', 'Hutte de druide', 'indisponible.jpg', 7, 3),
	(33, 'Acidcloridrix', NULL, 'indisponible.jpg', 16, 14),
	(34, 'Iélosubmarine', 'Poissonnerie', 'indisponible.jpg', 1, 7),
	(35, 'Avoranfix', NULL, 'indisponible.jpg', 8, 15),
	(36, 'Choucroutgarnix', NULL, 'indisponible.jpg', 1, 10),
	(37, 'César Labeldecadix', 'Taverne du port', 'indisponible.jpg', 14, 17),
	(38, 'Doublepolémix', NULL, 'indisponible.jpg', 6, 8),
	(39, 'Maestria', NULL, 'indisponible.jpg', 8, 15),
	(40, 'Odalix', 'Ruelle Tay\'m Strahtedji', 'indisponible.jpg', 12, 17),
	(41, 'Soutienlogistix', 'Rue Stine', 'indisponible.jpg', 15, 2),
	(42, 'Moralélastix', NULL, 'indisponible.jpg', 9, 1),
	(43, 'Aplusbégalix', 'En dehors de la ville', 'indisponible.jpg', 9, 4),
	(44, 'Orthopédix', 'Quartier d\'Orange', 'indisponible.jpg', 9, 17),
	(45, 'Champdeblix', 'Ferme Hantassion', 'indisponible.jpg', 6, 12);

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `potion` (
  `id_potion` int(11) NOT NULL AUTO_INCREMENT,
  `nom_potion` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_potion`)
)
--3
INSERT INTO potion (id_potion, nom_potion) VALUES
(1, 'Magique'),
(2, 'Rajeunissement II'),
(3, 'Santé'),
(4, 'Vitesse'),
(5, 'Invisibilité'),
(6, 'Force'),
(7, 'Intelligence'),
(8, 'Assouplissement II'),
(9, 'Soupe'),
(10, 'Rajeunissement I'),
(11, 'Assouplissement I'),
(12, 'Envol'),
(13, 'Coloration pour cheveux'),
(14, 'Gigantisme'),
(15, 'Miniaturisation');

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `prendre_casque` (
  `id_casque` int(11) NOT NULL,
  `id_personnage` int(11) NOT NULL,
  `id_bataille` int(11) NOT NULL,
  `qte` int(5) NOT NULL,
  PRIMARY KEY (`id_casque`,`id_personnage`,`id_bataille`),
  KEY `FK_PRCSQ_BATAILLE` (`id_bataille`),
  KEY `FK_PRCSQ_PERSO` (`id_personnage`),
  CONSTRAINT `FK_PRCSQ_BATAILLE` FOREIGN KEY (`id_bataille`) REFERENCES `bataille` (`id_bataille`),
  CONSTRAINT `FK_PRCSQ_CASQUE` FOREIGN KEY (`id_casque`) REFERENCES `casque` (`id_casque`),
  CONSTRAINT `FK_PRCSQ_PERSO` FOREIGN KEY (`id_personnage`) REFERENCES `personnage` (`id_personnage`)
)
--3
INSERT INTO `prendre_casque` (`id_casque`, `id_personnage`, `id_bataille`, `qte`) VALUES
	(2, 8, 1, 8),
	(2, 15, 15, 4),
	(3, 4, 11, 1),
	(3, 20, 13, 24),
	(4, 22, 15, 2),
	(5, 4, 3, 5),
	(5, 8, 5, 10),
	(5, 10, 7, 4),
	(10, 4, 1, 21),
	(10, 5, 2, 42),
	(11, 5, 2, 34),
	(11, 5, 10, 24),
	(14, 5, 9, 32),
	(14, 36, 12, 1),
	(16, 5, 11, 2),
	(17, 13, 13, 1),
	(18, 5, 1, 60),
	(18, 8, 1, 12);

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `specialite` (
  `id_specialite` int(11) NOT NULL AUTO_INCREMENT,
  `nom_specialite` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_specialite`)
)
--3
INSERT INTO specialite (id_specialite, nom_specialite) VALUES
	(1, 'Guerrier'),
	(2, 'Barde'),
	(3, 'Druide'),
	(4, 'Chef de village'),
	(5, 'Livreur de menhir'),
	(6, 'Forgeron'),
	(7, 'Poissonier'),
	(8, 'Facteur'),
	(9, 'Porteur de chef'),
	(10, 'Garde'),
	(11, 'Marin'),
	(12, 'Agriculteur'),
	(13, 'Chasseur'),
	(14, 'Espion'),
	(15, 'Artisan'),
	(16, 'Femme de chef'),
	(17, 'Autre');


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--1-2
CREATE TABLE IF NOT EXISTS `type_casque` (
  `id_type_casque` int(11) NOT NULL AUTO_INCREMENT,
  `nom_type_casque` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_type_casque`)
)
--3
INSERT INTO type_casque (id_type_casque, nom_type_casque) VALUES
	(1, 'Romain'),
	(2, 'Grec'),
	(3, 'Normand'),
	(4, 'Autre');

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
































