Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA09010
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 13:02:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA00285
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 18:02:10 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzswing.ncsc.mil  with ESMTP id SAA00277
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 18:02:10 GMT
Date: Thu, 29 Nov 2001 13:04:37 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Flood Randy Capt AFCA/TCAA <randy.flood@scott.af.mil>
cc: <selinux@tycho.nsa.gov>
Subject: RE: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils,
 fileutils, and [xkg]dm
In-Reply-To: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil>
Message-ID: <Pine.LNX.4.30.0111291258160.23115-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Nov 2001, Flood Randy Capt AFCA/TCAA wrote:

> This seems to be a flaw with the Debian distribution then.  Doesn't
> the Linux filesystems standard (or whatever its called) specify that
> software should be installed there?

http://www.pathname.com/fhs/2.0/fhs-toc.html

for /usr/local:
	http://www.pathname.com/fhs/2.0/fhs-4.6.html

the openbsd hier page is at
http://www.openbsd.org/cgi-bin/man.cgi?query=hier&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html
(not that it matters much, this *is* linux and not BSD)

it would seem to come down to "is selinux the base system or an add on?"
the distribution model of selinux would indicate that it's an add on, as
its not a full fledged distribution.

<opinion>
#include "disclaimer.h"

if debian wants it someplace else, have locally available patches. please
don't attempt to apply such standards to everyone else. thank you. it is,
after all, why you're a different distro.

$ cat disclaimer.h

#ifndef FLAMESUIT
#define FLAMESUIT 1
#endif

i am in no way connected to the SELinux team. i just use it and have a
longstanding interest in both filesystem hierarchies, the UNIX model (and
Linux deviances from it), and trusted OSes. i am speaking only for myself.

/* EOF */

</opinion>


____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
