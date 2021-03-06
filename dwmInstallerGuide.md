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

Also you need to install some `C` header files that `dwm` will be using.

    $ sudo apt-get install libx11-dev libxinerama-dev
    $ sudo apt install libxft-dev

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

We are need to rename the `config.def.h` file with the command:

    $ mv config.def.h config.h
    
Once you've done this you can edit the file with your favorite text editor ( you will need some C knowledge ) and save the changes. Now we just need to compile every file by using the command:

    $ sudo make install clean

We also going to run the same command inside the `dmenu` and `st`/`standar` directories and once you finished compiling every those three directories you wanna
go back to your `/home/user` directory and search for a `.xinitrc` file. In case it don't exits:

    $ echo "exec dwm" >> ~/.xinitrc

And you are supposed to be able to run `startx` command in order to start your dwm enviroment but in my case I get an error

    xauth: timeout in locking authority file /home/user/.Xauthority

But basically all you have to do is remove all the `.Xauthority` files by running this command:

    $ rm -fr .Xauthority-*

## Improving dwm
You already installed dwm and you can use it and customize it howver you want but some stuff I think should be worth it to add its by adding this on your `.xinitrc`

    [ -f /etc/xprofile ] && . /etc/xprofile
    [ -f ~/.xprofile ] && . ~/.xprofile

    while xsetroot -name " Battery: $(cat /sys/class/power_supply/BAT0/capacity)% | Date: `date` | WiFi: $(cat /sys/class/net/wlan0/operstate )"
    do
	    sleep 1
    done &
    exec dwm
 
You can leave the `.xinitrc` as is but this way it will print out your battery status, date and time and your wifi status, also it starts your `.xprofile` which helps you displaying a wallpaper.

In order to set up a wallpaper you will need the `xwallpaper` package, you can simply install this with:

    $ sudo apt install xwallpaper

Now you can use this to display a wallpaper, in my case my desired image file is `wall.png` and its on `~/.config/wallpapers/`. We can set this wallpaper by running the command

	$ xwallpaper --zoom ~/.config/wallpapers/wall.png

By executing this command you already have a wallpaper displayed as your background. In my case I used the `--zoom` argument but you can use other, the aviable agruments can be check on

	$ xwallpaper man
	
The problem with xwallpaper is that once you reboot your pc or terminate dwm the wallpaper is not saved so you must type the `xwallpaper --zoom ~/.config/wallpapers/wall.png` everytime you start dwm, but we dont want that so thats why we made a parameter in your `.xinitrc` earlier that checks on your `.xprofile`. Probably you won't have that file in your pc so you must create it

	$ touch .xprofile

And using the text editor of your preference you want to add the line

	xwallpaper --zoom ~/.config/wallpapers/wall.png

Once this command inside your `.xprofile` file you save the file and now you can end dwm by pressing `MODKEY` + `CTRL` + `Q`, this will causes your dwm terminates and you can restart it again with `startx` and look how your wallpaper is there as soon as your start it.

