Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97JVMWt014270
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:31:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97JVJ0p001137
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 19:31:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h97JVIr7001132
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 19:31:18 GMT
Subject: Re: A few clarifications - SID, Precondition functions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Vikram K <vikramatiitkdotacdotin@yahoo.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20031007172834.24557.qmail@web41011.mail.yahoo.com>
References: <20031007172834.24557.qmail@web41011.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1065555072.3919.292.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 Oct 2003 15:31:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 13:28, Vikram K wrote:
> Hello,
> 
> We had a few doubts regarding the SELinux kernel code.
> 
> 1. The need for having a SID ( instead of having a
> struct context* ) in
> each of the *_security_struct structures. (* = task,
> inode, etc.) As we
> see it, the SID is just a means of referring to the
> corresponding context
> structure and seems to have no other utility.

You might want to read the Flask architecture paper available
from http://www.nsa.gov/selinux/background.html to understand the
original motivation for SIDs.  However, I'll grant that the elimination
of SIDs from the userspace API makes them a less useful abstraction, so
it might be reasonable to investigate replacing them with direct
references to context structures (while continuing to keep the structure
definition private to the security server to encapsulate the policy).

> 2. If once an object is created, what would happen if
> we change its SID.
> Is it at all safe to change the SID?
> (maybe because the struct context to which it was
> referring has a
> few fields changed and this structure is being
> referred to by other
> objects)

Do you mean change the SID of the object or change the context
associated with the SID?  Two different concepts.  Changing the SID of
an object is supported, at least for certain classes of objects,
although revocation is not completely implemented yet (e.g.
memory-mapped files).  setxattr can be used to change the context
of a file, and /proc/pid/attr/exec can be used to change the context of
a process when it performs an exec.

> 3. There is a lot of documentation about "Precondition
> Functions" which
> are called whenever an SID needs to be dereferenced.
> This would help in
> initializing security fields of objects that were
> created before the
> SELinux module is loaded (or starts - if SELinux is
> built into the kernel)
> We couldn't find these precondition functions in the
> code, though. Can
> anybody tell us if they have been implemented and if
> yes, then in which
> version?

The module report is out-of-date with respect to the current
implementation; the SELinux module underwent many significant changes as
part of preparing it for mainline inclusion.  The precondition functions
were eliminated at the recommendation of the kernel developers, and
replaced by a combination of early initialization for the SELinux module
and more explicit initialization hooks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
