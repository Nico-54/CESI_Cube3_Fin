<template>

    <nav>
        <router-link to="/infos">Abonnement</router-link> |
        <router-link to="/profil">Profil</router-link> |
        <button @click="logout">Déconnexion</button>
    </nav>
    
    <div class="tableau">
        <div class="contenu">  
            <table>
                <thead>
                    <th>Numéro Facture</th>
                    <th>Date</th>
                    <th>Prix Final</th>
                    <th>Etat</th>
                    <th>Formule</th>
                    <th>PDF</th>
                    <th>CSV</th>
                </thead>
                <tbody>
                    <td>15518543154</td>
                    <td>20/05/2023</td>
                    <td>150 €</td>
                    <td>Payé</td>
                    <td>Primo</td>
                    <td>facture.pdf</td>
                    <td>facture.csv</td>
                </tbody>
                <tbody>
                    <td>15518543154</td>
                    <td>20/05/2023</td>
                    <td>150 €</td>
                    <td>Payé</td>
                    <td>Primo</td>
                    <td>facture.pdf</td>
                    <td>facture.csv</td>
                </tbody>
                <tbody>
                    <td>15518543154</td>
                    <td>20/05/2023</td>
                    <td>150 €</td>
                    <td>Payé</td>
                    <td>Primo</td>
                    <td>facture.pdf</td>
                    <td>facture.csv</td>
                </tbody>
                <tbody>
                    <td>15518543154</td>
                    <td>20/05/2023</td>
                    <td>150 €</td>
                    <td>Payé</td>
                    <td>Primo</td>
                    <td>facture.pdf</td>
                    <td>facture.csv</td>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
import store from '@/store';
import router from '@/router';

export default{
    name : 'Table_Devis', 
    methods: {
        logout() {
      // Appelez la mutation de déconnexion pour effacer les données d'utilisateur et le jeton
      store.commit('clearUserData');

      // Redirigez l'utilisateur vers la page de connexion ou une autre page appropriée
      router.push('/connexion'); // Remplacez '/login' par l'URL de votre page de connexion
    },
    }
}
</script>
    
<style lang="scss">
    
.contenu{
    margin: 10% auto;
}
.tableau{
    display: flex;
    flex-direction: column;
}

tbody td {
    padding: 5px 102px;
}

table,
td {
    //border: 1px solid #333;
    text-align: center;
    background: whitesmoke;
}

td, th{
    border: 1px solid #333;
    padding: 10px 50px;
}

thead,
tfoot {
    background-color: #333;
    color: #fff;
}
</style>