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
    },
    mentionClass() {
      const moy = parseFloat(this.moyenne);
      if (isNaN(moy)) return '';
      if (moy < 10) return 'fail';
      if (moy < 12) return 'passable';
      if (moy < 14) return 'bien';
      if (moy < 16) return 'assez-bien';
      return 'tres-bien';
    }
  },
  methods: {
    async fetchReleve() {
      const { idEtudiant, semestre, option } = this.$route.params;
      if (!idEtudiant || !semestre || !option) return;

      this.loading = true;
      try {
        const res = await fetch(`http://localhost:8080/notes/${idEtudiant}/${semestre}/${option}`);
        const data = await res.json();
        this.notes = data.data || [];
        this.optionNom = this.notes.length > 0 ? this.notes[0].optionNom : option;
      } catch (err) {
        this.error = err.message;
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
  <div class="container">
    <button @click="goBack" class="btn-back">← Retour</button>
    
    <h1 class="title">Relevé de notes - {{ $route.params.semestre }} - Option : {{ optionNom }}</h1>

    <div v-if="loading" class="loading-card">
      <div class="spinner"></div>
      <p>Chargement des notes...</p>
    </div>

    <div v-else-if="notes.length > 0" class="content">
      <div class="etudiant-info" v-if="notes.length > 0">
        <div>
          <strong>ETU:</strong>
          <span>{{ notes[0].numeroEtudiant ?? '-' }}</span>
        </div>
        <div>
          <strong>Nom:</strong>
          <span>{{ notes[0].nomEtudiant ?? '-' }}</span>
        </div>
      </div>
      <div class="card">
        <div class="card-header"><h2>Notes</h2></div>
        <div class="card-body">
          <table>
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
                <td>{{ note.dateSession ?? '-' }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="footer">
        <div class="summary-item credits">
          <strong>Crédits</strong>
          <span>{{ totalCredits }}</span>
        </div>
        <div class="summary-item moyenne">
          <strong>Moyenne</strong>
          <span>{{ moyenne }}</span>
        </div>
        <div class="summary-item mention" :class="mentionClass">
          <strong>Mention</strong>
          <span>{{ mention }}</span>
        </div>
      </div>
    </div>

    <div v-else class="error-card">
      <p>Aucune note trouvée pour cet étudiant.</p>
    </div>
  </div>
</template>


<style scoped>
.container {
  max-width: 1100px;
  margin: 0 auto;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
  background: #f9f9f9;
  border-radius: 12px;
  min-height: 100vh;
}

.btn-back {
  background-color: #4caf50;
  color: white;
  padding: 10px 18px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  margin-bottom: 20px;
  font-size: 16px;
  transition: all 0.3s ease;
}

.btn-back:hover { background-color: #45a049; }

.title {
  font-size: 2rem;
  font-weight: 700;
  text-align: center;
  margin-bottom: 2rem;
  color: #333;
}

.card {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 6px 16px rgba(0,0,0,0.08);
  margin-bottom: 1.5rem;
  overflow: hidden;
  border: 1px solid #e0e0e0;
}

.card-header {
  background: #fff;
  padding: 1rem 1.5rem;
  border-bottom: 2px solid #4caf50;
}

.card-header h2 { margin: 0; font-size: 1.3rem; font-weight: 600; }

.card-body { padding: 1.5rem; }

table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  border-radius: 8px;
  overflow: hidden;
}

th, td {
  padding: 14px;
  text-align: center;
  border-bottom: 1px solid #c8e6c9;
  font-size: 1.1rem;
}

th {
  background-color: #4caf50;
  color: #fff;
  font-weight: 600;
}

tr:nth-child(even) td { background-color: #f1fdf3; }

tr:hover td { background-color: #e0f7e9; }

td:nth-child(4) { font-weight: 600; color: #388e3c; }

/* Footer */
.footer {
  display: flex;
  justify-content: flex-end;
  gap: 40px;
  margin-top: 30px;
}

.summary-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 12px 18px;
  border-radius: 10px;
  min-width: 120px;
  font-weight: 600;
}

.summary-item.credits { background: #e8f5e9; color: #388e3c; }
.summary-item.moyenne { background: #4caf50; color: #fff; }
.summary-item.mention.fail { background: #f44336; color: #fff; }
.summary-item.mention.passable { background: #ff9800; color: #fff; }
.summary-item.mention.bien { background: #64b5f6; color: #fff; }
.summary-item.mention.assez-bien { background: #aed581; color: #fff; }
.summary-item.mention.tres-bien { background: #388e3c; color: #fff; }

/* Loading */
.loading-card {
  text-align: center;
  padding: 3rem;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 6px 16px rgba(0,0,0,0.08);
}

.spinner {
  width: 50px;
  height: 50px;
  border: 4px solid #e0e0e0;
  border-top-color: #4caf50;
  border-radius: 50%;
  margin: 0 auto 1rem;
  animation: spin 1s linear infinite;
}

@keyframes spin { to { transform: rotate(360deg); } }

.error-card {
  text-align: center;
  padding: 3rem;
  background: #fff;
  border-radius: 12px;
  border: 2px solid #f44336;
  color: #f44336;
  font-weight: 600;
  font-size: 1.1rem;
}

/* Responsive */
@media (max-width: 900px) {
  .container { padding: 1rem; }
  table th, table td { padding: 10px; font-size: 1rem; }
  .footer { flex-direction: column; gap: 20px; }
  .summary-item { min-width: 100%; }
}

.etudiant-info {
  display: flex;
  gap: 2rem;
  background: #e8fbe6;
  border: 2px solid #4caf50;
  border-radius: 12px;
  padding: 1.2rem 2rem;
  margin-bottom: 2rem;
  box-shadow: 0 2px 8px rgba(76, 175, 80, 0.08);
  align-items: center;
}

.etudiant-info strong {
  color: #388e3c;
  font-size: 1.08rem;
  font-weight: 700;
  margin-right: 0.5rem;
}

.etudiant-info span {
  color: #222;
  font-size: 1.15rem;
  font-weight: 600;
  background: #fff;
  padding: 0.3rem 0.8rem;
  border-radius: 8px;
  box-shadow: 0 1px 4px rgba(76,175,80,0.07);
  border: 1px solid #c8e6c9;
}
</style>
