#!/bin/bash

# Program to run postgresql container
# Author: Christopher Ortiz - @giocom

postgresqlContainerised() {
  echo -e
  if ! sudo -n true 2>/dev/null; then
    read -s -p "Enter your sudo password:" password
    echo -e
  fi
  read -p "Include the version of docker image:" version
  echo -e "\nVerifying that the postgres image exists..."

  cleaned_version=$(echo "${version}" | tr -d '.')
  name="postgres-${cleaned_version}"
  vol="${HOME}/docker-vol/${name}/data"
  verif_img=$(echo "${password}" | sudo -S docker images -q postgres:"${version}")

  if [ -n "${verif_img}" ]; then
    echo "This image version of postgres is already pulled"
  else
    echo "Pulling image..."
    echo -e
    echo "${password}" | sudo docker pull postgres:"${version}"
  fi

  echo -e
  read -s -p "Postgres password:" postgres_passw
  echo -e

  echo "${password}" | sudo docker run --name "${name}" \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD="${postgres_passw}" \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v ${vol}:/var/lib/postgresql/data \
    -d postgres:"${version}"

  echo -e
  echo "${password}" | sudo docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

