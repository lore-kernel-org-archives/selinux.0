Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06814
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 08:28:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA07255
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 13:28:06 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id NAA07251
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 13:28:06 GMT
Date: Thu, 29 Nov 2001 08:27:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils,
 fileutils, and [xkg]dm
In-Reply-To: <20011129124524.49DE63531E5@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0111290826160.23362-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 29 Nov 2001, Russell Coker wrote:

> Because no package is allowed to put files in /usr/local !

Well, I suppose that this makes sense for packages that are intended to be
installed as part of the base Debian system.  But won't your SELinux
packages be optional components to be installed after a base install?  And
if so, then is it really forbidden to use /usr/local?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
