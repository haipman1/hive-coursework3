# Apache Hive

Автоматическое развёртывание Apache Hive 4.0.0 и загрузка данных в партиционированную таблицу.

## Схема

- `postgres` — база метаданных Hive.
- `metastore` — отдельный Hive Metastore с подключением к PostgreSQL.
- `hiveserver2` — сервер для одновременного подключения нескольких клиентов по JDBC.

Данные таблицы сохраняются в Docker volume `warehouse`, метаданные — в `postgres_data`. Встроенный (embedded) Metastore не используется.

## Запуск

Нужен Docker Desktop с запущенным Docker Engine. Открыть PowerShell в папке проекта:

```powershell
.\scripts\run.cmd
```

Скрипт запускает контейнеры, создаёт базу `coursework` и таблицу `events`, затем загружает два CSV-файла в партиции `2026-10-22` и `2026-10-23`. Повторный запуск перезаписывает данные в партициях без дублирования строк.

## Проверка

Подключиться к Hive в первом окне PowerShell:

```powershell
docker compose exec hiveserver2 beeline -u jdbc:hive2://localhost:10000/default -n hive
```

Выполнить запросы:

```sql
SHOW PARTITIONS coursework.events;
SELECT * FROM coursework.events WHERE event_date='2026-10-22';
SELECT * FROM coursework.events WHERE event_date='2026-10-23';
```

Ожидается две партиции: три записи за `2026-10-22` и две за `2026-10-23`.

Открыть второе окно PowerShell и выполнить ту же команду подключения. Оба клиента смогут отправлять запросы одновременно через HiveServer2.

## Остановка

```powershell
docker compose down
```

Данные сохраняются в Docker volumes.
