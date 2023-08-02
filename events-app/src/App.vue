<template>
  <!--<SignIn />-->
  <RouterView/>
</template>

<style lang="scss">
$navbarColor : rgba(225,100,20,1.0);
$backColor : rgba(232,182,173,1.0);

*,
::before,
::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body{
  background: $backColor;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  //text-align: center;
  color: black;
}

</style>
