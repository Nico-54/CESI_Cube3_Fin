import Vuex from 'vuex';
import Cookies from 'js-cookie'; // Importez le module js-cookie

export default new Vuex.Store({
  state: {
    user: null, // Stocker les données de l'utilisateur
    authToken: Cookies.get('authToken') || null, // Récupérer le jeton à partir des cookies s'il existe
    loginErrorMessage: null,
  },
  mutations: {
    setUser(state, user) {
      state.user = user;
    },
    setAuthToken(state, authToken) {
      state.authToken = authToken;
      // Stockez le jeton dans un cookie avec une date d'expiration (par exemple, 1 jour)
      Cookies.set('authToken', authToken, { expires: 1 }); 
    },
    clearUserData(state) {
      state.user = null;
      state.authToken = null;
      // Supprimez également le cookie du jeton lorsque vous vous déconnectez
      Cookies.remove('authToken');
    }, 
    setLoginErrorMessage(state, message) {
      state.loginErrorMessage = message;
    },
  },
});
