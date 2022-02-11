<template>
    <div class="page_home">
        {{ $t('hello') }}
        <hr class="mt-2 mb-2">
        <div v-if="projects.length === 0">
            {{ $t('No projects yet') }}
            <router-link to="/project/new" class="mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white">{{ $t('Create your first project') }}</router-link>
        </div>
        <div v-else>
            {{ projects }}
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