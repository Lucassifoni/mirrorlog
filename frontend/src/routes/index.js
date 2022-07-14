import Home from '../pages/Home.vue';
import NewProject from '../pages/NewProject.vue';
import Project from '../pages/Project.vue';
import SessionEditor from '../pages/SessionEditor.vue';

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
    },
    {
        path: '/project/:project_id/session/:session_id',
        component: SessionEditor,
        props: true,
    }
];

export const route_fns = {
    project: id => `/project/${id}`,
    session: (pid, sid) => `${route_fns.project(pid)}/session/${sid}`,
};