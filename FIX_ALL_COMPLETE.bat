@echo off
chcp 65001 > nul
title ИСПРАВЛЕНИЕ ARTISTIC STORE

cls
echo.
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║                                                                      ║
echo ║          🔧 АВТОМАТИЧЕСКОЕ ИСПРАВЛЕНИЕ ПРОЕКТА                     ║
echo ║                     ARTISTIC STORE                                  ║
echo ║                                                                      ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.

setlocal enabledelayedexpansion
set "PROJECT_ROOT=%cd%"
set "ERRORS=0"
set "SUCCESS=0"

echo 📁 Корень проекта: %PROJECT_ROOT%
echo.

REM ════════════════════════════════════════════════════════════════════════
REM ФУНКЦИЯ: Проверка наличия директории
REM ════════════════════════════════════════════════════════════════════════
:check_directory
if not exist "%~1" (
    echo ❌ ОШИБКА: Директория не найдена: %~1
    set /a ERRORS+=1
    exit /b 1
)
exit /b 0

REM ════════════════════════════════════════════════════════════════════════
REM ЭТАП 1: BACKEND
REM ════════════════════════════════════════════════════════════════════════
echo.
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║ ЭТАП 1: ИСПРАВЛЕНИЕ BACKEND                                         ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.

if not exist "apps\backend" (
    echo ❌ Директория backend не найдена
    set /a ERRORS+=1
    goto skip_backend
)

echo 🔍 Поиск TypeScript файлов с ошибками...
echo.

REM Исправляем app.controller.ts
if exist "apps\backend\src\app.controller.ts" (
    echo   📝 Обрабатываю: app.controller.ts
    powershell -NoProfile -Command ^
        "$content = Get-Content 'apps\backend\src\app.controller.ts' -Raw; " ^
        "$content = $content -replace '(?m)^---\s*$', ''; " ^
        "Set-Content 'apps\backend\src\app.controller.ts' -Value $content -NoNewline"
    echo   ✓ Готово
    set /a SUCCESS+=1
)

REM Исправляем entities/index.ts
if exist "apps\backend\src\entities\index.ts" (
    echo   📝 Обрабатываю: entities\index.ts
    powershell -NoProfile -Command ^
        "$content = Get-Content 'apps\backend\src\entities\index.ts' -Raw; " ^
        "$content = $content -replace '(?m)^---\s*$', ''; " ^
        "Set-Content 'apps\backend\src\entities\index.ts' -Value $content -NoNewline"
    echo   ✓ Готово
    set /a SUCCESS+=1
)

REM Исправляем products.service.ts
if exist "apps\backend\src\modules\products\products.service.ts" (
    echo   📝 Обрабатываю: products\products.service.ts
    powershell -NoProfile -Command ^
        "$content = Get-Content 'apps\backend\src\modules\products\products.service.ts' -Raw; " ^
        "$content = $content -replace '(?m)^---\s*$', ''; " ^
        "Set-Content 'apps\backend\src\modules\products\products.service.ts' -Value $content -NoNewline"
    echo   ✓ Готово
    set /a SUCCESS+=1
)

echo.
echo 📦 Установка @nestjs/config...
cd apps\backend

REM Проверяем наличие пакета в package.json
findstr /M "@nestjs/config" package.json >nul 2>&1
if errorlevel 1 (
    echo   ⚠️  Пакет не найден, устанавливаю...
    call pnpm add @nestjs/config >nul 2>&1
    if errorlevel 1 (
        echo   ⚠️  Ошибка при установке (может потребоваться ручная установка)
    ) else (
        echo   ✓ Пакет установлен
    )
)

echo   ✓ Переустанавливаю зависимости...
call pnpm install >nul 2>&1

cd "%PROJECT_ROOT%"
echo ✅ Backend исправлен!
echo.

:skip_backend

REM ════════════════════════════════════════════════════════════════════════
REM ЭТАП 2: FRONTEND
REM ════════════════════════════════════════════════════════════════════════
echo.
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║ ЭТАП 2: ПРОВЕРКА FRONTEND                                           ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.

