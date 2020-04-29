# DuetVersions
Commands to correlate 'apt' versions (such as 2.1.1) to Duet internal firmware nomenclature (such as "V3.01 RC5")

## Installation
    cd
    git clone https://github.com/DanalEstes/DuetVersions

## Run DuetVersion.sh

* By default shows highest available, installed, and dependencies for installed, and reprapfirmware internal version for installed, version of duetcontrolframework. 
* Specify a number as a command line argument to see same info for that many lines 'backward' from highest available duetcontrolframework. 

Example:

` ./DuetVersion.sh 22`<br>
`  Highest Available DuetSoftwareFramework = 2.1.1`<br>
`Currently Installed DuetSoftwareFramework = 2.1.1`<br>
` `<br>
`Command line arg specified to request Release -22 from highest available.`<br>
`       Highest-22 is DuetSoftwareFramework = 1.0.4.1`<br>
` `<br>
`Dependencies for DSF version 1.0.4.1 are:`<br>
` duetcontrolserver (= 1.0.4.1)`<br>
` duetsd (= 1.0.3)`<br>
` duettools (= 1.0.4.1)`<br>
` duetwebserver (= 1.1.1.0)`<br>
` duetwebcontrol (= 2.0.0-5)`<br>
` reprapfirmware (>= 1.0.4.1-1)`<br>
` reprapfirmware (<= 1.0.4.1-999) )`<br>
` `<br>
` `<br>
`reprapfirmware apt version 1.0.4.1-1 is internal version 3.0beta10+1`<br>

## Run DuetVersionsAll.sh

* Shows version and associated reprapfirmware internal version, for all duetsoftwareframework packages available on your feed(s). See https://duet3d.dozuki.com/Wiki/Getting_Started_With_Duet_3#Section_Software_Installation for more information

Example:

`./DuetVersionsAll.sh`<br>
`Expect this to take several seconds per line of output.`<br>
` `<br>
`duetsoftwareframework 2.1.1 contains reprapfirmware version 2.1.1-1 which is internal version 3.01-RC10`<br>
`duetsoftwareframework 2.1.0 contains reprapfirmware version 2.1.0-1 which is internal version 3.01-RC9`<br>
`duetsoftwareframework 2.0.0 contains reprapfirmware version 2.0.0-1 which is internal version 3.01-RC8`<br>
`duetsoftwareframework 1.3.2 contains reprapfirmware version 1.3.2-1 which is internal version 3.01-RC7`<br>
`duetsoftwareframework 1.3.1 contains reprapfirmware version 1.3.1-1 which is internal version 3.01-RC6`<br>
`...snip...`<br>

## Run DuetRegress.sh

* Shows commands that will install a 'back' or 'regressed' version of DSF and friends. 

Example: 
 `./DuetRegress.sh 2.1.0`<br>
`Currently Installed duetsoftwareframework=2.1.2`<br>
`Command line argument is requesting duetsoftwareframework=2.1.0`<br>
`Which has associated reprapfirmware of 2.1.0-1 also known as 3.01-RC9`<br>
` `<br>
`***********************************************************************************`<br>
`* Note: The next step will run for a while; the script is (probably) not hung.    *`<br>
`***********************************************************************************`<br>
` `<br>
`To regress to DSF version 2.1.0 which is RRF version 3.01-RC9:`<br>
`1) Backup your files via:`<br>
`  mkdir ~/duetback`<br>
`  cp -r /opt/dsf/sd/* ~/duetback`<br>
`or similar. Verify that the backup worked: 'ls ~/duetback' should show directories: 'filaments firmware gcodes macros sys' or similar.`<br>
` `<br>
`2) Run this command: (it is long, be sure you get it all on one line)`<br>
`  sudo apt -y --allow-downgrades install duetsoftwareframework=2.1.0 duetcontrolserver=2.1.0 duetruntime=2.1.0 duetsd=1.0.6 duettools=2.1.0 duetwebcontrol=2.1.4 duetwebserver=2.1.0 reprapfirmware=2.1.0-1`<br>
` `<br>
`3) Verify system is running properly, web interface opens, etc`<br>
` `<br>
`4) If Pi runs, but won't connect to Duet Board, bossa the board`<br>
`   with the file found at /opt/dsf/sd/sys/Duet3Firmware_MB6HC.bin`<br>
`   Instructions here:`<br>
`   https://duet3d.dozuki.com/Wiki/Getting_Started_With_Duet_3#Section_Updating_Duet_3_main_board_firmware`<br>
` `<br>
`5) Check files like config.g, macros, etc, and restore as required.`<br>




