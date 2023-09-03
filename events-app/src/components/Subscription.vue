<template>
    <nav>
        <router-link to="/infos">Abonnement</router-link> |
        <router-link to="/profil">Profil</router-link> |
        <button @click="logout">Déconnexion</button>
    </nav>

    <div class="test">
      <div class="about">
        <div class="bord">
          <h1>Formule Amélioration :</h1>
          <span>Module Action / Accident</span>
        </div>
      </div>
  
      <div class="about2">
        <div class="bord2">
          <h1>Prix :</h1>
          <span>X €</span>
        </div>
      </div>
    </div>
  
    <div class="facture">
      <h1>Dernières Factures</h1>
      <div class="doc">
        <span><a @click="telechargerPDF" class="pdf">facture.pdf</a></span>
        
        <br>
        <span>facture.csv</span>
      </div>
  
      <div class="buttons">

      <div class="all">
        <a href="/facture">Toutes les factures</a>
      </div>

      <div class="formule">
        <a href="/formule">Modifier ma formule</a>
      </div>

    </div>
    </div>
  
</template>

<script>
import store from '@/store';
import router from '@/router';

export default{
    name: 'SubsInfos',
    methods: {
        logout() {
      // Appelez la mutation de déconnexion pour effacer les données d'utilisateur et le jeton
      store.commit('clearUserData');

      // Redirigez l'utilisateur vers la page de connexion ou une autre page appropriée
      router.push('/connexion');
    },
    telechargerPDF() {
      // Construire le chemin vers le fichier PDF
      const cheminPDF = require('../assets/pdf/architecture.png');

      // Créer un lien invisible vers le fichier PDF
      const lienDeTelechargement = document.createElement('a');
      lienDeTelechargement.href = cheminPDF;

      // Spécifier le nom du fichier lors du téléchargement
      lienDeTelechargement.download = 'facture.pdf';

      // Simuler un clic sur le lien pour déclencher le téléchargement
      lienDeTelechargement.click();
    },
  }
}
</script>
  
<style lang="scss">
$backTest: whitesmoke;

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

.buttons{
  display: flex;
  flex-direction: column;
  align-items: center;
}

.formule{
  margin-top: 50px;
  //margin-left: 46%;
  width: 160px;
  height: 42px;
  background: rgba(225,100,20,1.0);
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-content: center;
  flex-wrap: wrap;
}
.formule a{
  text-decoration: none;
  color: whitesmoke;
}

.all{
  margin-top: 50px;
  //margin-left: 46%;
  width: 160px;
  height: 42px;
  background: rgba(225,100,20,1.0);
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-content: center;
  flex-wrap: wrap;
}
.all a{
  text-decoration: none;
  color: whitesmoke;
}

.facture{
  margin: 150px 700px;
  background: $backTest;
  text-align: center;
  padding: 10px 0;
  width: 600px;
  border-radius: 2%;
}
.pdf{
  text-decoration: none;
  color: black;
  cursor: pointer;
}

.doc{
  margin-top: 20px;
}
.doc span{
  display: block;
  margin-bottom: 10px;
}

.test{
  display: flex;
  justify-content: space-between;
  margin: 60px 150px;
}

.about{
  width: 450px;
  float: left;
}

.bord{
  width: 100%;
    padding: 30px;
    border: 1px solid #f1f1f1;
    background: #fff;
    border-radius: 2%;
    //box-shadow: 0 0 20px 0 rgba(0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0.24);
}

.about2{
  width: 400px;
  float: left;
}

.bord2{
  width: 100%;
    padding: 30px;
    border: 1px solid #f1f1f1;
    background: #fff;
    text-align: center;
    border-radius: 2%;
    //box-shadow: 0 0 20px 0 rgba(0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0.24);
}

.bord2 span, .bord span{
  margin-top: 10px;
  display: block;
}

span{
  font-size: larger;
}


</style>