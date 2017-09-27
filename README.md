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
./compose.sh OVERRIDE.yaml PLUGIN-TO-ENABLE
```

**TODO:** future usage...

```bash
./compose.sh OVERRIDE.yaml [--enable-plugin=PLUGIN1,PLUGIN2,...]
```

## Examples

```bash
# Current usage:
./compose.sh stack-override2.yaml chl-news-notifications

# Future usage:
./compose.sh stack-override2.yaml --enable-plugin=chl-news-notifications
```
