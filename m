Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA19374
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 16:40:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA14791
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:39:33 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA14787
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:39:32 GMT
Date: Thu, 11 Jul 2002 16:39:33 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: David Caplan <dac@tresys.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RH util build bug?
In-Reply-To: <NJEELFKFDFJAACDDMCHCGEFPEEAA.dac@tresys.com>
Message-ID: <Pine.GSO.4.33.0207111631570.21775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, David Caplan wrote:

> I was installing the latest version of SEL on a fresh RH7.2 machine and I
> got an error when building the util's (see error message at bottom).  In the
> past I've been building systems with RH7.1, so I checked and my other (7.1)
> system had a different version of /usr/bin/msgfmt (0.10.35 in 7.1 vs.
> 0.10.38 in 7.2), which is used to build tar-1.13.19 for selinux.  When I put
> the 0.10.35 version on the new 7.2 machine I could finish the util's build
> without error.

This is odd, since selinux/utils/tar-1.13.19 is a patched version of the
tar-1.13.19-6 SRPM for RH7.2.  I have successfully built this on RH7.2
without changing msgfmt, and was able to do so just now from a clean copy
of the selinux archive downloaded from nsa.gov.  The build did fail,
however, when I did it in a working copy of the sourceforge nsa/selinux
CVS tree.  But a diff of a pristine copy of both showed no differences.
It may be that building from the tar ball avoids regenerating this file
due to the timestamp, so the problem doesn't show up.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
