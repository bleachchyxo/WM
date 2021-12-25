# Installing ratpoison wm

The installation of this wm it's really simple, the configuration it's the hard part. In order to install it you must install this packages first

    $ sudo apt install build-essential
    $ sudo apt install ratpoison
    $ sudo apt install xorg

once you've done this you need to create a `.xinitrc` file and put this inside

    exec ratpoison
    
and you ready to go when you type `startx`.
