CREATE DATABASE IF NOT EXISTS gestion_scolarite;
USE gestion_scolarite;

CREATE TABLE etudiant (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ETU VARCHAR(50),
    nom VARCHAR(100),
    prenom VARCHAR(100),
    dtn DATE
);

CREATE TABLE filiere (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100)
);

CREATE TABLE promotion (
    idProm INT AUTO_INCREMENT PRIMARY KEY,
    idFiliere INT,
    FOREIGN KEY (idFiliere) REFERENCES filiere(id)
);

CREATE TABLE inscription (
    id INT AUTO_INCREMENT PRIMARY KEY,
    DateInscription DATE,
    idEtudiant INT,
    semestre VARCHAR(20),
    idPromo INT,
    FOREIGN KEY (idEtudiant) REFERENCES etudiant(id),
    FOREIGN KEY (idPromo) REFERENCES promotion(idProm)
);

CREATE TABLE session (
    idSession INT AUTO_INCREMENT PRIMARY KEY,
    date DATE
);

CREATE TABLE avancement (
    idAvancement INT AUTO_INCREMENT PRIMARY KEY,
    idEtudiant INT,
    semestre VARCHAR(20),
    idSession INT,
    FOREIGN KEY (idEtudiant) REFERENCES etudiant(id),
    FOREIGN KEY (idSession) REFERENCES session(idSession)
);

CREATE TABLE option_ (
    idOption INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100)
);

CREATE TABLE matiere (
    idMatiere INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150),
    UE VARCHAR(50)
);

CREATE TABLE credit (
    idCredit INT AUTO_INCREMENT PRIMARY KEY,
    idMatiere INT,
    idOption INT,
    semestre VARCHAR(20),
    credit INT,
    ensembleOptionnel INT NULL,
    FOREIGN KEY (idMatiere) REFERENCES matiere(idMatiere),
    FOREIGN KEY (idOption) REFERENCES option_(idOption)
);

CREATE TABLE note (
    idNote INT AUTO_INCREMENT PRIMARY KEY,
    idAvancement INT,
    idMatiere INT,
    note DECIMAL(5,2),
    FOREIGN KEY (idAvancement) REFERENCES avancement(idAvancement),
    FOREIGN KEY (idMatiere) REFERENCES matiere(idMatiere)
);

CREATE TABLE rattrapage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idAvancement INT,
    idMatiere INT,
    noteRattrapage DECIMAL(5,2),
    FOREIGN KEY (idAvancement) REFERENCES avancement(idAvancement),
    FOREIGN KEY (idMatiere) REFERENCES matiere(idMatiere)
);
INSERT INTO etudiant (ETU, nom, prenom, dtn) VALUES
('ETU001', 'RAKOTO', 'Jean', '2002-01-15'),
('ETU002', 'RANDRIA', 'Miora', '2001-11-02'),
('ETU003', 'RASOLO', 'Kevin', '2002-05-20'),
('ETU004', 'ANDRIAM', 'Fara', '2003-03-30'),
('ETU005', 'RAKOTONDR', 'Tiana', '2002-07-12');

INSERT INTO filiere (nom) VALUES ('Informatique');

INSERT INTO promotion (idFiliere) VALUES (1);
INSERT INTO option_ (nom) VALUES ('Développement');
-- SEMESTRE 1
INSERT INTO matiere (nom, UE) VALUES
('INF101 : Programmation procédurale', 'INF101'),
('INF104 : HTML et Introduction au Web', 'INF104'),
('INF107 : Informatique de Base', 'INF107'),
('MTH101 : Arithmétique et nombres', 'MTH101'),
('MTH102 : Analyse mathématique', 'MTH102'),
('ORG101 : Techniques de communication', 'ORG101');

INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
(1, 1, 'S1', 7),
(2, 1, 'S1', 5),
(3, 1, 'S1', 4),
(4, 1, 'S1', 4),
(5, 1, 'S1', 6),
(6, 1, 'S1', 4);

-- SEMESTRE 2
INSERT INTO matiere (nom, UE) VALUES
('INF102 : Bases de données relationnelles', 'INF102'),
('INF103 : Administration système', 'INF103'),
('INF105 : Maintenance matériel et logiciel', 'INF105'),
('INF106 : Compléments de programmation', 'INF106'),
('MTH103 : Calcul Vectoriel et Matriciel', 'MTH103'),
('MTH105 : Probabilité et Statistique', 'MTH105');

INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
(7, 1, 'S2', 5),
(8, 1, 'S2', 5),
(9, 1, 'S2', 4),
(10, 1, 'S2', 6),
(11, 1, 'S2', 6),
(12, 1, 'S2', 4);

