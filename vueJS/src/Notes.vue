<template>
  <div class="notes-container">
    <h1>Notes des Étudiants</h1>
    
    <div class="filters">
      <input 
        v-model="idEtudiant" 
        type="text" 
        placeholder="ID Étudiant"
        @keyup.enter="fetchNotes"
      />
      <input 
        v-model="semestre" 
        type="text" 
        placeholder="Semestre"
        @keyup.enter="fetchNotes"
      />
      <input 
        v-model="option" 
        type="text" 
        placeholder="Option"
        @keyup.enter="fetchNotes"
      />
      <button @click="fetchNotes">Rechercher</button>
      <button @click="fetchAllNotes">Toutes les notes</button>
    </div>

    <div v-if="loading" class="loading">Chargement...</div>
    <div v-if="error" class="error">{{ error }}</div>

    <div v-if="notes.length > 0" class="notes-table">
      <table>
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
    </div>
    <div v-else-if="!loading" class="no-data">Aucune note trouvée</div>
  </div>
</template>

<script>
export default {
  name: 'Notes',
  data() {
    return {
      notes: [],
      idEtudiant: '',
      semestre: '',
      option: '',
      loading: false,
      error: null,
      apiUrl: 'http://localhost:8080'
    }
  },
  mounted() {
    this.fetchAllNotes()
  },
  methods: {
    async fetchAllNotes() {
      this.loading = true
      this.error = null
      try {
        const response = await fetch(`${this.apiUrl}/notes`)
        if (!response.ok) throw new Error('Erreur lors de la récupération des notes')
        this.notes = await response.json()
      } catch (err) {
        this.error = err.message
        console.error(err)
      } finally {
        this.loading = false
      }
    },
    async fetchNotes() {
      if (!this.idEtudiant || !this.semestre || !this.option) {
        this.error = 'Veuillez remplir tous les champs'
        return
      }
      
      this.loading = true
      this.error = null
      try {
        const response = await fetch(
          `${this.apiUrl}/notes/${this.idEtudiant}/${this.semestre}/${this.option}`
        )
        if (!response.ok) throw new Error('Erreur lors de la récupération des notes')
        this.notes = await response.json()
      } catch (err) {
        this.error = err.message
        console.error(err)
      } finally {
        this.loading = false
      }
    }
  }
}
</script>

<style scoped>
.notes-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

h1 {
  color: #333;
  text-align: center;
}

.filters {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  flex-wrap: wrap;
}

input, button {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

button {
  background-color: #007bff;
  color: white;
  cursor: pointer;
  border: none;
}

button:hover {
  background-color: #0056b3;
}

.loading, .error {
  text-align: center;
  padding: 20px;
  font-weight: bold;
}

.error {
  color: #dc3545;
  background-color: #f8d7da;
  border: 1px solid #f5c6cb;
  border-radius: 4px;
}

.loading {
  color: #007bff;
}

.notes-table {
  overflow-x: auto;
}

table {
  width: 100%;
  border-collapse: collapse;
  background-color: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

thead {
  background-color: #f8f9fa;
}

th, td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

th {
  font-weight: bold;
  color: #333;
}

tbody tr:hover {
  background-color: #f5f5f5;
}

.no-data {
  text-align: center;
  padding: 40px;
  color: #999;
  font-size: 16px;
}
</style>
