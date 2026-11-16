<template>
  <span class="next-brand-mark" :class="{ 'next-brand-mark--small': small }" aria-hidden="true">
    <svg viewBox="0 0 52 52" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M15 36V16L37 36V16" stroke="white" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" />
      <circle cx="38" cy="11" r="3.5" fill="#59E4D4" />
    </svg>
  </span>
</template>

<script setup>
defineProps({ small: { type: Boolean, default: false } })
</script>
