Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA24281
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 10:14:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA23511
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:13:36 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id PAA23507
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:13:35 GMT
Date: Mon, 3 Dec 2001 10:13:29 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: X windows with i810 chip
In-Reply-To: <1007308295.1903.0.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112031009550.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 2 Dec 2001, Justin Smith wrote:

> X windows presents special problems with this (unfortunately common)
> graphics chip. Even with all of the standard allows declarations for X
> windows (and a few extras), I get the following:

I don't think that this has anything to do with the graphics chip.

> avc:  denied  { read } for  pid=1215 exe=/usr/X11R6/bin/XFree86
> path=/dev/mem dev=03:01 ino=25224
>    scontext=jsmith:user_r:user_t
>    tcontext=system_u:object_r:memory_device_t
>    tclass=chr_file

The X server should be running in the user_xserver_t domain, which has the
necessary permissions to /dev/mem.  On my systems, the X server is run
indirectly through /usr/X11R6/bin/Xwrapper, which is labeled with the
xserver_exec_t type.  This type causes a domain transition from user_t
to user_xserver_t.  So I don't know why your X server is running in the
wrong domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
