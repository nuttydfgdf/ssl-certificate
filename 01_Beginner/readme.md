openssl req -x509 -newkey rsa:2048 -sha256 -days 3650 -nodes \
  -keyout example.key -out example.crt -subj "/CN=keycloak.local.com" \
  -addext "subjectAltName=DNS:*.ap-southeast-1.compute.amazonaws.com,DNS:www.example.net,IP:10.0.0.1"

