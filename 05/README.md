> :white_check_mark: *Jeśli będziesz mieć problem z rozwiązaniem tego zadania, poproś o pomoc na odpowiednim kanale na Slacku, tj. `s14-django-deployment` (dotyczy [mentee](https://devmentor.pl/mentoring/)) lub na ogólnodostępnej i bezpłatnej [społeczności na Discordzie](https://devmentor.pl/discord). Pamiętaj, aby treść Twojego wpisu spełniała [odpowiednie kryteria](https://devmentor.pl/jak-prosic-o-pomoc/).*

 

# `#05` Django: Deployment aplikacji

Twoim zadaniem jest przygotowanie mechanizmu **automatycznego backupu bazy danych PostgreSQL** w środowisku produkcyjnym.

---

## Zakres zadania

1. Utwórz skrypt `backup.sh`, który:

   * wykonuje `pg_dump` bazy danych działającej w Docker Compose,
   * zapisuje plik backupu w katalogu `backups/`,
   * nadaje nazwę pliku w formacie: `backup_YYYYMMDD_HHMM.sql`.

2. Skrypt powinien:

   * korzystać ze zmiennych środowiskowych (nazwa bazy, użytkownik),
   * działać z poziomu hosta (np. przez `docker compose exec`),
   * zwracać kod błędu, jeśli backup się nie powiedzie.

3. Dodaj mechanizm czyszczenia starych backupów:

   * usuń pliki starsze niż 7 dni.

4. Dodaj zadanie cron (opis w README), które:

   * uruchamia `backup.sh` codziennie o 02:00.

---

## Wymagania funkcjonalne

* Po uruchomieniu `./backup.sh` w katalogu `backups/` pojawia się nowy plik `.sql`.
* Plik zawiera strukturę i dane bazy (nie jest pusty).
* Backupy starsze niż 7 dni są automatycznie usuwane.
* Skrypt kończy się błędem (exit code ≠ 0), jeśli połączenie z bazą się nie powiedzie.

---

## Wskazówki

* Możesz użyć: `docker compose exec -T db pg_dump ...`
* Użyj `date +"%Y%m%d_%H%M"` do generowania nazwy pliku.
* Do czyszczenia plików użyj `find backups -type f -mtime +7 -delete`.

---

## Twoje rozwiązanie powinno zawierać

* plik `backup.sh`,
* katalog `backups/` (ignorowany w repo),
* wpis w `.gitignore`,
* instrukcję konfiguracji crona w `README.md`.

 

> :no_entry: *Jeśli nie posiadasz materiałów do tego zadania tj. **PDF, projekt + Code Review**, znajdziesz je na stronie [devmentor.pl](https://devmentor.pl/workshop-django-deployment)*

> :arrow_left: [*poprzednie zadanie*](./../04) | ~~*następne zadanie*~~ :arrow_right:
