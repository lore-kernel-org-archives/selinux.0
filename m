Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA19156
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 12:35:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04288
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 17:35:47 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id RAA04284
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 17:35:47 GMT
Date: Tue, 30 Oct 2001 12:35:04 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Femitha Majeed <m_femitha@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: RedHat 7.2
In-Reply-To: <F153sB53WU1VOmmuoqf00017b23@hotmail.com>
Message-ID: <Pine.GSO.4.33.0110301220200.4537-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 30 Oct 2001, Femitha Majeed wrote:

> Is SELinux easily configurable on RedHat 7.2?

We haven't tried RedHat 7.2 yet, so I don't know about what changes
might be necessary in the example policy configuration.  However, there
is at least one non-policy issue for RedHat 7.2 - the use of the ext3
filesystem.  LSM is tracking Linus' kernel tree, and Linus' kernel tree
does not yet include ext3.  Hopefully, ext3 will be merged into Linus'
tree sometime soon.  As far as the SELinux security module is concerned,
ext3 shouldn't present any problems, although you do need the patch that I
posted a little while back (of course, it will be included in future
releases) so that the security module will recognize ext3 as a legitimate
filesystem type for persistent labeling.

Another non-policy issue for RedHat 7.2 will be the base sources for our
modified daemons and utilities.  Due to limited resources and the fact
that many of the modified packages are non-essential, we only update these
packages as necessary or when there is a serious bug.  We've internally
updated to the latest util-linux and openssh SRPMS for RedHat 7.1, which
should show up in the next release.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
