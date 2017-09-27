# Docker WordPress driver

Description
---
A bash script to compose a WordPress, WP-CLI, MySQL environment in Docker, and run through some startup tasks.

Installation
---
Place the WordPress plugin in the "plugin" folder.


Usage
---
./compose.sh OVERRIDE.yaml PLUGIN-TO-ENABLE

**TODO:** Future usage...  
... ./compose.sh OVERRIDE.yaml [--enable-plugin=PLUGIN1,PLUGIN2,...]


## Examples
./compose.sh stack-override2.yaml chl-news-notifications
./compose.sh stack-override2.yaml --enable-plugin=chl-news-notifications
