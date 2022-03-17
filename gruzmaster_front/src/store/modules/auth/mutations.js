export default {
  setUser(state, payload) {
    state.token = payload.token;
    state.userId = payload.userId;
    state.isAdmin = payload.is_admin;
    state.tokenExpiration = payload.tokenExpiration;
  }
};

