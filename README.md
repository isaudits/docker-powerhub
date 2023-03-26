# docker-powerhub
Docker implementation of Powerhub framework

## Description
Coming soon!

## Build Notes
Pull:

    docker pull isaudits/powerhub

or Build:

    ./build.sh

# Usage
Provided launcher script for powerhub will automatically launch Powerhub server 
with parameters based on environment variables or program defaults. If any additional 
arguments are passed to the script, those will be passed as parameters.

Provided launcher script for power-obfuscate will execute power-obfuscate with provided arguments.

Metasploit framework has been included to provide msfvenom capabilities. Provided msfvenom
launcher script will execute msfvenom with provided arguments and the output can be piped to 
the power-obfuscate launcher script. Resulting output of the power-obfuscate script to stdout
can then be piped to a local file.

--------------------------------------------------------------------------------

Copyright 2023

Matthew C. Jones, CPA, CISA, OSCP, CCFE

Symphona - <https://www.symphona.us/>

--------------------------------------------------------------------------------

Except as otherwise specified:

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.