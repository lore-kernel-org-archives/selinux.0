Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAELxQRb027761
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 16:59:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAELwwBb022883
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 21:58:58 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAELwu4o022863
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 21:58:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id EFB4661BD7
	for <selinux@tycho.nsa.gov>; Sat, 15 Nov 2003 08:59:16 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17151-04 for <selinux@tycho.nsa.gov>;
	Sat, 15 Nov 2003 08:59:15 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id B2B6D61BAF
	for <selinux@tycho.nsa.gov>; Sat, 15 Nov 2003 08:59:08 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 741BB925E8
	for <selinux@tycho.nsa.gov>; Sat, 15 Nov 2003 08:59:08 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: unix_chkpwd
Date: Sat, 15 Nov 2003 08:59:04 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200311141901.14660.russell@coker.com.au> <1068813495.9878.31.camel@sisko.scot.redhat.com>
In-Reply-To: <1068813495.9878.31.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311150859.04677.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Nov 2003 23:38, "Stephen C. Tweedie" <sct@redhat.com> wrote:
> > We can do one of three things:
> > 1)  dontaudit system_chkpwd_t inetd_t:fd use;
> > 2)  Change sshd to use fcntl() before doing any PAM stuff.
> > 3)  Put code in pam_unix.so to close all file handles after the fork().
> >
> > Which do you think is best?  2 seems most correct to me
>
> 2 would require fcntl()ing it back again afterwards, of course.  Having
> your shell inherit FD_CLOEXEC on stdin could be confusing, at best. :-)

That handle isn't used by the application and I need to have the policy deal 
with unix_chkpwd inheriting file handles for the pty/tty device anyway for 
the case of screen blankers etc.  So setting it back shouldn't be necessary.

> 2 seems clearly the cleanest solution, but is also a rather
> PAM+SELinux-specific hack.

It's not really SE Linux specific.  There is no need for a program that sshd 
executes to receive a copy of that file handle.  So the best practise (IMHO) 
is to ensure that such programs don't get it.

> I guess that we're going to be maintaining
> SELinux-specific patches against a lot of core utils for some time,

I certainly hope not.  Maintaining such patches is extremely painful and time 
consuming.  We want to get upstream support for SE Linux things as soon as 
possible.

> until it becomes so widespread that all maintainers are desperate to
> merge full SELinux support :-), and this specific change seems a
> relatively minimal and painless one to maintain in that manner.

I don't think that maintainers will be desperate for SE Linux support for a 
while.  However during our SE Linux work we often find and fix other bugs 
that may have security implications.  It would be rather embarassing for an 
upstream maintainer if the SE Linux version of a program was the only version 
that did not have a security hole and people who don't use SE Linux were 
forced to use the SE Linux version to close the hole!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
