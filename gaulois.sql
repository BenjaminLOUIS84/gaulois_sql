--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- REQUETES SQL EXERCICE LE GAULOIS
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--Etape 1 Créer la Base de données et les tables
--Etape 2 Lier les tables avec les Clés étrangères
--Etape 3 Peupler la base de données avec INSERT INTO "table" () VALUES 
--Etape 4 Requêtes SQL

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
































