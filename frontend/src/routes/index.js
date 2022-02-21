import Home from '../pages/Home.vue';
import NewProject from '../pages/NewProject.vue';
import Project from '../pages/Project.vue';

export const routes = [
    {
        path: '/',
        component: Home,
    },
    {
        path: '/project/new',
        component: NewProject,
    },
    {
        path: '/project/:id',
        component: Project,
        props: true,
    }
];