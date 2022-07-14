<template>
    <div class="page page_sessioneditor">
        <div v-if="project && session">
            <h3>Saisir une session de travail pour le projet {{ project.name }}</h3>
            <h4>Paramètres visés :</h4>
            <ul>
                <li>ROC : {{ session.surface.radius }}</li>
                <li>Conique : {{ session.surface.conic }}</li>
            </ul>
            <hr>
            <ul>
            <li>
                Type de travail :
                <select v-model="session.type">
                    <option value="">Ébauchage</option>
                    <option value="">Réunissage</option>
                    <option value="">Doucissage</option>
                    <option value="">Polissage</option>
                    <option value="">Mise en forme</option>
                </select>
            </li>
            <li>Date de démarrage : 
            <input type="date" v-model="session.date_start" /></li>
            <li>Durée en minutes : 
                <input type="number" v-model="session.duration" />
            </li>
            <li>But souhaité ? (facultatif)
                <textarea v-model="session.goal"></textarea>
            </li>
            <li>Commentaires ? (facultatif)
                <textarea v-model="session.short_note"></textarea>
            </li>
            <li>Résultat ?
                <textarea v-model="session.outcome"></textarea>
            </li>
            <hr>
            <h4>Paramètres à la fin de la session précédente</h4>
            <p>Si vous avez fait des sessions sans les noter, il est encore temps de modifier ces valeurs ;-).</p>
            <ul>
                <li>
                    ROC : <input type="number" v-model="session.start_roc" />
                </li>
                <li>
                    Conique :  <input type="number" v-model="session.start_conic" />
                </li>
                <li>
                    Écart P/V à lambda :  <input type="number" v-model="session.start_pv" /><br>
                    (Pour 1/8L, écrivez 0.125)
                </li>
            </ul>
            </ul>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, computed, useAttrs } from "vue";
import { api_routes } from "../api";
import { api_get } from "../utils";

const props = defineProps({
    project_id: {
        type: Number,
        required: true,
    },
    session_id: {
        type: Number,
        required: true,
    },
});

const attrs = useAttrs();
const project = ref(null);
const session = ref(null);
const initializeSessionStartValues = (session) => {
    if (session.previous_session) {
        if (session.previous_session.end_roc)
            session.start_roc = session.previous_session.end_roc;
        if (session.previous_session.end_conic)
            session.start_conic = session.previous_session.end_conic;
        if (session.previous_session.end_pv)
            session.start_pv = session.previous_session.end_pv;
        if (session.previous_session.tool)
            session.tool = {id: session.previous_session.tool.id};
    }
}
onMounted(async () => {
    session.value = await api_get(api_routes.get_session(props.session_id));
    project.value = await api_get(api_routes.get_project(props.project_id));
    initializeSessionStartValues(session.value);
});
</script>
