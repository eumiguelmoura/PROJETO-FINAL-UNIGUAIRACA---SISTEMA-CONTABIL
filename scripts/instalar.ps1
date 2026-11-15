$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath (Split-Path -Parent $PSScriptRoot)

function Run-Docker([string[]]$Arguments) {
    & docker @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw ("Falha ao executar: docker " + ($Arguments -join ' '))
    }
}

try {
    Write-Host '=== SISTEMA CONTABIL - PRIMEIRA INSTALACAO ===' -ForegroundColor Cyan
    if (-not (Test-Path -LiteralPath '.\docker-compose.yaml')) {
        throw 'docker-compose.yaml nao encontrado. Extraia o ZIP e execute na pasta sistema_contabil_unificado.'
    }
    if (-not (Get-Command 'docker' -ErrorAction SilentlyContinue)) {
        throw 'Docker nao instalado ou nao encontrado no PATH. Instale o Docker Desktop.'
    }
    & docker info --format '{{.ServerVersion}}' | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw 'Docker Desktop nao esta funcionando. Abra o programa e aguarde Engine running.'
    }
    if (-not (Test-Path -LiteralPath '.\apps\api\.env.example')) {
        throw 'Arquivo apps/api/.env.example ausente. Extraia o ZIP completo.'
    }
    $configureAdmin = -not (Test-Path -LiteralPath '.\apps\api\.env')
    if (-not $configureAdmin) {
        $existingEnv = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath '.\apps\api\.env').Path)
        $configureAdmin = $existingEnv.Contains('SEED_ADMIN_PASSWORD=DefinaUmaSenhaForteAntesDoSeed')
    }
    if ($configureAdmin) {
        Write-Host 'Configurando administrador da NOVA instalacao...' -ForegroundColor Yellow
        $email = Read-Host 'E-mail do administrador (Enter = admin@contabil.local)'
        if ([string]::IsNullOrWhiteSpace($email)) { $email = 'admin@contabil.local' }
        if ($email -notmatch '^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$') {
            throw 'E-mail invalido. Corrija apps/api/.env e execute novamente.'
        }
        $password = ''
        do {
            $secure = Read-Host 'Escolha uma senha (12+ caracteres; letras, numeros, ! @ # % . _ -)' -AsSecureString
            $pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
            try {
                $password = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
            } finally {
                [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
            }
            if ($password -cnotmatch '^[A-Za-z0-9!@#%._\-]{12,}$') {
                Write-Host 'A senha deve ter pelo menos 12 caracteres e usar apenas os simbolos indicados.' -ForegroundColor Yellow
            }
        } until ($password -cmatch '^[A-Za-z0-9!@#%._\-]{12,}$')
        $envPath = Join-Path (Get-Location).Path 'apps\api\.env'
        if (Test-Path -LiteralPath $envPath) {
            $content = [System.IO.File]::ReadAllText($envPath)
        } else {
            $content = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath '.\apps\api\.env.example').Path)
        }
        $content = [regex]::Replace($content, '(?m)^SEED_ADMIN_EMAIL=.*$', 'SEED_ADMIN_EMAIL=' + $email)
        $content = [regex]::Replace($content, '(?m)^SEED_ADMIN_PASSWORD=.*$', 'SEED_ADMIN_PASSWORD="' + $password + '"')
        [System.IO.File]::WriteAllText($envPath, $content, (New-Object System.Text.UTF8Encoding($false)))
        $password = ''
        Write-Host ('Administrador configurado: ' + $email) -ForegroundColor Green
    } else {
        Write-Host 'Arquivo .env ja existe: mantive as credenciais existentes.'
    }
    if (-not (Test-Path -LiteralPath '.\apps\web\.env')) {
        Copy-Item -LiteralPath '.\apps\web\.env.example' -Destination '.\apps\web\.env'
    }

    Write-Host "`n[1/5] Construindo e iniciando Docker (primeira vez baixa arquivos)..." -ForegroundColor Cyan
    Run-Docker -Arguments @('compose','up','-d','--build')
    Write-Host "`n[2/5] Instalando dependencias do Laravel..." -ForegroundColor Cyan
    Run-Docker -Arguments @('compose','exec','-T','-u','root','php','composer','install','--no-interaction','--prefer-dist')
    Run-Docker -Arguments @('compose','exec','-T','-u','root','php','sh','-c','mkdir -p storage/framework/cache storage/framework/sessions storage/framework/views storage/logs bootstrap/cache && chown -R www-data:www-data storage bootstrap/cache')

    $envContent = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath '.\apps\api\.env').Path)
    if ($envContent -match '(?m)^APP_KEY=\s*$') {
        Write-Host "`n[3/5] Gerando chave do Laravel..." -ForegroundColor Cyan
        Run-Docker -Arguments @('compose','exec','-T','-u','root','php','php','artisan','key:generate')
    } else {
        Write-Host "`n[3/5] Chave do Laravel ja existe, nao sera substituida."
    }
    Write-Host "`n[4/5] Criando/atualizando tabelas..." -ForegroundColor Cyan
    Run-Docker -Arguments @('compose','exec','-T','php','php','artisan','migrate','--force')
    Write-Host "`n[5/5] Criando usuario administrador..." -ForegroundColor Cyan
    Run-Docker -Arguments @('compose','exec','-T','php','php','artisan','db:seed','--force')

    Write-Host "`nINSTALACAO CONCLUIDA!" -ForegroundColor Green
    Write-Host 'Web: http://localhost:9010'
    Write-Host 'API: http://localhost:8182/api/health'
    Write-Host 'phpMyAdmin: http://localhost:8184'
    Start-Process 'http://localhost:9010'
    exit 0
} catch {
    Write-Host ("`nERRO: " + $_.Exception.Message) -ForegroundColor Red
    Write-Host 'Depois de corrigir o erro, execute INSTALAR_PRIMEIRA_VEZ.bat novamente.'
    exit 1
}
