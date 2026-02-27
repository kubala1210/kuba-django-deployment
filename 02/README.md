> :white_check_mark: *Jeśli będziesz mieć problem z rozwiązaniem tego zadania, poproś o pomoc na odpowiednim kanale na Slacku, tj. `s14-django-deployment` (dotyczy [mentee](https://devmentor.pl/mentoring/)) lub na ogólnodostępnej i bezpłatnej [społeczności na Discordzie](https://devmentor.pl/discord). Pamiętaj, aby treść Twojego wpisu spełniała [odpowiednie kryteria](https://devmentor.pl/jak-prosic-o-pomoc/).*

 

# `#02` Django: Deployment aplikacji

Twoim zadaniem jest wystawienie aplikacji Django przez **Nginx** jako reverse proxy w Docker Compose.

---

## Zakres zadania

1. Utwórz plik `nginx/default.conf`, który:

   * nasłuchuje na porcie `80`,
   * przekazuje ruch do aplikacji Django pod `http://web:8000`,
   * ustawia nagłówki: `Host`, `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`.

2. Utwórz `docker-compose.yml`, który uruchamia dwie usługi:

   * `web` (Twoja aplikacja Django uruchomiona na `0.0.0.0:8000`),
   * `nginx` (obraz `nginx:alpine`) z podmontowanym plikiem `default.conf`.

3. W `docker-compose.yml` wystaw tylko port Nginx na hosta:

   * mapowanie `80:80`,
   * **bez** mapowania portu `8000` na hosta.

---

## Wymagania funkcjonalne

* Po uruchomieniu `docker compose up --build` aplikacja jest dostępna pod:

  * `http://localhost/`
* Port `8000` nie jest publicznie dostępny na hoście.
* Nginx przekazuje żądania do kontenera `web` (reverse proxy działa).

---

## Twoje rozwiązanie powinno zawierać

* plik `nginx/default.conf`,
* plik `docker-compose.yml`,
* krótką instrukcję uruchomienia.

 

> :no_entry: *Jeśli nie posiadasz materiałów do tego zadania tj. **PDF, projekt + Code Review**, znajdziesz je na stronie [devmentor.pl](https://devmentor.pl/workshop-django-deployment)*

> :arrow_left: [*poprzednie zadanie*](./../01) | [*następne zadanie*](./../03) :arrow_right:
