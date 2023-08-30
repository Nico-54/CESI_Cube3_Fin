<template>
  <img class="logo" src="../assets/mp-logo.png" alt="Vue logo">

  <div class="connexion">
      <div class="oui">
          <h1>Connexion</h1>

          <div class="inputbox">
            <label>Adresse mail</label>
            <input placeholder="Email" type="email" v-model="email"/>
          </div>

          <div class="inputbox">    
            <label>Mot de passe</label>
            <input placeholder="Mot de passe" type="password" v-model="password" minlength="8"/>
          </div>

          <input type="submit" value="Connexion" v-on:click="login">

          <br><br>

          <span style="color:red; font-size: small;">{{ error }}</span>

          <div v-if="errorMessage" class="error-message">
                {{ errorMessage }}
          </div>
      </div>
</div>

<div class="sub">
  <h2>Nouvel utilisateur ?</h2>
  <a href="/inscription">Inscription</a>
</div>
</template>

<script>
import axios from 'axios';
import store from '@/store';


export default{
  name: 'SignIn',
  data()
  {
    return{
      email:'',
      password:'', 
      error: '',
    }
  }, 
  computed: {
    errorMessage() {
      return store.state.errorMessage;
    },
  },
  methods:{
    async login() {
    // Validation des données côté client
    if (!this.email || !this.password) {
      //console.error("Veuillez remplir tous les champs.");
      this.error = "Veuillez remplir tous les champs.";
      return;
    }
    if (this.password.length < 8){
      this.error = "Mot de passe trop court.";
      return;
    }

    // Validation et nettoyage côté serveur
    const cleanedEmail = this.email.trim();
    const cleanedPassword = this.password;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(cleanedEmail)) {
      this.error = "Adresse e-mail invalide. Veuillez entrer une adresse e-mail valide.";
      return;
    }

    try {
    const response = await axios.post( // Utilisez axios.post au lieu de axios.get
      `http://localhost:3000/users/login`, // Utilisez le chemin complet de l'API
      {
        email: cleanedEmail,
        pwd: cleanedPassword
      }
    );

    if (response.status === 200 && response.data.user && response.data.authToken) {
      // Vous pouvez maintenant accéder aux données de l'utilisateur et au jeton d'authentification
      store.commit('setUser', response.data.user);
      store.commit('setAuthToken', response.data.authToken);
      
      console.log('Données de l\'utilisateur :', response.data.user);
      // Puis redirigez l'utilisateur vers la page de profil
      this.$router.push({ name: 'profil' });
    } else {
      this.error = "Identifiants incorrects.";
    }
  } catch (error) {
    this.error = "Une erreur s'est produite : " + error;
  }
}
}
}

</script>

<style lang="scss">

.logo{
  width: 100px;
  margin: 0 47%;
  //margin: 0 900px;
}

.connexion{
width: 400px;
margin: 0 auto;
margin-top: 5%;
}

.connexion h1{
width: 38%;
margin: 0 90px;
padding-bottom: 30px;
}

.oui{
width: 100%;
padding: 30px;
border: 1px solid #f1f1f1;
background: #fff;
box-shadow: 0 0 20px 0 rgba(0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0.24);
}

input[type=email], input[type=password]{
width: 100%;
padding: 12px 20px;
margin: 20px 0 20px;
display: inline-block;
border: 1px solid #ccc;
box-sizing: border-box;
}

input[type=submit]{
background-color: rgba(225, 100, 20, 1.0);
color: white;
padding: 14px 20px;
border: 1px solid;
cursor: pointer;
width: 100%;
border-radius: 10px;
}

input[type=submit]:hover{
background-color: whitesmoke;
color: black;
border: 1px solid rgba(225, 100, 20, 1.0);
}

.inputbox {
padding-top: 10px;
}

.sub{
margin-top: 50px;
margin-left: 46%;
width: 160px;
height: 42px;
display: flex;
justify-content: center;
align-content: center;
flex-wrap: wrap;
}
.sub a{
width: 160px;
height: 42px;
background: blue;
border-radius: 5px;
display: flex;
justify-content: center;
align-content: center;
flex-wrap: wrap;
text-decoration: none;
color: whitesmoke;
}

.error-message{
  text-align: center;
  color: #FF0000;
}
</style>