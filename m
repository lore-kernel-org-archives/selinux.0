Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA08014
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 11:28:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA17015
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 16:28:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id QAA17009
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 16:28:12 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Thu, 29 Nov 2001 17:02:54 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0111290826160.23362-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0111290826160.23362-100000@raven>
MIME-Version: 1.0
Message-Id: <20011129160254.D637335C4D9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Nov 2001 14:27, Stephen Smalley wrote:
> On Thu, 29 Nov 2001, Russell Coker wrote:
> > Because no package is allowed to put files in /usr/local !
>
> Well, I suppose that this makes sense for packages that are intended to be
> installed as part of the base Debian system.  But won't your SELinux
> packages be optional components to be installed after a base install?  And
> if so, then is it really forbidden to use /usr/local?

It's forbidden for any Debian packages to put files there for any reason.

Whether a package is optional or required makes no difference.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
