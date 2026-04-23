> :white_check_mark: *Jeśli będzziesz mieć problem z rozwiązaniem tego zadania, poproś o pomoc na odpowiednim kanale na Slacku, tj. `s14-django-deployment` (dotyczy [mentee](https://devmentor.pl/mentoring/)) lub na ogólnodostępnej i bezpłatnej [społeczności na Discordzie](https://devmentor.pl/discord). Pamiętaj, aby treść Twojego wpisu spełniała [odpowiednie kryteria](https://devmentor.pl/jak-prosic-o-pomoc/).*

 

# `#04` Django: Deployment aplikacji

Twoim zadaniem jest przygotowanie **pipeline CI/CD**, który automatycznie wdraża aplikację na serwer po pushu do gałęzi `main`.

---

## Zakres zadania

1. Utwórz workflow GitHub Actions w `.github/workflows/deploy.yml`, który uruchamia się na:

* `push` do gałęzi `main`.

2. W workflow wykonaj kroki:

* checkout repozytorium,
* połączenie przez SSH do serwera (użyj klucza prywatnego z `GitHub Secrets`),
* na serwerze w katalogu projektu wykonaj:

  * `git pull`,
  * `docker compose up -d --build`,
  * `docker compose exec -T web python manage.py migrate`,
  * `docker compose exec -T web python manage.py collectstatic --noinput`.

3. Dodaj do `README.md` sekcję:

* jakie `Secrets` są wymagane (nazwy),
* jak uruchomić pierwszy deploy (np. przez pierwszy push do `main`).

---

## Wymagania funkcjonalne

* Po pushu do `main` workflow kończy się sukcesem.
* Na serwerze po zakończeniu workflow:

  * kontenery działają,
  * migracje są wykonane,
  * statyczne pliki są zebrane (`collectstatic`).

---

## Wskazówki

* Użyj `docker compose exec -T`, żeby uniknąć problemów z TTY w CI.
* Nie wpisuj danych dostępowych do serwera w repo — tylko `GitHub Secrets`.
* Jeśli używasz innej nazwy usługi niż `web`, dostosuj komendy.

---

## Twoje rozwiązanie powinno zawierać

* plik `.github/workflows/deploy.yml`,
* aktualizację `README.md` z listą wymaganych `Secrets`,
* instrukcję, jak zweryfikować, że deploy się wykonał (np. `docker ps` / logi).

 
## Konfiguracja Deploymentu (CI/CD)

### Wymagane GitHub Secrets
Aby automatyczne wdrażanie działało, należy dodać następujące wpisy w ustawieniach repozytorium (`Settings -> Secrets and variables -> Actions`):

`SERVER_HOST`: Adres IP Twojego serwera
`SERVER_USER`: Nazwa użytkownika
`SSH_PRIVATE_KEY`: Klucz prywatny SSH (wygenerowany komendą `ssh-keygen`)
`PROJECT_PATH`: Ścieżka do folderu z projektem na serwerze
`SERVER_PORT`: Port SSH, jeśli jest inny niż 22.

### Pierwsze uruchomienie (First Deploy)
1.  Zaloguj się na serwer i wykonaj jednorazowo `git clone` swojego repozytorium do ścieżki zdefiniowanej w `PROJECT_PATH`.
2.  Skonfiguruj plik `.env` na serwerze (jeśli projekt go wymaga).
3.  Dodaj powyższe `Secrets` do GitHub.
4.  Wypchnij zmiany do gałęzi głównej: git push origin main

### Jak zweryfikować, czy deploy się udał?
1. Sprawdź zakładkę `Actions` w repozytorium — jeśli ikona jest zielona, komendy SSH zostały wykonane pomyślnie.
2. Zaloguj się na serwer i wpisz `docker ps`. Powinieneś zobaczyć działający kontener `web` (lub inny zdefiniowany w docker-compose).
3. Użyj komendy `docker compose logs -f web`, aby upewnić się, że Django wystartowało bez błędów.
4. Sprawdź, czy baza danych jest aktualna i czy strona poprawnie wczytuje style CSS.

> :no_entry: *Jeśli nie posiadasz materiałów do tego zadania tj. **PDF, projekt + Code Review**, znajdziesz je na stronie [devmentor.pl](https://devmentor.pl/workshop-django-deployment)*

> :arrow_left: [*poprzednie zadanie*](./../03) | [*następne zadanie*](./../05) :arrow_right:
