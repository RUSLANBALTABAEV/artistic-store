@echo off
REM ═════════════════════════════════════════════════════════════════════════════
REM Artistic Store - Quick Fix Script
REM Исправляет все ошибки в проекте на Windows
REM ═════════════════════════════════════════════════════════════════════════════

setlocal enabledelayedexpansion
color 0A

echo.
echo ════════════════════════════════════════════════════════════════
echo 🔧 ARTISTIC STORE - FIX ERRORS
echo ════════════════════════════════════════════════════════════════
echo.

REM Проверить что мы в корневой папке
if not exist "package.json" (
    echo ❌ package.json не найден! Убедитесь что вы в корневой папке проекта.
    pause
    exit /b 1
)

echo ✅ Проект найден
echo.

REM ═════════════════════════════════════════════════════════════════════════════
REM Шаг 1: Очистить node_modules
REM ═════════════════════════════════════════════════════════════════════════════

echo.
echo 📝 Шаг 1: Очистка node_modules...
echo.

if exist "node_modules" (
    echo ⏳ Удаление node_modules (это может занять минуту)...
    rmdir /s /q node_modules >nul 2>&1
    if exist "node_modules" (
        echo ❌ Не удалось удалить node_modules
        echo 💡 Попробуйте закрыть все VS Code окна и повторить
        pause
        exit /b 1
    )
    echo ✅ node_modules удалён
) else (
    echo ✅ node_modules уже удалён
)

echo.

REM ═════════════════════════════════════════════════════════════════════════════
REM Шаг 2: Удалить lock файлы
REM ═════════════════════════════════════════════════════════════════════════════

echo.
echo 📝 Шаг 2: Удаление lock файлов...
echo.

if exist "pnpm-lock.yaml" (
    del pnpm-lock.yaml
    echo ✅ pnpm-lock.yaml удалён
)

if exist "package-lock.json" (
    del package-lock.json
    echo ✅ package-lock.json удалён
)

if exist "yarn.lock" (
    del yarn.lock
    echo ✅ yarn.lock удалён
)

echo.

REM ═════════════════════════════════════════════════════════════════════════════
REM Шаг 3: Переустановить зависимости
REM ═════════════════════════════════════════════════════════════════════════════

echo.
echo 📝 Шаг 3: Переустановка зависимостей...
echo ⏳ Это может занять 3-5 минут...
echo.

REM Проверить какой пакетный менеджер использовать
where pnpm >nul 2>&1
if %errorlevel% equ 0 (
    echo 📦 Используем pnpm...
    call pnpm install
    if %errorlevel% neq 0 (
        echo ❌ Ошибка при установке pnpm
        echo 💡 Переключаемся на npm...
        call npm install
    )
) else (
    echo 📦 Используем npm...
    call npm install
)

if %errorlevel% neq 0 (
    echo ❌ Ошибка при установке зависимостей
    pause
    exit /b 1
)

echo.
echo ✅ Зависимости установлены
echo.

REM ═════════════════════════════════════════════════════════════════════════════
REM Шаг 4: Одобрить build скрипты (pnpm)
REM ═════════════════════════════════════════════════════════════════════════════

where pnpm >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo 📝 Шаг 4: Одобрение build скриптов...
    echo ⏳ Следуйте инструкциям в терминале...
    echo.
    call pnpm approve-builds
    if %errorlevel% equ 0 (
        echo ✅ Build скрипты одобрены
    ) else (
        echo ⚠️  Пропуск одобрения build скриптов
    )
)

echo.

REM ═════════════════════════════════════════════════════════════════════════════
REM Шаг 5: Проверить файлы
REM ═════════════════════════════════════════════════════════════════════════════

echo.
echo 📝 Шаг 5: Проверка файлов...
echo.

setlocal enabledelayedexpansion
set "missing=0"

if not exist "apps\backend\tsconfig.json" (
    echo ⚠️  apps\backend\tsconfig.json не найден
    echo 💡 Скопируйте tsconfig.json.backend в apps\backend\tsconfig.json
    set "missing=1"
)

if not exist "apps\backend\src\main.ts" (
    echo ⚠️  apps\backend\src\main.ts не найден
    echo 💡 Скопируйте main.ts.backend в apps\backend\src\main.ts
    set "missing=1"
)

if not exist "apps\frontend\app\layout.tsx" (
    echo ⚠️  apps\frontend\app\layout.tsx не найден
    echo 💡 Скопируйте layout.tsx.root в apps\frontend\app\layout.tsx
    set "missing=1"
)

if not exist "apps\frontend\app\(routes)\page.tsx" (
    echo ⚠️  apps\frontend\app\(routes)\page.tsx не найден
    echo 💡 Скопируйте page.tsx.home в apps\frontend\app\(routes)\page.tsx
    set "missing=1"
)

if !missing! equ 1 (
    echo.
    echo 💡 ВАЖНО: Скопируйте недостающие файлы из папки с исправлениями
    echo 📂 Смотри файлы с расширениями .fixed и .backend
) else (
    echo ✅ Все необходимые файлы найдены
)

echo.

REM ═════════════════════════════════════════════════════════════════════════════
REM Завершение
REM ═════════════════════════════════════════════════════════════════════════════

echo.
echo ════════════════════════════════════════════════════════════════
echo ✅ ИСПРАВЛЕНИЕ ЗАВЕРШЕНО!
echo ════════════════════════════════════════════════════════════════
echo.
echo 🚀 Для запуска проекта используйте:
echo.
echo    Terminal 1 (Frontend):
echo    cd apps\frontend
echo    pnpm dev
echo.
echo    Terminal 2 (Backend):
echo    cd apps\backend
echo    pnpm dev
echo.
echo    Terminal 3 (Strapi):
echo    cd apps\cms
echo    pnpm dev
echo.
echo 🌐 Доступные сервисы:
echo    Frontend:  http://localhost:3000
echo    Backend:   http://localhost:3001
echo    Strapi:    http://localhost:1337/admin
echo.
echo ════════════════════════════════════════════════════════════════
echo.

pause
