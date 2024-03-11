@echo off
chcp 65001
setlocal

rem Задать путь к системным файлам
set "system_files=C:\Task"
set "web_service_url=http://localhost:3000/"

rem Создать список текущих контрольных сумм для системных файлов
for %%F in ("%system_files%\*") do (
    certutil -hashfile "%%F" SHA256 | findstr /v "hash" >> current_checksums.txt
)

rem Отслеживать изменения в системных файлах
:loop
cls
echo Отслеживание изменений в системных файлах...

rem Создать список текущих контрольных сумм для системных файлов
for %%F in ("%system_files%\*") do (
    certutil -hashfile "%%F" SHA256 | findstr /v "hash" >> new_checksums.txt
)

rem Сравнить новые контрольные суммы с предыдущими
fc /b current_checksums.txt new_checksums.txt > nul
if errorlevel 1 (
    echo Изменение обнаружено!
    move /y new_checksums.txt current_checksums.txt > nul
    rem Отправить уведомление через веб-сервис
    curl -X POST -d "change_detected=true" %web_service_url%
) else (
    echo Изменений не обнаружено.
    del new_checksums.txt > nul
)

rem Подождать некоторое время перед повторной проверкой
timeout /t 10 > nul
goto loop