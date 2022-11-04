To generate a self-signed certificate, run the following in your shell:
```javascript
cd cert
openssl genrsa -out server.key
openssl req -new -key server.key -out csr.pem
openssl x509 -req -days 9999 -in csr.pem -signkey server.key -out certificate.pem
rm csr.pem
```

Step 4: Install the express framework.
Go to your terminal and hit the following command.

```
npm install
```


Okay, the next step is to install the express framework.
```
npm install express --save
```

Finally, our Build nodejs web server tutorial is over. Thanks for taking it.
```
npm start
```


curl -k https://localhost:8443 -viii
curl -iv https://localhost:8443 -k

I have used this command to troubleshoot client certificate negotiation:
```
openssl s_client -connect localhost:8443
```


