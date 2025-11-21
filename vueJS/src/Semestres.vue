<script>
export default {
  name: 'Semestres',
  data() {
    return {
      semestres: ['S1', 'S2', 'S3', 'S4'],
      selectedSemestre: localStorage.getItem('semestre') || null,
      selectedOption: localStorage.getItem('option') || '1',
      options: [
        { value: '1', label: 'Développement', icon: '💻' },
        { value: '2', label: 'Web', icon: '🌐' },
        { value: '3', label: 'Réseaux', icon: '🔗' }
      ]
    }
  },
  methods: {
    selectSemestre(semestre) {
      this.selectedSemestre = semestre;
      localStorage.setItem('semestre', semestre);
      localStorage.setItem('option', this.selectedOption);
    }
  }
}
</script>

<template>
  <div class="container">
    <div class="header">
      <h1 class="title">Gestion de Scolarité</h1>
      <p class="subtitle">Sélectionnez votre semestre et option</p>
    </div>

    <div class="content">
      <!-- Section Options -->
      <div class="card option-card">
        <div class="card-header">
          <h3>Option d'étude</h3>
        </div>
        <div class="card-body">
          <div class="option-grid">
            <label 
              v-for="option in options" 
              :key="option.value"
              class="option-item"
              :class="{ 'option-active': selectedOption === option.value }"
            >
              <input 
                type="radio" 
                v-model="selectedOption" 
                :value="option.value"
                class="option-radio"
              >
              <div class="option-content">
                <span class="option-icon">{{ option.icon }}</span>
                <span class="option-label">{{ option.label }}</span>
              </div>
            </label>
          </div>
        </div>
      </div>

      <!-- Section Semestres -->
      <div class="card semestre-card">
        <div class="card-header">
          <h3>Semestres disponibles</h3>
        </div>
        <div class="card-body">
          <div class="semestre-grid">
            <router-link
              v-for="semestre in semestres"
              :key="semestre"
              :to="{ name: 'Etudiants', params: { semestre, option: selectedOption } }"
              @click.native="selectSemestre(semestre)"
              class="semestre-item"
              :class="{ 'semestre-active': semestre === selectedSemestre }"
            >
              <div class="semestre-badge">{{ semestre }}</div>
              <div class="semestre-label">Semestre {{ semestre.substring(1) }}</div>
              <div class="semestre-arrow">→</div>
            </router-link>
          </div>
        </div>
      </div>
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
  text-align: center;
  margin-bottom: 3rem;
  animation: fadeIn 0.6s ease-in;
}

.title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 0.5rem;
  letter-spacing: -0.5px;
}

.subtitle {
  font-size: 1.1rem;
  color: #666;
  font-weight: 400;
}

.content {
  display: grid;
  gap: 2rem;
  animation: slideUp 0.8s ease-out;
}

.card {
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 6px rgba(139, 195, 74, 0.08), 0 1px 3px rgba(139, 195, 74, 0.12);
  overflow: hidden;
  transition: all 0.3s ease;
}

.card:hover {
  box-shadow: 0 8px 12px rgba(139, 195, 74, 0.12), 0 2px 6px rgba(139, 195, 74, 0.16);
  transform: translateY(-2px);
}

.card-header {
  background: linear-gradient(135deg, #4caf50 0%, #9ccc65 100%);
  padding: 1.5rem;
  border-bottom: 2px solid #7cb342;
}

.card-header h3 {
  margin: 0;
  color: white;
  font-size: 1.3rem;
  font-weight: 600;
  letter-spacing: 0.3px;
}

.card-body {
  padding: 2rem;
}

/* Options Grid */
.option-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
}

.option-item {
  position: relative;
  cursor: pointer;
  display: block;
}

.option-radio {
  position: absolute;
  opacity: 0;
  pointer-events: none;
}

.option-content {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.25rem;
  background: #f5f5f5;
  border: 2px solid #e0e0e0;
  border-radius: 12px;
  transition: all 0.3s ease;
}

.option-content:hover {
  background: #f1f8e9;
  border-color: #c5e1a5;
  transform: translateY(-2px);
}

.option-active .option-content {
  background: linear-gradient(135deg, #e8f5e9 0%, #c5e1a5 100%);
  border-color: #4caf50;
  box-shadow: 0 4px 8px rgba(139, 195, 74, 0.2);
}

.option-icon {
  font-size: 1.8rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.option-label {
  font-size: 1.1rem;
  font-weight: 600;
  color: #2d5016;
}

/* Semestres Grid */
.semestre-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.semestre-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.5rem;
  background: #fafafa;
  border: 2px solid #e0e0e0;
  border-radius: 12px;
  text-decoration: none;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.semestre-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 4px;
  height: 100%;
  background: #4caf50;
  transform: scaleY(0);
  transition: transform 0.3s ease;
}

.semestre-item:hover {
  background: #f1f8e9;
  border-color: #c5e1a5;
  transform: translateX(8px);
}

.semestre-item:hover::before {
  transform: scaleY(1);
}

.semestre-active {
  background: linear-gradient(135deg, #e8f5e9 0%, #c5e1a5 100%);
  border-color: #4caf50;
  box-shadow: 0 4px 8px rgba(139, 195, 74, 0.2);
}

.semestre-active::before {
  transform: scaleY(1);
}

.semestre-badge {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #4caf50 0%, #9ccc65 100%);
  border-radius: 12px;
  color: white;
  font-size: 1.4rem;
  font-weight: 700;
  box-shadow: 0 2px 4px rgba(139, 195, 74, 0.3);
}

.semestre-label {
  flex: 1;
  font-size: 1.1rem;
  font-weight: 600;
  color: #2d5016;
}

.semestre-arrow {
  font-size: 1.5rem;
  color: #4caf50;
  transition: transform 0.3s ease;
}

.semestre-item:hover .semestre-arrow {
  transform: translateX(5px);
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
    font-size: 2rem;
  }

  .option-grid,
  .semestre-grid {
    grid-template-columns: 1fr;
  }

  .semestre-item {
    padding: 1.25rem;
  }

  .semestre-badge {
    width: 50px;
    height: 50px;
    font-size: 1.2rem;
  }
}
</style>