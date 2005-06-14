Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5EJf9gA017415
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 15:41:09 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5EJWoBf013486
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 19:32:50 GMT
Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Colin Walters <walters@verbum.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118770638.3422.27.camel@nexus.verbum.private>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
	 <1118770638.3422.27.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 20:50:42 +0100
Message-Id: <1118778642.10262.70.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> This should be system_r, not object_r, I'm pretty sure.
> 
> > 2)
> > All similar to the one above (any code that calls sendmail):
> > audit(1118761207.922:0): avc:  denied  { transition } for  pid=28648
> > exe=/bin/bash path=/usr/sbin/sendmail dev=md3 ino=783481
> > scontext=system_u:system_r:myscript_exec_t
> > tcontext=system_u:object_r:sysadm_mail_t tclass=process
> 
> Similarly, try audit2why.
> 
I almost hosed the live system this is happening on by trying (and
failing) to upgrade to current cvs... Fortunately I still had a console
and access to static versions of ls and cp to restore the libs!
I had tried to build a statically linked version, but it dies - which
has to be expected I guess...
Any other ideas? (or a way to compile it against 1.22)

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
