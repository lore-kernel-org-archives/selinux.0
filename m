Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8HPLIi006350
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 12:25:21 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8HNiTx000866
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 17:23:44 GMT
Subject: Re: getfilecon() and friends in libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41B73620.6050905@tresys.com>
References: <41B73620.6050905@tresys.com>
Content-Type: text/plain
Message-Id: <1102526433.26951.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Dec 2004 12:20:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-12-08 at 12:13, Joshua Brindle wrote:
> The idea is to iterate the filesystem mount points and do a getfilecon() 
> or similar on a file in it, then examine the error code returned to 
> decide if the filesystem supports xattr and also supports the security 
> namespace. Is this a stable API to rely on for this? Will the error 
> codes remain stable?

Yes, getfilecon() should return -1 with errno EOPNOTSUPP if the
filesystem does not support xattrs at all or if the filesystem does not
support the security namespace.

> Further, if there is ever support for contexts via psids or something 
> that isn't xattr will getfilecon() also be a supported method for 
> accessing those?

Yes - even if we were to implement a persistent label mapping (or
something similar to what was done for reiserfs) for a given filesystem,
we would still export it via the xattr API, and thus getfilecon() (or
lgetfilecon or fgetfilecon) would still be the preferred interface for
getting the file context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
