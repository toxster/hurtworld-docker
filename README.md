Yarr!

Unofficial docker image for ARK: Survival Evolved w/ PirateWorld mod (auto updated) - http://store.steampowered.com/app/346110/

Possibly the easiest way yet to create your own ARK: Survival Evolved server with them Pirates!  
Just follow the instructions and you'll be up and swearing in minutes!

If you're experiencing issues using this docker image please report them on [Github](https://github.com/toxster/pirate-ark/issues)

### Features
- Allows you to run an ARK: Survival Evolved server via Docker
- Autoupdate of ARK and Mods upon restart of container
- Automatic backup before container startup/update

### Preparations
- Create /data/ark on your system and give permissions to user with UID 1000:  
  `mkdir /data/ark; chown 1000 -R /data/ark/`
- On the docker host increase the ulimits for open files as recommended by ARK devs here: [http://steamcommunity.com/app/346110/discussions/0/594820656471833280/](http://steamcommunity.com/app/346110/discussions/0/594820656471833280/)
  + Edit `/etc/sysctl.conf` and set:  
    `fs.file-max=100000`

  + Edit `/etc/security/limits.conf` and set these limits:  
    `soft nofile 100000`  
    `hard nofile 100000`

  + Edit `/etc/pam.d/common-session` and add the line:  
    `session required pam_limits.so`

    Finally execute: `sysctl -p` or reboot the machine.
- Create your server configuration file
  + Create the directory which holds the configuration files  
  `mkdir -p /data/ark/arkdedicated/ShooterGame/Saved/Config/LinuxServer`
  + Create the file `/data/ark/arkdedicated/ShooterGame/Saved/Config/LinuxServer/GameUserSettings.ini`
    go to [http://steamcommunity.com/app/346110/discussions/0/615086038673139870/](http://steamcommunity.com/app/346110/discussions/0/615086038673139870/) for a list of configuration options


### Usage
- Pull the docker-ark image:  
  `docker pull tobias/pirate-ark`

- Launching a server container:  
  `docker run -d --restart=on-failure:5 -v /data/ark:/data/ark -p 27015:27015/udp -p 7777:7777/udp --name=pirateark tobias/pirate-ark`

- Updating a server container  
  `docker restart ark`
  + Currently no save on exit! Known issue reported by DEVs here:    [http://steamcommunity.com/app/346110/discussions/0/594820656471833280/](http://steamcommunity.com/app/346110/discussions/0/594820656471833280/)
  + Workaround: login to the game server and type the following commands into the console:  
   `enablecheats ADMINPASS`  
   `cheat saveworld`

- Starting a stopped server container  
  `docker start ark`

- Stopping a server container  
  `docker stop ark`
  + Currently no save on exit! Known issue reported by DEVs here:    [http://steamcommunity.com/app/346110/discussions/0/594820656471833280/](http://steamcommunity.com/app/346110/discussions/0/594820656471833280/)
   + Workaround: login to the game server and type the following commands into the console:  
   `enablecheats ADMINPASS`  
   `cheat saveworld`

# Optional variables
- __CHECKFILES__ Set this variable to true in order to validate installation files, this is off by default as it slows down startup a lot.
  + If you want to validate an existing server, remove it first and set the CHECKFILES variable in the run command like so:  
    `docker run -d -e CHECKFILES="true" --restart=on-failure:5 -v /data/ark:/data/ark -p 27015:27015/udp -p 7777:7777/udp --name=pirateark tobias/pirate-ark`

Credits go to [Phantium](https://github.com/phantium/docker-ark/) for the main gruntwork.

