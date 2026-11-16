<template>
  <q-layout view="lHh Lpr lFf" class="next-login-layout notranslate" translate="no">
    <q-page-container>
      <q-page class="next-login-page">
        <div class="next-login-shell">
          <section class="next-login-hero" aria-label="Apresentação do NextContábil">
            <div class="next-brand-lockup next-brand-lockup--light">
              <NextBrandMark />
              <div class="next-brand-name">Next<span>Contábil</span><small>GESTÃO CONTÁBIL E FISCAL</small></div>
            </div>

            <div class="next-hero-content">
              <span class="next-eyebrow-light"><q-icon name="auto_awesome" size="17px" /> SIMPLICIDADE PARA OS SEUS NÚMEROS</span>
              <h1>Seu controle fiscal<br /><span>em outro nível.</span></h1>
              <p>Notas fiscais e apuração de impostos em um ambiente claro, organizado e conectado.</p>
              <div class="next-feature-list">
                <div><q-icon name="task_alt" /> Lançamentos com cálculos de ICMS e IPI</div>
                <div><q-icon name="task_alt" /> Organização e consulta das notas fiscais</div>
                <div><q-icon name="task_alt" /> Apuração e histórico em um só lugar</div>
              </div>
            </div>
            <div class="next-hero-footer"><span class="next-glow-dot" /> Projeto acadêmico • Laravel + Quasar + Flutter</div>
            <div class="next-hero-orb next-hero-orb--one" aria-hidden="true"></div>
            <div class="next-hero-orb next-hero-orb--two" aria-hidden="true"></div>
          </section>

          <section class="next-login-form-side">
            <div class="next-mobile-brand next-brand-lockup">
              <NextBrandMark small />
              <div class="next-brand-name">Next<span>Contábil</span></div>
            </div>
            <q-card flat class="next-login-form-card">
              <q-card-section class="q-pa-none">
                <div class="next-login-overline"><span></span> ACESSO À PLATAFORMA</div>
                <h2>Bem-vindo de volta.</h2>
                <p class="next-form-hint">Entre com suas credenciais para continuar.</p>
                <q-form @submit.prevent="login" class="next-login-fields">
                  <div>
                    <label for="next-email" class="next-input-label">E-mail</label>
                    <q-input id="next-email" outlined v-model.trim="username" placeholder="seuemail@empresa.com" type="email" autocomplete="username" :rules="[v => !!v || 'Informe seu e-mail']" bg-color="white">
                      <template #prepend><q-icon name="alternate_email" size="20px" /></template>
                    </q-input>
                  </div>
                  <div>
                    <label for="next-password" class="next-input-label">Senha</label>
                    <q-input id="next-password" outlined v-model="password" placeholder="Informe sua senha" :type="showPassword ? 'text' : 'password'" autocomplete="current-password" :rules="[v => !!v || 'Informe sua senha']" bg-color="white">
                      <template #prepend><q-icon name="lock_outline" size="20px" /></template>
                      <template #append>
                        <q-btn flat dense round :icon="showPassword ? 'visibility_off' : 'visibility'" :aria-label="showPassword ? 'Ocultar senha' : 'Mostrar senha'" @click="showPassword = !showPassword" />
                      </template>
                    </q-input>
                  </div>
                  <q-banner v-if="error" class="next-error-banner" rounded><q-icon name="error_outline" class="q-mr-sm" />{{ error }}</q-banner>
                  <q-btn type="submit" unelevated no-caps class="next-login-submit full-width" :loading="loading" :disable="loading" label="Acessar NextContábil" icon-right="arrow_forward" />
                </q-form>
              </q-card-section>
            </q-card>
            <p class="next-login-smallprint">Acesso protegido • Ambiente de demonstração acadêmica</p>
          </section>
        </div>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref } from 'vue'
import { LocalStorage } from 'quasar'
import { useRouter } from 'vue-router'
import { api } from 'src/boot/axios'
import NextBrandMark from 'src/components/NextBrandMark.vue'

const router = useRouter()
const username = ref('')
const password = ref('')
const loading = ref(false)
const error = ref('')
const showPassword = ref(false)

async function login() {
  loading.value = true
  error.value = ''
  try {
    const { data } = await api.post('/auth/login', { username: username.value, password: password.value })
    LocalStorage.set('auth_data', data)
    await router.replace('/admin')
  } catch (e) {
    error.value = e.response?.data?.message || 'Não foi possível entrar. Confira seu e-mail e senha.'
  } finally {
    loading.value = false
  }
}
</script>
