Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA24953
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 10:23:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA12048
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 15:23:25 GMT
Received: from mailhub.iastate.edu (mailhub.iastate.edu [129.186.1.102])
	by jazzband.ncsc.mil  with ESMTP id PAA12044
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 15:23:24 GMT
Received: from iastate.edu (luke.cs.iastate.edu [129.186.93.102])
	by mailhub.iastate.edu (8.9.3/8.9.3) with ESMTP id JAA06859
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 09:23:28 -0600
Message-ID: <3A93DD70.2FD7913B@iastate.edu>
Date: Wed, 21 Feb 2001 09:23:28 -0600
From: Mark Slagell <ms@iastate.edu>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: scontext/tcontext/tclass
References: <Pine.SOL.3.95.1010220092233.25753C-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Stephen Smalley wrote:
> 
> As others have mentioned, scontext is an abbreviation for source security
> context, tcontext is an abbreviation for target security context, and
> tclass is an abbreviation for target security class.
> ...

Thanks to everyone for the helpful replies. Lesson #1: RTFM is most
helpful when you're reading the _right_ FM. :-)  Whoops. So I have that
now, and things are beginning to make sense.

> ... your /var/log/cron file is incorrectly
> labeled with the xfs_tmp_t type.  It should be labeled with the
> cron_log_t type.  This might have happened if you booted your
> system with an ordinary Linux kernel after initially installing
> SELinux, because the file may have been recreated while running
> the ordinary Linux kernel.

Bullseye. In fact we installed selinux here with the agreement that the
machine be dual-boot into modified and unmodified modes. I'll have to
make sure it stays in the SE kernel.

  -- Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
