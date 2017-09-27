# Docker WordPress plugin driver, for testing plugins

Description
---
A bash script to compose a WordPress, WP-CLI, PHP, MySQL environment in Docker, and run through some startup tasks, for testing WordPress plugins.

Installation
---
Place the WordPress plugin in the "plugin" folder.


Usage
---

```bash
./compose.sh REQUIRED-OVERRIDE.yaml PLUGIN-TO-ENABLE

# TODO: Future usage...
./compose.sh REQUIRED-OVERRIDE.yaml [--enable-plugin=PLUGIN1,PLUGIN2,...]
```

**Examples:**  

```bash
# Current usage:
./compose.sh stack-override2.yaml chl-news-notifications

# Future usage:
./compose.sh stack-override2.yaml --enable-plugin=chl-news-notifications
```

## Override file
The override file is required, so at least we know which versions of WordPress, PHP, and MySQL to run.

```yaml
version: "3"
services:

  wordpress: 
    image: biagio2chl/wordpress-ci

  mysql: 
    image: mysql:latest

```
