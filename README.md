# DuetVersions
Commands to correlate 'apt' versions to Duet style "V3.01 RC5"

## Installation
    cd
    git clone https://github.com/DanalEstes/DuetVersions

## Run
    cd
    cd DuetVersions
    ./DuetVersion.sh

By default shows highest available, installed, and dependencies for installed, and reprapfirmware internal version for installed. Specify a number as a command line argument to see same info for that many lines 'backward' from highest available.

    cd
    cd DuetVersions
    .DuetVersionAll.sh

Shows version and associted reprapfirmware internal version, for all duetsoftwareframework packages available on your feed(s)
