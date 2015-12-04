#!/usr/bin/env bash

cd /data/hurtworld

# Get steamcmd
if [ ! -f steamcmd_linux.tar.gz ]; then
        echo -e "Grabbing SteamCMD...\n"
        wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
        tar -xf steamcmd_linux.tar.gz
fi

# Backup before updating just to be safe
saves=$(ls /data/hurtworld/hurtworlddedicated/autosave_* 2> /dev/null | wc -l)
if [ "$saves"" != "0" ]; then
        echo -e "Backing up autosaves...\n"
	if [ ! -d /data/hurtworld/backup/ ]; then
		mkdir /data/ark/backup/
	fi
	tar czf /data/ark/backup/Saved-startup_$(date +%Y-%m-%d_%H-%M).tar.gz /data/hurtworld/hurtworlddedicated
fi


# Update / install server
echo -e "Updating HurtWorld...\n"
./steamcmd.sh +login anonymous +force_install_dir /data/hurtworld/hurtworlddedicated +app_update 405100 +quit


# Start Hurtworld 
cd /data/hurtworld/hurtworlddedicated/
export LD_LIBRARY_PATH=/data/hurtworld/hurtworlddedicated/

#echo -e "Launching HurtWorld Dedicated Server.. .\n"
#
./Hurtworld.x86 -batchmode -nographics -exec "host 7778;queryport 27016;servername HYPE;maxplayers 70" -logfile log
