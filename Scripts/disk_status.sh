#!/bin/sh

uptime
echo DISK STATUS: 
df -H /dev/sda
smartctl -H /dev/sda | sed '1,4d'
smartctl -xH /dev/sdb  || echo sdb not mounted
echo Latest home backup: $(ls -Art /media/cpt-n3m0/Storage/Backups/home_* | tail -n 1)

