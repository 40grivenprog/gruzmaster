import { createStore } from 'vuex';

import authModule from './modules/auth/index.js';
import membersModule from './modules/members/index.js'

const store = createStore({
  modules: {
    auth: authModule,
    members: membersModule
  },
  state() {
  }
});

export default store;
