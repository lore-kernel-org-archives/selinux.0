Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5P4Mj3E027297
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 00:22:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5P4Lvss029661
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 04:21:57 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5P4LrhY029652
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 04:21:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>
Subject: Re: local policy changes, /var/lib access, syslogd
Date: Wed, 25 Jun 2003 14:22:26 +1000
Cc: selinux@tycho.nsa.gov
References: <1056505792.29159.43.camel@columbia> <200306251354.20028.russell@coker.com.au> <1056514151.744.8.camel@columbia>
In-Reply-To: <1056514151.744.8.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306251422.26574.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Jun 2003 14:09, Colin Walters wrote:
> > Is sshd configured to have a privsep directory under /var/lib?
>
> I don't have any privsep stuff in my sshd config, no.
>
> > I suspect that postfix_master_t is trying to copy files around to setup a
> > chroot environment.  For my machines I configure postfix to not use
> > chroot.
>
> I did that as well on the advice of weasel (from #selinux irc).  But I
> still get that message.

Please give me the full log details from dmesg, and tell me what operations 
are necessary to cause it (restart of daemon, make connection, etc).

> Also, since this occurs for so many programs, I suspect something lower
> level is doing it, like glibc maybe?

Maybe libnss_db.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
