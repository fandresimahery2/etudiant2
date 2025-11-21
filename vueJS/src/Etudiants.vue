
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
        // Récupère tous les étudiants
        const res = await fetch('http://localhost:8080/etudiants');
        const json = await res.json();
        const etudiants = json.data || [];
        const semestre = this.$route.params.semestre;
        const option = this.$route.params.option;

        // Pour chaque étudiant, récupère la moyenne du semestre/option
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
    <table>
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
          <td>{{ etudiant.moyenne ?? '-' }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
