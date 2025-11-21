<?php
ini_set('display_errors', 0); // Désactiver en production
error_reporting(E_ALL);

require_once __DIR__ . '/flight/Flight.php';
require __DIR__ . '/config/database.php';

use App\Controllers\NoteController;
use App\Controllers\UserController;
use App\Controllers\EtudiantController;

// CORS - AVANT toute sortie
Flight::before('start', function() {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, Authorization');
    header('Content-Type: application/json; charset=utf-8');
    
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        http_response_code(200);
        exit();
    }
});

// Users
Flight::route('GET /users', [UserController::class, 'getAll']);
Flight::route('GET /users/@id', [UserController::class, 'getById']);
Flight::route('POST /users', [UserController::class, 'create']);
Flight::route('PUT /users/@id', [UserController::class, 'update']);
Flight::route('DELETE /users/@id', [UserController::class, 'delete']);

// Notes
Flight::route('GET /notes', [NoteController::class, 'getAllNotes']);
Flight::route('GET /notes/@idEtudiant/@semestre/@option', function($idEtudiant, $semestre, $option){
    $controller = new NoteController();
    $controller->getNotesByEtudiantAndSemestre($idEtudiant, $semestre, $option);
});
Flight::route('POST /notes', [NoteController::class, 'addNote']);

Flight::route('GET /notes/annuel/@idEtudiant/@annee/@option', function($idEtudiant, $annee, $option){
    $controller = new NoteController();
    $controller->getNotesAnnuelByEtudiant($idEtudiant, $annee, $option);
});

// Étudiants
Flight::route('GET /etudiants', [EtudiantController::class, 'getAll']);
Flight::route('GET /etudiants/@id', [EtudiantController::class, 'getById']);

Flight::start();
