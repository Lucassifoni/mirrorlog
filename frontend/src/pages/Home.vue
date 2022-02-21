<template>
    <div class="page_home">
        {{ $t('hello') }}
        <hr class="mt-2 mb-2">
        <div v-if="projects.length === 0">
            {{ $t('No projects yet') }}
            <router-link to="/project/new" class="mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white">{{ $t('Create your first project') }}</router-link>
        </div>
        <div v-else>
            {{ $t('Projects') }}
            <div class="bg-slate-200 hover:bg-slate-300 cursor-pointer rounded mb-2 p-2 shadow-md"
                @click="$router.push(`/project/${project.id}`)"
                v-for="project in projects" :key="project.id">
            {{ project.name }}<br><time>{{ project.date_start.slice(0, 10) }}</time>
            {{ project.optics.length }} optiques<br>
            {{ project.optics.reduce((c, a) => a.surfaces.length + c, 0) }} surfaces
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Home',
        data() {
            return {
                projects: [],
            };
        },
        async mounted() {
            this.projects = await (await (fetch('/api/projects'))).json();
        }
    };
</script>

<style lang="scss">

</style>