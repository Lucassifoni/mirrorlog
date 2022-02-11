import { createApp } from 'vue'
import { createRouter, createWebHashHistory } from "vue-router";
import App from './App.vue'
import { routes } from "./routes";
import {fr, en} from "./langs";
import {createI18n} from "vue-i18n";
import "./index.css";

const router = createRouter({
    routes,
    history: createWebHashHistory(),
});

const i18n = createI18n({
    locale: 'en',
    fallbackLocale: 'fr',
    messages: {fr, en}, 
})
createApp(App).use(router).use(i18n).mount('#app')
