Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16237
	for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 08:29:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h02DTfI17456
	for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 13:29:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h02DTef17452 for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 13:29:40 GMT
Message-Id: <200301021336.IAA10041@moss-shockers.ncsc.mil>
Date: Thu, 2 Jan 2003 08:36:49 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux To Do list
To: kerry@crypt.gen.nz, selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Note that denying avc_toggle does not stop you from entering enforcing mode if 
> you boot in permissive mode (for obvious reasons ;).
> 
> Actually now that I consider this, it doesn't seem to make much sense to 
> compile a kernel that doesn't support switching between enforcing and 
> permissive modes.  It would make more sense to compile a kernel to default to 
> enforcing (without needing a parameter).  Steve, what do you think?

We could provide the latter (a config option to default to enforcing while 
retaining development support), without removing the former (a config option to 
completely disable development support).  I think that some users will still 
want the former, preferring to keep an entirely separate kernel from their 
production kernel that can be booted for development/maintenance operations.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
