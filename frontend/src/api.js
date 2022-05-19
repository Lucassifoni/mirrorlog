export const api_routes = {
    get_project: id => `/api/project/${id}`,
    get_projects: () => `/api/projects`,
    create_session: (pid, sid) => `/api/project/${pid}/surface/${sid}/add_session`,
    project_wizard: () => '/api/project_wizard',
}