Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA20081
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 14:27:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA02678
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 19:27:32 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA02673
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 19:27:31 GMT
Date: Mon, 26 Nov 2001 14:27:28 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tracy R Reed <treed@ultraviolet.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: kernel oops
In-Reply-To: <20011126115936.A14920@ultraviolet.org>
Message-ID: <Pine.GSO.4.33.0111261419130.21971-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Nov 2001, Tracy R Reed wrote:

> I've had 3 oopses in the last week that I've been playing with selinux.

Looks like you're still using the 2.4.12-based SELinux rather than the
latest release, and it doesn't look like you've applied patches that have
been posted since that release.  Make sure that you've at least applied
these patches:

http://marc.theaimsgroup.com/?l=selinux&m=100378165408266&w=2
http://marc.theaimsgroup.com/?l=selinux&m=100445617604999&w=2

The first kernel Oops definitely looked like the load_policy bug fixed by
the second patch above.  I'm not sure about the latter two Oopses - I
haven't seen them, and they weren't in SELinux code.  Could be a side
effect of one of the two bugs for which we've posted patches.

If you upgrade to the latest release, be sure to apply the
selinux_inode_delete patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
