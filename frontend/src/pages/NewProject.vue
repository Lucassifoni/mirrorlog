<script>
import {api_post} from './../utils';
import {api_routes} from './../api';
import {surface, optic} from '../models';

export default {
    name: "NewProject",
    data() {
        return {
            step: 0,
            current_optic: 0,
            current_surface: 0,
            project: {
                name: '',
                status: 0,
                date_start: (new Date()).toISOString(),
                optics: [optic()],
            },
        }
    },
    methods: {
        async create_project() {
            const r = await api_post(api_routes.project_wizard(), this.project);
            this.$router.push('/');
        },
        add_surface() {
            this.project.optics[this.current_optic].surfaces.push(surface());
            this.current_surface = (this.project.optics[this.current_optic].surfaces.length) - 1;
        },
        add_optic() {
            this.project.optics.push(optic());
            this.current_surface = 0;
            this.current_optic = this.project.optics.length - 1;
            this.step = 1;
        },
    }
}
</script>

<template>
    <div v-if="step === 0">
        <div class="font-slate-400 mb-4 text-xs">{{ $t("1/4 : Project definition") }}</div>
        <div class="mb-2">
            <label class="block font-bold">{{ $t("Project name" )}}</label>
            <input v-model="project.name" class="bg-slate-400" type="text" />
        </div>
        <div class="mb-2">
            <label for="" class="block font-bold">{{ $t("Project status") }}</label>
            <select v-model="project.status" class="bg-slate-400">
                <option :value="0">{{ $t("Started") }}</option>
                <option :value="1">{{ $t("Paused") }}</option>
                <option :value="2">{{ $t("Finished") }}</option>
            </select>    
        </div>
        <div class="mb-2">
            <label class="block font-bold">{{ $t("Project start date" )}}</label>
            <input v-model="project.date_start" class="bg-slate-400" type="date" />
        </div>
        <div class="mt-4">
            <button @click="step = 1" class="mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white">{{ $t("Define this project's optics") }}</button>
        </div>
    </div>
    <div v-else-if="step === 1">
        <div class="font-slate-400 mb-0 text-xs">{{ project.name }}</div>
        <div class="font-slate-400 mb-4 text-xs">{{ $t(`2/4 : Define ${project.optics.length === 1 ? 'at least an' : 'this' } optical piece.`) }}</div>
        <div class="mb-2">
            <label class="block font-bold">{{ $t("Name of this optical piece" )}}</label>
            <input v-model="project.optics[current_optic].name" class="bg-slate-400" type="text" />
        </div>
        <div class="mb-2">
            <label for="" class="block font-bold">{{ $t("Is it a lens or mirror ?") }}</label>
            <select v-model="project.optics[current_optic].type" class="bg-slate-400">
                <option :value="0">{{ $t("Mirror") }}</option>
                <option :value="1">{{ $t("Lens") }}</option>
            </select>    
        </div>
        <div class="mb-2">
            <label for="" class="block font-bold">{{ $t("Do you know the glass type ?") }}</label>
            <input v-model="project.optics[current_optic].glass" class="bg-slate-400" type="text" />
        </div>
        <div class="mb-2">
            <label class="block font-bold">{{ $t("Diameter ?" )}}</label>
            <input v-model="project.optics[current_optic].diameter" class="bg-slate-400" type="number" />
        </div>
        <div class="mb-2">
            <label class="block font-bold">{{ $t("Thickness ?" )}}</label>
            <input v-model="project.optics[current_optic].thickness" class="bg-slate-400" type="number" />
        </div>
        <div class="mt-4">
            <button @click="step = 2" class="mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white">{{ $t("Define the surfaces") }}</button>
        </div>
    </div>
    <div v-else-if="step === 2">
        <div class="font-slate-400 mb-0 text-xs">{{ project.name }} / <select v-model="current_optic"><option v-for="(optic, key) in project.optics" :value="key">{{ optic.name }}</option></select> / <select v-model="current_surface"><option v-for="(surface, key) in project.optics[current_optic].surfaces" :value="key">Surface #{{ key }}</option></select></div>
        <div class="font-slate-400 mb-4 text-xs">{{ $t(`3/4 : Define ${project.optics[current_optic].surfaces.length === 1 ? 'at least a' : 'this' } surface`) }}</div>
        <div class="mb-2">
            <label class="block font-bold">{{ $t("Target Radius of curvature" )}}</label>
            <input v-model="project.optics[current_optic].surfaces[current_surface].radius" class="bg-slate-400" type="number" />
        </div>
        <div class="mb-2">
            <label for="" class="block font-bold">{{ $t("Is it convex or concave ?") }}</label>
            <select v-model="project.optics[current_optic].surfaces[current_surface].type" class="bg-slate-400">
                <option :value="0">{{ $t("Convex") }}</option>
                <option :value="1">{{ $t("Concave") }}</option>
            </select>    
        </div>
        <div class="mb-2">
            <label for="" class="block font-bold">{{ $t("What is the target conic ?") }}</label>
            <input v-model="project.optics[current_optic].surfaces[current_surface].conic" class="bg-slate-400" type="number" />
        </div>
        <div class="mt-4">
            <button @click="create_project" class="mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white">{{ $t("I'm done !") }}</button>
            <button @click="add_surface" class="mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white">{{ $t("Define another surface") }}</button>
            <button @click="add_optic" class="mt-2 block rounded p-2 bg-emerald-900 hover:bg-emerald-700 text-white">{{ $t("Define another optic") }}</button>
        </div>
    </div> 
</template>