<script setup>
import AppMenu from './components/AppMenu.vue';
</script>
 
<template>
  <div class="dev_plate">
    <div class="mobile-like appview_mobile">
      <app-menu></app-menu>
      <router-view></router-view>
    </div>
    <div class="laptop-like appview_laptop">
      <app-menu></app-menu>
      <router-view></router-view>
    </div>
  </div>
</template>

<style lang="scss">
.dev_plate {
  width: 100vw;
  height: 100vh;
  position: fixed;
  left: 0;
  top: 0;
  background: #333;
  display: flex;
  justify-content: space-around;
  align-items: center;

  .mobile-like {
    width: 320px;
    height: 540px;
    background: white;
    overflow-x: hidden;
    overflow-y: scroll;
  }

  .laptop-like {
    width: 800px;
    height: 600px;
    background: white;
    overflow-x: hidden;
    overflow-y: scroll;
  }
}
</style>
