

Instrukcja uruchomienia projektu w środowisku kontenerowym z wykorzystaniem serwera Nginx jako Reverse Proxy (Zadanie #02).

---

Struktura folderu projektu

Upewnij się, że Twoje pliki są ułożone w folderze `02` w następujący sposób:

* **`02/project/`** – tutaj musi znajdować się cała zawartość Twojej aplikacji Django (plik `manage.py` oraz folder 'project' z `settings.py` i `wsgi.py`).
* **`02/nginx/default.conf`** – plik konfiguracyjny dla serwera Nginx.
* **`02/Dockerfile`** – instrukcja budowania obrazu dla aplikacji Python/Django.
* **`02/docker-compose.yml`** – definicja usług `web` oraz `nginx`.
* **`02/.env`** – plik ze zmiennymi środowiskowymi (DEBUG, SECRET_KEY, ALLOWED_HOSTS).

---

Kroki przed uruchomieniem

1.  Weryfikacja kodu: Upewnij się, że pliki Django nie są "puste" wewnątrz kontenera. Plik `manage.py` powinien znajdować się bezpośrednio w katalogu `project/`.
2.  Konfiguracja Gunicorn: W pliku `docker-compose.yml` komenda startowa powinna wyglądać następująco:
    `command: gunicorn --chdir project nazwa_folderu_ustawien.wsgi:application --bind 0.0.0.0:8000`
    *(Zastąp `nazwa_folderu_ustawien` nazwą folderu, w którym faktycznie znajduje się plik `wsgi.py`)*.
3.  ALLOWED_HOSTS: W pliku `.env` lub `settings.py` upewnij się, że `localhost` znajduje się na liście dozwolonych hostów.

---

Uruchomienie aplikacji

Będąc w terminalu w folderze `02`, wykonaj poniższe kroki:

1.  Zatrzymanie i usunięcie starych kontenerów/wolumenów:
    ```bash
    docker compose down
    ```

2.  Budowanie obrazów i start usług:
    ```
    docker compose up --build
    ```

---
Weryfikacja działania

* Dostęp przez przeglądarkę: Aplikacja powinna być dostępna pod adresem [http://localhost](http://localhost) (standardowy port 80).
* Brak dostępu bezpośredniego: Próba wejścia na [http://localhost:8000](http://localhost:8000) powinna zakończyć się niepowodzeniem (port Django jest ukryty za Nginxem).
* Podgląd logów: Jeśli zobaczysz błąd `502 Bad Gateway`, sprawdź logi usługi web:
    ```bash
    docker compose logs -f web
    ```
    Poprawnie działająca aplikacja wyświetli komunikat: `[INFO] Booting worker with pid: ...`

---