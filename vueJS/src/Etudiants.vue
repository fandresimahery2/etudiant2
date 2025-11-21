<template>
  <div>
    <h2>Liste des étudiants</h2>
    
    <!-- Message de chargement -->
    <p v-if="loading">Chargement...</p>
    
    <!-- Message d'erreur -->
    <p v-else-if="error" style="color: red;">{{ error }}</p>
    
    <!-- Tableau des étudiants -->
    <table v-else-if="etudiants.length > 0">
      <thead>
        <tr>
          <th>ETU</th>
          <th>Nom</th>
          <th>Prénom</th>
          <th>Date de naissance</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="etudiant in etudiants" :key="etudiant.id">
          <td>{{ etudiant.ETU }}</td>
          <td>{{ etudiant.nom }}</td>
          <td>{{ etudiant.prenom }}</td>
          <td>{{ etudiant.dtn }}</td>
        </tr>
      </tbody>
    </table>
    
    <!-- Message si aucun étudiant -->
    <p v-else>Aucun étudiant trouvé.</p>
  </div>
</template>

<script>
export default {
  name: 'Etudiants',
  data() {
    return {
      etudiants: [],
      loading: true,
      error: null
    }
  },
  async created() {
    try {
      const response = await fetch('http://localhost:8000/etudiants');
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const text = await response.text();
      const data = JSON.parse(text);
      
      // Stocker les données dans la propriété etudiants
      if (data.status === 'success') {
        this.etudiants = data.data;
      } else {
        this.error = data.error || 'Erreur inconnue';
      }
      
    } catch (error) {
      console.error('Erreur détaillée:', error);
      this.error = error.message;
    } finally {
      this.loading = false;
    }
  }
}
</script>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

th {
  background-color: #4CAF50;
  color: white;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

tr:hover {
  background-color: #ddd;
}
</style>