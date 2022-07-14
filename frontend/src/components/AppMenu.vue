<script setup>
import { ref } from 'vue';

const open = ref(false);
const toggleMenu = () => {
    open.value = !open.value;
};
</script>

<template>
    <nav class="flex bg-white shadow-xl absolute w-full left-0 top-0 p-2 items-center z-10">
        <img src="/images/Logo.svg" class="w-6 mr-2" alt=""> 
        <h1 class="font-bold">Mirror Log</h1>
        <button class="m-auto btn" @click="toggleMenu">Menu</button>
        <div class="ml-auto">
            <select v-model="$i18n.locale">
              <option v-for="locale in $i18n.availableLocales" :key="`locale-${locale}`" :value="locale">{{ locale }}</option>
            </select>
        </div>
    </nav> 

    <div class="menu" :class="{open}">
        <h3>Base de données</h3>
        <ul>
            <li>
                Tous les projets
            </li>
            <li>
                Toutes les pièces optiques
            </li>
            <li>
                Toutes les surfaces
            </li>
            <li>
                Tous les outils
            </li>
            <li>
                Toutes les courses
            </li>
            <li>
                Toutes les notes prises
            </li>
        </ul>
    </div>
</template>

<style lang="css">
.menu {
    width: 100%;
    max-width: 290px;
    background: white;
    box-shadow: 0 5px 10px rgba(0,0,0,0.45);
    position: absolute;
    left: 0;
    top: 50px;
    height: calc(100% - 60px);
    padding: 16px;
    transform: translateX(-100%);
    transition: transform 0.3s;
}
.menu.open {
    transform: translateX(0%);
}
</style>