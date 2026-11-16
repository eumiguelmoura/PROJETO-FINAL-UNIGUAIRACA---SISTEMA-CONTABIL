# NextContábil — Aplicativo Flutter

**Aluno:** Eloir Miguel Moura Martins  
**Curso:** Tecnologia em Análise e Desenvolvimento de Sistemas (TADS)  
**Instituição:** Centro Universitário UniGuairacá  
**Disciplina:** Programação para Dispositivos Móveis  
**Opção de back-end:** **Opção A — API Laravel**  
**Repositório do projeto integrado:** [GitHub — PROJETO-FINAL-UNIGUAIRACA---SISTEMA-CONTABIL](https://github.com/eumiguelmoura/PROJETO-FINAL-UNIGUAIRACA---SISTEMA-CONTABIL)

## 1. Descrição do aplicativo

O **NextContábil** é um projeto acadêmico que permite lançar e consultar notas fiscais, cadastrar produtos vinculados a cada nota e acompanhar os valores destacados de ICMS e IPI. Também oferece uma área para selecionar notas pendentes e registrar apurações demonstrativas, além de consultar o histórico das apurações realizadas.

O aplicativo móvel é desenvolvido em **Flutter/Dart** e consome uma **API REST criada em Laravel (PHP)**. Os dados são armazenados em um banco **MySQL**, acessado pelo backend. O Flutter não acessa diretamente o banco de dados.

O projeto também possui uma interface web em **Quasar/Vue.js**, que utiliza a mesma API e o mesmo banco. **Não usamos Firebase Firestore** neste aplicativo, pois a opção escolhida para o trabalho é a **A — API Laravel**.

### Funcionalidades principais

- Autenticação com e-mail e senha por meio da API Laravel, usando Laravel Sanctum.
- Tela inicial com acesso aos módulos **Lançamento de Notas** e **Apuração de Impostos**.
- **CRUD completo de notas fiscais:** cadastrar, listar/consultar, editar e excluir.
- Inclusão de vários produtos em uma nota, com SKU, descrição, CFOP, quantidade, preço unitário, ICMS e IPI.
- Cálculo e conferência dos valores dos itens; em operações compatíveis, desconto e base de IPI podem ser inferidos a partir da base do ICMS.
- Seleção de notas pendentes para apuração demonstrativa de impostos.
- Consulta do histórico e dos detalhes das apurações.
- Exibição de estados de carregamento, mensagens de erro e listas vazias.

> **Observação:** a apuração apresentada é didática: soma valores de ICMS e IPI destacados nas notas selecionadas. Não substitui uma apuração fiscal oficial com análise de créditos, débitos, regime tributário e demais regras legais.

## 2. Tecnologias utilizadas

| Tecnologia | Utilização |
| --- | --- |
| Flutter e Dart | Desenvolvimento do aplicativo móvel |
| `go_router` | Navegação e definição das rotas |
| `http` | Consumo da API REST Laravel |
| `flutter_secure_storage` | Armazenamento do token de autenticação |
| `intl` | Formatação de valores monetários e datas |
| Laravel (PHP) | API REST, autenticação e regras de negócio |
| Laravel Sanctum | Proteção dos endpoints autenticados |
| MySQL | Persistência dos dados |
| Docker Compose | Execução do backend e dos serviços locais |
| Quasar / Vue.js | Interface web complementar do projeto integrado |

## 3. Telas e rotas do Flutter

As rotas estão definidas em `lib/core/routes/app_routes.dart` e configuradas em `lib/core/routes/app_router.dart`.

| Rota | Tela | Descrição |
| --- | --- | --- |
| `/login` | Login | Autenticação do usuário |
| `/inicio` | Tela inicial | Acesso aos módulos e opção de sair |
| `/notas` | Lançamento de Notas | Lista das notas, com consulta e exclusão |
| `/notas/nova` | Nova nota | Formulário de cadastro de nota e seus produtos |
| `/notas/:id` | Editar nota | Consulta/edição dos dados da nota selecionada |
| `/apuracoes` | Apuração de Impostos | Seleção das notas pendentes e acesso ao histórico |
| `/apuracoes/:id` | Detalhes da apuração | Totais de ICMS/IPI e notas relacionadas |

> Na rota `:id`, o trecho representa o identificador da nota ou da apuração; por exemplo, `/notas/1`.

## 4. Integração com a API Laravel — Opção A

O aplicativo utiliza o pacote **`http`** para enviar e receber dados JSON da API. A comunicação está organizada em `lib/services/`, com os serviços `api_client.dart`, `auth_service.dart`, `invoice_service.dart` e `tax_assessment_service.dart`.

Os endpoints utilizados pelo app incluem:

| Método | Endpoint | Finalidade |
| --- | --- | --- |
| `POST` | `/api/auth/login` | Entrar no sistema |
| `POST` | `/api/auth/logout` | Sair do sistema |
| `GET` | `/api/invoices` | Listar notas |
| `GET` | `/api/invoices/{id}` | Consultar nota específica |
| `POST` | `/api/invoices` | Cadastrar nota |
| `PUT` | `/api/invoices/{id}` | Atualizar nota |
| `DELETE` | `/api/invoices/{id}` | Excluir nota |
| `GET` | `/api/tax-assessments` | Consultar apurações |
| `GET` | `/api/tax-assessments/{id}` | Detalhar apuração |
| `POST` | `/api/tax-assessments` | Registrar apuração |
| `DELETE` | `/api/tax-assessments/{id}` | Excluir apuração |

Os endpoints protegidos usam o token de autenticação obtido no login. O token fica armazenado no aplicativo usando `flutter_secure_storage`.

## 5. Estrutura do projeto Flutter

```text
apps/mobile/
├── lib/
│   ├── main.dart                # Inicialização do aplicativo
│   ├── app.dart                 # MaterialApp, tema e rotas
│   ├── core/
│   │   ├── constants/          # Textos e constantes
│   │   ├── routes/             # Rotas com go_router
│   │   ├── theme/              # Tema, cores e espaçamentos
│   │   └── utils/              # Validações e formatadores
│   ├── models/                 # Models de notas e apurações
│   ├── services/               # Comunicação HTTP com Laravel
│   ├── screens/
│   │   ├── auth/               # Login
│   │   ├── home/               # Início
│   │   ├── invoices/           # Lista e formulário de notas
│   │   └── assessments/        # Apuração e detalhes
│   └── widgets/                # Componentes reutilizáveis
├── test/                       # Testes do projeto
└── pubspec.yaml                # Dependências do Flutter
```

## 6. Requisitos para executar

- **Docker Desktop** instalado e em execução, para iniciar a API Laravel e o MySQL.
- **Flutter SDK** compatível com o Dart exigido em `pubspec.yaml` (`sdk: ^3.5.0`).
- **Android Studio** com emulador Android configurado, ou um dispositivo Android conectado.
- **VS Code** com extensões Flutter/Dart (opcional).
- Acesso à internet na primeira instalação para baixar imagens e dependências.

## 7. Passo a passo de execução — Windows / PowerShell

### 7.1. Iniciar a API Laravel

No terminal do VS Code, entre na **pasta raiz** `sistema_contabil_unificado` (a que contém `docker-compose.yaml`):

```powershell
cd "C:\Users\eloir\Desktop\sistemacontabil\sistema_contabil_unificado"
```

Na **primeira instalação**, crie o arquivo de ambiente da API, caso ainda não exista:

```powershell
if (!(Test-Path .\apps\api\.env)) {
    Copy-Item .\apps\api\.env.example .\apps\api\.env
}
notepad .\apps\api\.env
```

No arquivo `.env`, configure `SEED_ADMIN_EMAIL` e uma senha forte em `SEED_ADMIN_PASSWORD` (mínimo de 12 caracteres), sem publicar essa senha no GitHub.

Em seguida, com o Docker Desktop aberto:

```powershell
docker compose up -d --build
```

Na primeira instalação, execute também:

```powershell
docker compose exec -u root -e COMPOSER_PROCESS_TIMEOUT=1200 php composer install --prefer-dist --no-progress
docker compose exec php php artisan key:generate
docker compose exec php php artisan migrate --force
docker compose exec php php artisan db:seed --force
```

Confirme se os contêineres estão funcionando:

```powershell
docker compose ps
```

Teste a API abrindo **http://localhost:8182/api/health**. Ela deve responder com um JSON semelhante a `{"status":"ok"}`.

> **Nas próximas execuções:** basta iniciar o Docker Desktop, abrir um terminal na pasta raiz e executar `docker compose up -d`. Não é necessário repetir `key:generate` e `db:seed`.

### 7.2. Preparar e executar o Flutter

Em **outro terminal do VS Code**, entre na pasta do aplicativo móvel:

```powershell
cd "C:\Users\eloir\Desktop\sistemacontabil\sistema_contabil_unificado\apps\mobile"
```

Se o pacote ainda não tiver as pastas de plataforma, gere-as uma única vez:

```powershell
flutter create --platforms=android,ios --project-name sistema_contabil .
```

Instale as dependências e confira os dispositivos disponíveis:

```powershell
flutter pub get
flutter devices
```

Inicie um emulador Android pelo Android Studio e execute:

```powershell
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8182/api
```

**Por que `10.0.2.2`?** No emulador Android, esse endereço aponta para o computador onde a API Laravel está em execução. `localhost`, dentro do emulador, apontaria para o próprio emulador, e não para o Windows.

Se estiver usando um **celular físico**, substitua `10.0.2.2` pelo IP local do computador que executa o backend, com o celular e computador na mesma rede e a porta liberada no firewall. Em ambiente real, prefira HTTPS.

Se o Android bloquear requisições HTTP locais durante o desenvolvimento, pode ser necessário habilitar temporariamente `android:usesCleartextTraffic="true"` na tag `<application>` do arquivo `android/app/src/main/AndroidManifest.xml`. Não mantenha essa configuração em produção.

### 7.3. Entrar no aplicativo

Na tela de login, use o e-mail e a senha configurados para o administrador da API. Depois disso, é possível acessar o lançamento de notas e a apuração de impostos.

### 7.4. Verificar a qualidade do código

Na pasta `apps/mobile`, execute:

```powershell
dart format .
flutter analyze
flutter test
```

Esses comandos formatam o código, verificam possíveis problemas e executam os testes disponíveis.

## 8. Prints das telas do aplicativo

**IMPORTANTE:** os arquivos abaixo devem ser capturados **no aplicativo Flutter em execução**. Prints da interface web Quasar não substituem os prints do aplicativo móvel. A versão do projeto disponibilizada para esta documentação não contém capturas reais do emulador; por isso, elas devem ser acrescentadas antes da entrega ao professor.

Crie a pasta `apps/mobile/screenshots/` e salve os prints com os nomes indicados. No Android Studio, utilize o botão de captura de tela do emulador. Alternativamente, com o Flutter em execução no dispositivo, utilize:

```powershell
New-Item -ItemType Directory -Force .\screenshots
flutter screenshot --out=screenshots/01-login.png
```

Navegue para cada tela, troque o nome do arquivo e capture novamente.

| Print a incluir | O que deve aparecer |
| --- | --- |
| `screenshots/01-login.png` | Tela de login |
| `screenshots/02-inicio.png` | Tela inicial com os módulos |
| `screenshots/03-listagem-notas.png` | Lista de notas fiscais |
| `screenshots/04-cadastro-nota.png` | Formulário de nova nota com produto |
| `screenshots/05-edicao-nota.png` | Formulário com uma nota existente |
| `screenshots/06-apuracao.png` | Seleção de notas para apuração |
| `screenshots/07-historico-apuracoes.png` | Histórico de apurações |
| `screenshots/08-detalhes-apuracao.png` | Detalhes e totais de uma apuração |

Quando os arquivos estiverem salvos, substitua este aviso pelas imagens em Markdown abaixo (elas serão exibidas automaticamente no GitHub depois que os arquivos existirem):

<!-- INSERIR PRINTS REAIS DO FLUTTER ANTES DA ENTREGA

### Tela de login
![Tela de login](screenshots/01-login.png)

### Tela inicial
![Tela inicial](screenshots/02-inicio.png)

### Lançamento de notas — listagem
![Listagem de notas](screenshots/03-listagem-notas.png)

### Cadastro de nota
![Cadastro de nota](screenshots/04-cadastro-nota.png)

### Edição de nota
![Edição de nota](screenshots/05-edicao-nota.png)

### Apuração de impostos
![Apuração de impostos](screenshots/06-apuracao.png)

### Histórico de apurações
![Histórico de apurações](screenshots/07-historico-apuracoes.png)

### Detalhes da apuração
![Detalhes da apuração](screenshots/08-detalhes-apuracao.png)

FIM DOS PRINTS -->

## 9. Publicação no GitHub

Depois de atualizar este README e adicionar os prints reais, execute no terminal da raiz do repositório:

```powershell
git add apps/mobile/README.md apps/mobile/screenshots
git commit -m "Documenta aplicativo Flutter e adiciona prints das telas"
git push origin main
```

> Nunca envie `apps/api/.env`, senhas, tokens ou outros dados privados ao repositório.
