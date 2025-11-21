<script>
export default {
  name: 'Semestres',
  data() {
    return {
      semestres: ['S1', 'S2', 'S3', 'S4'],
      selectedSemestre: localStorage.getItem('semestre') || null,
      selectedOption: localStorage.getItem('option') || '1'
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
    <div>
      <h2>Liste des semestres</h2>
      <ul>
        <li
          v-for="semestre in semestres"
          :key="semestre"
          :class="{ selected: semestre === selectedSemestre }"
        >
          <router-link
            :to="{ name: 'Etudiants', params: { semestre, option: selectedOption } }"
            @click.native="selectSemestre(semestre)"
          >
            {{ semestre }}
          </router-link>
        </li>
      </ul>
      <select v-model="selectedOption">
        <option value="1">Option 1</option>
        <option value="2">Option 2</option>
      </select>
    </div>
  </template>
  

  
  <style scoped>
  .selected {
    font-weight: bold;
    color: blue;
  }
  </style>