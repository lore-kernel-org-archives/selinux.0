Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA13298
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 13:55:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA15144
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 18:52:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA15140
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 18:52:23 GMT
Message-Id: <200302271903.OAA16289@moss-shockers.ncsc.mil>
Date: Thu, 27 Feb 2003 14:03:09 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy, second pass
To: russell@coker.com.au, wsalamon@tislabs.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Wayne Salamon wrote:
> Or, do we require some
> customization for the user to be able to run, to enable base
> functionality?

I don't think that this is unreasonable, and it is already true for
many users of SELinux (i.e. it is rarely the case that someone can just
use the example policy as is).  We should note in the README that
people are likely to find it necessary to enable additional policy
program modules whether via sepcut or manually to have a fully
functional system.

I am more interested in having the core policy be a safe starting point
for policy developers than in having it provide a highly functional
system to end users.  

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
