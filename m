Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5P49I3E027251
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 00:09:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5P48Uss029126
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 04:08:30 GMT
Received: from monk.verbum.org (mx-outgoing.verbum.org [216.226.142.159])
	by jazzswing.ncsc.mil  with ESMTP id h5P48UhY029123
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 04:08:30 GMT
Subject: Re: local policy changes, /var/lib access, syslogd
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200306251354.20028.russell@coker.com.au>
References: <1056505792.29159.43.camel@columbia>
	 <200306251354.20028.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1056514151.744.8.camel@columbia>
Mime-Version: 1.0
Date: 25 Jun 2003 00:09:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(I'm going to CC you because this list is so slow)

On Tue, 2003-06-24 at 23:54, Russell Coker wrote:

> We probably should document some suggested names to avoid the possibility of 
> conflicts.

Yeah, it'd be a good idea, but no big deal.

> One way that programs can request search access to a directory is if you do 
> the following:
> cd /var/lib ; ssh foo

No, I'm not doing anything like that.

> Is sshd configured to have a privsep directory under /var/lib?

I don't have any privsep stuff in my sshd config, no.

> I suspect that postfix_master_t is trying to copy files around to setup a 
> chroot environment.  For my machines I configure postfix to not use chroot.

I did that as well on the advice of weasel (from #selinux irc).  But I
still get that message.  

Also, since this occurs for so many programs, I suspect something lower
level is doing it, like glibc maybe?

> /dev/xconsole is not inherantly related to X.  

Right, I understand that.

> The best thing to do (IMHO) is to configure syslogd to not write anything to 
> /dev/xconsole.

Good idea, I've done that.  Thanks!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
