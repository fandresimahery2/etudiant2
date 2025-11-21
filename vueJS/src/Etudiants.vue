<template>
    <div>
      <h2>Étudiants du {{ $route.params.semestre }} (Option {{ $route.params.option }})</h2>
      <table>
        <thead>
          <tr>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Moyenne S1</th>
            <th>Moyenne S2</th>
            <th>Moyenne S3</th>
            <th>Moyenne S4</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="etudiant in etudiants" :key="etudiant.id">
            <td>{{ etudiant.nom }}</td>
            <td>{{ etudiant.prenom }}</td>
            <td>{{ etudiant.meta?.S1 ?? '-' }}</td>
            <td>{{ etudiant.meta?.S2 ?? '-' }}</td>
            <td>{{ etudiant.meta?.S3 ?? '-' }}</td>
            <td>{{ etudiant.meta?.S4 ?? '-' }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>