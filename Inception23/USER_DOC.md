# User Documentation

## Introduction

This document explains how to use the Inception infrastructure as an end user or administrator.

The project provides a WordPress website running through three main services:

- **NGINX**: provides HTTPS access to the website.
- **WordPress**: provides the website and administration interface.
- **MariaDB**: stores the WordPress database.

Each service runs in its own Docker container.

## Starting the Project

From the root of the project, run:

```bash
make
```

This builds the required Docker images and starts the containers.

## Stopping the Project

To stop and remove the containers:

```bash
make down
```

To stop the containers without removing them:

```bash
make stop
```

To start stopped containers again:

```bash
make start
```

## Accessing the Website

After the project is running, access the WordPress website using the configured domain name:

```text
https://oelbied.42.fr
```

The domain must point to the IP address of the Virtual Machine.

## Accessing the Administration Panel

The WordPress administration panel is available at:

```text
https://oelbied.42.fr/wp-admin/
```

Use the WordPress administrator credentials configured for the project.

## Credentials

Project configuration values are stored in:

```text
srcs/.env
```

The `.env` file contains the configuration required by Docker Compose.

Credentials should not be shared publicly or committed to a public repository.

If credentials need to be changed, update the appropriate configuration and recreate the required containers.

## Checking the Services

To check the status of the containers:

```bash
make ps
```

All required services should be running.

To check the service logs:

```bash
make logs
```

Logs can be used to identify errors in NGINX, WordPress, or MariaDB.

## Useful Commands

Restart the infrastructure:

```bash
make restart
```

Stop the containers:

```bash
make stop
```

Start stopped containers:

```bash
make start
```

Stop and remove containers:

```bash
make down
```

## Data

The project stores persistent data outside the containers:

```text
~/data/wordpress
~/data/mariadb
```

This allows important WordPress and MariaDB data to remain available when containers are recreated.

## Warning

The following command performs a full cleanup:

```bash
make fclean
```

This removes the persistent WordPress and MariaDB data.

Do not use `make fclean` if you want to keep the existing project data.