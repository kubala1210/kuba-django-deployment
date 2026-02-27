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

 

> :no_entry: *Jeśli nie posiadasz materiałów do tego zadania tj. **PDF, projekt + Code Review**, znajdziesz je na stronie [devmentor.pl](https://devmentor.pl/workshop-django-deployment)*

> :arrow_left: [*poprzednie zadanie*](./../03) | [*następne zadanie*](./../05) :arrow_right:
