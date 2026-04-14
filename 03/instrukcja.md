# Deployment Django (Nginx + HTTPS)

## 1. Generowanie certyfikatów SSL

Ze względów bezpieczeństwa certyfikaty SSL nie są wgrywane do repozytorium (znajdują się w `.gitignore`). Aby uruchomić aplikację lokalnie, musisz wygenerować certyfikat *self-signed*.

Otwórz terminal w głównym folderze projektu (tam gdzie znajduje się plik `docker-compose.yml`) i wykonaj poniższe kroki:

1. Utwórz folder na certyfikaty i wejdź do niego:
   ```bash
   mkdir certs
   cd certs
   
2. Wygeneruj certyfikat komendą:

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privkey.pem -out fullchain.pem

3. Podczas generowania certyfikatu zostaniesz poproszony o podanie danych. Możesz zostawić większość pól pustych (klikając Enter), ale koniecznie wpisz localhost w polu Common Name.

4. Wróc do głównego folderu

cd ..

Gdy pliki fullchain.pem i privkey.pem znajdują się w folderze certs/, zbuduj i uruchom kontenery:

docker compose up --build

Aplikacja będzie działać pod adresem:
https://localhost (przeglądarka wyświetli ostrzeżenie bezpieczeństwa dla certyfikatu self-signed – należy kliknąć "Zaawansowane" i zaakceptować ryzyko, by wejść na stronę).