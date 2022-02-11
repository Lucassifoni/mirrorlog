import { createApp } from 'vue'
import { createRouter, createWebHashHistory } from "vue-router";
import App from './App.vue'
import { routes } from "./routes";

const router = createRouter({
    routes,
    history: createWebHashHistory(),
});

createApp(App).use(router).mount('#app')
