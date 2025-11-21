import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
import Semestres from './Semestres.vue'
import Etudiants from './Etudiants.vue'
import ReleveNotes from './ReleveNotes.vue'
import EtudiantDetail from './EtudiantDetail.vue'
import NotesAnnuel from './NotesAnnuel.vue'

const routes = [
  { path: '/', component: Semestres },
  { name: 'Etudiants', path: '/etudiants/:semestre/:option', component: Etudiants },
  { name: 'ReleveNotes', path: '/releve/:idEtudiant/:semestre/:option', component: ReleveNotes }
  { name: 'EtudiantDetail', path: '/etudiant/:id', component: EtudiantDetail },
  { name: 'NotesAnnuel', path: '/notes/annuel/:idEtudiant/:annee/:option', component: NotesAnnuel }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

createApp(App).use(router).mount('#app')