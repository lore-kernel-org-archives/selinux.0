Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5A7V2rT025618
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 03:31:02 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5A7UuaH028854
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 03:30:58 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: se-samba - a possible way to get round no seteuid
Date: Thu, 10 Jun 2004 17:31:39 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, samba-technical@samba.org,
   tng-technical@lists.samba-tng.org
References: <20040609100345.GA5727@lkcl.net>
In-Reply-To: <20040609100345.GA5727@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406101731.39235.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Jun 2004 20:03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> then, a set of capabilities can be associated with each executable,
> which will of course do a straight execve to /usr/sbin/exim4 -
> taking the new context with it.
>
> it occurred to me that a similar approach could be taken with samba.
>
> instead of doing a seteuid back to root, you do an execve to
> an executable named samba-root.

That doesn't work.  There are more possible UIDs than the root file system may 
have Inodes...

We just need to have Samba know about SE Linux and tell the kernel what 
context it wants the child process to use.

> or, in the main loop, you do an execve() to an executable named
> smbd-child, and then do a setuid, and when you're done, you do
> an execve back to smbd.

execve back to smbd is a bad idea.  I believe that samba already has code to 
setuid() and then exit when finished with that UID, we should plan for the 
same design.  Letting smbd go back to the main context provides no real 
benefit but a lot of work in serialisation.

> it's a hell of a lot simpler approach than messing about with
> proxying and a darn site simpler than doing a rewrite of samba
> to do user-space checking.

This still doesn't cover the case of a single TCP connection having more than 
one identity...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
