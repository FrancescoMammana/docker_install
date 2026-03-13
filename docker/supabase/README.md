# Supabase - Installazione Sicura

## Configurazione di Sicurezza

### 🔐 Password e Autenticazione
- **Password complesse**: Utilizzare password complesse e uniche
- **Autenticazione a più fattori**: Configurare per l'accesso allo Studio
- **API Keys**: Generare chiavi API sicure per l'accesso programmatico

### 🛡️ Firewall e Accesso
- **Porte esposte**: Solo 19132 (Studio) e 19133 (API Gateway)
- **Accesso diretto al DB**: Porta 5432 bloccata esternamente
- **Limitazione IP**: Configurare solo IP attendibili

### 🔒 SSL/TLS
- **Certificati SSL**: Utilizzare certificati validi per l'accesso HTTPS
- **Crittografia**: Comunicazione cifrata tra servizi
- **CORS**: Configurazione restrittiva per le richieste cross-origin

### ⚡ Rate Limiting
- **API Gateway**: Limitare le richieste al secondo
- **Studio**: Limitare l'accesso per prevenire abusi
- **Auth**: Limitare le richieste di autenticazione

## Setup Sicurezza

1. **Copiare e configurare `.env`**:
   ```bash
   cp .env.example .env
   # Compilare con valori sicuri
   ```
   
## Best Practice

### 🔧 Configurazione Database
- Utilizzare utenti separati per diverse applicazioni
- Configurare ruoli e permessi granulari
- Abilitare audit logging

### 🌐 Accesso Web
- Utilizzare Nginx Proxy Manager per SSL e dominio personalizzato
- Configurare autenticazione aggiuntiva per lo Studio
- Monitorare gli accessi con log dettagliati

### 📊 Monitoraggio
- Configurare log rotation
- Monitorare risorse e performance
- Configurare alert per attività sospette

## Comandi Utili

```bash
# Verificare stato container
docker ps -f name=supabase

# Visualizzare log
docker logs supabase-db
docker logs supabase-kong

# Backup database
docker exec supabase-db pg_dump -U postgres > backup.sql

# Monitoraggio risorse
docker stats supabase-*
```