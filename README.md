# Repository container
tramite questo repository, con il makefile e i file yaml presenti nella cartella docker, è possibile installare vari container già configurati dentro la cartella docker 

# Passaggi consigliati
0. posizionarsi nella cartella home\projects della macchina dove si è già installato docker e si vuole installare i vari container
0. git clone https://github.com/FrancescoMammana/docker_install.git
0. installare make: sudo apt-get install make
0. make init (per inizializzare docker)
0. make portainer (per installare portainer sulla porta 9443)
0. nella macchina dare accesso in ingresso alle porte 80 (http), 443 (https), 9443 (portainer)
0. far ripartire portainer - docker restart portainer
0. accedere a portainer con indirizzo https://<ip>:9443
0. connettere portainer all'istanza docker