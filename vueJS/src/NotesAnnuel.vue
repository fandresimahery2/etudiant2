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
      <div v-if="etudiant">
        <strong>ETU:</strong> {{ etudiant.ETU }}<br>
        <strong>Nom:</strong> {{ etudiant.nom }}<br>
        <strong>Prénom:</strong> {{ etudiant.prenom }}<br>
        <strong>Date de naissance:</strong> {{ etudiant.dtn }}<br>
        <strong>Option:</strong> {{ $route.params.option }}<br>
      </div>
      <p>Année : {{ $route.params.annee === '1' ? 'L1' : 'L2' }}</p>
      <table v-if="notes.length">
        <thead>
          <tr>
            <th>Matière</th>
            <th>Note</th>
            <th>Crédit</th>
            <th>Semestre</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="note in notes" :key="note.idNote">
            <td>{{ note.matiere }}</td>
            <td>{{ note.note }}</td>
            <td>{{ note.credit }}</td>
            <td>{{ note.semestre }}</td>
          </tr>
        </tbody>
      </table>
      <p v-if="moyenne !== null"><strong>Moyenne annuelle :</strong> {{ moyenne }}</p>
      <p v-else>Chargement...</p>
    </div>
  </template>
  
