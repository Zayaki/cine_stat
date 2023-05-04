import vuetify from 'vite-plugin-vuetify'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    // ssr: false,
    vite: {
        // Remove/comment if not using ssr | ssr: false
        ssr: {
            noExternal: ['vuetify'],
        },
    },
    modules: [
        async (options, nuxt) => {
            // @ts-ignore
            nuxt.hooks.hook('vite:extendConfig', config => config.plugins.push(
                vuetify()
            ))
        }
    ],
})