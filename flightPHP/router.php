<?php
// Router pour le serveur PHP intégré
if (php_sapi_name() == 'cli-server') {
    $url = parse_url($_SERVER['REQUEST_URI']);
    $file = __DIR__ . $url['path'];
    
    // Si c'est un fichier statique, le servir directement
    if (is_file($file)) {
        return false;
    }
}

require_once __DIR__ . '/index.php';