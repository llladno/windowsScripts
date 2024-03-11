@echo off
SET PGPASSWORD=qwerty12
SET PGUSER=postgres
SET PGDATABASE=tempGridnis
SET PGHOST=localhost
SET PGPORT=5432
SET BACKUP_DIR=F:\projects\WindowsScripts\result
SET BACKUP_FILE_NAME=backup_%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.sql
SET PG_DUMP_PATH="C:\Program Files\PostgreSQL\15\bin\pg_dump.exe"
IF NOT EXIST %BACKUP_DIR% (
  mkdir %BACKUP_DIR%
)
%PG_DUMP_PATH% -U %PGUSER% -h %PGHOST% -p %PGPORT% -F p -b -v -f %BACKUP_DIR%\%BACKUP_FILE_NAME% %PGDATABASE%
IF %ERRORLEVEL% NEQ 0 (
  echo Backup failed!
) else (
  echo Backup created successfully!
)
