#!/bin/bash

# Program to create docker containers
# Author: Christopher Ortiz - @giocom

option=0

createContainer() {
  echo -e
  read -s -p "Enter your sudo password:" password
  echo -e
  read -p "Include docker image:" img_name
  read -p "Include docker image version:" version
  echo -e "\nVerifing that image exists..."

  cleaned_version=$(echo "${version}" | tr -d '.')
  name="${img_name}-${version}"
  verif_img=$(echo "${password}" | sudo -S docker images -q "${img_name}":"${version}")

  if [ -n "${verif_img}" ]; then
    echo "This image is alredy pulled"
  else
    echo "Pulling image..."
    echo -e
    echo "${password}" | sudo -S docker pull "${img_name}":"${version}"
  fi

  echo -e
  read -p "Container name:" name
  echo -e

  docker_command="sudo -S docker run --name ${name}"

  # Add port mappings
  read -p "Do you want to add ports? (yes/no): " add_ports
  if [ "${add_ports}" = "yes" ]; then
    read -p "Enter ports mappings (host_port:container_port,...,so on): " ports
    # Convert ports to an array
    IFS=',' read -ra ports_arr <<< "${ports}"
    for port in "${ports_arr[@]}"; do
      docker_command+=" -p ${port}"
    done
  fi

  # Add env variables
  read -p "Do you want to add env variables? (yes/no): " add_env_vars
  if [ "${add_ports}" = "yes" ]; then
    read -p "Enter environment variables (env_var=value,...,so on): " env_vars
    # Convert variables to an array
    IFS=',' read -ra env_vars_arr <<< "${env_vars}"
    for var in "${env_vars_arr[@]}"; do
      docker_command+=" -e ${var}"
    done
  fi

  # Add volume path
  read -p "Do you want to attach a volume? (yes/no): " add_volume
  if [ "${add_volume}" = "yes" ]; then
    docker_command+=" -v ${HOME}/docker-vol/${name}"
  fi

  docker_command+=" -d ${img_name}:${version}"

  echo "${password}" | eval "$docker_command"

  echo -e
  echo "${password}" | sudo -S docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

menu() {
  while :
  do
    clear
    echo "-------------------------------------------------"
    echo "                  DockerizeMe                    "
    echo "-------------------------------------------------"
    echo "                   Main Menu                     "
    echo "-------------------------------------------------"
    echo "1. Create docker container"
    echo "2. Exit"
    echo "-------------------------------------------------"

    read -n 1 -p "Enter a valid option:" opt

    case $opt in
      1)
        createContainer
        ;;
      2)
        echo -e "\nExit"
        exit 0
        ;;
    esac
  done
}

cd ~/
menu
