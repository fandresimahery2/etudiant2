<script>
export default {
  name: 'NotesAnnuel',
  data() {
    return {
      notes: [],
      moyenne: null,
      etudiant: null
    }
  },
  async created() {
    const { idEtudiant, annee, option } = this.$route.params;
    // Récupère les notes annuelles
    const res = await fetch(`http://localhost:8080/notes/annuel/${idEtudiant}/${annee}/${option}`);
    const data = await res.json();
    this.notes = data.data || [];
    this.moyenne = data.meta?.moyenne_annuelle ?? null;
    // Récupère les infos de l'étudiant
    const etuRes = await fetch(`http://localhost:8080/etudiants/${idEtudiant}`);
    const etuData = await etuRes.json();
    this.etudiant = etuData.data;
  }
}
</script>

<template>
    
    <div>
      <h2>Notes annuelles</h2>
      <div class="etudiant-info" v-if="etudiant">
        <div>
          <strong>ETU:</strong>
          <span>{{ etudiant.ETU }}</span>
        </div>
        <div>
          <strong>Nom:</strong>
          <span>{{ etudiant.nom }}</span>
        </div>
        <div>
          <strong>Prénom:</strong>
          <span>{{ etudiant.prenom }}</span>
        </div>
        <div>
          <strong>Date de naissance:</strong>
          <span>{{ etudiant.dtn }}</span>
        </div>
        <div>
          <strong>Option:</strong>
          <span>{{ $route.params.option }}</span>
        </div>
        <div>
          <strong>Année:</strong>
          <span>{{ $route.params.annee === '1' ? 'L1' : 'L2' }}</span>
        </div>
        <p>Année : {{ $route.params.annee === '1' ? 'L1' : 'L2' }}</p>
      </div>
      <table v-if="notes.length">
        <thead>
          <tr>
            <th>Matière</th>
            <th>Note</th>
            <th>Crédit</th>
            <th>Semestre</th>
            <th>Session</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="note in notes" :key="note.idNote">
            <td>{{ note.matiere }}</td>
            <td>{{ note.note }}</td>
            <td>{{ note.credit }}</td>
            <td>{{ note.semestre }}</td>
            <td>{{ note.dateSession ?? '-' }}</td>
          </tr>
        </tbody>
      </table>
      <p class="moyenne-label" v-if="moyenne !== null"><strong>Moyenne annuelle :</strong> {{ moyenne }}</p>
      <p v-else>Chargement...</p>
    </div>
</template>
<style scoped>
.container {
  max-width: 900px;
  margin: 0 auto;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
  background: #fafafa;
  min-height: 100vh;
}

h2 {
  font-size: 2rem;
  font-weight: 700;
  color: #388e3c;
  margin-bottom: 1.5rem;
  text-align: center;
}

.etudiant-info {
  background: #e8fbe6;
  border: 1.5px solid #4caf50;
  border-radius: 12px;
  padding: 1.5rem 2rem;
  margin-bottom: 2rem;
  box-shadow: 0 2px 8px rgba(76, 175, 80, 0.08);
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 1.2rem;
}

.etudiant-info strong {
  color: #388e3c;
  font-size: 0.95rem;
  font-weight: 600;
  display: block;
  margin-bottom: 0.2rem;
}

.etudiant-info span {
  color: #222;
  font-size: 1.08rem;
  font-weight: 500;
}

.annee-label {
  font-size: 1.1rem;
  color: #4caf50;
  font-weight: 600;
  margin-bottom: 1rem;
  text-align: center;
}

/* Table plus classique */
table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0;
  background: #fff;
  border: 1px solid #4caf50;
  border-radius: 6px;
  overflow: hidden;
}

th, td {
  padding: 0.9rem 1rem;
  text-align: center;
  border: 1px solid #4caf50; /* bordure simple */
  font-size: 1rem;
}

th {
  font-weight: 600;
  color: #fff;
  background-color: #4caf50; /* en-tête en vert */
}

tr:nth-child(even) {
  background-color: #f1fdf3; /* lignes alternées très légères */
}

tr:hover td {
  background-color: #e0f7e9; /* hover léger */
  transition: background 0.2s;
}

/* Moyenne bien visible */
.moyenne-label {
  font-size: 1.4rem;
  color: #4caf50;
  font-weight: 700;
  margin-top: 1.5rem;
  text-align: right;
}

@media (max-width: 700px) {
  .container { padding: 1rem; }
  .etudiant-info { grid-template-columns: 1fr; padding: 1rem; }
  th, td { padding: 0.7rem; font-size: 0.98rem; }
}
</style>