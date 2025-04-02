// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  modules: ['@nuxt/content', '@nuxt/fonts', '@nuxt/icon'],
  content: {
    highlight: {
      theme: 'github-light',
      preload: ['java', 'javascript', 'css', 'json']
    }
  },
  icon: {
    serverBundle: {
      collections: ['uil', 'mdi'] // <!--- this
    }
  }
})