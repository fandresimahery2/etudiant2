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
  <div>
    <h2>Étudiants du {{ $route.params.semestre }} (Option {{ $route.params.option }})</h2>
    
    <p v-if="loading">Chargement...</p>
    <p v-else-if="error" style="color: red;">{{ error }}</p>
    
    <table v-else>
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
        <tr v-for="etudiant in etudiants" :key="etudiant.id">
          <td>{{ etudiant.ETU }}</td>
          <td>{{ etudiant.nom }}</td>
          <td>{{ etudiant.prenom }}</td>
          <td>{{ etudiant.dtn }}</td>
          <td>
            <button 
              @click="openReleve(etudiant)"
              style="background: none; border: none; color: #4CAF50; cursor: pointer; text-decoration: underline;"
            >
              {{ etudiant.moyenne ?? '-' }}
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

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

button:hover {
  opacity: 0.8;
}
</style>
