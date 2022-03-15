<script>
    import AppMenu from "./components/AppMenu.vue";

    export default {
        name: "RealApp",
        components: {
            AppMenu,
        },
    };
</script>

<template>
<div class="bg-emerald-900 min-h-full p-2 pt-4 relative">
    <app-menu></app-menu>
    <div class="mt-8 rounded bg-white p-4">
        <router-view></router-view>
    </div>
</div>
</template>