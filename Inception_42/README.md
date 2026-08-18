*This project has been created as part of the 42 curriculum by oelbied.*

# Description

Inception is a system administration project from the 42 curriculum.

The goal of this project is to build a small infrastructure using Docker and Docker Compose.

The project contains three main services:

- NGINX
- WordPress
- MariaDB

Each service runs in its own Docker container.

NGINX is used as the entry point and handles HTTPS connections.
WordPress is used to provide the website.
MariaDB is used to store the WordPress database.

The services communicate with each other through a Docker network, and the WordPress and MariaDB data is stored persistently.

## Project Structure

The main project files are inside the `srcs/` directory:

```text
srcs/
├── .env
├── docker-compose.yml
└── requirements/
    ├── nginx/
    ├── wordpress/
    └── mariadb/
```

The project also uses a `Makefile` at the root to make the Docker commands easier to use.

# Instructions

## Requirements

Before running the project, make sure you have:

- A Linux Virtual Machine.
- Docker and Docker Compose installed in the Virtual Machine.
- Make.

## Configuration

The project uses a `.env` file to store configuration values used by Docker Compose.

The `.env` file is located at:

```text
srcs/.env
```

The domain used by the project is:

```text
oelbied.42.fr
```

The domain must point to the IP address of the Virtual Machine.

## Build and Run

The Makefile is located at the root of the project.

To build the Docker images and start the containers:

```bash
make
```

## Useful Commands

Check the container status:

```bash
make ps
```

Show the container logs:

```bash
make logs
```

Stop the containers:

```bash
make stop
```

Start the stopped containers:

```bash
make start
```

Stop and remove the containers:

```bash
make down
```

Restart the infrastructure:

```bash
make restart
```

## Cleaning

Remove stopped containers and unused Docker resources:

```bash
make clean
```

Perform a full cleanup:

```bash
make fclean
```

> Warning: `make fclean` removes the persistent WordPress and MariaDB data.

Rebuild the project from scratch:

```bash
make re
```

## Access

The WordPress website is available at:

```text
https://oelbied.42.fr
```

The WordPress administration panel is available at:

```text
https://oelbied.42.fr/wp-admin/
```

# Resources

## Docker

- Docker Documentation: https://docs.docker.com/
- Docker Official Website: https://www.docker.com/
- Docker Compose Documentation: https://docs.docker.com/compose/
- NGINX Documentation: https://nginx.org/en/docs/
- WordPress Documentation: https://wordpress.org/documentation/
- MariaDB Documentation: https://mariadb.com/docs/

- How Docker Actually Works:
  https://dev.to/piyushjajoo/how-docker-actually-works-a-deep-dive-into-the-internals-501d

- Docker - Containers, Images and Volumes:
  https://www.youtube.com/watch?v=PrusdhS2lmo&t=1573s

- How Docker Works:
  https://www.youtube.com/watch?v=rjjES5IsPdg

## AI Usage

I used AI mainly when I had problems or when I did not understand something.

It helped me understand Docker, containers, images, networks and volumes, and also helped me debug some configuration and setup problems.

I also used AI to help with some parts of the README and documentation.

# Docker and Design Choices

## Virtual Machines vs Docker

A Virtual Machine runs a complete operating system.

Docker containers are lighter because they share the host system kernel.

For this project, Docker is useful because each service can run in its own container without needing a separate operating system.

| Virtual Machine | Docker |
|---|---|
| Complete operating system | Shares the host kernel |
| Uses more resources | Uses fewer resources |
| Slower to start | Faster to start |
| More isolated | Lightweight isolation |

## Secrets vs Environment Variables

Environment variables are mainly used to pass configuration values to containers.

Secrets are designed for sensitive information such as passwords and private keys.

In this project, environment variables are used through the `.env` file.

For real production systems, sensitive information should preferably be handled using a proper secrets management system.

| Secrets | Environment Variables |
|---|---|
| Made for sensitive information | Mainly used for configuration |
| Better for passwords and private keys | Easy to use |
| Better protection for secrets | Easier to expose |

## Docker Network vs Host Network

A Docker network allows containers to communicate with each other using their service names.

For example, WordPress can communicate with MariaDB through the Docker network.

With host networking, the container uses the host machine's network directly.

This project uses a Docker network because the services need to communicate with each other while keeping their network separated from the host.

| Docker Network | Host Network |
|---|---|
| Containers communicate through Docker | Uses the host network directly |
| Provides network isolation | Less network isolation |
| Containers can use service names | Uses host network interfaces |
| Better suited for this project | Not needed for this project |

## Docker Volumes vs Bind Mounts

Docker volumes are managed by Docker and are commonly used to store persistent container data.

Bind mounts connect a specific directory on the host machine to a directory inside a container.

In this project, persistent data is stored under:

```text
~/data/wordpress
~/data/mariadb
```

The data needs to stay available when containers are recreated.

| Docker Volumes | Bind Mounts |
|---|---|
| Managed by Docker | Managed by the user |
| Docker chooses the storage location | User chooses the host directory |
| Easy to manage with Docker | Easy to access directly from the host |
| Good for persistent application data | Useful when a specific host directory is required |