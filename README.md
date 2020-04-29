# DuetVersions
Commands to correlate 'apt' versions (such as 2.1.1) to Duet internal firmware nomenclature (such as "V3.01 RC5")

## Installation
    cd
    git clone https://github.com/DanalEstes/DuetVersions

## Run DuetVersion.sh

* By default shows highest available, installed, and dependencies for installed, and reprapfirmware internal version for installed. 
* Specify a number as a command line argument to see same info for that many lines 'backward' from highest available. Example:

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

* Shows version and associated reprapfirmware internal version, for all duetsoftwareframework packages available on your feed(s). Example:

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




