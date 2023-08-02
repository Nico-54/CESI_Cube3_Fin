<template>

    <h1>Formule</h1>
    
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
    
    <div class="form">
        <h2>Formule Amélioration</h2>
    </div>
    
    <div class="prix">
        <h2>Prix:</h2>
        <h2>X €</h2>
    </div>
    
</template>

<script>
export default{
    name: 'FormuleData',
}
</script>
    
<style lang="scss">

.mods{
    margin-top: 50px;
    margin-left: 10px;
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