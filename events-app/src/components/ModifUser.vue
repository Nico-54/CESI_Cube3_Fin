<template>
    <nav>
        <router-link to="/infos">Abonnement</router-link> |
        <router-link to="/profil">Profil</router-link>
    </nav>

    <div class="infos">
        <div class="profil">
            <h1 id="page">Coordonnées</h1>
            
            <div class="societe">
                <h2>Société :</h2>
                <!--<span>Smile</span>-->
                <input type="text" v-model="this.userInfo.entreprise">
            </div>
            
            <hr>

            <div class="mdp">
                <h2>Mot de passe :</h2>
                <!--<span>Smile</span>-->
                <input type="text" v-model="this.userInfo.password">
            </div>
            
            <hr>

            <div class="adressepostale">
                <h2>Adresse :</h2>
                <input type="text" v-model="this.userInfo.adresse">
            </div>

            <hr>

            <div class="cp">
                <h2>Code Postal :</h2>
                <input type="text" v-model="this.userInfo.codepostal">
            </div>

            <hr>

            <div class="ville">
                <h2>Ville :</h2>
                <input type="text" v-model="this.userInfo.ville">
            </div>

            <hr>
            
            <div class="mail">
                <h2>Adresse Email :</h2>
                <input type="text" v-model="this.userInfo.email">
            </div>

            <hr>

            <div class="phone">
                <h2>Téléphone : </h2>
                <input type="text" v-model="this.userInfo.phone">
            </div>

            <input type="submit" value="Modification" v-on:click="update">

        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default{
    name: 'UserInfos',
    data() {
    return {
      userInfo: {
        entreprise: '',
        email: '',
        phone: ''
      }
    };
  },
  mounted() {
    const userId = 1; // L'ID de l'utilisateur que vous souhaitez récupérer
    this.fetchUserData(userId);
  },
  methods: {
    fetchUserData(userId) {
      axios.get(`http://localhost:3000/user?id=${userId}`)
      .then(response => { 
        console.log(response.data);
        
        if (Array.isArray(response.data) && response.data.length > 0) {
          this.userInfo = response.data[0]; // Accédez à la première entrée du tableau
        }
      })

      .catch(error => {
        console.error('Erreur lors de la récupération des données de l\'utilisateur:', error);
      });
    }
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

.societe, .mail, .adressepostale, .cp, .ville, .mdp{
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
</style>