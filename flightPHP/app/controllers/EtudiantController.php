<?php
namespace App\Controllers;

use App\Models\Etudiant;
use Flight;

class EtudiantController {

    public static function getAll() {
        try {
            $model = new Etudiant(Flight::db());
            $etudiants = $model->getAll();

            if (!is_array($etudiants)) {
                $etudiants = [];
            }

            $etudiants = array_map(function($etu) {
                return [
                    'id' => $etu['id'] ?? null,
                    'ETU' => $etu['ETU'] ?? '',
                    'nom' => $etu['nom'] ?? '',
                    'prenom' => $etu['prenom'] ?? '',
                    'dtn' => $etu['dtn'] ?? ''
                ];
            }, $etudiants);

            // Nettoyer le buffer de sortie
            if (ob_get_level()) ob_clean();
            
            Flight::json([
                'status' => 'success',
                'data' => $etudiants,
                'error' => null
            ]);
            
        } catch (\Exception $e) {
            if (ob_get_level()) ob_clean();
            
            Flight::json([
                'status' => 'error',
                'data' => [],
                'error' => $e->getMessage()
            ], 500);
        }
    }
}