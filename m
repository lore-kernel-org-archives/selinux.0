Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27140
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 11:04:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA20032
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 16:04:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id QAA20028
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 16:04:29 GMT
Date: Fri, 16 Mar 2001 11:03:28 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Kurth Bemis <kurth@usaexpress.net>
cc: selinux@tycho.nsa.gov
Subject: Re: Secure?
In-Reply-To: <4.3.2.7.2.20010315083635.02bb5068@mail.usaexpress.net>
Message-ID: <Pine.SOL.3.95.1010316102520.7537D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


Security-Enhanced Linux is not a secure Linux distribution.
It is a reference implementation of a flexible mandatory access 
control architecture in the Linux kernel, and an example security policy
configuration that shows how to use those controls.  The mandatory
access controls can confine the actions of any process, so the 
potential damage that can be done by exploiting a flaw in an
application can be strictly limited.  The modified applications
merely serve to help demonstrate some of the kernel features,
but they are not integral to the system.  The ftpd modifications
were an example of how to allow the ftp daemon to transition to a new
security context after authenticating the user.  But even these
transitions are controlled by the kernel in accordance with the security
policy configuration, so a vulnerability in the ftp daemon is still
confined to a limited set of accesses.  We simply used the ftpd sources
that came with our RedHat 6.1 systems, which happened to be wu-ftpd.

As has been mentioned earlier, Linux was simply viewed as the best
platform for transferring the Flask flexible mandatory access control
architecture to a larger developer and user community.  Since the 
SELinux development team is small, it was not practical to create
both a Linux-based and a BSD-based implementation simultaneously.
The TrustedBSD project has expressed the intention of drawing ideas from
the SELinux mandatory access control architecture, so a similar
architecture will hopefully become available for BSD systems as well.
The security portion of the OpenBSD project is really orthogonal to the
SELinux or TrustedBSD projects - OpenBSD is focused on a BSD distribution
that is free from known security problems and that incorporates
cryptographic mechanisms.  The mandatory access controls of SELinux
or TrustedBSD can provide strong security guarantees even in the
presence of security flaws in applications.  Ideally, some of the
TrustedBSD work will filter over to the OpenBSD project as well.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Thu, 15 Mar 2001, Kurth Bemis wrote:

> isn't the point of NSA ESL to be secure?  If so why are you using something 
> that is buggier than netscape code??  I referring to wu-FTP.  why not put 
> efforts toward something that is already secure (like OpenBSD)?  Is there 
> some reason that i'm missing as to why you choosing this route?
> 
> ~kurth
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
