#!/usr/bin/env bash
printf "Expect this to take several seconds per line of output.\n"
printf "Note: For highest accuracy, run 'sudo apt get update' first.\n"
printf "\n"
LIST="$( apt list duetsoftwareframework -a 2>/dev/null | grep -i -v listing)"


while IFS= read -r LINE
 	do
 	DSFV="$( echo "$LINE" | head -n2 | tail -n1 | cut -d' ' -f 2)"  
	SHOW="$(apt show duetsoftwareframework=$DSFV 2>/dev/null | grep Depends | tr ',' '\n' | tr ':' '\n' | grep -v Depends) )"
	RRFV="$( echo "$SHOW" | grep reprap -m1 | tr ')' ' ' |cut -d' ' -f4 )"

	# Download a reprapfirmware repository, extract it, and find the version identifier in the binary. 
	mkdir /tmp/rrf$RRFV > /dev/null 2>&1
	cd /tmp/rrf$RRFV
	apt download reprapfirmware=$RRFV > /dev/null 2>&1
	dpkg-deb -R rep*_$RRFV*.deb . > /dev/null 2>&1
	if [ -f "opt/dsf/sd/sys/Duet3Firmware_MB6HC.bin" ]
	then
		RRFR=$( strings opt/dsf/sd/sys/Duet3Firmware_MB6HC.bin | grep -a version= | tail -n1 | cut -d'=' -f2 )
		 DWC=$(echo "$SHOW" | grep duetwebcontrol | sed 's/duetwebcontrol.*=//' | sed 's|)||' | sed 's/  / /g')
		printf "DSF V$DSFV DWC$DWC RRF $RRFR\n"
	else
		printf "duetsoftwareframework $DSFV - Unable to determine reprapfirmware version.\n"
	fi
	rm -r /tmp/rrf$RRFV > /dev/null 2>&1

done <<< "$LIST"
exit

