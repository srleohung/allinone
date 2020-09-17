# postgresql

# Usage
##  Export table as insert sql script
```bash
pg_dump --table=$table --data-only --column-inserts $db > script.sql
```