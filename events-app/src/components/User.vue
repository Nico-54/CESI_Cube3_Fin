<template>

    <div class="infos">
        <div class="profil">
            <h1 id="page">Profil</h1>
            
            <div class="societe">
                <h1>Société :</h1>
                <h2>Smile</h2>
            </div>
        
            <div class="mail">
                <h1>Adresse Email :</h1>
                <h2>smile@smile.com</h2>
            </div>
    
            <div class="phone">
                <h1>Téléphone : </h1>
                <h2>0653496378</h2>
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

.societe, .mail{
    padding-top: 10px;
    padding-bottom: 60px;
}

.infos{
    width: 450px;
    margin: 0 auto;
    margin-top: 10%;
}

#page{
width: 38%;
margin: 0 40%;
padding-bottom: 30px;
}

.profil{
  width: 100%;
  padding: 30px;
  border: 1px solid #f1f1f1;
  background: #fff;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0.24);
}
</style>