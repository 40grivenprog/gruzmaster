import { createStore } from 'vuex';

import authModule from './modules/auth/index.js';

const store = createStore({
  modules: {
    auth: authModule
  },
  state() {
  }
});

export default store;
