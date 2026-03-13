# Repository Container

Tramite questo repository, con il Makefile e i file YAML presenti nella cartella `docker`, è possibile installare vari container già configurati.

## Passaggi Consigliati

### Setup Iniziale
1. Posizionarsi nella cartella `home/projects` della macchina dove si è già installato Docker e si vuole installare i vari container
2. Clonare il repository:
   ```bash
   git clone https://github.com/FrancescoMammana/docker_install.git
   ```
3. Installare Make:
   ```bash
   sudo apt-get install make
   ```

### Installazione Portainer
4. Eseguire `make init` (per inizializzare Docker)
5. Eseguire `make portainer` (per installare Portainer sulla porta 19130)
6. Nella macchina, dare accesso in ingresso alla porta 19130 (Portainer)
7. Riavviare Portainer:
   ```bash
   docker restart portainer
   ```
8. Accedere a Portainer all'indirizzo `https://<ip>:19130` (usare l'indirizzo IP e la porta scelti)
9. Connettere Portainer all'istanza Docker e verificare che funzioni tutto

### Installazione Nginx Proxy Manager
10. Eseguire `make nginxpm` (per installare Nginx Proxy Manager)
11. Nella macchina, dare accesso in ingresso alle porte:
    - 80 (HTTP)
    - 443 (HTTPS) 
    - 19131 (Nginx)
12. Accedere a Nginx all'indirizzo `http://<ip>:19131` (usare l'indirizzo IP e la porta scelti)

### Installazione Supabase
14. Eseguire `make supabase` (per installare Supabase)
15. Nella macchina, dare accesso in ingresso alle porte:
    - 19132 (Supabase Studio)
    - 19133 (API Gateway)
16. Configurare le variabili di ambiente:
    ```bash
    cd docker/supabase
    cp .env.example .env
    # Modificare con valori sicuri
    ```
17. Accedere a Supabase Studio all'indirizzo `http://<ip>:19132`
18. Configurare il progetto, creare le tabelle e generare le API keys

### Configurazione DNS e SSL
1. Su CloudNS creare:
    - Una zona (es. `fra3222`)
    - Un indirizzo di tipo A per l'indirizzo pubblico della macchina (es. `vps.fra3222.cloudns.it`)
    - Due indirizzi di tipo C per Nginx Proxy Manager e Portainer
2. Su Nginx Proxy Manager creare due proxy host:
    - Uno che punta a Nginx Proxy Manager stesso
    - L'altro che punta a Portainer
    - Inserire come domain name l'indirizzo C creato su CloudNS
    - Usare come IP pubblico quello della macchina e come porta quella configurata
    - Aggiungere in SSL l'opzione "Force SSL" e creare il certificato

### Accesso Finale
A questo punto si potrà accedere a Nginx con l'indirizzo `nginx.fra3222.cloudns.it` e similmente a Portainer con lo stesso meccanismo.

## Aggiunta di Nuovi Container

Per tutti i container non presenti nel Makefile, sarà necessario:

1. Modificare il Makefile aggiungendo la riga necessaria
2. Aggiungere nella cartella `docker` la cartella del nuovo container con il suo file compose
3. Eseguire `make <container_name>`
4. Creare su CloudNS l'indirizzo di tipo C che deve puntare al nuovo container
5. Creare su Nginx Proxy Manager il proxy host che punta all'indirizzo pubblico e la porta della macchina che contiene Docker e all'indirizzo C di CloudNS