<template>
  <div>
    <h1>Frontend Nuxt-vite avec Vuetify</h1>
    <v-btn @click="showMessage()">Click</v-btn>
    <div v-if="active"> Coucou Chouk's je te n'aime ! </div>
  </div>
</template>

<script>
import { ref  } from 'vue'

export default {
  
  setup(){
    const active = ref(false)

    function showMessage() {
      active.value = !active.value
    }

    return {
      active,
      showMessage
    }
  }
}
</script>