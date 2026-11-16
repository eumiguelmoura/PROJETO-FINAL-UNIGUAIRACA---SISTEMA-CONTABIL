# Identidade visual — NextContábil

O **NextContábil** é o novo nome público da aplicação acadêmica. O código mantém as rotas, tabelas e nomes internos anteriores para compatibilidade com instalações já existentes.

## Identidade
- **Marca:** NextContábil
- **Assinatura:** Gestão contábil e fiscal
- **Azul-marinho:** `#14213B` (estrutura, contraste)
- **Azul Next:** `#4659EC` (ações e navegação)
- **Verde-água:** `#26CDB7` (destaques e confirmação)
- **Plano de fundo:** `#F5F7FC`
- **Logotipo:** N estilizado em bloco arredondado, utilizado no painel, login e favicon.

## Onde foi atualizado
- Quasar: tela de login, menu lateral, cabeçalho, tela inicial, favicon, título da aba do navegador, cores dos componentes e estilos responsivos.
- Flutter: título do aplicativo, tema, login e tela inicial com os mesmos elementos visuais.
- Laravel: `APP_NAME` de exemplo e fallback da configuração.
- README e documentação.

## Atualizar uma instalação existente (Windows / PowerShell)

O arquivo `apps/api/.env` **não é sobrescrito** por esta atualização. Se estiver presente, altere apenas a linha abaixo:

```dotenv
APP_NAME="NextContábil"
```

Depois, na pasta do projeto:

```powershell
docker compose exec php php artisan optimize:clear
docker compose restart web php
```

Acesse `http://localhost:9010` e use `Ctrl + Shift + R` se o navegador continuar exibindo o título antigo.

Não é necessário rodar migrations ou reinstalar o banco de dados por causa do nome.
