#!/bin/bash

if [ -z "$1" ]; then
    # First variable missing
    # See https://stackoverflow.com/a/6482403/382770

    (>&2 echo 'Missing docker-compose override file'; \
         echo 'Usage: ./compose.sh override-file.yaml' )
    # See https://stackoverflow.com/a/23550347/382770

    with_errors=1
    exit $with_errors

else
    : # pass; see https://stackoverflow.com/a/17583599/382770
fi

# healthcheck() {
#
#     docker inspect --format='{{.State.Health.Status}}' $1
#
# }

is_wordpress_container_ready() {

    local is_apache_running="$(docker exec -i ${1} /etc/init.d/apache2 status)"
    if [ "$is_apache_running" = "apache2 is running." ]; then

        echo true
        return 0

    else

        echo false
        return -1

    fi

}

wait_for_wordpress_container_to_be_ready() {

    # Block until container is ready

    local wp_statuscheck_count=1
    local wp_statuscheck_interval=5 # seconds
    local wp_statuscheck_totalwait=0
    local wp_statuscheck_status=`is_wordpress_container_ready $1`

    # echo $wp_statuscheck_status

    while [ "$wp_statuscheck_status" = false ]; do

        wp_statuscheck_totalwait=$[ ($wp_statuscheck_count - 1) * $wp_statuscheck_interval ]

        echo "Waiting for WordPress container to finish loading... Sleeping $wp_statuscheck_interval seconds (status: ${wp_statuscheck_status}, attempts: ${wp_statuscheck_count}, wait: ${wp_statuscheck_totalwait} seconds)"
        # See https://stackoverflow.com/a/44581064/382770

        sleep $wp_statuscheck_interval
        wp_statuscheck_status=`is_wordpress_container_ready $1`
        ((wp_statuscheck_count++))
        
        # echo $wp_statuscheck_status

    done

}

main_script() {

    local wordpress_container=bbna-notificationclient-wordpress
    local mysql_container=bbna-notificationclient-mysql

    echo '# Removing containers to clear out existing data'

    if [ "$(docker ps -q -f name=$wordpress_container)" ]; then

        docker stop $wordpress_container
        docker rm $wordpress_container

    else

        : # pass

    fi

    if [ "$(docker ps -q -f name=$mysql_container)" ]; then

        docker stop $mysql_container
        docker rm $mysql_container

    else

        : # pass

    fi

    echo '# Starting application stack (using: docker-compose)'
    docker-compose -f stack-base.yaml -f $1 up -d

    echo '# Waiting for WordPress container'
    wait_for_wordpress_container_to_be_ready $wordpress_container

    echo '# Running container operations'

    # Install WordPress
    docker exec -i $wordpress_container \
        bash -c 'wp core install --allow-root \
                                 --path=/var/www/html \
                                 --url=localhost:8080 \
                                 --title="Testing" \
                                 --admin_user=admin \
                                 --admin_password=password \
                                 --admin_email=biagio+admin@ch-labs.com \
                                 --skip-email'

    if [ -z "$2" ]; then
        : # pass
          # TODO: Swap this with the ELSE portion (might need to use getopt)
    else

        # Enable plugin
        # TODO: Use format --enable-plugin=PLUGIN1,PLUGIN2
        docker exec -i $wordpress_container \
            bash -c 'wp plugin activate $2 --allow-root'

    fi

    # Mark to send notifications (in plugin)
    # Mark "posts" for sending notifications (in plugins)

}

main_script $1
