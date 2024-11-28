-- Requête de test pour vérifier les relations
SELECT 
    r.nom as restaurant,
    t.numero as table_num,
    m.nom as menu,
    p.nom as plat,
    res.date,
    res.heure,
    u.nom as client,
    a.note
FROM RESTAURANT r
LEFT JOIN TABLES t ON t.id_restaurant = r.id_restaurant
LEFT JOIN MENU m ON m.id_restaurant = r.id_restaurant
LEFT JOIN MENU_PLAT mp ON mp.id_menu = m.id_menu
LEFT JOIN PLAT p ON p.id_plat = mp.id_plat
LEFT JOIN RESERVATION res ON res.id_restaurant = r.id_restaurant
LEFT JOIN UTILISATEUR u ON u.id_utilisateur = res.id_utilisateur
LEFT JOIN AVIS a ON a.id_restaurant = r.id_restaurant AND a.id_utilisateur = u.id_utilisateur
GROUP BY r.nom, t.numero, m.nom, p.nom, res.date, res.heure, u.nom, a.note;