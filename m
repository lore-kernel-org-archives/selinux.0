Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5HBubrT008572
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 07:56:37 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5HBuSuB025145
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 11:56:28 GMT
Subject: Re: CONFIG_SECURITY_NETWORK required?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tom Anderson <granite217@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040617010912.36445.qmail@web14929.mail.yahoo.com>
References: <20040617010912.36445.qmail@web14929.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1087473390.25033.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 07:56:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-06-16 at 21:09, Tom Anderson wrote:
> Is CONFIG_SECURITY_NETWORK required for SELinux?  I've seen some docs
> which recommend enabling it, but I'd expect it to be listed under NSA
> SELinux Support (menuconfig) if it was truly required.  Any real
> (dis)advantage to leaving it disabled?

SELinux _should_ work with it disabled (although I haven't tested this
for some time), but disabling it does cause all socket hooks to be
disabled, even those related to Unix domain sockets.  Consequently,
local socket IPC would no longer be controlled by policy, and the
getpeercon API for obtaining the context of a Unix domain peer would not
be supported if you disabled it.  The latter is important for certain
userspace policy enforcers, e.g. security-enhanced X.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
