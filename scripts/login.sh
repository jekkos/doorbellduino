#!/bin/sh

# synology urls 
export SERVER_ROOT="http://192.168.1.50:5000"
ACCOUNT=admin
PASSWD=yourPwd

[ -f session.txt ] && rm session.txt
AUTH_RESULT=`curl -s -c session.txt "$SERVER_ROOT/webapi/auth.cgi?api=SYNO.API.Auth&method=Login&version=1&account=$ACCOUNT&passwd=$PASSWD"`
echo $AUTH_RESULT
