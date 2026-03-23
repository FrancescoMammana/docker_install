# Function: Docker Rebuild
# [execute: down, remove, pull, build, up]
# $(call docker_rebuild,"stack_name")
define docker_rebuild
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml down && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml rm -f && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml pull && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml build --no-cache && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml up -d
endef
# Function: Docker Remove
# [execute: down, remove]
# $(call docker_remove,"stack_name")
define docker_remove
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml down && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml rm -f
endef
# Function: Docker Rebuild with Pull
# [execute: pull, rebuild]
# $(call docker_rebuild_adguard,"adguard")
define docker_rebuild_adguard
	#0 Attiva il resolver di sistema
	sudo systemctl start systemd-resolved && \

	# 1. Scarica l'aggiornamento (Mentre AdGuard è ancora attivo e risolve i nomi)
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml pull && \

	# 2. Spegni il vecchio container
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml down && \

	# 3. ASSICURATI che il resolver di sistema sia spento (Libera la porta 53)
	sudo systemctl stop systemd-resolved && \
	sudo systemctl disable systemd-resolved && \
	
	# 4. Pulisci e ricostruisci
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml rm -f && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml build --no-cache && \

	# 5. Fai partire il nuovo AdGuard
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml up -d
endef
# Initialization
init:
	docker network create --driver bridge reverse-proxy
# Remove Stack
remove:
	@if [ -z "$(stack)" ]; then echo "usage: make remove stack=portainer"; exit 1; fi
	$(call docker_remove,$(stack))
# Portainer
portainer:
	docker volume create portainer_data
	$(call docker_rebuild,"portainer")
# NGINX Proxy Manager
nginxpm:
	docker volume create nginxpm_data
	docker volume create nginxpm_letsencrypt
	$(call docker_rebuild,"nginxpm")
# AD Guard
adguard:
	$(call docker_rebuild_adguard,"adguard")
# Gotify
gotify:
	docker volume create gotify_data
	$(call docker_rebuild,"gotify")
# WatchTower
watchtower:
	$(call docker_rebuild,"watchtower")
# Glances
glances:
	$(call docker_rebuild,"glances")
# IT Tools
it-tools:
	$(call docker_rebuild,"it-tools")
# Passbolt
passbolt:
	docker volume create passbolt_db
	docker volume create passbolt_gpg
	docker volume create passbolt_jwt
	$(call docker_rebuild,"passbolt")
# Uptime Kuma
uptime-kuma:
	docker volume create uptime-kuma_data
	$(call docker_rebuild,"uptime-kuma")
# N8N
n8n:
	docker volume create n8n_data
	$(call docker_rebuild,"n8n")
# Papra
papra:
	docker volume create papra_data
	$(call docker_rebuild,"papra")
# SpeedTest Tracker
speedtest-tracker:
	docker volume create speedtest-tracker_data
	$(call docker_rebuild,"speedtest-tracker")
# Supabase con sicurezza avanzata
supabase:
	@echo "🔒 Installazione Supabase con sicurezza avanzata"
	@echo "Assicurati di aver configurato il file .env in docker/supabase/"
	docker volume create supabase_db
	docker volume create supabase_storage
	$(call docker_rebuild,"supabase")
	@echo "Esegui lo script di sicurezza: cd docker/supabase && ./security-setup.sh"

# Rimuovere Supabase
supabase-remove:
	$(call docker_remove,"supabase")
	docker volume rm supabase_db supabase_storage
