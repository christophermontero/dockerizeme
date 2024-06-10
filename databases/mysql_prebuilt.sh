#!/bin/bash

# Program to run mysql container
# Author: Christopher Ortiz - @giocom

mysqlContainerised() {
  echo -e
  read -s -p "Enter your sudo password:" password
  echo -e
  read -p "Include the version of docker image:" version
  echo -e "\nVerifing that mysql image exists..."

  cleaned_version=$(echo "${version}" | tr -d '.')
  name="mysql-${cleaned_version}"
  vol="${HOME}/docker-vol/${name}"
  verif_img=$(echo "${password}" | sudo -S docker images -q mysql:"${version}")
  echo -e

  if [ -n "${verif_img}" ]; then
    echo "This images version of mysql is alredy pulled"
  else
    echo "Pulling image..."
    echo -e
    echo "${password}" | sudo -S docker pull mysql:"${version}"
  fi

  echo -e
  read -s -p "MySQL password:" mysql_passw
  echo -e

  echo "${password}" | sudo -S docker run --name "${name}" \
    -e MYSQL_ROOT_PASSWORD="${mysql_passw}" \
    -v "${vol}":/var/lib/mysql \
    -d mysql:"${version}"

  echo -e
  echo "${password}" | sudo -S docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

