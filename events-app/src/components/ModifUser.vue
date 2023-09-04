<template>
  <nav>
      <router-link to="/infos">Abonnement</router-link> |
      <router-link to="/profil">Profil</router-link> |
      <button @click="logout">Déconnexion</button>
  </nav>

  <div class="infos">
      <div class="profil">
          <h1 id="page">Modifications</h1>
          
          <div class="datas-container">
            <div class="datas">

              <div class="name">
                  <h2>Nom :</h2>
                  <!--<span>Smile</span>-->
                  <ul><input type="text" v-model="userInfo.firstName"></ul>
              </div>

              <hr>

              <div class="prenom">
                  <h2>Prenom :</h2>
                  <!--<span>Smile</span>-->
                  <input type="text" v-model="userInfo.lastName">
              </div>

              <hr>

              <div class="mail">
                  <h2>Adresse Email :</h2>
                  <input type="text" v-model="userInfo.email">
              </div>

            </div>


          <div class="datas">

            <div class="societe">
                <h2>Société :</h2>
                <!--<span>Smile</span>-->
                <input type="text" v-model="userInfo.companyName">
            </div>

            <hr>

            <div class="adressepostale">
                <h2>Adresse :</h2>
                <!--<span>12 rue de la Tour</span>-->
                <input type="text" v-model="userInfo.companyAddress">
            </div>

            <hr>

            <div class="ville">
                <h2>Ville :</h2>
                <!--<span>Nancy</span>-->
                <input type="text" v-model="userInfo.companyCity">
            </div>

          </div>  
        </div>

        <hr id="separate">

        <div class="button">
          <input class="validation" type="submit" value="Valider" v-on:click="modification">

          <a href="/profil">
              <div class="return">
                  Retour
              </div>
          </a>
        </div>

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
        'http://localhost:3000/company/me',
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
  async modification() {
    try {
      const authToken = store.state.authToken;
      
      // Les données que vous souhaitez envoyer à l'API
      const modifiedData = {
        email: this.userInfo.email.trim(),
        firstName: this.userInfo.firstName.trim(),
        lastName: this.userInfo.lastName.trim(),
        companyName: this.userInfo.companyName.trim(),
        companyAddress: this.userInfo.companyAddress.trim(),
        companyCity: this.userInfo.companyCity.trim(),
        companyPostCode: this.userInfo.companyPostCode.trim()
      };
      
      // Faites la requête à votre route API de modification
      const response = await axios.patch(
        'http://localhost:3000/users/me', // Modification
        modifiedData,
        {
          headers: {
            Authorization: `Bearer ${authToken}`
          }
        }
      );

      if (response.status === 200) {
        // La modification a réussi, vous pouvez faire quelque chose ici, comme afficher un message de succès.
        console.log('Modification réussie');
        store.commit('setValidationMessage', 'Modification réussie');
        router.push('/profil')
      } else {
        console.error('Erreur lors de la modification des données de l\'utilisateur');
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
  margin-bottom: 10px;
}

#separate{
  margin: 30px;
}

h2{
  margin-bottom: 15px;
}

.return{
margin-top: 30px;
width: 50%;
height: 42px;
background: rgba(222,222,222,1.0);
border-radius: 5px;
display: flex;
justify-content: center;
align-content: center;
flex-wrap: wrap;
font-size: larger;
margin-left: 25%;
}
.button a{
text-decoration: none;
color: black;
}

.societe, .mail, .adressepostale, .ville, .prenom, .name{
  text-align: center;
}

.infos{
  width: 1160px;
  margin: 5% auto;
}

#page{
padding-bottom: 60px;
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

.datas-container {
  display: flex;
  flex-direction: row; /* Les divs .datas seront placées côte à côte */
  justify-content: space-between; /* Pour espacer les divs horizontalement */
  align-items: center; /* Pour aligner verticalement le contenu des divs */
  gap: 100px;
}

.datas {
  flex: 1; /* Pour que chaque div .datas occupe une part égale de l'espace disponible */
}

input[type=text]{
  text-align: center;
}
input[type=submit]{
  width: 50%;
  margin-left: 25%;
  font-size: larger;
}
</style>