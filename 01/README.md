> :white_check_mark: *Jeśli będziesz mieć problem z rozwiązaniem tego zadania, poproś o pomoc na odpowiednim kanale na Slacku, tj. `s14-django-deployment` (dotyczy [mentee](https://devmentor.pl/mentoring/)) lub na ogólnodostępnej i bezpłatnej [społeczności na Discordzie](https://devmentor.pl/discord). Pamiętaj, aby treść Twojego wpisu spełniała [odpowiednie kryteria](https://devmentor.pl/jak-prosic-o-pomoc/).*

 

# `#01` Django: Deployment aplikacji

Twoim zadaniem jest uruchomienie aplikacji Django w trybie produkcyjnym przy użyciu **Docker Compose** oraz **Gunicorn**.

---

## Zakres zadania

1. Dodaj do projektu plik `Dockerfile`, który:

   * instaluje zależności z `requirements.txt`,
   * ustawia `PYTHONDONTWRITEBYTECODE=1`,
   * ustawia `PYTHONUNBUFFERED=1`.

2. Dodaj pakiet `gunicorn` do `requirements.txt`.

3. Utwórz plik `docker-compose.yml`, który:

   * buduje obraz aplikacji,
   * mapuje port `8000:8000`,
   * uruchamia aplikację komendą z użyciem `gunicorn`,
   * korzysta z pliku `.env` do wczytania zmiennych środowiskowych.

4. Uruchom projekt przy użyciu:

```
docker compose up --build
```

---

## Wymagania funkcjonalne

Po uruchomieniu:

* aplikacja działa pod adresem `http://localhost:8000`,
* nie używasz `runserver`,
* w logach widoczny jest start Gunicorn,
* aplikacja startuje bez błędów.

---

## Wskazówki

* Komenda startowa powinna wskazywać na `projekt.wsgi:application`.
* Użyj parametru `--bind 0.0.0.0:8000`.
* Nie commituj pliku `.env` do repozytorium.

---

## Twoje rozwiązanie powinno zawierać

* plik `Dockerfile`,
* plik `docker-compose.yml`,
* zaktualizowany `requirements.txt`,
* plik `.env` (bez wrażliwych danych w repozytorium).

 

> :no_entry: *Jeśli nie posiadasz materiałów do tego zadania tj. **PDF, projekt + Code Review**, znajdziesz je na stronie [devmentor.pl](https://devmentor.pl/workshop-django-deployment)*

> :arrow_left: ~~*poprzednie zadanie*~~ | [*następne zadanie*](./../02) :arrow_right:
