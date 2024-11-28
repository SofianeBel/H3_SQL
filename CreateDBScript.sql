-- Création de la base de données
CREATE DATABASE IF NOT EXISTS restaurant_reservations;
USE restaurant_reservations;

-- Table des utilisateurs
CREATE TABLE UTILISATEUR (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    telephone VARCHAR(15),
    role ENUM('CLIENT', 'ADMIN', 'RESTAURANT') NOT NULL DEFAULT 'CLIENT',
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table des restaurants
CREATE TABLE RESTAURANT (
    id_restaurant INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse TEXT NOT NULL,
    telephone VARCHAR(15) NOT NULL,
    capacite_max INT NOT NULL,
    description TEXT,
    horaires_ouverture TEXT NOT NULL
);

-- Table des tables
CREATE TABLE TABLES (
    id_table INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    capacite INT NOT NULL,
    emplacement VARCHAR(50),
    id_restaurant INT NOT NULL,
    FOREIGN KEY (id_restaurant) REFERENCES RESTAURANT(id_restaurant) ON DELETE CASCADE,
    UNIQUE KEY unique_table_resto (numero, id_restaurant)
);

-- Table des menus
CREATE TABLE MENU (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    id_restaurant INT NOT NULL,
    date_debut DATE,
    date_fin DATE,
    FOREIGN KEY (id_restaurant) REFERENCES RESTAURANT(id_restaurant) ON DELETE CASCADE
);

-- Table des plats
CREATE TABLE PLAT (
    id_plat INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    categorie ENUM('ENTREE', 'PLAT', 'DESSERT', 'BOISSON') NOT NULL,
    id_restaurant INT NOT NULL,
    FOREIGN KEY (id_restaurant) REFERENCES RESTAURANT(id_restaurant) ON DELETE CASCADE
);

-- Table de liaison menu-plat (relation many-to-many)
CREATE TABLE MENU_PLAT (
    id_menu INT NOT NULL,
    id_plat INT NOT NULL,
    PRIMARY KEY (id_menu, id_plat),
    FOREIGN KEY (id_menu) REFERENCES MENU(id_menu) ON DELETE CASCADE,
    FOREIGN KEY (id_plat) REFERENCES PLAT(id_plat) ON DELETE CASCADE
);

-- Table des réservations
CREATE TABLE RESERVATION (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    heure TIME NOT NULL,
    nombre_personnes INT NOT NULL,
    statut ENUM('CONFIRMEE', 'EN_ATTENTE', 'ANNULEE') NOT NULL DEFAULT 'EN_ATTENTE',
    commentaire TEXT,
    id_utilisateur INT NOT NULL,
    id_restaurant INT NOT NULL,
    id_table INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur),
    FOREIGN KEY (id_restaurant) REFERENCES RESTAURANT(id_restaurant),
    FOREIGN KEY (id_table) REFERENCES TABLES(id_table)
);

-- Table des avis
CREATE TABLE AVIS (
    id_avis INT AUTO_INCREMENT PRIMARY KEY,
    note INT NOT NULL CHECK (note BETWEEN 1 AND 5),
    commentaire TEXT,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_utilisateur INT NOT NULL,
    id_restaurant INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur),
    FOREIGN KEY (id_restaurant) REFERENCES RESTAURANT(id_restaurant)
);

-- Création des index pour optimiser les performances
CREATE INDEX idx_reservation_date ON RESERVATION(date, heure);
CREATE INDEX idx_user_email ON UTILISATEUR(email);
CREATE INDEX idx_restaurant_nom ON RESTAURANT(nom);
CREATE INDEX idx_menu_dates ON MENU(date_debut, date_fin);
CREATE INDEX idx_plat_categorie ON PLAT(categorie);
CREATE INDEX idx_avis_date ON AVIS(date_creation);