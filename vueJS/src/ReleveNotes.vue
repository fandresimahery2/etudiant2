<script>
export default {
  name: 'ReleveNotes',
  data() {
    return {
      notes: [],
      loading: false,
      error: null,
      nomEtudiant: null,
      numeroEtudiant: null
    }
  },
  computed: {
    moyenne() {
      if (this.notes.length === 0) return null;
      const totalPoints = this.notes.reduce((sum, n) => sum + (n.note * n.credit), 0);
      const totalCredits = this.notes.reduce((sum, n) => sum + n.credit, 0);
      return totalCredits > 0 ? (totalPoints / totalCredits).toFixed(2) : null;
    }
  },
  methods: {
    getResultat(note) {
      if (note < 10) return 'A journée';
      if (note < 12) return 'Passable';
      if (note < 14) return 'Bien';
      if (note < 16) return 'Assez bien';
      return 'Très bien';
    },
    async fetchReleve() {
      const idEtudiant = this.$route.params.idEtudiant;
      const semestre = this.$route.params.semestre;
      const option = this.$route.params.option;
      
      if (!idEtudiant || !semestre || !option) return;
      
      this.loading = true;
      this.error = null;
      try {
        const response = await fetch(
          `http://localhost:8080/notes/${idEtudiant}/${semestre}/${option}`
        );
        const data = await response.json();
        
        if (data.status === 'success') {
          this.notes = data.data || [];
          this.nomEtudiant = data.meta?.nomEtudiant;
          this.numeroEtudiant = data.meta?.numeroEtudiant;
        } else {
          this.error = data.error || 'Erreur inconnue';
        }
      } catch (error) {
        this.error = error.message;
      } finally {
        this.loading = false;
      }
    },
    goBack() {
      this.$router.back();
    }
  },
  created() {
    this.fetchReleve();
  },
  watch: {
    '$route.params': 'fetchReleve'
  }
}
</script>

<template>
  <div class="releve-container">
    <button @click="goBack" class="btn-back">← Retour</button>
    
    <h2>Relevé de notes - {{ $route.params.semestre }}</h2>
    
    <div v-if="nomEtudiant && numeroEtudiant" class="student-info">
      <p><strong>Étudiant:</strong> {{ nomEtudiant }}</p>
      <p><strong>Numéro:</strong> {{ numeroEtudiant }}</p>
    </div>
    
    <p v-if="loading">Chargement...</p>
    <p v-else-if="error" style="color: red;">{{ error }}</p>
    
    <table v-else-if="notes.length > 0">
      <thead>
        <tr>
          <th>Matière</th>
          <th>Note</th>
          <th>Crédit</th>
          <th>Points</th>
          <th>Résultat</th>
          <th>Date Session</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="note in notes" :key="note.idNote">
          <td>{{ note.matiere }}</td>
          <td>{{ note.note }}</td>
          <td>{{ note.credit }}</td>
          <td>{{ (note.note * note.credit).toFixed(2) }}</td>
          <td>{{ getResultat(note.note) }}</td>
          <td>{{ note.dateSession }}</td>
        </tr>
      </tbody>
    </table>
    
    <div v-else>Aucune note trouvée.</div>
    
    <div class="footer" v-if="notes.length > 0">
      <strong>Moyenne: {{ moyenne }}</strong>
    </div>
  </div>
</template>

<style scoped>
.releve-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
}

.btn-back {
  background-color: #4CAF50;
  color: white;
  padding: 8px 15px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-bottom: 20px;
  font-size: 14px;
}

.btn-back:hover {
  background-color: #45a049;
}

h2 {
  color: #333;
  margin-bottom: 20px;
}

.student-info {
  background-color: #f9f9f9;
  border-left: 4px solid #4CAF50;
  padding: 15px;
  margin-bottom: 20px;
  border-radius: 4px;
}

.student-info p {
  margin: 5px 0;
  font-size: 16px;
  color: #333;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin: 15px 0;
}

th, td {
  border: 1px solid #ddd;
  padding: 12px;
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

.footer {
  text-align: right;
  margin-top: 20px;
  padding-top: 20px;
  border-top: 2px solid #ddd;
  font-size: 18px;
}
</style>