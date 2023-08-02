<template>
    <div class="test">
      <div class="about">
        <div class="bord">
          <h1>Formule Amélioration :</h1>
          <h2>Module Action / Accident</h2>
        </div>
      </div>
  
      <div class="about2">
        <div class="bord2">
          <h1>Prix :</h1>
          <h2>X €</h2>
        </div>
      </div>
    </div>
  
    <div class="facture">
      <h1>Dernières Factures</h1>
      <div class="doc">
        <h2>facture.pdf</h2>
        <h2>facture.csv</h2>
      </div>
  
      <div class="all">
        <a href="/facture">Toutes les factures</a>
      </div>
    </div>
  
    <div class="formule">
      <a href="#">Modifier ma formule</a>
    </div>
</template>

<script>
export default{
    name: 'SubsInfos'
}
</script>
  
<style lang="scss">
$backTest: green;

.formule{
  margin-top: 50px;
  margin-left: 46%;
  width: 160px;
  height: 42px;
  background: blue;
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
  margin-left: 46%;
  width: 160px;
  height: 42px;
  background: blue;
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
  margin-top: 100px;
  background: $backTest;
  text-align: center;
}

.doc{
  margin-top: 20px;
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
    //box-shadow: 0 0 20px 0 rgba(0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0.24);
}

.bord2 h2, .bord h2{
  margin-top: 10px;
}


</style>