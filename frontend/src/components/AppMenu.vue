<template>
    <nav class="flex bg-white shadow-xl absolute w-full left-0 top-0 p-2 items-center">
        <img src="/images/Logo.svg" class="w-6 mr-2" alt=""> 
        <h1 class="font-bold">Mirror Log</h1>
        <div class="ml-auto">
            <select v-model="$i18n.locale">
              <option v-for="locale in $i18n.availableLocales" :key="`locale-${locale}`" :value="locale">{{ locale }}</option>
            </select>
        </div>
    </nav> 
</template>