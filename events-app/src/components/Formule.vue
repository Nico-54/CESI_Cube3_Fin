<template>

    <nav>
        <router-link to="/infos">Abonnement</router-link> |
        <router-link to="/profil">Profil</router-link> |
        <button @click="logout">Déconnexion</button>
    </nav>

    <h1>Choix de l'abonnement</h1>

    <label for="form">Formule</label>
    <select id="form" name="form">
        <option value="">--Formule--</option>
        <option value="duer">DUER</option>
        <option value="primo">Primo</option>
        <option value="amelioration">Amélioration</option>
        <option value="performance">Performance</option>
        <option value="prevention">Prévention</option>
        <option value="excellence">Excellence</option>
    </select>

    <div class="mods">


        <div class="checkbox">
            <input type="checkbox" id="action" name="action">
            <label for="action">Action</label><br>
    
            <input type="checkbox" id="anomalie" name="anomalie">
            <label for="anomalie">Anomalie</label><br>
    
            <input type="checkbox" id="risque" name="risque">
            <label for="risque">Risque</label><br>
    
            <input type="checkbox" id="accident" name="accident">
            <label for="accident">Accident</label><br>
        </div>
    
        <div class="checkbox2">
            <input type="checkbox" id="echeance" name="echeance">
            <label for="echeance">Echéance</label><br>
    
            <input type="checkbox" id="audit" name="audit">
            <label for="audit">Audit</label><br>
    
            <input type="checkbox" id="signalement" name="signalement">
            <label for="signalement">Signalement</label><br>
    
            <input type="checkbox" id="rps" name="rps">
            <label for="rps">RPS</label>
        </div>
    </div>    

    <br><br>
    
    <div class="prix">
        <h2>Prix:</h2>
        <h2>X €</h2>
    </div>

    <div class="check">
        <input type="checkbox" name="abo" id="abo" checked>Reconduite tacite de l'abonnement. A décocher pour le désactiver
    </div>
    
</template>

<script>
import store from '@/store';
import router from '@/router';
import axios from 'axios';
import Cookies from 'js-cookie'; // Importez le module js-cookie

export default{
    name: 'FormuleData',
    data() {
    return {
      formulaInfo: {
 
      }
    };
  },
    mounted() {
    // Récupérez le jeton d'authentification depuis le cookie
    const authToken = Cookies.get('authToken');
    
    if (authToken) {
      // Utilisez le jeton d'authentification pour récupérer les données de l'utilisateur
      this.fetchFormulaData(authToken);
    } else {
      console.error('Aucun jeton d\'authentification trouvé.');
    }
  },
    methods: {
        async fetchFormulaData() {
      try {
        const authToken = store.state.authToken;
        const response = await axios.get(
          'http://localhost:3000/formulas',
          {
            headers: {
              Authorization: `Bearer ${authToken}`
            }
          }
        );

        if (response.status === 200) {
          this.formulaInfo = response.data.formulas;
          console.log(this.formulaInfo);
        } else {
          console.error('Erreur lors de la récupération des données des formules');
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

document.addEventListener("DOMContentLoaded", function() {
                var select = document.getElementById('form');

                /* Déclaration des checkbox pour le switch */
                var checkboxes = document.querySelectorAll('input[type="checkbox"]');
                var actionCheckbox = document.getElementById('action');
                var auditCheckbox = document.getElementById('audit');
                var signalementCheckbox = document.getElementById('signalement');
                var echeanceCheckbox = document.getElementById('echeance');
                var accidentCheckbox = document.getElementById('accident');
                var risqueCheckbox = document.getElementById('risque');
                //var anomalieCheckbox = document.getElementById('anomalie');
                var aboCheckbox = document.getElementById('abo');
                

                select.addEventListener('change', function() {
                    var selectedOption = select.options[select.selectedIndex].value;

                    switch (selectedOption) {
                        case 'duer':

                            console.log(selectedOption);
                            break;

                        case 'primo':

                            console.log(selectedOption);
                            break;

                        case 'amelioration':

                            actionCheckbox.checked = true;
                            //this.formulaInfo.message = 'Un autre module au choix';

                            console.log(selectedOption);
                            break;

                        case 'performance':

                            actionCheckbox.checked = true;
                            auditCheckbox.checked = true;
                            signalementCheckbox.checked = true;


                            console.log(selectedOption);
                            break;

                        case 'prevention':

                            actionCheckbox.checked = true;
                            risqueCheckbox.checked = true;
                            signalementCheckbox.checked = true;
                            accidentCheckbox.checked = true;
                            echeanceCheckbox.checked = true;

                            console.log(selectedOption);
                            break;

                        case 'excellence':
                            console.log(selectedOption);

                            checkboxes.forEach(function(checkbox) {
                                if (checkbox !== aboCheckbox) {
                                    checkbox.checked = true;
                                }
                            });
                            break;

                        default:
                            console.log('Nothing_select');

                            checkboxes.forEach(function(checkbox) {
                                if (checkbox !== aboCheckbox) {
                                    checkbox.checked = false;
                                }
                                });
                            break;
                    }
                });
            });
</script>
    
<style lang="scss">

.mods{
    margin-top: 50px;
    margin-left: 10px;
    margin-bottom: 60px;
}

.checkbox{
    float: left;
}

.checkbox2{
    margin-left: 150px;
    float: left
}

.form{
    margin-top: 170px;
    margin-left: 10px;
}

.prix{
    margin-top: 50px;
    margin-left: 10px;
}

</style>