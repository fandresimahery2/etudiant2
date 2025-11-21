<script>
export default {
  name: 'ReleveNotes',
  data() {
    return {
      notes: [],
      loading: false,
      error: null,
      optionNom: null
    }
  },
  computed: {
    moyenne() {
      if (this.notes.length === 0) return null;
      const totalPoints = this.notes.reduce((sum, n) => sum + (n.note * n.credit), 0);
      const totalCredits = this.notes.reduce((sum, n) => sum + n.credit, 0);
      return totalCredits > 0 ? (totalPoints / totalCredits).toFixed(2) : null;
    },
    totalCredits() {
      return this.notes.reduce((sum, n) => sum + n.credit, 0);
    },
    mention() {
      const moy = parseFloat(this.moyenne);
      if (isNaN(moy)) return null;
      if (moy < 10) return 'A journée';
      if (moy < 12) return 'Passable';
      if (moy < 14) return 'Bien';
      if (moy < 16) return 'Assez bien';
      return 'Très bien';
    }
  },
  methods: {
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
          this.optionNom = this.notes.length > 0 ? this.notes[0].optionNom : null;
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
    
    <h2>Relevé de notes - {{ $route.params.semestre }} </h2><h2> Option : {{ optionNom }}</h2>
    
    <p v-if="loading">Chargement...</p>
    <p v-else-if="error" style="color: red;">{{ error }}</p>
    
    <table v-else-if="notes.length > 0">
      <thead>
        <tr>
          <th>Matière</th>
          <th>Note</th>
          <th>Crédit</th>
          <th>Points</th>
          <th>Date Session</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="note in notes" :key="note.idNote">
          <td>{{ note.matiere }}</td>
          <td>{{ note.note }}</td>
          <td>{{ note.credit }}</td>
          <td>{{ (note.note * note.credit).toFixed(2) }}</td>
          <td>{{ note.dateSession }}</td>
        </tr>
      </tbody>
    </table>
    
    <div v-else>Aucune note trouvée.</div>
    
    <div class="footer" v-if="notes.length > 0">
      <div class="summary">
        <div class="summary-item">
          <strong>Crédits:</strong> {{ totalCredits }}
        </div>
        <div class="summary-item">
          <strong>Moyenne:</strong> {{ moyenne }}
        </div>
        <div class="summary-item">
          <strong>Mention:</strong> {{ mention }}
        </div>
      </div>
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

.summary {
  display: flex;
  justify-content: flex-end;
  gap: 40px;
  padding: 15px 0;
}

.summary-item {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.summary-item strong {
  color: #333;
  margin-bottom: 5px;
}
</style>