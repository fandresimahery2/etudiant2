# 📌 ToDo List du Projet (Version structurée)

## ✅ 1. Déployer l'environnement (Luberri)

* Configurer l'environnement de développement avec Docker.
* Déployer les images Docker pour PHP et MySQL.
* Vérifier que les conteneurs communiquent correctement.

---

## ✅ 2. Web Service : Notes Semestre

### Postman (Luberri)

* Créer une requête **GET `/notes/@idEtudiant/@semestre`**.

### Routing (Safidy)

* Route : **GET `/notes/@idEtudiant/@semestre`**

  * Appelle : `NoteController.getNotesByEtudiantAndSemestre($idEtudiant, $semestre)`

### Fonctions (Luberri)

* `getNotesByEtudiantAndSemestre(semestre, idEtudiant)` :

  * Retourne les notes d'un étudiant pour un semestre.
  * Calcule la moyenne du semestre :

    * **Σ(note × crédit) / Σ(crédits)**
  * Gestion des erreurs.

### Base (Safidy)

* **Note**(idNote, idAvancement, note, idMatiere)
* **Avancement**(idAvancement, idEtudiant, semestre, idSession)
* **Matiere**(idMatiere, nom, UE)
* **Credit**(idCredit, idMatiere, semestre, credit)

---

## ✅ 3. Web Service : Notes Annuel

### Postman (Safidy)

* Créer une requête **GET `/notes/annee/{idannee}/{idEtudiant}`**.

### Routing (Luberri)

* Route : **GET `/notes/annee/{idannee}/{idEtudiant}`**

  * Appelle : `NoteController.getNotesAnneeL1ByEtudiant(idEtudiant)`

### Fonctions (Safidy)

* `getNotesAnnuelByEtudiant($idEtudiant, $annee)` :

  * Retourne les notes annuelles d'un étudiant.
  * Calcul des moyennes dans `meta`.
  * Gestion erreurs.

### Base (Luberri)

* Ajout : **Etudiant**(id, ETU, nom, prenom, dtn)

---

## 🟡 4. Authentification avec login et token

### Postman (Luberri)

* POST `/login` avec email + mot de passe.
* Tester génération + validation du token.

### Routing (Safidy)

* POST `/login` → `AuthController.login($email, $password)`
* Middleware : vérification token.

### Fonctions (Luberri)

* `login($email, $password)` : vérifie identifiants + génère JWT.
* `validateToken($token)` : vérifie la validité du JWT.

### Base (Safidy)

* **User**(id, email, password_hash, role)

---

## ✅ 5. Configuration de Postman

### Postman (Luberri)

* Créer une collection regroupant toutes les requêtes.
* Ajouter les variables d'environnement : `base_url`, `token`.

### Routing (Safidy)

* Ajouter tests automatiques (status, data, erreurs).

### Fonctions (Luberri)

* Documenter chaque endpoint (exemples requêtes + réponses).

### Base (Safidy)

* Vérifier cohérence des données retournées.

---

## 🟡 6. Liste des semestres + lien vers étudiants avec moyennes S1 à S4

### Frontend (Luberri)

* Créer la page Vue JS pour afficher les semestres.
* Ajouter un lien vers la liste des étudiants.
* Afficher les moyennes S1 à S4.
* Fonctionnalités PDF Vue JS :

  * Tableau dynamique des semestres.
  * Navigation par clic.
  * Affichage des moyennes dans un tableau.

### Routing (Safidy)

* GET `/semestres` → `SemestreController.getAllSemestres()`
* GET `/etudiants/{semestre}/{option}` → `EtudiantController.getEtudiantsBySemestre()`

### Fonctions (Luberri)

* `getAllSemestres()` : retourne les semestres.
* `getEtudiantsBySemestre($semestre, $option)` : retourne les étudiants + moyennes.

### Base (Safidy)

* Semestre, Étudiant, Note, Credit

---

## 🟡 7. Affichage du relevé de notes (clic sur une moyenne)

### Frontend (Luberri)

* Ajouter action sur la moyenne → afficher relevé.
* Composant Vue JS pour relevé de notes.
* Fonctionnalités PDF Vue JS : tableau matières + notes + crédits.

### Routing (Safidy)

* GET `/notes/{idEtudiant}/{semestre}/{option}`
  → `NoteController.getNotesByEtudiantAndSemestre()`

### Fonctions (Luberri)

* `getNotesByEtudiantAndSemestre($idEtudiant, $semestre, $option)` : relevé.

### Base (Safidy)

* Note, Matiere, Credit

---

## 🟡 8. Infos étudiant + moyennes S1-S4 + liens L1/L2

### Frontend (Luberri)

* Page Vue JS : infos détaillées étudiant.
* Tableau des moyennes S1-S4.
* Liens vers L1 (S1+S2) et L2 (S3+S4).
* Fonctionnalités PDF Vue JS : fiche détaillée + tableau récapitulatif.

### Routing (Safidy)

* GET `/etudiant/{idEtudiant}`
  → `EtudiantController.getInfosEtudiant()`
* GET `/notes/annuel/{idEtudiant}/{annee}/{option}`
  → `NoteController.getReleveNotesAnnuel()`

### Fonctions (Luberri)

* `getInfosEtudiant($idEtudiant)` : infos complètes.
* `getReleveNotesAnnuel($idEtudiant, $annee, $option)` : notes L1/L2.

### Base (Safidy)

* Étudiant, Note, Avancement, Credit
