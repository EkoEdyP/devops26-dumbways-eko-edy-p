#!/bin/bash

DOMAINS=(
"eep.wayshub-frontend.studentdumbways.my.id"
"api.eep.wayshub-backend.studentdumbways.my.id"
)

echo "=== SSL Cerbot Checker ==="

for DOMAIN in "${DOMAINS[@]}"
do
    echo "-----------------------------"
    echo "Checking: $DOMAIN"

    EXPIRY_DATE=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null \
    | openssl x509 -noout -enddate | cut -d= -f2)

    if [ -z "$EXPIRY_DATE" ]; then
        echo "Gagal ambil expiry date (domain mungkin down)"
        continue
    fi

    EXPIRY_TS=$(date -d "$EXPIRY_DATE" +%s)
    NOW_TS=$(date +%s)

    DAYS_LEFT=$(( (EXPIRY_TS - NOW_TS) / 86400 ))

    echo "Sisa hari: $DAYS_LEFT"

    if [ $DAYS_LEFT -le 1 ]; then
        echo "H-1 expired → renew $DOMAIN"

        certbot certonly --nginx -d $DOMAIN --quiet

        systemctl reload nginx
    else
        echo "Belum perlu renew"
    fi
done

echo "=== Done ==="