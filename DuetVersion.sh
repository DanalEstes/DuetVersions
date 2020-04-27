#!/usr/bin/env bash
LIST="$( apt list duetsoftwareframework -a 2>/dev/null)"

HIGH="$( echo "$LIST" | head -n2 | tail -n1 | cut -d' ' -f 2)"  
printf "  Highest Available DuetSoftwareFramework = $HIGH\n"

DSFV=$( echo "$LIST" | grep installed | cut -d' ' -f 2 )  
printf "Currently Installed DuetSoftwareFramework = $DSFV\n"

if [ $# -gt 0 ]
then
	printf "\n"
	printf "Command line arg specified to request Release -$1 from highest available.\n"
	DSFV=$( echo "$LIST" | head -n$1 | tail -n1 |  cut -d' ' -f 2 )  
	printf "       Highest-$1 is DuetSoftwareFramework = $DSFV\n"
fi

printf "\n"
printf "Dependencies for DSF version $DSFV are:\n"
SHOW="$(apt show duetsoftwareframework=$DSFV 2>/dev/null | grep Depends | tr ',' '\n' | tr ':' '\n' | grep -v Depends) )"
echo "$SHOW"

RRFV="$( echo "$SHOW" | grep reprap -m1 | tr ')' ' ' |cut -d' ' -f4 )"

# Download a reprapfirmware repository, extract it, and find the version identifier in the binary. 
mkdir /tmp/rrf$RRFV > /dev/null 2>&1
cd /tmp/rrf$RRFV
apt download reprapfirmware=$RRFV > /dev/null 2>&1
dpkg-deb -R rep*_$RRFV*.deb . > /dev/null 2>&1
RRFR=$( strings opt/dsf/sd/sys/D*_MB6HC.bin | grep -a version= | tail -n1 | cut -d'=' -f2 )
rm -r /tmp/rrf$RRFV > /dev/null 2>&1

printf "\n"
printf "reprapfirmware apt version $RRFV is internal version $RRFR\n"

