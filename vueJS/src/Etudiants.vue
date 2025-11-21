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
  methods: {
    async loadEtudiants() {
      this.loading = true;
      this.error = null;
      try {
        const res = await fetch('http://localhost:8080/etudiants');
        const json = await res.json();
        const etudiants = json.data || [];
        const semestre = this.$route.params.semestre;
        const option = this.$route.params.option;

        for (const etu of etudiants) {
          const notesRes = await fetch(`http://localhost:8080/notes/${etu.id}/${semestre}/${option}`);
          const notesData = await notesRes.json();
          etu.moyenne = notesData.meta?.moyenne ?? null;
        }
        this.etudiants = etudiants;
      } catch (error) {
        this.error = error.message;
      } finally {
        this.loading = false;
      }
    },
    goBack() {
      this.$router.back();
    },
    openReleve(etudiant) {
      this.$router.push({
        name: 'ReleveNotes',
        params: {
          idEtudiant: etudiant.id,
          semestre: this.$route.params.semestre,
          option: this.$route.params.option
        }
      });
    }
  },
  created() {
    this.loadEtudiants();
  },
  watch: {
    '$route.params': 'loadEtudiants'
  }
}
</script>

<template>
  <div class="etudiants-container">
    <button @click="goBack" class="btn-back">← Retour</button>
    
    <h2>Étudiants du {{ $route.params.semestre }} (Option {{ $route.params.option }})</h2>
    
    <p v-if="loading">Chargement...</p>
    <p v-else-if="error" style="color: red;">{{ error }}</p>
    
    <table v-else-if="etudiants.length > 0">
      <thead>
        <tr>
          <th>ETU</th>
          <th>Nom</th>
          <th>Prénom</th>
          <th>Date de naissance</th>
          <th>Moyenne</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="etudiant in etudiants" :key="etudiant.id" @click="$router.push({ name: 'EtudiantDetail', params: { id: etudiant.id } })" style="cursor:pointer;">
          <td>{{ etudiant.ETU }}</td>
          <td>{{ etudiant.nom }}</td>
          <td>{{ etudiant.prenom }}</td>
          <td>{{ etudiant.dtn }}</td>
          <td>
            <button 
              @click.stop="openReleve(etudiant)"
              class="btn-moyenne"
            >
              {{ etudiant.moyenne ?? '-' }}
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    
    <div v-else>Aucun étudiant trouvé.</div>
  </div>
</template>

<style scoped>
.etudiants-container {
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

.btn-moyenne {
  background: none;
  border: none;
  color: #4CAF50;
  cursor: pointer;
  text-decoration: underline;
  font-size: 14px;
  padding: 0;
}

.btn-moyenne:hover {
  opacity: 0.8;
}
</style>
