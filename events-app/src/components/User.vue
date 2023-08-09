<template>
    <div class="infos">
        <div class="profil">
            <h1 id="page">Coordonnées</h1>
            
            <div class="societe">
                <h2>Société :</h2>
                <span>Smile</span>
            </div>
            
            <hr>
            
            <div class="mail">
                <h2>Adresse Email :</h2>
                <span>smile@smile.com</span>
            </div>

            <hr>

            <div class="phone">
                <h2>Téléphone : </h2>
                <span>0653496378</span>
            </div>

            <div class="modif">
                <a href="#">Modification</a>
            </div>

        </div>
    </div>
</template>

<script>
export default{
    name: 'UserInfos' 
}
</script>
    
<style lang="scss">

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
.modif a{
  text-decoration: none;
  color: whitesmoke;
}

.societe, .mail{
    padding-top: 10px;
    padding-bottom: 30px;
}

.infos{
    width: 450px;
    margin: 0 auto;
    margin-top: 10%;
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
}
</style>