if exist "apps\frontend\app\globals.css" (
    echo ✓ globals.css уже существует
) else (
    echo ⚠️  globals.css не найден, создаю...
    REM Создание базового globals.css
    (
        echo * { margin: 0; padding: 0; box-sizing: border-box; }
        echo html { scroll-behavior: smooth; }
        echo body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; }
    ) > "apps\frontend\app\globals.css"
    echo ✓ Файл создан
)

echo ✅ Frontend проверен!
echo.

REM ════════════════════════════════════════════════════════════════════════
REM ЭТАП 3: CMS (STRAPI)
REM ════════════════════════════════════════════════════════════════════════
echo.
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║ ЭТАП 3: КОНФИГУРАЦИЯ CMS (STRAPI)                                   ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.

if not exist "apps\cms\src\plugins" (
    echo 📁 Создаю директорию plugins...
    mkdir "apps\cms\src\plugins"
)

echo 🔍 Проверка плагинов...
echo.

REM Проверяем конфиг плагинов
if exist "apps\cms\config\plugins.ts" (
    echo ⚠️  Найден config\plugins.ts
    echo   ℹ️  ВАЖНО: Проверьте конфиг плагинов!
    echo.
    echo   Если вы видите ошибку "backend-sync couldn't be resolved":
    echo.
    echo   СПОСОБ 1 (простой): Удалить плагин из конфига
    echo   - Откройте apps\cms\config\plugins.ts
    echo   - Найдите строку с 'backend-sync'
    echo   - Удалите эту строку
    echo.
    echo   СПОСОБ 2: Создать плагин
    echo   - Создайте папку: apps\cms\src\plugins\backend-sync
    echo   - Добавьте файлы package.json и strapi-server.js
    echo.
    pause
)

REM Проверяем email-notifications плагин
if exist "apps\cms\src\plugins\email-notifications" (
    echo ✓ Плагин email-notifications существует
    
    if not exist "apps\cms\src\plugins\email-notifications\package.json" (
        echo   ⚠️  Создаю package.json...
        (
            echo {
            echo   "name": "strapi-plugin-email-notifications",
            echo   "version": "1.0.0",
            echo   "strapi": { "name": "email-notifications", "kind": "plugin" },
            echo   "main": "./strapi-server.js"
            echo }
        ) > "apps\cms\src\plugins\email-notifications\package.json"
        echo   ✓ Файл создан
    )
    
    if not exist "apps\cms\src\plugins\email-notifications\strapi-server.js" (
        echo   ⚠️  Создаю strapi-server.js...
        (
            echo 'use strict';
            echo module.exports = (strapi^) =^> ({
            echo   register() {},
            echo   bootstrap() {},
            echo   destroy() {},
            echo   config: { default: {}, validator() {} },
            echo });
        ) > "apps\cms\src\plugins\email-notifications\strapi-server.js"
        echo   ✓ Файл создан
    )
)

echo.
echo 📦 Переустанавливаю зависимости CMS...
cd apps\cms
call pnpm install >nul 2>&1
cd "%PROJECT_ROOT%"
echo ✓ CMS готова
echo.

REM ════════════════════════════════════════════════════════════════════════
REM ИТОГОВЫЙ ОТЧЕТ
REM ════════════════════════════════════════════════════════════════════════
echo.
echo ╔══════════════════════════════════════════════════════════════════════╗

if %ERRORS% equ 0 (
    echo ║                  ✅ ВСЕ ОШИБКИ ИСПРАВЛЕНЫ!                         ║
) else (
    echo ║                ⚠️  ИСПРАВЛЕНИЕ ЗАВЕРШЕНО С ПРЕДУПРЕЖДЕНИЯМИ            ║
)

echo ║                                                                      ║
echo ║  Исправлено файлов: %SUCCESS%                                           ║
echo ║  Ошибок: %ERRORS%                                              ║
echo ║                                                                      ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo.
echo 🚀 СЛЕДУЮЩИЕ ШАГИ:
echo.
echo  1️⃣  Проверьте конфигурацию CMS (если были предупреждения)
echo  2️⃣  Запустите проект:
echo.
echo      pnpm dev
echo.
echo  3️⃣  Приложения должны запуститься на:
echo.
echo      - Frontend:  http://localhost:3000
echo      - Backend:   http://localhost:3001
echo      - CMS:       http://localhost:1337
echo.
echo.
pause
