#!/bin/bash
#---
## @Synopsis    Install script for Harmony
## @Copyright   Copyright 2013, Laurent Legendre
## @License     GPL : http://www.gnu.org/licenses/gpl-3.0.txt
#---
###############################################################################
# Copyright (C) <2013>  <TACT Factory>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/gpl-3.0.txt
#
# For more information, please contact us at contact@tactfactory.com
###############################################################################

# Define centreon version
version_installer="0.1.0"

#----
## Usage informations for harmony_install.sh
## @Sdtout      Usage informations
#----
function usage() {
   local program=$0
   echo -e "\nHarmony - Copyright (C) 2013  TACT Factory\n
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions. See http://www.gnu.org/licenses/gpl-3.0.txt\n\n"
   echo -e "Usage: $program [OPTION]"
   echo -e "  -i\t Install Harmony"
   echo -e "  -V\t Display Harmony installer version and exit"
   echo -e "  -h\t Display this help and exit"
   echo ""
   return 0
}

function compile() {
   local bundleName=$1
   echo -e "\n> Compiling project\n-------------------"
   ant "-buildfile" "$harmonyPath/vendor/$bundleName/build.xml"
   [ $? -ne 0 ] && echo "[BUILDING FAIL] - Check your config and retry" && exit 1
}

function is_valid_dir() {
   local directory=$1
   if [ -d "$directory" ]; then
	if [ -w "$directory" ]; then
	   return 0
	else
	   echo "Folder $directory is not writable, please retry"
	   return 1
	fi
   else
	echo "$directory is not a valid folder, please retry"
	return 1
   fi
}


function installer() {
   local harmonyPath=$1
   if [ ! -z "$harmonyPath" ] 
      then
           is_valid_dir $harmonyPath
           resume=$?
      else
           resume=-1
   fi
   while [ $resume -ne 0 ]; do
	echo "Where do you want to install Harmony ?"
	read harmonyPath
	is_valid_dir $harmonyPath
	resume=$?
   done


   echo -e "\n> Cloning Harmony remote git repository\n---------------------------------------"
   git "clone" "--recursive" $TACT_CORE_REMOTE_GIT "$harmonyPath"
   [ $? -ne 0 ] && echo "[GIT CLONE FAIL] - Check your config and retry" && exit 1

   compile "tact-core"
   compile "tact-rest"

   echo -e "\n>>> CONGRATS! <<<\n-----------------\nHarmony installation complete !"
   echo -e "You can now start using Harmony by executing commands with $harmonyPath/script/console.sh\n"

}

## Settings vars
TACT_CORE_REMOTE_GIT="ssh://git@git.tactfactory.com:2222/harmony/harmony.git"

if [ ! -z "$2" ]
   then
      installPath="$2"
fi

## Parse options
while getopts ":iVh" Options
do
        case ${Options} in
                i )   echo ">>> Starting Harmony Installer <<<" ; installer $installPath; exit 0 ;;
                V )   echo $version_installer ; exit 0 ;;
                h )   usage ; exit 0 ;;
                * )   echo "Invalid option: -$OPTARG" >&2 ; usage ; exit 1 ;;
        esac
done

## Display usage if no args given
if [ "x$@" = "x" ] ; then
        usage; exit 1
fi

## Display usage if args given not starting with "-"
if [ "x$@" != "x-"* ] ; then
        echo "Invalid option: $@" >&2 ; usage ; exit 1
fi
