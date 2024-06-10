#!/bin/bash

# Program to run postgres + postgis container
# Author: Christopher Ortiz - @giocom

postgresqlPlusPostgisContainerised() {
  echo -e
  if ! sudo -n true 2>/dev/null; then
    read -s -p "Enter your sudo password:" password
    echo -e
  fi
  read -p "Include the version of docker image:" version
  echo -e "\nVerifing that postgres plus postgis image exists..."

  cleaned_version=$(echo "${version}" | tr -d '.')
  name="postgres-postgis-${cleaned_version}"
  vol="${HOME}/docker-vol/${name}/data"
  verif_img=$(echo "${password}" | sudo -S docker images -q postgis/postgis:"${version}")

  if [ -n "${verif_img}" ]; then
    echo "This image version of postgres plus postgis is alredy pulled"
  else
    echo "Pulling image..."
    echo -e
    echo "${password}" | sudo -S docker pull postgis/postgis:${version}
  fi

  echo -e
  read -s -p "Postgres password:" postgres_passw
  echo -e

  echo "${password}" | sudo -S docker run --name "${name}" \
    -p 5433:5432 \
    -e POSTGRES_PASSWORD="${postgres_passw}" \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v $vol:/var/lib/postgresql/data \
    -d postgis/postgis:"${version}"

  echo -e
  echo "${password}" | sudo -S docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

