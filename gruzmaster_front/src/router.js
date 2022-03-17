import { createRouter, createWebHistory } from 'vue-router';

import NotFound from './pages/NotFound.vue';
import UserAuth from './pages/auth/UserAuth.vue';
import MembersList from './pages/members/MembersList.vue'
import CompaniesList from './pages/companies/CompaniesList.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', redirect: '/auth' },
    { path: '/auth', component: UserAuth, meta: {requiresUnauth: true } },
    { path: '/members', component: MembersList },
    { path: '/companies', component: CompaniesList },
    { path: '/:notFound(.*)', component: NotFound }
  ]
});

export default router;
