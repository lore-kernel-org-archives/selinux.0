Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA26364
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 12:03:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA04904
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 17:03:10 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id RAA04897
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 17:03:08 GMT
Date: Mon, 10 Dec 2001 12:03:26 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <lonnie@outstep.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: User Level Security Policies
In-Reply-To: <1007874114.3c12f042364c3@mail.outstep.com>
Message-ID: <Pine.GSO.4.33.0112101132310.13300-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 9 Dec 2001 lonnie@outstep.com wrote:

> First the easy one.
> 1.) Is there some estimation as to when RH 7.2 might be supported?

We have the current snapshot of SELinux (which should be available soon as
a new public release) running on both RH7.1 and RH7.2.  The example policy
configuration still needs more testing and refinement for RH7.2, but it is
a reasonable starting point.  Some of the utility packages haven't been
updated to RH7.2 yet (findutils, psmisc, stat, tar), but the old versions
of these packages still seem to build and work fine on RH7.2.  Also, a
SELinux user just posted updated patches for several of these remaining
utility packages, but we haven't reviewed them yet for correctness.

> Now the harder one.
> 2.) We have been looking at various security methods such as "restricted
> shells", "chroot", etc... to find a method of locking a user into their HOME
> directory. While this may sound a little restrictive, the current special
> project that we are working on required that we allow the user to login via kdm
> after which a simple window manager (fvwm95) would be started and then the user
> could select an application to run.

If you need to use kdm, you'll need a modified kdm that sets the security
context for the user session.  Mark Westerman, a user of SELinux, has a
modified gdm that performs the necessary processing, so you should refer
to his patch for reference.  This isn't in the base SELinux release.

> The catch is that the user would really never have a shell available to them
> and only be able to run one of the applications that we have pre-configured for
> them.

SELinux can certainly control what the user can execute.  But you may find
that the system isn't useable if you don't grant the user's domain execute
access to a shell, since the programs that are legitimately run by the
user may assume that they can invoke shell commands.  Of course, you could
transition those programs into domains with the necessary execute
permission, but it isn't clear that this adds anything to the security of
the system.

> Also, we would like to prevent the user from navigating out of their HOME
> directory at all times.

Similar to the above, SELinux can control what directories the user can
search.  But many applications will expect to be able to search
directories other than the user's home directory.  As above, you can
transition those applications into their own domains with the necessary
permissions, but you need to consider whether you are really providing any
improvement in security by not just directly granting the permission to
the user's domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