-- SEMESTRE 3
INSERT INTO matiere (nom, UE) VALUES
('INF201 : Programmation orientée objet', 'INF201'),
('INF202 : Bases de données objets', 'INF202'),
('INF203 : Programmation système', 'INF203'),
('INF208 : Réseaux informatiques', 'INF208'),
('MTH201 : Méthodes numériques', 'MTH201'),
('ORG201 : Bases de gestion', 'ORG201');

INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
(13, 1, 'S3', 6),
(14, 1, 'S3', 6),
(15, 1, 'S3', 4),
(16, 1, 'S3', 6),
(17, 1, 'S3', 4),
(18, 1, 'S3', 4);

-- SEMESTRE 4 (Option Développement)
INSERT INTO matiere (nom, UE) VALUES
('INF204 : Système d information géographique', 'INF204'),
('INF205 : Système d information', 'INF205'),
('INF206 : Interface Homme/Machine', 'INF206'),
('INF207 : Eléments d algorithmique', 'INF207'),
('INF210 : Mini-projet de développement', 'INF210'),
('MTH204 : Géométrie', 'MTH204'),
('MTH205 : Equations différentielles', 'MTH205'),
('MTH206 : Optimisation', 'MTH206'),
('MTH203 : MAO', 'MTH203');

-- Crédits (S4)
INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
(19, 1, 'S4', 6),
(20, 1, 'S4', 6),
(21, 1, 'S4', 6),
(22, 1, 'S4', 6),
(23, 1, 'S4', 10),
(24, 1, 'S4', 4),
(25, 1, 'S4', 4),
(26, 1, 'S4', 4),
(27, 1, 'S4', 4);


INSERT INTO inscription (DateInscription, idEtudiant, semestre, idPromo) VALUES
('2025-01-10', 1, 'S1', 1),
('2025-01-10', 2, 'S1', 1),
('2025-01-10', 3, 'S1', 1),
('2025-01-10', 4, 'S1', 1),
('2025-01-10', 5, 'S1', 1);


INSERT INTO session (date) VALUES
('2025-03-20'),
('2025-06-25'),
('2025-10-15');

INSERT INTO avancement (idEtudiant, semestre, idSession) VALUES
(1, 'S1', 1),
(2, 'S1', 1),
(3, 'S1', 1),
(4, 'S1', 1),
(5, 'S1', 1);

INSERT INTO avancement (idEtudiant, semestre, idSession) VALUES
(1, 'S2', 2),
(2, 'S2', 2),
(3, 'S2', 2),
(4, 'S2', 2),
(5, 'S2', 2);
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(6, 7, 14.5),
(6, 8, 13.0),
(6, 9, 12.0),
(6, 10, 15.0),
(6, 11, 14.0),
(6, 12, 13.5);
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(7, 7, 12.5),
(7, 8, 11.0),
(7, 9, 14.0),
(7, 10, 13.5),
(7, 11, 15.0),
(7, 12, 12.0);
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(8, 7, 15.5),
(8, 8, 14.0),
(8, 9, 13.0),
(8, 10, 16.0),
(8, 11, 14.5),
(8, 12, 15.0);
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(9, 7, 11.5),
(9, 8, 12.0),
(9, 9, 10.0),
(9, 10, 13.0),
(9, 11, 12.5),
(9, 12, 11.0);
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(10, 7, 13.0),
(10, 8, 14.5),
(10, 9, 12.5),
(10, 10, 15.0),
(10, 11, 13.0),
(10, 12, 14.0);


-- Avancement pour S3
INSERT INTO avancement (idEtudiant, semestre, idSession) VALUES
(1, 'S3', 3),
(2, 'S3', 3);

-- Avancement pour S4
INSERT INTO avancement (idEtudiant, semestre, idSession) VALUES
(1, 'S4', 3),
(2, 'S4', 3);

-- Notes pour S3 (étudiant 1 et 2)
-- idMatiere pour S3 : 13 à 18
-- Étudiant 1 (idAvancement = 11)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(11, 13, 15.0),
(11, 14, 14.5),
(11, 15, 13.0),
(11, 16, 16.0),
(11, 17, 14.0),
(11, 18, 15.5);

-- Étudiant 2 (idAvancement = 12)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(12, 13, 14.0),
(12, 14, 13.5),
(12, 15, 12.0),
(12, 16, 15.0),
(12, 17, 13.5),
(12, 18, 14.0);

-- Notes pour S4 (étudiant 1 et 2)
-- idMatiere pour S4 : 19 à 27
-- Étudiant 1 (idAvancement = 13)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(13, 19, 15.0),
(13, 20, 14.5),
(13, 21, 13.0),
(13, 22, 16.0),
(13, 23, 15.5),
(13, 24, 14.0),
(13, 25, 13.5),
(13, 26, 15.0),
(13, 27, 14.0);

