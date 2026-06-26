@echo off
chcp 65001 > nul
REM Диагностика и исправление конфигурации плагинов CMS

cls
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║        ДИАГНОСТИКА ПЛАГИНОВ CMS (STRAPI)                      ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

set "CMS_DIR=apps\cms"
set "PLUGINS_DIR=%CMS_DIR%\src\plugins"

if not exist "%CMS_DIR%" (
    echo ❌ Директория CMS не найдена!
    pause
    exit /b 1
)

echo 📋 Проверка существующих плагинов...
echo.

if exist "%PLUGINS_DIR%" (
    echo ✓ Директория плагинов найдена: %PLUGINS_DIR%
    echo.
    echo 📁 Содержимое директории плагинов:
    dir "%PLUGINS_DIR%" /B /A:D
    echo.
) else (
    echo ❌ Директория плагинов НЕ НАЙДЕНА!
    echo Создаю директорию...
    mkdir "%PLUGINS_DIR%"
    echo ✓ Директория создана
    echo.
)

REM Проверяем наличие конфига плагинов
echo.
echo 📝 Проверка файлов конфигурации плагинов...
echo.

if exist "%CMS_DIR%\config\plugins.ts" (
    echo ✓ Найден: config\plugins.ts
    echo.
    echo ⚠️  ВНИМАНИЕ: В файле config\plugins.ts указаны плагины.
    echo    Проверьте, чтобы все указанные плагины существовали!
    echo.
) else if exist "%CMS_DIR%\config\plugins.js" (
    echo ✓ Найден: config\plugins.js
    echo.
    echo ⚠️  ВНИМАНИЕ: В файле config\plugins.js указаны плагины.
    echo    Проверьте, чтобы все указанные плагины существовали!
    echo.
) else (
    echo ✓ Файл конфигурации плагинов не найден (может быть ok)
    echo.
)

REM Проверяем конфиг Strapi
if exist "%CMS_DIR%\config\server.ts" (
    echo ✓ Найден: config\server.ts (конфигурация Strapi)
) else if exist "%CMS_DIR%\config\server.js" (
    echo ✓ Найден: config\server.js (конфигурация Strapi)
) else (
    echo ℹ️  Файл конфигурации сервера не найден
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                    РЕШЕНИЕ ПРОБЛЕМ                            ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo 🔧 Если вы видите ошибку:
echo    "Error: ./src/plugins/backend-sync couldn't be resolved"
echo.
echo    РЕШЕНИЕ:
echo    1. Откройте файл config\plugins.ts или config\plugins.js
echo    2. Найдите строку с "backend-sync"
echo    3. Либо:
echo       A) Удалите строку (если плагин не нужен)
echo       B) Создайте директорию src\plugins\backend-sync с package.json
echo.
echo 📌 БЫСТРОЕ ИСПРАВЛЕНИЕ:
echo.
echo    Выберите что делать с плагинами:
echo    1 - Отключить все кастомные плагины (просто удалить из конфига)
echo    2 - Создать пустые плагины для всех
echo    3 - Выход (вручную отредактирую файлы)
echo.

set /p choice="Выберите (1/2/3): "

if "%choice%"=="1" (
    echo.
    echo 🔨 Отключаю все кастомные плагины...
    
    if exist "%CMS_DIR%\config\plugins.ts" (
        REM Оставляем только стандартные плагины или пустой конфиг
        (
            echo export default {
            echo   // Все плагины отключены
            echo };
        ) > "%CMS_DIR%\config\plugins.ts"
        echo ✓ Файл config\plugins.ts очищен
    )
    
    echo ✅ Готово! Теперь можно запустить: pnpm dev
    
) else if "%choice%"=="2" (
    echo.
    echo 🔨 Создаю пустые плагины...
    
    REM Создаем структуру для backend-sync
    if not exist "%PLUGINS_DIR%\backend-sync" mkdir "%PLUGINS_DIR%\backend-sync"
    if not exist "%PLUGINS_DIR%\backend-sync\package.json" (
        (
            echo {
            echo   "name": "strapi-plugin-backend-sync",
            echo   "version": "1.0.0",
            echo   "description": "Backend sync plugin",
            echo   "strapi": {
            echo     "name": "backend-sync",
            echo     "kind": "plugin"
            echo   },
            echo   "main": "./strapi-server.js"
            echo }
        ) > "%PLUGINS_DIR%\backend-sync\package.json"
        echo ✓ Создан backend-sync\package.json
    )
    
    if not exist "%PLUGINS_DIR%\backend-sync\strapi-server.js" (
        (
            echo 'use strict';
            echo module.exports = (strapi^) =^> ({
            echo   register() {},
            echo   bootstrap() {},
            echo   destroy() {},
            echo   config: { default: {}, validator() {} },
            echo });
        ) > "%PLUGINS_DIR%\backend-sync\strapi-server.js"
        echo ✓ Создан backend-sync\strapi-server.js
    )
    
    echo ✅ Готово! Теперь можно запустить: pnpm dev
    
) else (
    echo.
    echo 📌 Инструкции для ручного исправления:
    echo.
    echo 1. Откройте файл: %CMS_DIR%\config\plugins.ts
    echo.
    echo 2. Найдите все строки с плагинами (backend-sync, email-notifications, итд)
    echo.
    echo 3. Для каждого плагина либо:
    echo.
    echo    ВАРИАНТ А (Удалить плагин из конфига):
    echo    - Просто удалите строку из конфига
    echo.
    echo    ВАРИАНТ Б (Создать плагин):
    echo    - Создайте папку: apps\cms\src\plugins\<plugin-name>
    echo    - Добавьте package.json и strapi-server.js
    echo.
    echo 4. Сохраните файл и перезапустите: pnpm dev
    echo.
)

echo.
pause
