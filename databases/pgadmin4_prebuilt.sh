#!/bin/bash

# Program to run pgadmin4 container
# Author: Christopher Ortiz - @giocom

pgadmin4Containerised() {
  echo -e
  read -s -p "Enter your sudo password:" password
  echo -e
  echo -e "\nVerifing that pgadmin4 image exists..."

  name="pgadmin"
  verif_img=$(sudo -S <<< "${password}" docker images -q dpage/pgadmin4)

  if [ -n "${verif_img}" ]; then
    echo "This image of pgadmin4 is alredy pulled"
  else
    echo "Pulling image..."
    echo -e
    sudo -S <<< "${password}" docker pull dpage/pgadmin4
  fi

  echo -e
  read -p "Email:" email
  read -s -p "Password:" pg4_passw
  echo -e

  sudo -S <<< "${password}" docker run --name "${name}" \
    -p 3000:80 \
    -e PGADMIN_DEFAULT_EMAIL="${email}" \
    -e PGADMIN_DEFAULT_PASSWORD="${pg4_passw}" \
    -d dpage/pgadmin4

  echo -e
  sudo -S <<< "${password}" docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

