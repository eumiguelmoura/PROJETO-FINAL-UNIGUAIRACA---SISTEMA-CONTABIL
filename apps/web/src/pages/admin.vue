<template>
  <q-layout view="lHh Lpr lFf" class="next-app-layout notranslate" translate="no">
    <q-header class="next-app-header">
      <q-toolbar class="next-main-toolbar">
        <q-btn flat dense round icon="menu" @click="drawer = !drawer" aria-label="Abrir menu" class="next-menu-toggle" />
        <div class="next-header-brand" role="img" aria-label="NextContábil">
          <NextBrandMark small />
          <div class="next-brand-name">Next<span>Contábil</span><small>GESTÃO CONTÁBIL E FISCAL</small></div>
        </div>
        <q-space />
        <div class="next-header-user gt-xs" v-if="user">
          <div class="next-avatar"><q-icon name="person_outline" size="21px" /></div>
          <div class="next-user-copy"><strong>{{ user.name }}</strong><span>{{ user.email }}</span></div>
        </div>
        <q-btn flat round icon="logout" class="next-logout" @click="signOut" aria-label="Sair do sistema"><q-tooltip>Sair do sistema</q-tooltip></q-btn>
      </q-toolbar>
    </q-header>

    <q-drawer v-model="drawer" show-if-above bordered :width="278" class="next-sidebar">
      <div class="next-sidebar-inside">
        <div class="next-sidebar-caption">MENU PRINCIPAL</div>
        <q-list class="next-nav-list">
          <q-item clickable v-ripple to="/admin" exact active-class="next-menu-active">
            <q-item-section avatar><q-icon name="grid_view" size="22px" /></q-item-section>
            <q-item-section>Visão geral</q-item-section>
          </q-item>
          <q-item clickable v-ripple to="/admin/entradas" active-class="next-menu-active">
            <q-item-section avatar><q-icon name="description" size="22px" /></q-item-section>
            <q-item-section>Lançamento de notas</q-item-section>
          </q-item>
          <q-item clickable v-ripple to="/admin/apuracoes" exact active-class="next-menu-active">
            <q-item-section avatar><q-icon name="calculate" size="22px" /></q-item-section>
            <q-item-section>Apuração de impostos</q-item-section>
          </q-item>
          <q-item clickable v-ripple to="/admin/apuracoes/historico" active-class="next-menu-active">
            <q-item-section avatar><q-icon name="history" size="22px" /></q-item-section>
            <q-item-section>Histórico de apurações</q-item-section>
          </q-item>
        </q-list>
        <div class="next-sidebar-bottom">
          <div class="next-sidebar-bottom-icon"><q-icon name="verified_user" size="20px" /></div>
          <div><strong>Ambiente protegido</strong><span>NextContábil • Projeto acadêmico</span></div>
        </div>
      </div>
    </q-drawer>
    <q-page-container><router-view /></q-page-container>
  </q-layout>
</template>

<script setup>
import { ref, computed } from 'vue'
import { LocalStorage, Notify } from 'quasar'
import { useRouter } from 'vue-router'
import { api } from 'src/boot/axios'
import NextBrandMark from 'src/components/NextBrandMark.vue'

const router = useRouter()
const drawer = ref(false)
const user = computed(() => LocalStorage.getItem('auth_data')?.user)
async function signOut() {
  try { await api.post('/auth/logout') } catch { /* limpar sessão local mesmo offline */ }
  LocalStorage.remove('auth_data')
  Notify.create('Sessão encerrada')
  await router.replace('/login')
}
</script>
