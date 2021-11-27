# Installing dwm

## Installing C

First of all `dwm` is a `C` written program so you want to install `gcc` compiler by running this commands:

    $ sudo apt update

Once we done updating the packages lists we want to install the `build-essential` packages by running the command:

    $ sudo apt install build-essential

You may also want to install the manual pages that includes documentation about using GNU/Linux for development:

    $ sudo apt-get install manpages-dev

Now you have `gcc` compiler already installed, you can confirm this with the command:

    $ gcc --version

and you should get an output like this if you've done everything correctly:

    gcc (Debian 8.3.0-6) 8.3.0
    Copyright (C) 2018 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 
## Note
You must install `git` too, this one is easy to install since all you need to do to install the package it's just typing the well known

    $ sudo apt install git

## Installing dwm
The instructions are written in the main dwm website: https://git.suckless.org/dwm/file/README.html or in the dwm file once you downloaded but maybe not that 
clear.


So the first thing we are going to do it's cloning this three repos:

    $ git clone git://git.suckless.org/dwm
    
This ones are optional but HIGHLY RECOMMENDED.

    $ git clone https://git.suckless.org/dmenu 
    $ git clone https://git.suckless.org/st

Next thing we are going to do its `cd` into the new `dwm` folder created in our `/home/user/` directory and by typing `ls` you must get this files:

    config.def.h  drw.c  dwm.1  dwm.png  Makefile trancient.c  util.h
    config.mk     drw.h  dwm.c  LICENSE  README   util.c

