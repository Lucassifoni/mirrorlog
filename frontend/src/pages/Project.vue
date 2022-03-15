<template>
    <div v-if="project">
        <div class="breadcrumb"><router-link :to="'/'">{{ $t('Projects') }}</router-link> &gt; <span>{{project.name}}</span></div>
        {{ $t('Started on' ) }} {{ new Date(project.date_start).toLocaleString($i18n.locale).slice(0, 9) }}
        
        <hr>

        <strong>{{ $t('Surfaces') }}</strong>
        
        <table>
            <thead>
                <th>{{ $t('Optic') }}</th><th>{{ $t('Radius') }}</th><th>{{ $t('Conic') }}</th><th>{{ $t('Session count') }}</th><th>{{ $t('Actions') }}</th>
            </thead>
            <tr v-for="surface in computed_surfaces">
                <td>{{ surface.optic.name }}</td>
                <td>{{ surface.surface.radius }}</td>
                <td>{{ surface.surface.conic }}</td>
                <td>{{ surface.surface.sessions.length }}</td>
                <td><button>{{ $t('+ session') }}</button></td>
            </tr>
        </table>

        <div>
            <button class="btn">{{ $t('Add an optic to the project') }}</button>
        </div>

        <hr>

        <div>
            <button class="btn" v-for="o in project.optics">{{ $t('Add a surface to optic') }} &laquo; {{ o.name }} &raquo;</button>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            project: null,
        };
    },
    props: {
        id: {},
    },
    computed: {
        computed_surfaces() {
            if (!this.project) return [];
            return this.project.optics.reduce((out, o) => {
                out.push(...o.surfaces.map(s => ({ glass: o.glass, optic: {...o, surfaces: []}, surface: s })));
                return out;
            }, []);
        },
    },
    async mounted() {
        this.project = await (await (fetch(`/api/project/${this.id}`))).json();
    }
};
</script>

<style></style>