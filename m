Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA22280
	for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2001 09:57:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA02653
	for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2001 13:57:46 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA02649
	for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2001 13:57:46 GMT
Date: Mon, 9 Jul 2001 09:57:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Randy -Harborside Internet <randymb@harborside.com>
cc: selinux@tycho.nsa.gov, mcclellr@OIT.EDU
Subject: Re: SELinux + Engarde
In-Reply-To: <JMECKPIMOJNMLPBBEGBDAEIJCAAA.randymb@harborside.com>
Message-ID: <Pine.SOL.3.95.1010709094818.21543L-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 6 Jul 2001, Randy -Harborside Internet wrote:

> 1. There isn't a way to combine the LIDS kernel module with SELinux,
> correct? I remember seeing something about LIDS earlier on the
> mailing list, but didn't think it regarded to combining the two into
> one kernel.

When I last looked at it, LIDS was a kernel patch, not a module.
Likewise, the current SELinux implementation is a kernel patch
(although we are migrating to a module that depends on the
LSM kernel patch, which will hopefully find its way into
the 2.5 and subsequent kernel versions).  So if you wanted
to combine LIDS with SELinux, you would have to apply both
patches and resolve any conflicts.  And there will almost
certainly be conflicts, because LIDS and SELinux have
overlapping functionality.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
