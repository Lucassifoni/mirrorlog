<template>
    <div class="page_home">
        {{ $t('Welcome to the Mirrorlog app') }}
        <hr class="mt-2 mb-2">
        <div v-if="projects.length === 0">
            {{ $t('No projects yet') }}
            <router-link to="/project/new" class="btn">{{ $t('Create your first project') }}</router-link>
        </div>
        <div v-else>
            <strong>{{ $t('Projects') }}</strong>
            <div class="tile"
                @click="$router.push(`/project/${project.id}`)"
                v-for="project in projects" :key="project.id">
            {{ project.name }}<br><time>{{ new Date(project.date_start).toLocaleString($i18n.locale).slice(0, 9) }}</time><br>
            {{ project.optics.length }} optiques / {{ project.optics.reduce((c, a) => a.surfaces.length + c, 0) }} surfaces
            </div>
            <router-link to="/project/new" class="btn">{{ $t('Create another project') }}</router-link>
        </div>
    </div>
</template>

<script>
    import {api_routes} from './../api';

    export default {
        name: 'Home',
        data() {
            return {
                projects: [],
            };
        },
        async mounted() {
            this.projects = await api_get(api_routes.get_projects());
        }
    };
</script>

<style lang="scss">
.tile {
    @apply bg-slate-200 hover:bg-slate-300 cursor-pointer rounded mb-2 p-2 shadow-md;
}
.btn {
    @apply mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white;
}
</style>