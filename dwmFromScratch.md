# Suckless installation guide from scratch
Im going to be installing suckless from scratch on Devuan, this means I my Devuan installation has no GUI (You can avoid installing a GUI while installing the OS).

## Fixing the Devuan mirrors
For some reason Devuan has a mirror on the source list that causes a `cdrom` error, this error makes you unable to download packages and update or upgrade your system. To fix this you just need to go on `root` by typing

    $ su

Once you on `root` user you need to edit the `sources list` or mirror list

    # nano /etc/apt/sources.list

The `sources.list` file should look like this

    #

    # deb cdrom:[Devuan GNU/Linux 3.1 beowulf amd64 - desktop 20210315]/ beowulf contrib main non-free

    deb cdrom:[Devuan GNU/Linux 3.1 beowulf amd64 - desktop 20210315]/ beowulf contrib main non-free

    deb http://pkgmaster.devuan.org/merged beowulf main
    deb-src http://pkgmaster.devuan.org/merged beowulf main

    deb http://pkgmaster.devuan.org/merged beowulf-security main
    deb-src http://pkgmaster.devuan.org/merged beowulf-security main

    # beowulf-updates, previously known as 'volatile'
    deb http://pkgmaster.devuan.org/merged beowulf-updates main
    deb-src http://pkgmaster.devuan.org/merged beowulf-updates main

As you can se there is a `non-free` cdrom that you just need to comment by adding a `#` at the start of the line looking like this

    # deb cdrom:[Devuan GNU/Linux 3.1 beowulf amd64 - desktop 20210315]/ beowulf contrib main non-free

Now you can upgrade your system but this lead us to our next problem...

## Fixing internet connection
Your Devuan system is just running the essentials so the OS can work but you have no internet, if you try to ping a website, for example:

    # ping searx.xyz

You will get a `100% packet loss` meaning you dont have internet at all. Even if you connect your machine via ethernet you will get the exact same result, but here is how you can fix it. 
Connect the ethernet cable to your computer and the way to make your computer to recognize it is by using the command `dhclient`. Currently your `/sbin` path 
hasn't been exported to your bash source so many useful applications/programs stored on `/sbin/` can't be executed, at least just by typing their names as it's supposed to.
You can try typing whatever program stored on `/sbin` path like `ifconfig` and it won't work. Dont believe me? try it yourslef

    root@devuan:/home/user# ifconfig
    
    bash: ifconfig: command not found

For now we won't fix this because it's caused due a missing line on the `.bashrc` file and it will be modified in the future so if we fix this now means 
we must repeat the process in the future so not worth it.


Running programs from `/sbin` it's easier than you think you just need to type `/sbin/` at the beginning of the command, in our case we want to run the `dchlient` so we
type:

    # /sbin/dhclient eth0

The `eth0` specifies that we want to connect via ethernet, this allows your computer to recognize the ethernet cable and your internet connection is stablished. Now
you can ping `searx.xyz` again and you will recieve `0% packet loss`.

## Installing packages

Now that we fixed the pakcage mirrors and stablished an internet connection you should update/upgrade your OS

    # apt update
    # apt upgrade

Done that, we can continue installing important packages that sucklees rely on, starting with `gcc compiler`

    # apt install build-essential

Once it finished installing you can confirm this with the command:

    # gcc --version

and you should get an output like this if you've done everything correctly:

    gcc (Debian 8.3.0-6) 8.3.0
    Copyright (C) 2018 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Now we proceed to install another important packages and libraries

    # apt install libx11-dev libxinerama-dev libxft-dev git vim

I've installed `vim` because is my favorite text editor but you can continue using `nano` or maybe `emacs`.

## Installing suckless

On your `/home/user` shouln't be any directoy yet, maybe just a couple of hidden files you can see by typing `ls -a` like `.bashrc` but nothing relevant. If so, all linux distros have a hidden config folder on this path, so we must create it

    # mkdir .config

Now you `cd` on this new directoy, here we will store all our config files from most of our programs. 


The instructions to install suckless are written in the main dwm website: https://git.suckless.org/dwm/file/README.html or in the dwm file once you downloaded but maybe not that clear.

So the first thing we are going to do it's cloning this three repos:

    # git clone https://git.suckless.org/dwm 

This ones are optional but HIGHLY RECOMMENDED.

    # git clone https://git.suckless.org/dmenu 
    # git clone https://git.suckless.org/st

Next thing we are going to do its `cd` into the new `dwm` folder created in our `/home/user/.config` directory and by typing ls you must get this files:

    config.def.h  drw.c  dwm.1  dwm.png  Makefile trancient.c  util.h
    config.mk     drw.h  dwm.c  LICENSE  README   util.c
    
You can edit the `config.def.h` file to costumize the sucklees look or add custom keybinds (you will need some C knowledge). Now we just need to compile every file by using the command:

    # make install

We also going to run the same command inside the other new directories `demnu` and `st` (in case you downloaded them too). Once you finished compiling those three
folders want to exit from the `.config` folder and go back to `/home/user` and search for a `.xinitrc` file. In case it doesn't exits (my case) you can create it by typing

    # echo "exec dwm" >> ~/.xinitrc

## Installing Xorg
You basically finished installing sucklees but there still a few problems we need to fix. Most linux distros use a window engine called `Xorg`, of course our Devuan installation doesn't have xorg installed but it's easy to install

    # apt install xorg
    # apt install x11-xserver-utils

With `Xorg` you can run basic windows like a browser or a videogame, etc.

## Wicd

Another problem we have is the internet connection, maybe you have a laptop and you don't want to depend on the ethernet cable, after all the whole point of a laptop it's their mobilty. So in order to be able to connect via `wireless` you need to install `wicd` a network manager that comes by default on Devuan (with a GUI of course).

    # apt install wicd
    
# Doas

Most linux distros use `sudo` as their root manager, sudo has been proven insecure multiple times since it has lots of vunerabilies. Luckily our OS also forgot to install `sudo` out of the box so in case you want to install it just type

    # apt install sudo

In my case I'll be installing `doas`. The instructions are in the main github page https://github.com/slicer69/doas, but Im going to explain it anyways.


First we need to install some extra packages

    # apt install make bison flex libpam0g-dev

Now you need to go back again inside your `.config` file and clone the doas repository:

    # git clone https://github.com/slicer69/doas

onced installed you `cd` into the new `doas` folder created and type

    # make install

And basically you just installed doas on your system, now you probably wanna give some user `root` perms so you need to create a file

    # vim /usr/local/etc/doas.conf

Again, I used `vim` but you can use whatever text editor you like. Now we are writing inside this new config file we just created we need to add a line:

    permit user as root

In this case you replace `user` to your user account or the account you want to give root privileges.

You can now start your suckless enviroment, REMEMBER to exit the `root` just by tiping `exit` and you can run this command:

    $ startx
