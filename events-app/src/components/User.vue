<template>
    <nav>
        <router-link to="/infos">Abonnement</router-link> |
        <router-link to="/profil">Profil</router-link> |
        <button @click="logout">Déconnexion</button>
    </nav>

    <div class="infos">
        <div class="profil">
            <h1 id="page">Coordonnées</h1>

            <div v-if="validationMessage" class="validation-message">
                {{ validationMessage }}
            </div>
            
            <div class="name">
                <h2>Nom :</h2>
                <!--<span>Smile</span>-->
                <ul><input type="text" readonly v-model="userInfo.firstName"></ul>
            </div>

            <hr>

            <div class="prenom">
                <h2>Prenom :</h2>
                <!--<span>Smile</span>-->
                <input type="text" readonly v-model="userInfo.lastName">
            </div>

            <hr>

            <div class="societe">
                <h2>Société :</h2>
                <!--<span>Smile</span>-->
                <input type="text" readonly v-model="userInfo.companyName">
            </div>
            
            <hr>

            <div class="adressepostale">
                <h2>Adresse :</h2>
                <!--<span>12 rue de la Tour</span>-->
                <input type="text" readonly v-model="userInfo.companyAddress">
            </div>

            <hr>

            <div class="ville">
                <h2>Ville :</h2>
                <!--<span>Nancy</span>-->
                <input type="text" readonly v-model="userInfo.companyCity">
            </div>

            <hr>
            
            <div class="mail">
                <h2>Adresse Email :</h2>
                <input type="text" readonly v-model="userInfo.email">
            </div>

            <a href="/modif">
                <div class="modif">
                    Modification
                </div>
            </a>

        </div>
    </div>
</template>

<script>
import axios from 'axios';
import store from '@/store';
import Cookies from 'js-cookie'; // Importez le module js-cookie
import router from '@/router';

export default {
  name: 'UserInfos',
  data() {
    return {
      userInfo: {
        email: '',
        firstName: '',
        lastName: '',
        companyName: '', 
        companyAddress: '', 
        companyCity: '', 
        companyPostCode: '',
        validationMessage: '',
      }
    };
  },
  computed: {
    validationMessage() {
      return store.state.validationMessage;
    },
  },
  mounted() {
    // Récupérez le jeton d'authentification depuis le cookie
    const authToken = Cookies.get('authToken');
    
    if (authToken) {
      // Utilisez le jeton d'authentification pour récupérer les données de l'utilisateur
      this.fetchUserData(authToken);
    } else {
      console.error('Aucun jeton d\'authentification trouvé.');
    }
  },
  methods: {
    async fetchUserData() {
      try {
        const authToken = store.state.authToken;
        const response = await axios.get(
          'http://localhost:3000/users/me',
          {
            headers: {
              Authorization: `Bearer ${authToken}`
            }
          }
        );
        const res_comp = await axios.get(
          'http://localhost:3000/companies/me',
          {
            headers: {
              Authorization: `Bearer ${authToken}`
            }
          }
        );

        if (response.status === 200) {
          this.userInfo = response.data.user;
          this.userInfo.companyName = response.data.companyName || '';
          this.userInfo.companyAddress = res_comp.data.companyAddress || '54';
          this.userInfo.companyCity = res_comp.data.companyCity || '68';
          this.userInfo.companyPostCode = res_comp.data.companyPostCode || '87';
        } else {
          console.error('Erreur lors de la récupération des données de l\'utilisateur');
        }
      } catch (error) {
        console.error('Une erreur s\'est produite : ', error);
      }
    },
    logout() {
      // Appelez la mutation de déconnexion pour effacer les données d'utilisateur et le jeton
      store.commit('clearUserData');

      // Redirigez l'utilisateur vers la page de connexion ou une autre page appropriée
      router.push('/connexion'); // Remplacez '/login' par l'URL de votre page de connexion
    },
  }
};
</script>
    
<style lang="scss">

nav {
  text-align: center;
  padding: 30px;
  background: rgba(225,100,20,1.0);

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}

hr{
    margin-bottom: 30px;
}

h2{
    margin-bottom: 15px;
}

.modif{
  margin-top: 50px;
  //margin-left: 46%;
  //width: 160px;
  height: 42px;
  background: rgba(225,100,20,1.0);
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-content: center;
  flex-wrap: wrap;
  font-size: larger;
}
a{
  text-decoration: none;
  color: whitesmoke;
}

.societe, .mail, .adressepostale, .ville{
    padding-top: 10px;
    padding-bottom: 30px;
}

.infos{
    width: 450px;
    margin: 1% auto;
}

#page{
//width: 38%;
//margin: 0 40%;
padding-bottom: 40px;
display: flex;
justify-content: center;
}

.profil{
  width: 100%;
  padding: 30px;
  border: 1px solid #f1f1f1;
  background: #fff;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0.24);
  border-radius: 3%;
}

.validation-message{
  text-align: center;
  color:green;
}
</style>