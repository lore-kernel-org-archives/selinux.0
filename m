Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01875
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 07:50:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA12987
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:48:20 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA12983 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:48:19 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: /dev/pty*
Date: Tue, 1 Oct 2002 13:49:55 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210010740110.1579-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210010740110.1579-100000@raven>
MIME-Version: 1.0
Message-Id: <200210011349.55677.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Oct 2002 13:42, Stephen Smalley wrote:
> On Tue, 1 Oct 2002, Russell Coker wrote:
> > What's the correct type for /dev/pty*?  devpts_t?
>
> Possibly, but you are likely to need some additional rules.  We've always
> used the devpts pseudo filesystem (or alternatively, devfs now that
> Rogelio's patch has been merged) and haven't tried using SELinux with
> traditional /dev/pty* nodes.

Actually I've never tried using /dev/pty* (or at least never wanted to try 
it).

However with a default devfs setup you get /dev/pty* symlinks and some 
applications will try /dev/pty* first (and presumably they would try 
/dev/pty* first on a non-devfs system with all the default device nodes in 
place), should we consider such applications to be broken and file bug 
reports?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
