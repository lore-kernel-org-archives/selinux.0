Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA08561
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 12:08:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA26874
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 17:07:39 GMT
Received: from fw1.amc.af.mil (amcuxfw801.amc.af.mil [131.9.254.189])
	by jazzswing.ncsc.mil  with ESMTP id RAA26869
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 17:07:38 GMT
Received: from fw1.amc.af.mil (root@localhost)
	by fw1.amc.af.mil with ESMTP id fATGwiO17188
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 10:58:44 -0600 (CST)
Received: from amcw2av808.amc.ds.af.mil (amcw2av808.amc.af.mil [131.9.19.137])
	by fw1.amc.af.mil with SMTP id fATGwin17184
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 10:58:44 -0600 (CST)
Received: from amcw2ms872.amc.ds.af.mil ([131.9.19.110])
 by amcw2av808.amc.ds.af.mil (NAVGW 2.5.1.13) with SMTP id M2001112911080124607
 for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 11:08:01 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Thu, 29 Nov 2001 11:08:00 -0600
Message-ID: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil>
From: "Flood Randy Capt AFCA/TCAA" <randy.flood@scott.af.mil>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This seems to be a flaw with the Debian distribution then.  Doesn't the
Linux filesystems standard (or whatever its called) specify that
software should be installed there?



-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Thursday, November 29, 2001 10:03 AM
To: Stephen Smalley
Cc: selinux@tycho.nsa.gov
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat,
findutils, fileutils, and [xkg]dm


On Thu, 29 Nov 2001 14:27, Stephen Smalley wrote:
> On Thu, 29 Nov 2001, Russell Coker wrote:
> > Because no package is allowed to put files in /usr/local !
>
> Well, I suppose that this makes sense for packages that are intended
to be
> installed as part of the base Debian system.  But won't your SELinux
> packages be optional components to be installed after a base install?
And
> if so, then is it really forbidden to use /usr/local?

It's forbidden for any Debian packages to put files there for any
reason.

Whether a package is optional or required makes no difference.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
