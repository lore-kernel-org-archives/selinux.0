Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KES8Rb019068
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:28:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KEPfB2000277
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:25:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4KEPewi000274
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:25:40 GMT
Subject: Re: FAM uses seteuid and setegid
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040520135553.GD8810@lkcl.net>
References: <20040520121538.GA8810@lkcl.net>
	 <1085056946.521.65.camel@moss-spartans.epoch.ncsc.mil>
	 <20040520135553.GD8810@lkcl.net>
Content-Type: text/plain
Message-Id: <1085063247.521.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 10:27:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 09:55, Luke Kenneth Casson Leighton wrote:
> > You can either a) re-architect the application to use a
> > fork/setexeccon/exec model or b) have the application perform access
> > checking itself on behalf of the user context via avc_has_perm 
> 
>  is there any example code about that does this, or what's the closest
>  GPL project that you are aware of that does something with
>  avc_has_perm?

- You can certainly read the inline documentation in
include/selinux/avc.h, and get more information from the original tech
report and background papers about the interface.

- The userspace AVC was derived from the kernel AVC, so the SELinux
kernel module provides an example of how to use avc_has_perm.  But there
are certain differences, particularly with respect to obtaining SIDs
(since kernel SIDs are not exported to userspace, so the userspace AVC
maintains its own mapping) and the callbacks required for the userspace
AVC to encapsulate operations like memory allocation and threading.

- Since the userspace AVC is relatively new, there are only two present
users of it: security-enhanced X and security-enhanced dbus.  See Eamon
Walsh's posting about security-enhanced X.  He created the userspace AVC
from the kernel AVC to support that work, thus addressing a longstanding
item on our todo list for providing full support for userland policy
enforcers.  Security-enhanced X is likely the best example of how to use
the userspace AVC and is the most readily available (see Eamon's posting
for the CVS information).

- Note that avc_has_perm internally calls security_compute_av when the
decision is not in the cache.  If you look at some of the existing
SELinux patches (e.g. cron, pam_rootok), you'll see that they directly
call security_compute_av.  Since we didn't have a userspace AVC when
those patches were created and since it wasn't clear that there would be
a strong benefit from a userspace AVC for those particular programs,
they simply directly invoke the security_compute_av interface.  For
famd, it likely makes sense to cache decisions for performance.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
