<script>
import TableMoyennes from './TableMoyennes.vue'
export default {
  name: 'EtudiantDetail',
  components: { TableMoyennes },
  data() {
    return {
      etudiant: null,
      moyennes: { S1: '-', S2: '-', S3: '-', S4: '-' },
      loading: true
    }
  },
  async created() {
    const id = this.$route.params.id;
    try {
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
    } catch (error) {
      console.error('Erreur:', error);
    } finally {
      this.loading = false;
    }
  }
}
</script>

<template>
  <div class="container">
    <!-- En-tête avec retour -->
    <div class="header">
      <router-link to="/" class="back-link">
        ← Retour
      </router-link>
      <h1 class="title">Fiche Étudiant</h1>
    </div>

    <!-- Loading -->
    <div v-if="loading" class="loading-card">
      <div class="spinner"></div>
      <p>Chargement des données...</p>
    </div>

    <!-- Contenu -->
    <div v-else-if="etudiant" class="content">
      <!-- Carte Informations personnelles -->
      <div class="card info-card">
        <div class="card-header">
          <h2>Informations personnelles</h2>
        </div>
        <div class="card-body">
          <div class="info-grid">
            <div class="info-item">
              <span class="info-label">Numéro étudiant</span>
              <span class="info-value highlight">{{ etudiant.ETU }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Nom complet</span>
              <span class="info-value">{{ etudiant.nom }} {{ etudiant.prenom }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Date de naissance</span>
              <span class="info-value">{{ etudiant.dtn }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Option</span>
              <span class="info-value badge">
                {{ etudiant.option === '1' ? 'Développement' : etudiant.option === '2' ? 'Web' : 'Réseaux' }}
              </span>
            </div>
          </div>
        </div>
      </div>

      <!-- Carte Scolarité -->
      <div class="card">
        <div class="card-header">
          <h2>Informations scolarité</h2>
        </div>
        <div class="card-body">
          <div class="info-grid">
            <div class="info-item">
              <span class="info-label">Date d'inscription</span>
              <span class="info-value">{{ etudiant.DateInscription ?? '-' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Semestre d'inscription</span>
              <span class="info-value">{{ etudiant.semestre ?? '-' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Promotion</span>
              <span class="info-value">{{ etudiant.idPromo ?? '-' }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Tableau des moyennes -->
      <div class="card">
        <div class="card-header">
          <h2>Moyennes par semestre</h2>
        </div>
        <div class="card-body">
          <TableMoyennes :moyennes="moyennes" />
        </div>
      </div>

      <!-- Relevés annuels -->
      <div class="card">
        <div class="card-header">
          <h2>Relevés de notes annuels</h2>
        </div>
        <div class="card-body">
          <div class="releve-links">
            <router-link 
              :to="`/notes/annuel/${etudiant.id}/1/${etudiant.option ?? '1'}`"
              class="releve-link"
            >
              <div class="releve-icon">📄</div>
              <div class="releve-content">
                <div class="releve-title">Licence 1</div>
                <div class="releve-subtitle">Semestres S1 et S2</div>
              </div>
              <div class="releve-arrow">→</div>
            </router-link>
            
            <router-link 
              :to="`/notes/annuel/${etudiant.id}/2/${etudiant.option ?? '1'}`"
              class="releve-link"
            >
              <div class="releve-icon">📄</div>
              <div class="releve-content">
                <div class="releve-title">Licence 2</div>
                <div class="releve-subtitle">Semestres S3 et S4</div>
              </div>
              <div class="releve-arrow">→</div>
            </router-link>
          </div>
        </div>
      </div>
    </div>

    <!-- Erreur -->
    <div v-else class="error-card">
      <p>Étudiant introuvable</p>
    </div>
  </div>
</template>

<style scoped>
* {
  box-sizing: border-box;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  background: #fafafa;
  min-height: 100vh;
}

.header {
  margin-bottom: 2rem;
  animation: fadeIn 0.6s ease-in;
}

.back-link {
  display: inline-flex;
  align-items: center;
  color: #666;
  text-decoration: none;
  font-size: 0.95rem;
  margin-bottom: 1rem;
  transition: color 0.2s ease;
}

.back-link:hover {
  color: #4caf50;
}

.title {
  font-size: 2rem;
  font-weight: 700;
  color: #1a1a1a;
  margin: 0;
}

.content {
  display: grid;
  gap: 1.5rem;
  animation: slideUp 0.8s ease-out;
}

.card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.06);
  overflow: hidden;
  border: 1px solid #e8e8e8;
  transition: all 0.3s ease;
}

.card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-header {
  background: white;
  padding: 1.25rem 1.5rem;
  border-bottom: 2px solid #4caf50;
}

.card-header h2 {
  margin: 0;
  color: #1a1a1a;
  font-size: 1.25rem;
  font-weight: 600;
}

.card-body {
  padding: 1.5rem;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.info-label {
  font-size: 0.85rem;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-weight: 500;
}

.info-value {
  font-size: 1.1rem;
  color: #1a1a1a;
  font-weight: 600;
}

.info-value.highlight {
  color: #4caf50;
  font-size: 1.3rem;
}

.badge {
  display: inline-block;
  padding: 0.4rem 1rem;
  background: #f1f8f2;
  border: 1px solid #4caf50;
  border-radius: 20px;
  font-size: 0.95rem !important;
  color: #4caf50 !important;
  font-weight: 600 !important;
}

/* Relevés de notes */
.releve-links {
  display: grid;
  gap: 1rem;
}

.releve-link {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.25rem;
  background: #fafafa;
  border: 2px solid #e0e0e0;
  border-radius: 12px;
  text-decoration: none;
  transition: all 0.3s ease;
}

.releve-link:hover {
  background: #f1f8f2;
  border-color: #4caf50;
  transform: translateX(5px);
}

.releve-icon {
  font-size: 2rem;
}

.releve-content {
  flex: 1;
}

.releve-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: #1a1a1a;
  margin-bottom: 0.25rem;
}

.releve-subtitle {
  font-size: 0.9rem;
  color: #666;
}

.releve-arrow {
  font-size: 1.5rem;
  color: #4caf50;
  transition: transform 0.3s ease;
}

.releve-link:hover .releve-arrow {
  transform: translateX(5px);
}

/* Loading */
.loading-card {
  background: white;
  border-radius: 12px;
  padding: 3rem;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.06);
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

@keyframes spin {
  to { transform: rotate(360deg); }
}

.loading-card p {
  color: #666;
  font-size: 1.1rem;
}

/* Error */
.error-card {
  background: white;
  border-radius: 12px;
  padding: 3rem;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.06);
  border: 2px solid #f44336;
}

.error-card p {
  color: #f44336;
  font-size: 1.1rem;
  font-weight: 600;
}

/* Animations */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive */
@media (max-width: 768px) {
  .container {
    padding: 1rem;
  }

  .title {
    font-size: 1.5rem;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .releve-link {
    padding: 1rem;
  }
}
</style>