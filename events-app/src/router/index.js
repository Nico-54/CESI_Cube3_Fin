import { createRouter, createWebHistory } from 'vue-router'
//import HomeView from '../views/HomeView.vue'
import SignInn from '../views/ConnectView.vue'
import SignUpp from '../views/InscripView.vue'
import All_Devis from '../views/AllFormuleViews.vue'
import UserData from '../views/ProfilViews.vue'
import UserSubs from '../views/InfosView.vue'
import CreateFormule from '../views/FormuleViews.vue'
import UserModif from '../views/ProfilModif.vue'

import store from '@/store'; // Importez le store Vuex


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
    component: UserSubs, 
    meta: { requiresAuth: true }, // Ajoutez cette méta-information pour indiquer que cette route nécessite une authentification
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
    component: All_Devis,
    meta: { requiresAuth: true }, // Ajoutez cette méta-information pour indiquer que cette route nécessite une authentification
  },
  {
    path: '/profil',
    name: 'profil',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: UserData,
    meta: { requiresAuth: true }, // Ajoutez cette méta-information pour indiquer que cette route nécessite une authentification
  },
  {
    path: '/formule',
    name: 'formule',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: CreateFormule,
    meta: { requiresAuth: true }, // Ajoutez cette méta-information pour indiquer que cette route nécessite une authentification
  },
  {
    path: '/modif',
    name: 'modification',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: UserModif,
    meta: { requiresAuth: true }, // Ajoutez cette méta-information pour indiquer que cette route nécessite une authentification
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

router.beforeEach((to, from, next) => {
  // Vérifiez si la route nécessite une authentification
  if (to.meta.requiresAuth) {
    // Vérifiez si l'utilisateur est authentifié
    if (!store.state.authToken) {
      // utilisateur pas authentifié, direction connexion
      store.commit('setLoginErrorMessage', 'Vous devez être connecté pour accéder à cette page.');
      next('/connexion');
    } else {

      next();
    }
  } else {
    // Si la route ne nécessite pas d'authentification, laissez l'utilisateur passer
    next();
  }
});

export default router
