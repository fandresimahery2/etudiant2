<?php
require_once __DIR__ . '/../flight/Flight.php';

Flight::register('db', 'PDO', array(
    'mysql:host=localhost;port=3306;dbname=gestion_scolarite;charset=utf8',
    'root',      // utilisateur MySQL dans ton conteneur
    'ratisbonne2005'      // mot de passe MySQL
), function ($db) {
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
});
