<template>
    <div class="connexion">
        <div class="oui">
            <h1>Inscription</h1>
  
            <div class="inputbox">
                <label>Nom</label>
                <input placeholder="Nom" type="text" v-model="name"/>
            </div>
  
            <div class="inputbox">    
                <label>Prenom</label>
                <input placeholder="Prenom" type="text" v-model="prenom" />
            </div>

            <div class="inputbox">    
                <label>Adresse Mail</label>
                <input placeholder="Email" type="email" v-model="email"/>
            </div>
  
            <div class="inputbox">    
                <label>Mot de passe</label>
                <input placeholder="Mot de passe" type="password" v-model="password" minlength="8"/>
            </div>

            <div class="inputbox">    
                <label>Mot de passe - verif</label>
                <input placeholder="Mot de passe" type="password" v-model="passwordVerif" minlength="8"/>
            </div>

            <div class="inputbox">    
                <label>Entreprise</label>
                <input placeholder="Entreprise" type="text" v-model="entreprise"/>
            </div>

            <div class="inputbox">    
                <label>Adresse Postal</label>
                <input placeholder="Adresse" type="text" v-model="adresse"/>
            </div>

            <div class="inputbox">    
                <label>Code Postal</label>
                <input placeholder="Code Postal" type="text" v-model="postal"/>
            </div>

            <div class="inputbox">    
                <label>Ville</label>
                <input placeholder="Ville" type="text" v-model="ville"/>
            </div>
  
            
            
            <input type="checkbox" name="cgv" id="cgv">
            <label for="cgv" class="cgv" required>En cochant cette case, vous consentez à nos CGV et nos CGU</label>

            <br><br>

            <input type="checkbox" name="cookie" id="cookie">
            <label for="cookie" class="cookie" required>En cochant cette case, vous consentez à l'utilisation de cookie</label>

            <input type="submit" value="Inscription" v-on:click="signUp">
<br><br>
            <span style="color:red; font-size: small;">{{ error }}</span>
        
        </div>
    </div>
  </template>

<script>
import axios from 'axios'

export default{
    name: 'SignUp', 
    data()
    {
      return {
        name:'',
        prenom:'',
        password:'',
        passwordVerif:'',
        email:'',
        entreprise:'',
        ville: '',
        adresse: '',
        postal: '',
        error:''
      }
    }, 
    methods:{
      async signUp(){

        if (!this.email || !this.password || !this.passwordVerif || !this.prenom || !this.name || !this.entreprise || !this.ville || !this.adresse || !this.postal) {
        //console.error("Veuillez remplir tous les champs.");
        this.error = "Veuillez remplir tous les champs.";
        return;
      } 
      if (this.password.length < 8){
        this.error = "Mot de passe trop court.";
        return;
      }
      if (this.password !== this.passwordVerif){
        this.error = "Vos mots de passe sont différents";
        return;
      }

      const cleanedEmail = this.email.trim();
      const cleanedName = this.name.trim();
      const cleanedPrenom = this.prenom.trim();
      const cleanedEntreprise = this.entreprise.trim();
      const cleanedVille = this.ville.trim();
      const cleanedAddress = this.adresse.trim();
      const cleanedPostal = this.postal.trim();
      const cleanedPassword = this.password;

      // Validation du numéro de téléphone avec une regex
      /*const phoneRegex = /^(06|09|07)[0-9]{8}$/;
      if (!phoneRegex.test(cleanedTel)) {
        this.error = "Numéro de téléphone invalide. Veuillez entrer un numéro à 10 chiffres commençant par 06 ou 09.";
        return;
      }*/

      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(cleanedEmail)) {
        this.error = "Adresse e-mail invalide. Veuillez entrer une adresse e-mail valide.";
        return;
      }
      
      try{

       const result = await axios.post("http://localhost:3000/users", {
          lastName:cleanedName,
          firstName:cleanedPrenom,
          pwd:cleanedPassword,
          email:cleanedEmail,
          companyName:cleanedEntreprise,
          companyAddress:cleanedAddress,
          companyPostCode:cleanedPostal,
          companyCity:cleanedVille,
        });

        if(result.status==201){
          this.$router.push({name:'connexion'})
        } else {
          this.error = "Erreur d'inscription.";
        }
      }catch(error){
        this.error = "Une erreur s'est produite : ", error;
        console.log(error);
      }
    }
      /*{
        
        console.warn(result);
        if(result.status==201){
          this.$router.push({name:'connexion'})
          localStorage.setItem("user-info", JSON.stringify(result.data))
        }
      }*/
    }
}
</script>
  
<style lang="scss">

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  //text-align: center;
  color: black;
}

.cgv{
  margin-left: 10px;
}

.connexion{
  width: 400px;
  //width: 535px;
  margin: 1% auto;
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

input[type=text], input[type=password], input[type=email]{
  width: 100%;
  padding: 12px 20px;
  margin: 10px 0 20px;
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
</style>