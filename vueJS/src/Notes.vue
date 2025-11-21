<template>
  <div>
    <h2>Liste des notes</h2>
    
    <!-- Message de chargement -->
    <p v-if="loading">Chargement...</p>
    
    <!-- Message d'erreur -->
    <p v-else-if="error" style="color: red;">{{ error }}</p>
    
    <!-- Tableau des notes -->
    <table v-else-if="notes.length > 0">
      <thead>
        <tr>
          <th>ID Étudiant</th>
          <th>Semestre</th>
          <th>Option</th>
          <th>Note</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="note in notes" :key="note.id">
          <td>{{ note.idEtudiant }}</td>
          <td>{{ note.semestre }}</td>
          <td>{{ note.option }}</td>
          <td>{{ note.note }}</td>
        </tr>
      </tbody>
    </table>
    
    <!-- Message si aucune note -->
    <p v-else>Aucune note trouvée.</p>
  </div>
</template>

<script>
export default {
  name: 'Notes',
  data() {
    return {
      notes: [],
      loading: true,
      error: null
    }
  },
  async created() {
    try {
      const response = await fetch('http://localhost:8000/notes');
      
      if (!response.ok) {
        throw new Error(`HTTP erro  r! status: ${response.status}`);
      }
      
      const text = await response.text();
      const data = JSON.parse(text);
      
      // Stocker les données dans la propriété notes
      if (data.status === 'success') {
        this.notes = data.data;
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
