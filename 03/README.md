> :white_check_mark: *Jeśli będziesz mieć problem z rozwiązaniem tego zadania, poproś o pomoc na odpowiednim kanale na Slacku, tj. `s14-django-deployment` (dotyczy [mentee](https://devmentor.pl/mentoring/)) lub na ogólnodostępnej i bezpłatnej [społeczności na Discordzie](https://devmentor.pl/discord). Pamiętaj, aby treść Twojego wpisu spełniała [odpowiednie kryteria](https://devmentor.pl/jak-prosic-o-pomoc/).*

 

# `#03` Django: Deployment aplikacji

Twoim zadaniem jest uruchomienie aplikacji Django za Nginx z włączonym **HTTPS (SSL/TLS)** w Docker Compose.

---

## Zakres zadania

1. Utwórz `docker-compose.yml` z usługami:

* `web` – Django uruchomione na `0.0.0.0:8000` (np. przez `gunicorn`),
* `nginx` – reverse proxy, wystawione na hosta portami `80:80` oraz `443:443`.

2. Dodaj konfigurację Nginx:

* `nginx/default.conf` (lub podobna ścieżka), która:

  * dla portu `80` robi przekierowanie `301` na HTTPS,
  * dla portu `443` proxy-pass do `http://web:8000`,
  * ustawia nagłówki: `Host`, `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`.

3. Wygeneruj certyfikat **self-signed** i klucz prywatny (lokalnie) oraz zamontuj je do kontenera Nginx:

* przykładowe ścieżki: `./certs/fullchain.pem`, `./certs/privkey.pem`.

4. (Django) Ustaw minimalną konfigurację pod reverse proxy:

* `SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")`.

---

## Wymagania funkcjonalne

* Po uruchomieniu `docker compose up --build`:

  * wejście na `http://localhost` przekierowuje na `https://localhost`,
  * wejście na `https://localhost` wyświetla aplikację Django,
  * port `8000` **nie** jest wystawiony na hosta (dostęp tylko przez Nginx).

---

## Wskazówki

* Przeglądarka pokaże ostrzeżenie bezpieczeństwa dla self-signed – to oczekiwane w tym zadaniu.
* Jeśli używasz innej nazwy usługi niż `web`, zaktualizuj `proxy_pass`.
* Certyfikaty trzymaj poza repozytorium (dodaj `certs/` do `.gitignore`).

---

## Twoje rozwiązanie powinno zawierać

* `docker-compose.yml`,
* konfigurację Nginx (np. `nginx/default.conf`),
* instrukcję wygenerowania certyfikatu self-signed,
* zmiany w `settings.py` dotyczące pracy za reverse proxy.

 

> :no_entry: *Jeśli nie posiadasz materiałów do tego zadania tj. **PDF, projekt + Code Review**, znajdziesz je na stronie [devmentor.pl](https://devmentor.pl/workshop-django-deployment)*

> :arrow_left: [*poprzednie zadanie*](./../02) | [*następne zadanie*](./../04) :arrow_right:
