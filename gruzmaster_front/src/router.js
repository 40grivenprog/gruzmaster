import { createRouter, createWebHistory } from 'vue-router';

import NotFound from './pages/NotFound.vue';
import UserAuth from './pages/auth/UserAuth.vue';
import MembersList from './pages/members/MembersList.vue';
import CompaniesList from './pages/companies/CompaniesList.vue';
import CompanyRegistration from './pages/companies/CompanyRegistration.vue';
import store from './store/index.js'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', redirect: '/auth' },
    { path: '/auth', component: UserAuth, meta: {requiresUnauth: true } },
    { path: '/members', component: MembersList },
    { path: '/companies', component: CompaniesList },
    { path: '/register_company', component: CompanyRegistration, meta: { requiresAdmin: true } },
    { path: '/:notFound(.*)', component: NotFound }
  ]
});

router.beforeEach(function(to, _, next) {
  if (to.meta.requiresAdmin && !store.getters.isAdmin) {
    next('/notFound');
  } else if (to.meta.requiresUnauth && store.getters.isAuthenticated) {
    next('/companies');
  } else {
    next();
  }
})
export default router;
