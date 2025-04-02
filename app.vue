<template>
  <NuxtPage :page-key="route => route.fullPath" />
</template>

<script setup lang="ts">
useHead({
  title: "Aerztekasse Demo App"
});
</script>

<style>
body {
  font-family: "Nunito Sans", sans-serif;
}

.sz-green-dark {
  color: #658415;
}

.sz-green-light {
  color: #8ca71f;
}
</style>