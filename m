Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7T1j3La023010
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 21:45:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7T1j2et022917
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 01:45:02 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h7T1j0lq022883 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 01:45:00 GMT
Subject: Re: Package install probs
From: Colin Walters <walters@verbum.org>
To: Dale Amon <amon@vnl.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <20030828144825.GA6898@vnl.com>
References: <20030828144825.GA6898@vnl.com>
Content-Type: text/plain
Message-Id: <1062121264.2216.25.camel@columbia>
Mime-Version: 1.0
Date: Thu, 28 Aug 2003 21:41:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-08-28 at 10:48, Dale Amon wrote:
> Colin, at the end of the install of the default policy
> I'm getting this error message:
> 
>  an error on line 39260 "Unknown type klogd_t at token ';'"
> "neverallow ~klogd_t proc_kmsg_t:file ~{ getattr }"
> while parsing /usr/bin/checkpolicy configuration make
> /etc/security/selinux/policy.15 error 1

I added syslog-ng (and everything else that currently Provides:
system-log-daemon in Debian) to the X-Debian-Packages line in klogd.te
in my policy tree.

I need to figure out a way to have the installer do virtual packages...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
