import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
import Semestres from './Semestres.vue'
import Etudiants from './Etudiants.vue'

const routes = [
  { path: '/', component: Semestres },
  { name: 'Etudiants', path: '/etudiants/:semestre/:option', component: Etudiants }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

createApp(App).use(router).mount('#app')