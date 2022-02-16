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




