#!/bin/bash
rclone mount GDrive: $GDRIVE/GDrive --daemon --allow-other --buffer-size 512M --dir-cache-time 24h --poll-interval 15s --timeout 1h --user-agent 'yendorapp'
echo "Successfull"
