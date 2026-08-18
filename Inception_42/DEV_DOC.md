# Developer Documentation (`DEV_DOC.md`)

This document provides step-by-step instructions for developers setting up, building, running, and maintaining the infrastructure from scratch.

---

## 1. Environment Setup

### Prerequisites
Make sure your host machine has the following dependencies installed:

* **OS:** Linux (Ubuntu/Debian recommended) or macOS
* **Docker Engine:** `v20.10+`
* **Docker Compose:** `v2.0+` (Compose V2 `docker compose`)
* **GNU Make:** `v4.0+`
* **Git:** For source control management

### Directory Hierarchy
The project structure must follow this layout before triggering any builds:

```text
.
├── Makefile
├── srcs/
│   ├── docker-compose.yml
│   ├── .env
│   └── requirements/
│       ├── mariadb/
│       │   ├── Dockerfile
│       │   └── tools/
│       ├── nginx/
│       │   ├── Dockerfile
│       │   └── conf/
│       └── wordpress/
│           ├── Dockerfile
│           └── tools/
```

### Configuration & Secrets
Create a `.env` file inside the `./srcs/` directory. This file stores environment configuration and secret keys. **Never commit `.env` or plain-text secrets to Git.**

Example `./srcs/.env` contents:

```ini
# Domain Configuration
DOMAIN_NAME=login.42.fr

# MariaDB Secrets
MYSQL_DATABASE=wordpress
MYSQL_USER=...
MYSQL_PASSWORD=*****
MYSQL_ROOT_PASSWORD=********

# WordPress Secrets
WORDPRESS_TITLE=Inception
WORDPRESS_ADMIN_USER=.......
WORDPRESS_ADMIN_PASSWORD=**************
WORDPRESS_ADMIN_EMAIL=.....
WORDPRESS_USER=......
WORDPRESS_PASSWORD=**************
WORDPRESS_EMAIL=.....
```

> **Local DNS Setup:** Map your domain to loopback by updating `/etc/hosts` on your host machine:
> ```bash
> echo "127.0.0.1 login.42.fr" | sudo tee -a /etc/hosts
> ```

---

## 2. Build & Launch Procedures

All service orchestration is controlled via the root `Makefile`.

* **Build host directories, build images, and start containers in background:**
  ```bash
  make
  ```
  *(Or run `make all` / `make up`)*

* **Stop services without removing persistent host data:**
  ```bash
  make stop
  ```

* **Restart all container services:**
  ```bash
  make restart
  ```

* **Rebuild images from scratch and run:**
  ```bash
  make re
  ```

---

## 3. Container & Volume Management Commands

| Action | Execution Command |
| :--- | :--- |
| **Check running status** | `docker compose -f srcs/docker-compose.yml ps` |
| **Tail combined logs** | `docker compose -f srcs/docker-compose.yml logs -f` |
| **Tail specific container logs** | `docker compose -f srcs/docker-compose.yml logs -f <service_name>` |
| **Enter container shell** | `docker exec -it <container_name> /bin/sh` |
| **List active Docker volumes** | `docker volume ls` |
| **List custom networks** | `docker network ls` |

### Cleanup Operations

* **Stop and remove containers/networks (keeps data intact):**
  ```bash
  make down
  ```

* **Full teardown (removes containers, networks, volumes, and host directories):**
  ```bash
  make clean
  ```

* **System purge (cleans all cached Docker images, unused volumes, and networks):**
  ```bash
  make fclean
  ```

---

## 4. Data Storage & Persistence Mechanism

Data persistence is guaranteed using host-bound volume mappings (bind mounts) pointing to host system paths, typically under `/home/login/data/`.

### Persistent Volume Mappings

1. **MariaDB Database Files**
   * **Host System Path:** `/home/login/data/mariadb`
   * **Container Internal Path:** `/var/lib/mysql`
   * **Stored Data:** Table definitions, raw database records, post indexes, and user accounts.

2. **WordPress Application Files**
   * **Host System Path:** `/home/login/data/wordpress`
   * **Container Internal Path:** `/var/www/html`
   * **Stored Data:** WordPress core files, PHP scripts, themes, installed plugins, and uploaded media attachments.

### Persistence Lifecycle
* Stopping or re-creating containers (`docker compose down`, `make stop`, `make restart`) does **not** erase host storage directories.
* When containers boot up, Docker mounts these host folders back into `/var/lib/mysql` and `/var/www/html`, maintaining complete database and site state across reboots.
* Data wipe only occurs upon running `make clean` or manually executing `sudo rm -rf /home/login/data/*` on the host machine.يخ