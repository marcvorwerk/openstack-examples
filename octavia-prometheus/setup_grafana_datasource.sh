#!/usr/bin/env bash

GRAFANA_URL="http://localhost:3000"
DASHBOARD_ID="15828"
DATASOURCE_NAME="Prometheus"
DATASOURCE_TYPE="prometheus"
DATASOURCE_URL="http://prometheus:9090"
ADMIN_USER="admin"
ADMIN_PASSWORD="S3cure!"

# install if not da: curl
which curl &> /dev/null || sudo apt update && sudo apt install -y curl

# Warte, bis Grafana verfügbar ist
until $(curl --output /dev/null --silent --head --fail $GRAFANA_URL); do
    echo "Warte auf Grafana..."
    sleep 5
done

echo "Grafana verfügbar. Füge Datasource hinzu..."

# Überprüfe, ob die Datasource bereits existiert
if ! curl -s -u "$ADMIN_USER:$ADMIN_PASSWORD" "$GRAFANA_URL/api/datasources" | grep -q "\"name\":\"$DATASOURCE_NAME\""; then
    # Füge die Prometheus Datasource hinzu
    curl -s -X POST "$GRAFANA_URL/api/datasources" \
        -H "Content-Type: application/json" \
        -u "$ADMIN_USER:$ADMIN_PASSWORD" \
        -d "{
            \"name\": \"$DATASOURCE_NAME\",
            \"type\": \"$DATASOURCE_TYPE\",
            \"access\": \"proxy\",
            \"url\": \"$DATASOURCE_URL\",
            \"isDefault\": true,
	    \"uid\": \"$DASHBOARD_NAME\",
            \"jsonData\": {
                \"timeInterval\": \"5s\"
            }
        }"
    echo "Datasource '$DATASOURCE_NAME' hinzugefügt."
else
    echo "Datasource '$DATASOURCE_NAME' existiert bereits."
fi


echo "Dashboard $DASHBOARD_NAME importiert."
