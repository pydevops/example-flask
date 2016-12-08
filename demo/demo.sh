#!/usr/bin/env bash
#set -x
trap read debug

minikube start
minikube status

kubectl config current-context
kubectl cluster-info

# KID bootstrap
install_workflow

echo "run admin_user register for the first time, admin_user for the subsquent time"
admin_user register
deis users

echo "show flask's Dockerfile and app.py reading env POWERED_BY "

echo "showing docker build + push job on Jenkins"


# KID
kid versions

kid app --help

kid app create flask --port 443

deis apps

kid app deploy flask --ns vyang

echo "try in chrome: http://flask.192.168.99.100.nip.io"
echo "192.168.99.100 is the output of `minikube ip` "

# scale up
deis scale cmd=5 -a flask

# scale down
deis scale cmd=1 -a flask

# configure
deis config:set POWERED_BY=python3 -a flask

deis releases -a flask

deis releases:rollback -a flask

deis releases -a flask
