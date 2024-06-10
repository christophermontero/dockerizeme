#!/bin/bash

# Program to run postgres + postgis container
# Author: Christopher Ortiz - @giocom

postgresqlPlusPostgisContainerised() {
  echo -e
  read -s -p "Enter your sudo password:" password
  echo -e
  read -p "Include the version of docker image:" version
  echo -e "\nVerifing that postgres plus postgis image exists..."

  cleaned_version=$(echo "${version}" | tr -d '.')
  name="postgres-postgis-${cleaned_version}"
  vol="${HOME}/docker-vol/${name}/data"
  verif_img=$(sudo -S <<< "${password}" docker images -q postgis/postgis:"${version}")

  if [ -n "${verif_img}" ]; then
    echo "This image version of postgres plus postgis is alredy pulled"
  else
    echo "Pulling image..."
    echo -e
    sudo -S <<< "${password}" docker pull postgis/postgis:${version}
  fi

  echo -e
  read -s -p "Postgres password:" postgres_passw
  echo -e

  sudo -S <<< "${password}" docker run --name "${name}" \
    -p 5433:5432 \
    -e POSTGRES_PASSWORD="${postgres_passw}" \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v $vol:/var/lib/postgresql/data \
    -d postgis/postgis:"${version}"

  echo -e
  sudo -S <<< "${password}" docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

