Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03505
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 11:35:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA21181
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 15:33:42 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id PAA21177
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 15:33:41 GMT
Date: Fri, 5 Oct 2001 11:35:04 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: James Bishop <james.bishop@jrc.it>, <selinux@tycho.nsa.gov>
Subject: Re: Compiling for SuSE 7.2
In-Reply-To: <20011005150905.8ED4537DF6C@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0110051121260.29582-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 5 Oct 2001, Russell Coker wrote:

> /bin/login is for console logins, telnetd, and I think rshd.  sshd doesn't
> use it (but there's a patch to sshd).  X logins use an X program, options
> include xdm, kdm, gdm, and many others.  I intend to develop a patch for kdm
> after getting everything else working (if no-one beats me to it).

The simplest approach is to obtain the default security context for the
user (via the get_default_user_sid function in libsecure) and use it in
the appropriate exec*_secure call, and then let the user run newrole if
necessary to change roles after login.  Also, as with login, the ?dm
program should set the security context for the user's terminal device.
Mark Westerman experimented with a patch for gdm that is available on
his sourceforge selinux project site, but I'm not sure how far he got.

Note that some policy customization will be necessary to properly support
the use of the ?dm programs.  A separate domain should be defined for
these programs, and some of their helper programs may also need separate
domains to provide least privilege.

Longer term, it would be nice to change ?dm and its helper programs to
permit users to specify a security context upon login.  But this would
be more complicated and require a more invasive patch.

> Initially using startx after logging in on the console is easiest.

Yes, this is what we recommend if you want to run X.  However, please note
that you must uncomment some allow rules in the
policy/domains/program/xserver.te file to grant the X server the necessary
permissions.  And note that this is dangerous - X is far too privileged,
and needs to be restructured to support least privilege.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
