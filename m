Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j35DeFDo008174
	for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2005 09:40:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j35Dc2Gl024603
	for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2005 13:38:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Alejandro Mery <amery@geeks.cl>
Subject: Re: selinux without sysvinit
Date: Tue, 5 Apr 2005 23:37:25 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
References: <4188E956.7020808@geeks.cl> <1099579644.3174.73.cam el@moss-spartans.epoch.ncsc.mil> <418B9531.7090303@geeks.cl>
In-Reply-To: <418B9531.7090303@geeks.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504052337.28548.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 06 November 2004 01:58, Alejandro Mery <amery@geeks.cl> wrote:
> > Yes, that should work as well, and I think some people have actually
> > used that approach in the past.  But if you decide to move aside
> > /sbin/init and replace it with a small program that loads policy and
> > then runs the real init program, be careful that telinit is then
> > redirected to the real init program.
>
> i was thinking in a /sbin/seinit with proper init= on loader, hardcoded
> to execve /sbin/init and /bin/sh after that.

I've done that, it works.  It's a minor PITA though, you need to have your 
boot loader pass init=/sbin/seinit though.  If your boot loader is something 
like the boot loader in a Cobalt machine it's even more painful as BIOS 
upgrades etc can lose the boot loader config.

Best to just patch /sbin/init, I only patched init after trying all the other 
options and finding them to be worse.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
