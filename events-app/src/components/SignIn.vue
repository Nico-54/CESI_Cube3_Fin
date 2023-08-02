<template>
    <img class="logo" src="../assets/logo.png" alt="Vue logo">

    <div class="connexion">
        <div class="oui">
            <h1>Connexion</h1>

            <div class="inputbox">
              <label>Adresse mail</label>
              <input placeholder="Email" type="email"/>
            </div>

            <div class="inputbox">    
              <label>Mot de passe</label>
              <input placeholder="Mot de passe" type="password" />
            </div>
            <br><br>

            <input type="submit" value="Connexion">

        </div>
  </div>

  <div class="sub">
    <h2>Nouvel utilisateur ?</h2>
    <a href="/inscription">Inscription</a>
  </div>
</template>

<script>
export default{
    name: 'SignIn'
}
</script>

<style lang="scss">

.logo{
    width: 100px;
    margin: 0 47%;
    //margin: 0 900px;
}

.connexion{
  width: 400px;
  margin: 0 auto;
  margin-top: 5%;
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

input[type=email], input[type=password]{
  width: 100%;
  padding: 12px 20px;
  margin: 20px 0 20px;
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

.sub{
  margin-top: 50px;
  margin-left: 46%;
  width: 160px;
  height: 42px;
  display: flex;
  justify-content: center;
  align-content: center;
  flex-wrap: wrap;
}
.sub a{
  width: 160px;
  height: 42px;
  background: blue;
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-content: center;
  flex-wrap: wrap;
  text-decoration: none;
  color: whitesmoke;
}
</style>