#!/usr/bin/env bash
if [ $# -eq 0 ]
then
	printf "Please specify an argument that indicates the desired release of duetsoftwareframework.\n"
	printf "Example: ./DuetRegress 1.2.3.0\n"
	exit
fi	

LIST="$( apt list duetsoftwareframework -a 2>/dev/null | grep -v -i Listing)"
DSFV=$( echo "$LIST" | grep installed | cut -d' ' -f 2 )  
printf "Currently Installed duetsoftwareframework=$DSFV\n"
# N=$(expr $1 + 1)

printf "Command line argument is requesting duetsoftwareframework=$1\n"

SHOW="$(apt show duetsoftwareframework=$1 2>/dev/null | grep Depends | tr ',' '\n' | tr ':' '\n' | grep -v Depends )"
RRFV="$( echo "$SHOW" | grep reprap -m1 | tr ')' ' ' |cut -d' ' -f4 )"

if [ ! $RRFV ]
then
	printf "Release $1 of duetsoftwareframework not found.\n"
	exit
fi

# Download a reprapfirmware repository, extract it, and find the version identifier in the binary. 
mkdir /tmp/rrf$RRFV > /dev/null 2>&1
cd /tmp/rrf$RRFV
apt download reprapfirmware=$RRFV > /dev/null 2>&1
dpkg-deb -R rep*_$RRFV*.deb . > /dev/null 2>&1
RRFR=$( strings opt/dsf/sd/sys/D*_MB6HC.bin | grep -a version= | tail -n1 | cut -d'=' -f2 )
rm -r /tmp/rrf$RRFV > /dev/null 2>&1
printf "Which has associated reprapfirmware of $RRFV also known as $RRFR\n"
printf "\n"
printf "***********************************************************************************\n"
printf "* Note: The next step will run for a while; the script is (probably) not hung.    *\n"
printf "***********************************************************************************\n"
DEPS=$(echo "$SHOW" |  sed 's/<\|>//g;s/(=/=/g;s/ = /=/g;s/)/ /g;s/[^ ]*999//')
MAST="$DEPS"
DEPL=$(echo "$DEPS" | tr ' ' '\n')
for PACK in $DEPL
do
	SHOW="$(apt show $PACK 2>/dev/null | grep Depends)"
	DEPS=$(echo "$SHOW" |  sed 's/<\|>//g;s/(=/=/g;s/ = /=/g;s/)/ /g;s/[^ ]*999//;s/Depends:/ /g;s/,/ /')
	MAST="$MAST $DEPS" 
done
MAST=$(echo "$MAST" | sed 's/  / /g')
MASL=$(echo "$MAST" | tr ' ' '\n')
MASL=$(echo "$MASL" | grep '=')
SORT=$(echo "$MASL" | sort --unique --field-separator== -k 1,1 )
MAST=$(echo "$SORT" | tr '\n' '\' | sed 's|\\| \\\n    |g')
printf "\n"
printf "To regress to DSF version $1 which is RRF version $RRFR:\n"
printf "1) Backup your files via:\n"
printf "  mkdir ~/duetback\n"
printf "  cp -r /opt/dsf/sd/* ~/duetback\n"
printf "or similar. Verify that the backup worked: 'ls ~/duetback' should show directories: 'filaments firmware gcodes macros sys' or similar.\n"
printf "\n"
printf "2) Run this command: (it uses line continue back slashes, be sure you get it all)\n"
#printf "  sudo apt -y remove duetsoftwareframework\n"
printf "  sudo apt install \\ \n    duetsoftwareframework=$1 \\ \n    $MAST--allow-downgrades\n"
printf "\n"
printf "3) Verify system is running properly, web interface opens, etc\n"
printf "\n"
printf "4) If Pi runs, but won't connect to Duet Board, bossa the board \n"
printf "   with the file found at /opt/dsf/sd/sys/Duet3Firmware_MB6HC.bin \n"
printf "   Instructions here: \n"
printf "   https://duet3d.dozuki.com/Wiki/Getting_Started_With_Duet_3#Section_Updating_Duet_3_main_board_firmware \n"
printf "\n"
printf "5) Check files like config.g, macros, etc, and restore as required.\n"
