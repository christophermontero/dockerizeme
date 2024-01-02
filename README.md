# DockerizeMe

<p align="center"><img src="assets/dockerizeme.png" alt="logo"></p>
 
**_DockerizeMe_** this bash script allows you to create docker containers with ease, specifying environment variables, volumes, and other parameters.

# Table of content

- [DockerizeMe](#dockerizeme)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
  - [Port mappings](#port-mappings)
  - [Environment variables](#environment-variables)
  - [Volumes](#volumes)
- [Comments](#comments)
- [License](#license)
- [Authors](#authors)

# Screenshots

![prebuilt](./assets/prebuilt.png)

# Tech Stack

- **Bash**

- **Git** 

- **Docker**

# Installation

To install this project, clone it from github with the following

**shell**

```
git clone https://github.com/christophermontero/dockerizeme.git
cd dockerizeme
```

# Usage

To use this project, run the following command:

**shell**

```
./dockerizeme.sh
```

## Port mappings

When prompted for port mappings, use the following format:

**shell**

```
8080:8080,... (add more as needed)
```

## Environment variables

When prompted for environment variables, use the following format:

**shell**

```
VAR_NAME=value,... (add more as needed)
```

## Volumes

If you want to attach volume to the container, type 'yes' when prompted, and it will be located in `$HOME/docker-vol/image-name`

## Prebuilt containers


# Comments

If you have any feedback, please reach out at cgortizm21@gmail.com

# License

This project is under [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0)

# Authors

- [@christophermontero](https://github.com/christophermontero)

