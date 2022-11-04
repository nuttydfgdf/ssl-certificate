#!/bin/bash  
# Bash script To Create Self-Signed Certificate

PATH="/certs"
SERVER_KEY="$PATH/server.key"
SERVER_CSR="$PATH/server.csr"
SERVER_CRT="$PATH/server.crt"
EXTFILE="$PATH/cert_ext.cnf"
OPENSSL_CMD="/usr/bin/openssl"
COMMON_NAME="$1"

function show_usage {
    printf "Usage: $0 [options [parameters]]\n"
    printf "\n"
    printf "Options:\n"
    printf " -cn, Provide Common Name for the certificate\n"
    printf " -h|--help, print help section\n"

    return 0
}

case $1 in
     -cn)
         shift
         COMMON_NAME="$1"
         ;;
     --help|-h)
         show_usage
         exit 0
         ;;
     *)
        ## Use hostname as Common Name
        COMMON_NAME=`/usr/bin/hostname`
        ;;
esac

# generating server key
echo "Generating private key"
$OPENSSL_CMD genrsa -out $SERVER_KEY  4096 2>/dev/null
if [ $? -ne 0 ] ; then
   echo "ERROR: Failed to generate $SERVER_KEY"
   exit 1
fi

## Update Common Name in External File
/bin/echo "commonName              = $COMMON_NAME" >> $EXTFILE

# Generating Certificate Signing Request using config file
echo "Generating Certificate Signing Request"
$OPENSSL_CMD req -new -key $SERVER_KEY -out $SERVER_CSR -config $EXTFILE 2>/dev/null
if [ $? -ne 0 ] ; then
   echo "ERROR: Failed to generate $SERVER_CSR"
   exit 1
fi


echo "Generating self signed certificate"
$OPENSSL_CMD x509 -req -days 3650 -in $SERVER_CSR -signkey $SERVER_KEY -out $SERVER_CRT 2>/dev/null
if [ $? -ne 0 ] ; then
   echo "ERROR: Failed to generate self-signed certificate file $SERVER_CRT"
fi