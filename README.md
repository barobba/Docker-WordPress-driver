# Docker WordPress driver

Description
---
A bash script to compose a WordPress, WP-CLI, MySQL environment in Docker, and run through some startup tasks.

Installation
---
Place the WordPress plugin in the "plugin" folder.


Usage
---

```bash
./compose.sh REQUIRED-OVERRIDE.yaml PLUGIN-TO-ENABLE
```

**TODO:**  
Future usage...  

```bash
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
The override file is required.

```yaml
version: "3"
services:

  wordpress: 
    image: biagio2chl/wordpress-ci

  mysql: 
    image: mysql:latest

```
