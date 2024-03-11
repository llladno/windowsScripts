@echo off
chcp 65001
set sourceDir="F:\projects\WindowsScripts\web"
set backupDir="F:\projects\WindowsScripts\result"
set dateStamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

echo Создание резервной копии...
xcopy /E /I %sourceDir% %backupDir%\Backup_%dateStamp%
echo Резервная копия создана.

echo Архивация копии...
set zipName=Backup_%dateStamp%.zip
powershell Compress-Archive -Path %backupDir%\Backup_%dateStamp% -DestinationPath %backupDir%\%zipName%
echo Копия архивирована в %backupDir%\%zipName%.

echo Очистка временной копии...
rmdir /S /Q %backupDir%\Backup_%dateStamp%
echo Временная копия удалена.