import { createStore } from 'vuex';

import authModule from './modules/auth/index.js';
import membersModule from './modules/members/index.js'
import companiesModule from './modules/companies/index.js';

const store = createStore({
  modules: {
    auth: authModule,
    members: membersModule,
    companies: companiesModule
  },
  state() {
  }
});

export default store;
