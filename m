Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OFYsx6002942
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 10:34:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2OFYrR1011400
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 15:34:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h2OFYqj9011397 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 15:34:53 GMT
Date: Mon, 24 Mar 2003 10:33:46 -0500 (EST)
From: Chris Vance <cvance@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>, Chris Vance <cvance@tislabs.com>
Subject: Re: essential patches
In-Reply-To: <200303240127.23991.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0303241009180.31241-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


It seems that the errors you are seeing is a conflict with the concept of
"Core" policy and attempting to create a policy that provides least
privilege.  It's very difficult to have a policy that provides only "core"
services yet is usable as a general-purpose machine.

For example, the dhcpd domain was removed from the core policy, so
natually, it will fail to run correctly under a least privilege policy.

By removing domains from the core policy, programs may fail to transition
as you would like them to. In the case of ifconfig/dhclient, the
transition no longer occurs -- but this does not imply that all
permissions required by dhcpc_t should now be rolled into the policy for
ifconfig.

Other comments are inlined below:

On Mon, 24 Mar 2003, Russell Coker wrote:

> The attached patch file is essential for getting a working system
> based on the current CVS policy.

This patch is NOT essential to getting a working RedHat 7.2 and 8.0
systems booting and operating in enforcing mode, but I do realize this
does not encompass all possible Linux distributions.  It's a difference in
the startup behaviour of different systems with different "core"
requirements.

> initrc_t needs r_dir_perms access to /dev for some startup scripts (and there
> is no good reason to stop it).

What startup scripts on Debian require access to /dev entries?  Least
privilege is typically justified with the inverse of your statement, what
good reason is there to add new permissions?

> Any program that has access to create pty devices needs search access to
> /dev/pts (without such access it can't create a pty which makes no sense).

This makes sense, we'll add this.

>
> user_t needs search access to /boot and read access to the system.map files
> for the wchan.

It's a matter of opinion, I would think that the system.map files contains
privileged information that should be protected.  Again, what programs (in
core) require access?  If there is a special program that requires access,
why is it not in a special domain that has access rather than allowing all
of user_t?

> Many programs in user_t request read access to sysctl_kernel_t dir and file,
> and for var_lib_t.  We could probably survive without sysctl_kernel_t, but
> var_lib_t access is essential to many programs (particularly some perl
> scripts used for Debian package building).  If we deny this then we need to
> add some new types for the things that should be allowed.

Sorry, I'm not familiar with the Debian package manager, but if it needs
special access, then yes, it should run in another new domain.  The core
policy cannot be all things to all people and all systems.

> For random_device_t writing by a hostile user apparently does no harm
> according to all the best sources of information available to me.  There are
> probably some people on this list who know more about cryptology than the
> people who wrote the /dev/random code for Linux.  If an expert decrees that
> we should not allow write access then I'll accept that.  As for read access,
> too many programs break when user_t can't access it, EG all SSL clients...

What programs require write access to the random device?  I'm certainly no
expert, but I tend not to add unjustified permissions simply because it
_seems_ to do no harm.  Perhaps ssl clients should be running in a more
restrictive domain - don't they also require access to privileged
information, such as private keys?  Why run them directly in the user
domain?

> As for ifconfig, without udp_socket access it won't work when called from
> dhclient (dhcpc_t) and therefore denying such access breaks every DHCP
> system.  I'm not sure why ifconfig looks for access to sysctl_net_t:dir as it
> doesn't seem to do anything to files under that dir.  But based on my
> experience with that program I'm not inclined to turn things off without a
> really good reason.  ifconfig can break any part of your network setup if it
> runs amok, denying it access to sysctl_net_t doesn't make any sense to me.

See my initial comments.

> I've tried the current CVS policy on a few machines with different
> configurations and they all failed to work correctly on several counts.

I've tried the current CVS policy on a few machines and all boot in
enforcing mode and allow limited operation (limited, since this is a
core-only policy).

chris.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
