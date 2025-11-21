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
    
    <h2>
    Étudiants du {{ $route.params.semestre }} 
    (Option 
      {{
        $route.params.option === '1'
          ? 'Développement'
          : $route.params.option === '2'
          ? 'Web'
          : 'Réseaux'
      }}
    )
  </h2>
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
  max-width: 1100px;
  margin: 0 auto;
  padding: 30px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
  background: #fafafa;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

.btn-back {
  background-color: #4CAF50;
  color: white;
  padding: 10px 18px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  margin-bottom: 25px;
  font-size: 16px;
  transition: all 0.3s ease;
}

.btn-back:hover {
  background-color: #45a049;
}

h2 {
  color: #333;
  margin-bottom: 25px;
  text-align: center;
  font-size: 2rem;
  font-weight: 700;
}

/* Tableau moderne */
table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  margin: 20px 0;
  background: #fff;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(76,175,80,0.1);
}

th, td {
  padding: 16px 20px;
  text-align: center;
  font-size: 1.1rem;
  border-bottom: 1px solid #c8e6c9;
}

th {
  background-color: #4CAF50;
  color: white;
  font-weight: 700;
  font-size: 1.15rem;
  letter-spacing: 0.5px;
}

tr:nth-child(even) td {
  background-color: #f1fdf3;
}

tr:hover td {
  background-color: #e0f7e9;
  transition: background 0.25s;
  cursor: pointer;
}

/* Bouton moyenne plus visible */
.btn-moyenne {
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 6px;
  padding: 6px 14px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-moyenne:hover {
  background-color: #45a049;
}

/* Responsive */
@media (max-width: 900px) {
  .etudiants-container { padding: 20px; }
  th, td { padding: 12px 14px; font-size: 1rem; }
  h2 { font-size: 1.6rem; }
  .btn-back { font-size: 14px; padding: 8px 14px; }
}

</style>
