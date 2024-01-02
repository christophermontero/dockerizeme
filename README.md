
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

# DockerizeMe

**_DockerizeMe_** this bash script allows you to create docker containers with ease, specifying environment variables, volumes, and other parameters.
  
# Screenshots

![dockerizeme](./assets/dockerizeme.jpg)

# Tech Stack

**Bash version** 5.1.16(1)-release

**Docker version** 24.0.7

# Installation

To install this project simply clone it from github

**shell**

```
git clone https://github.com/christophermontero/dockerizeme.git
cd dockerizeme
```

# Usage

For use this project just run the following command

**shell**

```
./dockerizeme.sh
```

## Port mappings

If you want map ports just add them in this way

**shell**

```
8080:8080,...,so on
```

## Environment variables

For env variables just add them in this way 

**shell**

```
ROOT_PASSWORD=mypassword,...,so on
```

## Volumes

If you want attach some volume to container it will be located in `$HOME/docker-vol/image-name`

# Comments

If you have any feedback, please reach out at cgortizm21@gmail.com

# License

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)

# Authors

- [@christophermontero](https://github.com/christophermontero)

