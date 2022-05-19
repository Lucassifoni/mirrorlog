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

export const route_fns = {
    project: id => `/project/${id}`,
    session: (pid, sid) => `${route_fns.project(pid)}/session/${sid}`,
};