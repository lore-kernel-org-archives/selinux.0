Subject: RE: Security Context Type Changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com>
References: 
	 <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>
	 <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil>
	 <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com>
Content-Type: text/plain
Date: Mon, 11 Jan 2010 14:24:06 -0500
Message-Id: <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
> pf::powerfail:/sbin/shutdown -f -h +2 "Power Failure; System Shutting Down"
> 
> # If power was restored before the shutdown kicked in, cancel it.
> pr:12345:powerokwait:/sbin/shutdown -c "Power Restored; Shutdown Cancelled"
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
> and it changed the security context type from init_t to unconfined_t. It worked but we still don't know why it would changed. RHEL4 did not change the type. None of our scripts have changed.
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
