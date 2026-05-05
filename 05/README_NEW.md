Skrypt `backup.sh` wykonuje zrzut bazy danych PostgreSQL działającej w kontenerze Docker Compose, zapisuje go lokalnie i automatycznie usuwa pliki starsze niż 7 dni.

---

## Wymagania

| Narzędzie | Minimalna wersja |
|-----------|-----------------|
| Docker    | 20.x            |
| Docker Compose (plugin) | v2.x |
| bash      | 4.x             |

---

## Struktura projektu

```
.
├── backup.sh          # główny skrypt backupu
├── backups/           # katalog z plikami .sql (ignorowany przez git)
├── .gitignore
└── README.md
```

---

## Konfiguracja

### 1. Zmienne środowiskowe

Utwórz plik `.env` (lub eksportuj zmienne przed wywołaniem skryptu):

```env
DB_NAME=myapp_production   # nazwa bazy danych (domyślnie: postgres)
DB_USER=myapp_user         # użytkownik PostgreSQL (domyślnie: postgres)
COMPOSE_SERVICE=db         # nazwa serwisu w docker-compose.yml (domyślnie: db)
BACKUP_DIR=backups         # katalog docelowy (domyślnie: backups)
RETENTION_DAYS=7           # ile dni przechowywać backupy (domyślnie: 7)
```

> **Ważne:** plik `.env` jest umieszczony w `.gitignore` – nigdy nie commituj danych dostępowych.

### 2. Uprawnienia

Nadaj skryptowi prawo do wykonywania:

```bash
chmod +x backup.sh
```

### 3. Połączenie z bazą bez hasła

Skrypt używa flagi `--no-password`, co oznacza, że `pg_dump` nie pyta interaktywnie o hasło.  
Zalecane podejście – ustaw hasło w kontenerze przez `POSTGRES_PASSWORD` i udostępnij je skryptowi przez zmienną `PGPASSWORD` lub plik `.pgpass`.

Przykład z `PGPASSWORD` (dodaj do `.env`):

```env
PGPASSWORD=supersecretpassword
```

Następnie w skrypcie lub w cron:

```bash
export PGPASSWORD="$PGPASSWORD"
```

---

## Uruchamianie ręczne

```bash
# Z domyślną konfiguracją
./backup.sh

# Z nadpisaniem zmiennych
DB_NAME=mydb DB_USER=admin ./backup.sh
```

Po pomyślnym wykonaniu w katalogu `backups/` pojawi się plik:

```
backups/backup_20250505_0200.sql
```

---

## Automatyzacja – konfiguracja cron

### Krok 1 – otwórz crontab

```bash
crontab -e
```

### Krok 2 – dodaj wpis (codziennie o 02:00)

```cron
0 2 * * * /bin/bash /ścieżka/bezwzględna/do/projektu/backup.sh >> /ścieżka/do/projektu/backups/cron.log 2>&1
```

**Przykład dla projektu w `/opt/myapp`:**

```cron
0 2 * * * /bin/bash /opt/myapp/backup.sh >> /opt/myapp/backups/cron.log 2>&1
```

> **Wskazówka:** cron nie ładuje automatycznie zmiennych z `.env`.  
> Załaduj je jawnie lub wskaż plik środowiskowy:

```cron
0 2 * * * set -a; source /opt/myapp/.env; set +a; /bin/bash /opt/myapp/backup.sh >> /opt/myapp/backups/cron.log 2>&1
```

### Krok 3 – weryfikacja

```bash
# Sprawdź aktywne zadania cron
crontab -l

# Poczekaj na wykonanie i sprawdź log
tail -f backups/cron.log
```

---

## Zachowanie skryptu

| Sytuacja | Zachowanie |
|----------|-----------|
| Kontener nie działa | `exit 1`, komunikat w stderr |
| `pg_dump` zwraca błąd | `exit 1`, niekompletny plik usunięty |
| Plik backupu jest pusty | `exit 1`, plik usunięty |
| Backup udany | `exit 0`, rozmiar pliku zalogowany |
| Pliki starsze niż 7 dni | automatycznie usunięte przez `find` |

---

## Przywracanie backupu

```bash
# Wgraj plik .sql do kontenera i przywróć bazę
docker compose exec -T db psql \
    --username="${DB_USER}" \
    --dbname="${DB_NAME}" \
    < backups/backup_YYYYMMDD_HHMM.sql
```

---

## Bezpieczeństwo

- Pliki backupu zawierają pełne dane produkcyjne – przechowuj je w bezpiecznej lokalizacji.
- Rozważ szyfrowanie: `gpg --symmetric backups/backup_*.sql`.
- Rozważ kopiowanie backupów do zewnętrznej lokalizacji (S3, SFTP).