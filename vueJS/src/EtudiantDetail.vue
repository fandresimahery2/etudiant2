<script>
import TableMoyennes from './TableMoyennes.vue'
export default {
  name: 'EtudiantDetail',
  components: { TableMoyennes },
  data() {
    return {
      etudiant: null,
      moyennes: { S1: '-', S2: '-', S3: '-', S4: '-' }
    }
  },
  async created() {
    const id = this.$route.params.id;
    // Récupère l'étudiant
    const res = await fetch(`http://localhost:8080/etudiants/${id}`);
    const data = await res.json();
    this.etudiant = data.data;
    if (this.etudiant) {
      for (const semestre of ['S1', 'S2', 'S3', 'S4']) {
        const notesRes = await fetch(`http://localhost:8080/notes/${this.etudiant.id}/${semestre}/${this.etudiant.option ?? '1'}`);
        const notesData = await notesRes.json();
        this.moyennes[semestre] = notesData.meta?.moyenne ?? '-';
      }
    }
  }
}
</script>

<template>
  <div v-if="etudiant">
    <h2>Fiche étudiant</h2>
    <div>
      <strong>ETU:</strong> {{ etudiant.ETU }}<br>
      <strong>Nom:</strong> {{ etudiant.nom }}<br>
      <strong>Prénom:</strong> {{ etudiant.prenom }}<br>
      <strong>Date de naissance:</strong> {{ etudiant.dtn }}<br>
      <strong>Option:</strong> {{ etudiant.option ?? '1' }}<br>
      <strong>Date d'inscription:</strong> {{ etudiant.DateInscription ?? '-' }}<br>
      <strong>Semestre inscription:</strong> {{ etudiant.semestre ?? '-' }}<br>
      <strong>Promotion:</strong> {{ etudiant.idPromo ?? '-' }}
    </div>
    <TableMoyennes :moyennes="moyennes" />
    <div>
      <router-link :to="`/notes/annuel/${etudiant.id}/1/${etudiant.option ?? '1'}`">L1 (S1+S2)</router-link> |
      <router-link :to="`/notes/annuel/${etudiant.id}/2/${etudiant.option ?? '1'}`">L2 (S3+S4)</router-link>
    </div>
  </div>
  <div v-else>
    Chargement...
  </div>
</template>