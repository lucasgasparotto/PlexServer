#!/bin/bash
#
echo "Do you want:"
echo "1 - Start Plex"
echo "2 - Stop Plex"
read option
case $option in
    1)
        clear
        echo "Starting Plex"
        docker start plex
        ;;
    2)
        clear
        echo "Stopping Plex"
        docker stop plex
        ;;
    *)
        echo "Invalid option, please choose a correct option: "
        ;;
esac
