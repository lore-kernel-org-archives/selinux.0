Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA28247
	for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 08:53:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA19946
	for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 12:51:30 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA19942 for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 12:51:29 GMT
Date: Thu, 5 Sep 2002 08:52:24 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Trent Jaeger <jaegert@us.ibm.com>
cc: Magnus Johansson <magnusj@it.uu.se>, <selinux@tycho.nsa.gov>
Subject: Re: Buildproblems
In-Reply-To: <OF18B3CFD4.46DA5256-ON85256C2A.006B8ABD@us.ibm.com>
Message-ID: <Pine.GSO.4.33.0209050847070.13061-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 4 Sep 2002, Trent Jaeger wrote:

> So you are saying that if libtermcap is not installed, then configure uses
> libcurses.  This doesn't seem to have been my (or Magnus') case -- if so,
> it would have worked, right?

That's the intended behavior, as documented in the comments in the
configure script ("When termcap does not exist, we can try to compile more
with curses instead.").  I agree that the text-utils Makefile is broken
when termcap is not present, and we could apply a fix in our tree, but the
problem lies in the base package, not in the SELinux patch.  Hence, the
right thing to do is to report the problem to the upstream maintainer of
util-linux (or see if it has already been fixed in a newer base version).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