-- Étudiant 2 (idAvancement = 14)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(14, 19, 14.0),
(14, 20, 13.5),
(14, 21, 12.0),
(14, 22, 15.0),
(14, 23, 14.5),
(14, 24, 13.0),
(14, 25, 12.5),
(14, 26, 14.0),
(14, 27, 13.5);




-- Ajout des deux nouvelles options
INSERT INTO option_ (nom) VALUES 
('Web'),
('Réseaux');

INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
-- Option Web (idOption = 2)
(1, 2, 'S1', 7),
(2, 2, 'S1', 5),
(3, 2, 'S1', 4),
(4, 2, 'S1', 4),
(5, 2, 'S1', 6),
(6, 2, 'S1', 4),
-- Option Réseaux (idOption = 3)
(1, 3, 'S1', 7),
(2, 3, 'S1', 5),
(3, 3, 'S1', 4),
(4, 3, 'S1', 4),
(5, 3, 'S1', 6),
(6, 3, 'S1', 4);

-- SEMESTRE 2 : Même pour toutes les options (tronc commun)
INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
-- Option Web (idOption = 2)
(7, 2, 'S2', 5),
(8, 2, 'S2', 5),
(9, 2, 'S2', 4),
(10, 2, 'S2', 6),
(11, 2, 'S2', 6),
(12, 2, 'S2', 4),
-- Option Réseaux (idOption = 3)
(7, 3, 'S2', 5),
(8, 3, 'S2', 5),
(9, 3, 'S2', 4),
(10, 3, 'S2', 6),
(11, 3, 'S2', 6),
(12, 3, 'S2', 4);

-- SEMESTRE 3 : Même pour toutes les options (tronc commun)
INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
-- Option Web (idOption = 2)
(13, 2, 'S3', 6),
(14, 2, 'S3', 6),
(15, 2, 'S3', 4),
(16, 2, 'S3', 6),
(17, 2, 'S3', 4),
(18, 2, 'S3', 4),
-- Option Réseaux (idOption = 3)
(13, 3, 'S3', 6),
(14, 3, 'S3', 6),
(15, 3, 'S3', 4),
(16, 3, 'S3', 6),
(17, 3, 'S3', 4),
(18, 3, 'S3', 4);

-- SEMESTRE 4 : Matières spécifiques par option

-- ===== OPTION WEB =====
INSERT INTO matiere (nom, UE) VALUES
('INF211 : Développement Web Full Stack', 'INF211'),
('INF212 : Frameworks JavaScript', 'INF212'),
('INF213 : Design UI/UX', 'INF213'),
('INF214 : Sécurité Web', 'INF214'),
('INF215 : Mini-projet Web', 'INF215'),
('MTH207 : Statistiques Web', 'MTH207'),
('INF216 : API REST et GraphQL', 'INF216'),
('INF217 : Progressive Web Apps', 'INF217'),
('INF218 : CMS et E-commerce', 'INF218');

INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
(28, 2, 'S4', 6),
(29, 2, 'S4', 6),
(30, 2, 'S4', 6),
(31, 2, 'S4', 6),
(32, 2, 'S4', 10),
(33, 2, 'S4', 4),
(34, 2, 'S4', 4),
(35, 2, 'S4', 4),
(36, 2, 'S4', 4);

-- ===== OPTION RÉSEAUX =====
INSERT INTO matiere (nom, UE) VALUES
('INF221 : Architecture réseau avancée', 'INF221'),
('INF222 : Protocoles et Services', 'INF222'),
('INF223 : Sécurité réseau et Firewall', 'INF223'),
('INF224 : Administration serveurs', 'INF224'),
('INF225 : Mini-projet Réseaux', 'INF225'),
('MTH208 : Cryptographie', 'MTH208'),
('INF226 : VoIP et Téléphonie', 'INF226'),
('INF227 : Virtualisation et Cloud', 'INF227'),
('INF228 : Supervision réseau', 'INF228');

INSERT INTO credit (idMatiere, idOption, semestre, credit) VALUES
(37, 3, 'S4', 6),
(38, 3, 'S4', 6),
(39, 3, 'S4', 6),
(40, 3, 'S4', 6),
(41, 3, 'S4', 10),
(42, 3, 'S4', 4),
(43, 3, 'S4', 4),
(44, 3, 'S4', 4),
(45, 3, 'S4', 4);

-- ===== INSCRIPTIONS ET AVANCEMENTS =====
-- Les 5 étudiants sont déjà inscrits en S1

-- Inscriptions S2
INSERT INTO inscription (DateInscription, idEtudiant, semestre, idPromo) VALUES
('2025-06-10', 1, 'S2', 1),
('2025-06-10', 2, 'S2', 1),
('2025-06-10', 3, 'S2', 1),
('2025-06-10', 4, 'S2', 1),
('2025-06-10', 5, 'S2', 1);

