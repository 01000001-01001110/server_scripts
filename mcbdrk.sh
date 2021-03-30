#!/bin/bash
#Alan's bedrock MC setup script.
#Version 0.0.1
#Date 3/30/2021

read -p "Server Name : " servername
read -p "Game Mode, Select either creative|survival : " gamemode
read -p "Seed : " seed
read -p "Port : " port
if ! [[ "$port" =~ "^[0-9]+$" ]]
        then
            echo "Sorry integers only"
fi
read -p "Require Microsoft Account, Select either true|false : " online
read -p "Container Name : " contname
read -p "Spawn NPCs, Select either true|false : " npc
read -p "Server Monsters, Select either true|false : " monster
read -p "Spawn animals, Select either true|false : " animal
docker run -d -it -e EULA=TRUE --name $contname -e SERVER_NAME=$servername -e GAMEMODE=$gamemode -e ONLINE_MODE=$online -e level_seed=$seed -e difficulty=normal -e spawn-npcs=$npc -e spawn-monsters=$monster -e spawn-animals=$animal  -p 19133:19132/udp itzg/minecraft-bedrock-server --restart always
