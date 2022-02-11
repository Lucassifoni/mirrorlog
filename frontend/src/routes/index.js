import Home from '../pages/Home.vue';
import NewProject from '../pages/NewProject.vue';

export const routes = [
    {
        path: '/',
        component: Home,
    },
    {
        path: '/project/new',
        component: NewProject,
    }
];