-- Inscriptions S3 (tous les étudiants)
INSERT INTO inscription (DateInscription, idEtudiant, semestre, idPromo) VALUES
('2025-10-05', 1, 'S3', 1),
('2025-10-05', 2, 'S3', 1),
('2025-10-05', 3, 'S3', 1),
('2025-10-05', 4, 'S3', 1),
('2025-10-05', 5, 'S3', 1);

-- Inscriptions S4 (tous les étudiants)
INSERT INTO inscription (DateInscription, idEtudiant, semestre, idPromo) VALUES
('2026-01-08', 1, 'S4', 1),
('2026-01-08', 2, 'S4', 1),
('2026-01-08', 3, 'S4', 1),
('2026-01-08', 4, 'S4', 1),
('2026-01-08', 5, 'S4', 1);

-- Avancements S3 pour étudiants 3, 4, 5
INSERT INTO avancement (idEtudiant, semestre, idSession) VALUES
(3, 'S3', 3),
(4, 'S3', 3),
(5, 'S3', 3);

-- Avancements S4 pour étudiants 3, 4, 5
INSERT INTO avancement (idEtudiant, semestre, idSession) VALUES
(3, 'S4', 3),
(4, 'S4', 3),
(5, 'S4', 3);

-- ===== NOTES S1 (tous les étudiants) =====
-- Étudiant 1 (idAvancement = 1)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(1, 1, 15.5),
(1, 2, 14.0),
(1, 3, 13.5),
(1, 4, 12.0),
(1, 5, 16.0),
(1, 6, 14.5);

-- Étudiant 2 (idAvancement = 2)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(2, 1, 13.0),
(2, 2, 12.5),
(2, 3, 14.0),
(2, 4, 11.5),
(2, 5, 15.0),
(2, 6, 13.0);

-- Étudiant 3 (idAvancement = 3)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(3, 1, 16.0),
(3, 2, 15.5),
(3, 3, 14.5),
(3, 4, 13.0),
(3, 5, 17.0),
(3, 6, 15.0);

-- Étudiant 4 (idAvancement = 4)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(4, 1, 12.0),
(4, 2, 11.5),
(4, 3, 13.0),
(4, 4, 10.5),
(4, 5, 14.0),
(4, 6, 12.5);

-- Étudiant 5 (idAvancement = 5)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(5, 1, 14.5),
(5, 2, 13.5),
(5, 3, 15.0),
(5, 4, 12.5),
(5, 5, 16.5),
(5, 6, 14.0);

-- ===== NOTES S3 pour étudiants 3, 4, 5 =====
-- Étudiant 3 (idAvancement = 15)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(15, 13, 16.5),
(15, 14, 15.0),
(15, 15, 14.0),
(15, 16, 17.0),
(15, 17, 15.5),
(15, 18, 16.0);

-- Étudiant 4 (idAvancement = 16)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(16, 13, 13.0),
(16, 14, 12.5),
(16, 15, 11.5),
(16, 16, 14.0),
(16, 17, 13.0),
(16, 18, 13.5);

-- Étudiant 5 (idAvancement = 17)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(17, 13, 15.0),
(17, 14, 14.5),
(17, 15, 13.5),
(17, 16, 16.0),
(17, 17, 14.0),
(17, 18, 15.0);


-- Étudiant 3 : Option Web (idAvancement = 18)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(18, 28, 16.0),
(18, 29, 15.5),
(18, 30, 17.0),
(18, 31, 14.5),
(18, 32, 16.5),
(18, 33, 15.0),
(18, 34, 14.0),
(18, 35, 16.0),
(18, 36, 15.5);

-- Étudiant 4 : Option Réseaux (idAvancement = 19)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(19, 37, 13.5),
(19, 38, 12.0),
(19, 39, 14.0),
(19, 40, 11.5),
(19, 41, 13.0),
(19, 42, 12.5),
(19, 43, 13.0),
(19, 44, 11.0),
(19, 45, 12.0);

-- Étudiant 5 : Option Web (idAvancement = 20)
INSERT INTO note (idAvancement, idMatiere, note) VALUES
(20, 28, 15.5),
(20, 29, 14.0),
(20, 30, 16.0),
(20, 31, 13.5),
(20, 32, 15.0),
(20, 33, 14.5),
(20, 34, 13.0),
(20, 35, 15.5),
(20, 36, 14.0);

-- ===== QUELQUES RATTRAPAGES =====
-- Étudiant 4 a des notes faibles, ajoutons des rattrapages
INSERT INTO rattrapage (idAvancement, idMatiere, noteRattrapage) VALUES
(4, 1, 13.5),  -- S1
(4, 4, 12.0),  -- S1
(19, 38, 13.0), -- S4 Réseaux
(19, 40, 13.5), -- S4 Réseaux
(19, 44, 12.5); -- S4 Réseaux