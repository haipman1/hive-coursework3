@echo off
cd /d "%~dp0.."
docker compose up -d --build --wait postgres metastore || exit /b 1
docker compose up -d --force-recreate --no-deps --wait hiveserver2 || exit /b 1
docker compose exec -T hiveserver2 beeline -u jdbc:hive2://localhost:10000/default -n hive -f /opt/hive/sql/load.sql || exit /b 1
