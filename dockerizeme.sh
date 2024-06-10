#!/bin/bash

# Program to create docker containers
# Author: Christopher Ortiz - @giocom

option=0

# Source prebuilt_databases scripts
source databases/postgresql_prebuilt.sh
source databases/postgis_prebuilt.sh
source databases/pgadmin4_prebuilt.sh
source databases/mongo_prebuilt.sh
source databases/mysql_prebuilt.sh

# Function to run a PostgreSQL container
postgresql() {
  postgresqlContainerised
}

# Function to run postgresql with postgis extension container
postgresqlPlusPostgis() {
  postgresqlPlusPostgisContainerised
}

# Function to run pgadmin4 container
pgadmin4() {
  pgadmin4Containerised
}

# Function to run mongoDB container
mongoDB() {
  mongoDBContainerised
}

# Function to run mysql container
mysql() {
  mysqlContainerised
}

createContainer() {
  echo -e
  read -s -p "Enter your sudo password:" password
  echo -e
  read -p "Include docker image:" img_name
  read -p "Include docker image version:" version
  echo -e "\nVerifing that image exists..."

  cleaned_version=$(echo "${version}" | tr -d '.')
  name="${img_name}-${cleaned_version}"
  verif_img=$(sudo -S <<< "${password}" docker images -q "${img_name}":"${version}")

  if [ -n "${verif_img}" ]; then
    echo "This image is alredy pulled"
  else
    echo "Pulling image..."
    echo -e
    sudo -S <<< "${password}" docker pull "${img_name}":"${version}"
  fi

  docker_command="docker run --name ${name}"

  # Add port mappings
  read -p "Do you want to add ports? (yes/no): " add_ports
  if [ "${add_ports}" == "yes" ]; then
    read -p "Enter ports mappings (host_port:container_port,...,so on): " ports
    # Convert ports to an array
    IFS=',' read -ra ports_arr <<< "${ports}"
    for port in "${ports_arr[@]}"; do
      docker_command+=" -p ${port}"
    done
  fi

  # Add env variables
  read -p "Do you want to add env variables? (yes/no): " add_env_vars
  if [ "${add_env_vars}" == "yes" ]; then
    read -p "Enter environment variables (env_var=value,...,so on): " env_vars
    # Convert variables to an array
    IFS=',' read -ra env_vars_arr <<< "${env_vars}"
    for var in "${env_vars_arr[@]}"; do
      docker_command+=" -e ${var}"
    done
  fi

  # Add volume path
  read -p "Do you want to attach a volume? (yes/no): " add_volume
  if [ "${add_volume}" == "yes" ]; then
    mkdir -p "${HOME}/docker-vol/${name}"
    docker_command+=" -v ${HOME}/docker-vol/${name}"
  fi

  docker_command+=" -d ${img_name}:${version}"

  sudo -S <<< "{password}" eval "$docker_command"

  echo -e
  sudo -S <<< "{password}" docker ps -a
  echo -e
  read -n 1 -s -r -p "Press any KEY to continue..."
}

prebuilt () {
  while :
  do
    clear
    echo "-------------------------------------------------"
    echo "          Pre-built containers menu              "
    echo "-------------------------------------------------"
    echo "-------------------------------------------------"
    echo "1. Install PostgreSQL"
    echo "2. Install PostgreSQL + PostGIS"
    echo "3. Install Pgadmin4"
    echo "4. Install MongoDB"
    echo "5. Install MySQL"
    echo "6. Exit"
    echo "-------------------------------------------------"

    read -n 1 -p "Enter a valid option:" opt

    case $opt in
      1)
        postgresql
        ;;
      2)
        postgresqlPlusPostgis
        ;;
      3)
        pgadmin4
        ;;
      4)
        mongoDB
        ;;
      5)
        mysql
        ;;
      6)
        echo -e "\nExit"
        exit 0
        ;;
    esac
  done
}

menu() {
  while :
  do
    clear
    echo "-------------------------------------------------"
    echo "               DockerizeMe menu                  "
    echo "-------------------------------------------------"
    echo "-------------------------------------------------"
    echo "1. Create custom docker container"
    echo "2. Create pre-built docker container"
    echo "3. Exit"
    echo "-------------------------------------------------"

    read -n 1 -p "Enter a valid option:" opt

    case $opt in
      1)
        createContainer
        ;;
      2)
        prebuilt
        ;;
      3)
        echo -e "\nExit"
        exit 0
        ;;
    esac
  done
}

cd ~/
menu
