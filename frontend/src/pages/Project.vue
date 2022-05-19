<template>
    <div v-if="project">
        <div class="breadcrumb"><router-link :to="'/'">{{ $t('Projects') }}</router-link> &gt; <span>{{project.name}}</span></div>
        {{ $t('Started on' ) }} {{ new Date(project.date_start).toLocaleString($i18n.locale).slice(0, 9) }}
        
        <hr>

        <strong>{{ $t('Surfaces') }}</strong>
        
        <table class="w-full">
            <thead>
                <th>{{ $t('Optic') }}</th><th>{{ $t('Radius') }}</th><th>{{ $t('Conic') }}</th><th>{{ $t('Session count') }}</th><th>{{ $t('Actions') }}</th>
            </thead>
            <tr v-for="(surface, index) in computed_surfaces">
                <td>#{{index}} {{ surface.optic.name }}</td>
                <td>{{ surface.surface.radius }}</td>
                <td>{{ surface.surface.conic }}</td>
                <td>{{ surface.surface.sessions.length }}</td>
                <td><button class="btn" @click="add_session(surface.surface)">{{ $t('+ session') }}</button></td>
            </tr>
        </table>

        <div>
            <button class="btn" v-if="total_sessions > 0" @click="go_to_last_session">{{ $t('Go to last session') }}</button>
            <button class="btn">{{ $t('Add an optic to the project') }}</button>
        </div>

        <hr>

        <div>
            <button class="btn" v-for="o in project.optics">{{ $t('Add a surface to optic') }} &laquo; {{ o.name }} &raquo;</button>
        </div>
    </div>
</template>

<script>
import {api_get, api_post} from "./../utils";
import {route_fns} from './../routes';
import {api_routes} from './../api';

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
        total_sessions() {
            return this.computed_surfaces.reduce((out, cs) => out += cs.surface.sessions.length, 0);
        },
    },
    methods: {
        go_to_last_session() {
            
        },
        async add_session(surface) {
            const new_session = await api_post(api_routes.create_session(this.id, surface.id));
            this.$router.push(route_fns.session(this.id, new_session.id));
        },
    },
    async mounted() {
        this.project = await api_get(api_routes.get_project(this.id));
    }
};
</script>

<style></style>