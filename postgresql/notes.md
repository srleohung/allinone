# postgresql

# Usage
## Export table as insert sql script
```bash
pg_dump --table=$table --data-only --column-inserts $db > script.sql
```

## Terminates the session whose backend process has the specified process ID
```sql
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$dbname';
```