#!/bin/bash
  cd ../

  #exit the script if any errors occur
  set -e

  name=int-feb-17
  host=$name.developmentnow.net
  email=cgrahamstevenson@gmail.com

  # DEPLOY PRODUCTION CONTAINER
  # Build image for production environment
  docker build --no-cache=true -t $name --file Dockerfile .

  # Kill and delete the current docker container
  set +e
  docker rm -f $name
  set -e

  docker run -d \
  --name $name \
  -P \
  -e "VIRTUAL_HOST=$host" \
  -e "LETSENCRYPT_HOST=$host" \
  -e "LETSENCRYPT_EMAIL=$email" \
  --restart always \
  $name

  set +e
  echo CLEAN UP ALL THE DANGLING DOCKER IMAGES
  docker rmi $(docker images -q -f dangling=true)
  set -e

  # curl and get status code to make sure it's good
  for i in 1 2 3 4 5 6 7 8 9 10 ; do

    echo HEALTH CHECK ATTEMPT - $i
    sleep 10s

    status=$(curl -s -o /dev/null -w "%{http_code}\n" https://$host)
      if [ $status = "200" ] ; then
        echo SUCCESSFUL HEALTCHECK!
        exit 0
      fi
  done

  echo HEALTCHECK FAILED! STATUS CODE $status
  exit 1
