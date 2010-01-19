MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Security Context Type Changes
Date: Tue, 19 Jan 2010 15:15:34 -0600
Message-ID: <822A6B57FFD31647BB62F4676394C675034B6C0F@XMBTX131.northgrum.com>
In-Reply-To: <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil>
References: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com> <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil> <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com> <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil>
From: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

I apologize for my lack promptness, I have been in and out of the
office. We are in the middle of transitioning from RHEL4 to RHEL5 so
some of the links maybe off. Anyhow, here is our run_xstart.bash script:
========================================================================
========================
PATH=/usr/X11R6/bin:$PATH; export PATH
MODE=standalone
BACKEND=localhost

#
#       Do any computer-specific processing necessary
#
if [[ ! -f /tmp/.quickstart ]]; then
    #
    #   Put up the screen background
    #
    ROOTW=$(/usr/bin/X11/xrdb -symbols | \
          awk 'BEGIN {FS="="} $1 ~ /-DWIDTH/ {print $2}')
    DEPTH=$(/usr/bin/X11/xrdb -symbols | awk 'BEGIN {FS="="}
$1~/^-DPLANES$/ {print $2}')
    echo "ROOT WIDTH = $ROOTW"
    if [ $ROOTW -ge 1024 ] ; then
        ####BGFILE=hgttg-5.gif
        BGFILE=app-1024.gif
    elif [ $ROOTW -ge 800 ]; then
        BGFILE=app-800.gif
    else
        BGFILE=app-640.gif
    fi

    if [ "$ROOTW" -eq 640 -a "$DEPTH" -eq 8 ]
    then
        echo "not displaying background picture"
    else
        /usr/bin/X11/xloadimage -onroot -center -border black \
           -quiet -private /h/ProjectX/images/$BGFILE &
    fi
fi

#
#       Start the window manager
#
export HOME=/h/ProjectX
export SHELL=/bin/bash
sleep 1

# Get ip address of primary display #
DISPLAY1=$DISPLAY;export DISPLAY1

# Start window manager for primary display #
exec /usr/bin/fvwm -display $DISPLAY1 \
     -cmd "Read /h/ProjectX/config_values/system.fvwmrc"

========================================================================
===============


Thanks again.

Gregg

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Monday, January 11, 2010 11:24 AM
To: Tomas, Gregg A (IS)
Cc: selinux@tycho.nsa.gov
Subject: RE: Security Context Type Changes

On Sun, 2010-01-10 at 17:43 -0600, Tomas, Gregg A (IS) wrote:
> Thank you Stephen for replying.
> 
> The following is our inittab configuration
> 
> 
> id:4:initdefault:
> 
> ~:S:wait:/sbin/sulogin
> 
> # System initialization.
> si::sysinit:/etc/rc.d/rc.sysinit
> 
> l0:0:wait:/etc/rc.d/rc 0
> l1:1:wait:/etc/rc.d/rc 1
> l2:2:wait:/etc/rc.d/rc 2
> l3:3:wait:/etc/rc.d/rc 3
> l4:4:wait:/etc/rc.d/rc 4
> l5:5:wait:/etc/rc.d/rc 5
> l6:6:wait:/etc/rc.d/rc 6
> 
> # Things to run in every runlevel.
> #ud::once:/sbin/update
> 
> # Trap CTRL-ALT-DELETE
> ca::ctrlaltdel:/sbin/shutdown -t3 -r now
> 
> # When our UPS tells us power has failed, assume we have a few minutes
> # of power left.  Schedule a shutdown for 2 minutes from now.
> # This does, of course, assume you have powerd installed and your
> # UPS connected and working correctly.
> pf::powerfail:/sbin/shutdown -f -h +2 "Power Failure; System Shutting
Down"
> 
> # If power was restored before the shutdown kicked in, cancel it.
> pr:12345:powerokwait:/sbin/shutdown -c "Power Restored; Shutdown
Cancelled"
> 
> 
> # Run gettys in standard runlevels
> 1:2345:respawn:/sbin/mingetty tty1
> 2:2345:respawn:/sbin/mingetty tty2
> #3:2345:respawn:/sbin/mingetty tty3
> #4:2345:respawn:/sbin/mingetty tty4
> #5:2345:respawn:/sbin/mingetty tty5
> #6:2345:respawn:/sbin/mingetty tty6
> 
> # Run project specific stuff in runlevel 4
> # The following script executes the Xserver
> plo1:4:respawn:/<some directory>/run_xstart.bash
> 
> We changed the last line to the following:
> plo1:4:respawn:runcon -t unconfined_t /testdir/run_xstart.bash
> 
> and it changed the security context type from init_t to unconfined_t.
It worked but we still don't know why it would changed. RHEL4 did not
change the type. None of our scripts have changed.
> 
> Thanks for your help.

What does run_xstart.bash do?  Normally /sbin/init does not directly
start the X server, and thus the policy doesn't define any transition on
it, so it is normal that it would stay in init_t.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
