#!/bin/bash

# Program to run mongodb container
# Author: Christopher Ortiz - @giocom

mongoDBContainerised() {
  echo -e
  read -s -p "Enter your sudo password:" password
  echo -e
  read -p "Include the version of mongoDB image:" version
  echo -e "\nVerifing that mongoDB image exists..."

  cleaned_version=$(echo "${version}" | tr -d '.')
  name="mongo-${cleaned_version}"
  vol="${HOME}/docker-vol/${name}/data"
  verif_img=$(sudo -S <<< "${password}" docker images -q mongo:"${version}")

  if [ -n "${verif_img}" ]; then
    echo "This image of mongoDB is alredy pulled"
  else
    echo "Pulling image..."
    echo -e
    sudo -S <<< "${password}" docker pull mongo:"${version}"
  fi

  sudo -S <<< "${password}" docker run --name "${name}" \
    -p 27017:27017 \
    -v "${vol}"/db:/data/db \
    -v "${vol}"/configdb:/data/configdb \
    -d mongo:"${version}"

  echo -e
  sudo -S <<< "${password}" docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

