Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2SDDOx6029467
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 08:13:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2SD9olY015067
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 13:09:50 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h2SD9nKX015064
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 13:09:49 GMT
Message-Id: <200303281320.IAA25548@moss-shockers.ncsc.mil>
Date: Fri, 28 Mar 2003 08:20:59 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: kernel compile failure
To: selinux@tycho.nsa.gov, pebenito@ieee.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I patched a stock 2.4.20 kernel with the 2003011510 lsm and selinux
> patches from the NSA site.  The compile fails right at the end with a
> linker error (.config attached):
<snip>
> kernel/kernel.o(.text+0xbf34): In function `sys_acct':
> : undefined reference to `security_acct'
> make: *** [vmlinux] Error 1
> 
> 
> This config has worked on previous revisions of the patches.  Ideas?

Yes, while back porting the changes from 2.5 to make LSM a
configuration option, I missed a couple of instances where we need to
#include <linux/security.h> to pick up the static inline function
definitions.  This was mentioned previously in
http://marc.theaimsgroup.com/?l=selinux&m=104284099029343&w=2 (and the
next message in the thread, same problem if you enable quotas).  You
might want to check out a copy of the sourceforge CVS tree, since it
has the patches that have been posted since the last public release
already merged:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

--
Stephen Smalley, NSA



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
