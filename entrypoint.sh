#!/bin/sh -l

set -eu

echo 'Starting ftps mirror'

site="ftp://${INPUT_HOST}"
user="${INPUT_USERNAME},${INPUT_PASSWORD}"

[ ${INPUT_DEBUG} = 'true' ] && debug='-d'  || debug=''
[ ${INPUT_CHECK} = 'true' ] && check='yes' || check='no'

echo 'Uploading files using FTP over TLS'

lftp ${site} -p ${INPUT_PORT} -u ${user} ${debug} -e "
set ftp:ssl-auth TLS;
set ftp:ssl-allow yes;
set ftp:ssl-force yes;
set ftp:ssl-protect-fxp yes;
set ftp:ssl-protect-data yes;
set ftp:ssl-protect-list yes;
set ssl:check-hostname ${check};
mirror ${INPUT_OPTIONS} -R ${INPUT_LOCAL} ${INPUT_REMOTE};
quit"

echo 'ftps mirror complete'
