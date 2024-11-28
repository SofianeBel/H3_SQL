-- Insertion des utilisateurs
INSERT INTO UTILISATEUR (email, password_hash, nom, prenom, telephone, role) VALUES
('admin@resto.com', SHA2('hash123',256), 'Admin', 'System', '0123456789', 'ADMIN'),
('chef@bistrot.fr', SHA2('hash456',256), 'Dubois', 'Jean', '0234567890', 'RESTAURANT'),
('client@mail.com', SHA2('hash789',256), 'Martin', 'Sophie', '0345678901', 'CLIENT'),
('client2@mail.com', SHA2('hash101',256), 'Dupont', 'Marie', '0456789012', 'CLIENT');

-- Insertion des restaurants
INSERT INTO RESTAURANT (nom, adresse, telephone, capacite_max, description, horaires_ouverture) VALUES
('Le Bistrot Parisien', '123 rue de Paris', '0123456789', 50, 'Restaurant traditionnel', '10:00-23:00'),
('La Trattoria', '45 rue Italienne', '0234567890', 35, 'Cuisine italienne', '11:30-22:30');

-- Insertion des tables
INSERT INTO TABLES (numero, capacite, emplacement, id_restaurant) VALUES
('T1', 4, 'Terrasse', 1),
('T2', 6, 'Intérieur', 1),
('T3', 2, 'Bar', 1),
('T1', 2, 'Fenêtre', 2),
('T2', 4, 'Terrasse', 2);

-- Insertion des plats
INSERT INTO PLAT (nom, description, prix, categorie, id_restaurant) VALUES
("Soupe à l'oignon", 'Soupe traditionnelle', 8.00, 'ENTREE', 1),
('Steak-frites', 'Viande française', 18.00, 'PLAT', 1),
('Crème brûlée', 'Dessert maison', 7.00, 'DESSERT', 1),
('Bruschetta', 'Entrée italienne', 7.00, 'ENTREE', 2),
('Pizza Margherita', 'Pizza traditionnelle', 14.00, 'PLAT', 2),
('Tiramisu', 'Dessert italien', 6.00, 'DESSERT', 2);

-- Insertion des menus
INSERT INTO MENU (nom, description, prix, id_restaurant, date_debut, date_fin) VALUES
('Menu du Jour', 'Entrée + Plat + Dessert', 25.00, 1, '2024-01-01', '2024-12-31'),
('Menu Dégustation', 'Menu 5 services', 45.00, 2, '2024-01-01', '2024-12-31');

-- Liaison menu-plat
INSERT INTO MENU_PLAT (id_menu, id_plat) VALUES
(1, 1), -- Menu du Jour - Soupe
(1, 2), -- Menu du Jour - Steak
(1, 3), -- Menu du Jour - Crème brûlée
(2, 4), -- Menu Dégustation - Bruschetta
(2, 5), -- Menu Dégustation - Pizza
(2, 6); -- Menu Dégustation - Tiramisu

-- Insertion des réservations
INSERT INTO RESERVATION (date, heure, nombre_personnes, statut, commentaire, id_utilisateur, id_restaurant, id_table) VALUES
('2024-12-01', '19:30', 2, 'CONFIRMEE', 'Anniversaire', 3, 1, 1),
('2024-12-01', '20:00', 4, 'EN_ATTENTE', NULL, 4, 2, 4),
('2024-12-02', '12:30', 2, 'CONFIRMEE', NULL, 3, 1, 3),
('2024-12-02', '19:00', 6, 'ANNULEE', 'Changement de plans', 4, 2, 5);

-- Insertion des avis
INSERT INTO AVIS (note, commentaire, id_utilisateur, id_restaurant) VALUES
(5, 'Excellent service !', 3, 1),
(4, 'Très bonne cuisine', 4, 1),
(3, 'Service un peu lent', 3, 2),
(5, 'Meilleure pizza de la ville', 4, 2);

