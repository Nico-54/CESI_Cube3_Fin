<template>
    <div class="connexion">
        <div class="oui">
            <h1>Inscription</h1>
  
            <div class="inputbox">
                <label>Nom</label>
                <input placeholder="Nom" type="text"/>
            </div>
  
            <div class="inputbox">    
                <label>Prenom</label>
                <input placeholder="Prenom" type="text" />
            </div>
  
            <div class="inputbox">    
                <label>Mot de passe</label>
                <input placeholder="Mot de passe" type="password" />
            </div>
  
            <div class="inputbox">    
                <label>Adresse Mail</label>
                <input placeholder="Email" type="email" />
            </div>
  
            <div class="inputbox">    
                <label>Entreprise</label>
                <input placeholder="Entreprise" type="text" />
            </div>
            
            <input type="checkbox" name="cgv" id="cgv">
            <label for="cgv" class="cgv">En cochant cette case, vous concentez à nos CGV et nos CGU</label>
  
            <input type="submit" value="Inscription">
        
        </div>
    </div>
  </template>

<script>
export default{
    name: 'SignUp'
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
  margin: 0 auto;
  margin-top: 4%;
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