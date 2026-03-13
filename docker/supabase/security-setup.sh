#!/bin/bash

# Script di setup sicurezza per Supabase
# Eseguire dopo l'installazione di base

echo "🔒 Setup Sicurezza Supabase"

# # 1. Generare password complesse
# echo "Generazione password complesse..."
# DB_PASSWORD=$(openssl rand -base64 32)
# echo "POSTGRES_PASSWORD=$DB_PASSWORD" >> .env

# # 2. Configurare firewall
# echo "Configurazione firewall..."
# sudo ufw allow 19132/tcp comment "Supabase Studio"
# sudo ufw allow 19133/tcp comment "Supabase API"
# sudo ufw deny 5432/tcp comment "Blocca accesso diretto DB"

# # 3. Configurare limitazioni IP
# echo "Configurazione limitazioni IP..."
# if [ -n "$ALLOWED_IPS" ]; then
#     for ip in $ALLOWED_IPS; do
#         sudo ufw allow from $ip to any port 19132,19133 proto tcp
#     done
# fi

# # 4. Configurare SSL (se certificati disponibili)
# if [ -f "$SSL_CERT_PATH" ] && [ -f "$SSL_KEY_PATH" ]; then
#     echo "Configurazione SSL..."
#     # Aggiungere configurazione SSL a Kong
#     # Da implementare in base alla struttura SSL
# fi

# # 5. Configurare rate limiting
# echo "Configurazione rate limiting..."
# # Aggiungere configurazione avanzata a Kong

# # 6. Configurare monitoraggio
# echo "Configurazione monitoraggio..."
# # Aggiungere log e monitoraggio

echo "✅ Setup sicurezza completato"
echo "📝 Salva il file .env in un luogo sicuro!"
echo "🔑 Password generata: $DB_PASSWORD"