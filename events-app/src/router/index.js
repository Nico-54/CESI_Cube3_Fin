import { createRouter, createWebHistory } from 'vue-router'
//import HomeView from '../views/HomeView.vue'
import SignInn from '../views/ConnectView.vue'
import SignUpp from '../views/InscripView.vue'
import All_Devis from '../views/AllFormuleViews.vue'
import UserData from '../views/ProfilViews.vue'
import UserSubs from '../views/InfosView.vue'
import CreateFormule from '../views/FormuleViews.vue'


const routes = [
  {
    path: '/',
    name: 'home',
    component: SignInn
  },
  {
    path: '/infos',
    name: 'infos',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: UserSubs
  },
  {
    path: '/connexion',
    name: 'connexion',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: SignInn
  },
  {
    path: '/inscription',
    name: 'inscription',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: SignUpp
  },
  {
    path: '/facture',
    name: 'facture',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: All_Devis
  },
  {
    path: '/profil',
    name: 'profil',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: UserData
  },
  {
    path: '/formule',
    name: 'formule',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: CreateFormule
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
