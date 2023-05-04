import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'
import { createVuetify } from 'vuetify'

export default defineNuxtPlugin((nuxtApp) => {
    const vuetify = createVuetify({
      ssr: true, // Detect if SSR is used in order to properly render the application.
    })
    nuxtApp.vueApp.use(vuetify)
})