Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAECcgSf023884
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 07:38:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAECcFBb008308
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 12:38:15 GMT
Received: from sisko.scot.redhat.com (82-41-8-128.cable.ubr02.edin.blueyonder.co.uk [82.41.8.128])
	by jazzswing.ncsc.mil  with ESMTP id hAECcE4o008305
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 12:38:15 GMT
Subject: Re: unix_chkpwd
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311141901.14660.russell@coker.com.au>
References: <200311141901.14660.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1068813495.9878.31.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 14 Nov 2003 12:38:15 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Fri, 2003-11-14 at 08:01, Russell Coker wrote:

> We can do one of three things:
> 1)  dontaudit system_chkpwd_t inetd_t:fd use;
> 2)  Change sshd to use fcntl() before doing any PAM stuff.
> 3)  Put code in pam_unix.so to close all file handles after the fork().
> 
> Which do you think is best?  2 seems most correct to me

2 would require fcntl()ing it back again afterwards, of course.  Having
your shell inherit FD_CLOEXEC on stdin could be confusing, at best. :-)

2 seems clearly the cleanest solution, but is also a rather
PAM+SELinux-specific hack.  I guess that we're going to be maintaining
SELinux-specific patches against a lot of core utils for some time,
until it becomes so widespread that all maintainers are desperate to
merge full SELinux support :-), and this specific change seems a
relatively minimal and painless one to maintain in that manner.

--Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
