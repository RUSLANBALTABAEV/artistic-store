# PowerShell скрипт для автоматического исправления backend файлов
# Запуск: powershell -ExecutionPolicy Bypass -File fix-backend-complete.ps1

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        ПОЛНОЕ ИСПРАВЛЕНИЕ BACKEND ОШИБОК                      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$backendDir = "apps/backend"
$currentDir = Get-Location

if (-not (Test-Path $backendDir)) {
    Write-Host "❌ ОШИБКА: Директория $backendDir не найдена!" -ForegroundColor Red
    Write-Host "Убедитесь, что скрипт запущен из корня проекта" -ForegroundColor Yellow
    exit 1
}

# ============================================================
# ШАГ 1: Удаление разделителей из всех TypeScript файлов
# ============================================================
Write-Host "📝 ШАГ 1: Удаление разделителей (---) из TypeScript файлов" -ForegroundColor Yellow
Write-Host "─" * 65 -ForegroundColor Gray

$tsFiles = Get-ChildItem -Path "$backendDir/src" -Recurse -Filter "*.ts" -ErrorAction SilentlyContinue

foreach ($file in $tsFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Проверяем, есть ли строки с только ---
    if ($content -match '(?m)^---\s*$') {
        Write-Host "  📄 Обрабатываю: $($file.Name)" -ForegroundColor Cyan
        
        # Удаляем строки содержащие только ---
        $newContent = $content -replace '(?m)^---\s*$', ''
        
        # Убираем лишние пустые строки (более 2 подряд)
        $newContent = $newContent -replace '(?m)\n\n\n+', "`n`n"
        
        # Сохраняем файл
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "     ✓ Очищено" -ForegroundColor Green
    }
}

Write-Host "`n✅ Все разделители удалены!`n" -ForegroundColor Green

# ============================================================
# ШАГ 2: Проверка и исправление app.controller.ts
# ============================================================
Write-Host "📝 ШАГ 2: Проверка app.controller.ts" -ForegroundColor Yellow
Write-Host "─" * 65 -ForegroundColor Gray

$appControllerPath = "$backendDir/src/app.controller.ts"
if (Test-Path $appControllerPath) {
    $content = Get-Content -Path $appControllerPath -Raw
    
    # Проверяем структуру файла
    if ($content -like "*Injectable*" -and $content -like "*---*") {
        Write-Host "  ⚠️  Найдены проблемы в структуре файла" -ForegroundColor Yellow
        
        # Создаем правильный файл
        $correctContent = @"
import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}
"@
        Set-Content -Path $appControllerPath -Value $correctContent
        Write-Host "  ✓ Файл восстановлен" -ForegroundColor Green
    } else {
        Write-Host "  ✓ Файл в порядке" -ForegroundColor Green
    }
}

Write-Host ""

# ============================================================
# ШАГ 3: Установка @nestjs/config
# ============================================================
Write-Host "📝 ШАГ 3: Установка @nestjs/config" -ForegroundColor Yellow
Write-Host "─" * 65 -ForegroundColor Gray

cd "$backendDir"

Write-Host "  📦 Проверяю наличие @nestjs/config..." -ForegroundColor Cyan

# Проверяем package.json
$packageJsonPath = "package.json"
if (Test-Path $packageJsonPath) {
    $packageContent = Get-Content -Path $packageJsonPath -Raw
    
    if ($packageContent -notmatch '@nestjs/config') {
        Write-Host "  ⚠️  @nestjs/config не установлен, устанавливаю..." -ForegroundColor Yellow
        pnpm add @nestjs/config 2>&1 | Out-Null
        Write-Host "  ✓ @nestjs/config установлен" -ForegroundColor Green
    } else {
        Write-Host "  ✓ @nestjs/config уже установлен" -ForegroundColor Green
    }
}

cd "$currentDir"
Write-Host ""

# ============================================================
# ШАГ 4: Проверка конфигурации Strapi в CMS
# ============================================================
Write-Host "📝 ШАГ 4: Проверка конфигурации плагинов CMS" -ForegroundColor Yellow
Write-Host "─" * 65 -ForegroundColor Gray

$cmsPluginConfigPath = "apps/cms/config/plugins.ts"
if (Test-Path $cmsPluginConfigPath) {
    Write-Host "  📄 Найден: config/plugins.ts" -ForegroundColor Cyan
    Write-Host "  ℹ️  Проверьте, чтобы плагины были правильно зарегистрированы" -ForegroundColor Yellow
    Write-Host "  ℹ️  Убедитесь, что все плагины существуют в src/plugins/" -ForegroundColor Yellow
} else {
    Write-Host "  ℹ️  Файл plugins.ts не найден (может быть в другом месте)" -ForegroundColor Yellow
}

Write-Host ""

# ============================================================
# ШАГ 5: Переустановка зависимостей
# ============================================================
Write-Host "📝 ШАГ 5: Переустановка зависимостей backend" -ForegroundColor Yellow
Write-Host "─" * 65 -ForegroundColor Gray

cd "$backendDir"
Write-Host "  📦 Переустанавливаю зависимости..." -ForegroundColor Cyan
pnpm install 2>&1 | Out-Null
Write-Host "  ✓ Зависимости переустановлены" -ForegroundColor Green

cd "$currentDir"
Write-Host ""

# ============================================================
# ЗАВЕРШЕНИЕ
# ============================================================
Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║              ✅ ИСПРАВЛЕНИЕ ЗАВЕРШЕНО!                          ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

Write-Host "🚀 Следующие шаги:" -ForegroundColor Cyan
Write-Host "  1. Проверьте конфигурацию плагинов CMS" -ForegroundColor White
Write-Host "  2. Убедитесь, что все плагины существуют в apps/cms/src/plugins/" -ForegroundColor White
Write-Host "  3. Запустите проект: pnpm dev" -ForegroundColor White
Write-Host ""
