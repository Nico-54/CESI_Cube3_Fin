<template>
    <h1>Toutes les factures</h1>
    
    <div class="tableau">
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
</template>

<script>
export default{
    name : 'Table_Devis'
}
</script>
    
<style lang="scss">
    
.tableau{
    width: 450px;
    margin: 0 auto;
    margin-top: 10%;
}

table,
td {
    border: 1px solid #333;
    text-align: center;
    background: whitesmoke;
}

td, th{
    padding: 20px;
}

thead,
tfoot {
    background-color: #333;
    color: #fff;
}
</style>