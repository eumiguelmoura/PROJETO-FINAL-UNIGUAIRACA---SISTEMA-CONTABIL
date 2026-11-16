<template>
  <q-page class="page-wrap next-dashboard q-pa-md q-pa-lg-xl notranslate" translate="no">
    <section class="next-dashboard-hero">
      <div class="next-dashboard-hero-content">
        <span class="next-dashboard-kicker"><q-icon name="auto_awesome" size="16px" /> SEU ESPAÇO DE TRABALHO</span>
        <h1>Bem-vindo ao <span>NextContábil.</span></h1>
        <p>Um jeito mais inteligente de organizar seus lançamentos e acompanhar os impostos.</p>
        <q-btn unelevated no-caps class="next-hero-action" icon-right="arrow_forward" label="Novo lançamento" to="/admin/entradas/nova" />
      </div>
      <div class="next-hero-illustration" aria-hidden="true">
        <div class="next-floating-sheet next-sheet-back"><q-icon name="table_chart" size="47px" /></div>
        <div class="next-floating-sheet next-sheet-front"><q-icon name="description" size="58px" /><div><span></span><span></span><span></span></div></div>
        <div class="next-check-orb"><q-icon name="check" size="27px" /></div>
      </div>
    </section>

    <div class="next-section-heading">
      <div><span class="next-section-eyebrow">MÓDULOS</span><h2>O que você quer fazer hoje?</h2></div>
      <span class="next-section-caption">Selecione uma área para começar</span>
    </div>
    <div class="row q-col-gutter-lg next-module-grid">
      <div class="col-12 col-md-6">
        <q-card flat class="next-module-card cursor-pointer" @click="$router.push('/admin/entradas')">
          <q-card-section class="next-module-content">
            <div class="next-module-top"><div class="next-module-icon next-module-icon--blue"><q-icon name="note_add" size="30px" /></div><span class="next-module-category">GESTÃO DE DOCUMENTOS</span></div>
            <h3>Lançamento de notas</h3>
            <p>Cadastre, consulte e gerencie notas fiscais com cálculo automático de ICMS, IPI e valores totais.</p>
            <div class="next-module-footer"><span>Ver lançamentos</span><span class="next-arrow-circle"><q-icon name="arrow_forward" size="20px" /></span></div>
          </q-card-section>
        </q-card>
      </div>
      <div class="col-12 col-md-6">
        <q-card flat class="next-module-card cursor-pointer" @click="$router.push('/admin/apuracoes')">
          <q-card-section class="next-module-content">
            <div class="next-module-top"><div class="next-module-icon next-module-icon--mint"><q-icon name="calculate" size="30px" /></div><span class="next-module-category">CONTROLE DE TRIBUTOS</span></div>
            <h3>Apuração de impostos</h3>
            <p>Selecione notas, consolide os valores destacados e acompanhe o histórico de apurações.</p>
            <div class="next-module-footer"><span>Ver apurações</span><span class="next-arrow-circle"><q-icon name="arrow_forward" size="20px" /></span></div>
          </q-card-section>
        </q-card>
      </div>
    </div>

    <div class="next-quick-access">
      <div class="next-quick-copy"><q-icon name="bolt" size="20px" /><span><strong>Acesso rápido</strong> · Continue de onde parou</span></div>
      <div class="next-quick-links">
        <q-btn flat no-caps icon="add_circle_outline" label="Nova nota" to="/admin/entradas/nova" />
        <q-btn flat no-caps icon="history" label="Histórico" to="/admin/apuracoes/historico" />
      </div>
    </div>
  </q-page>
</template>
