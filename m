Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h38CtnI4020689
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 08:55:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h38Cq8Ov010820
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 12:52:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h38Cq8Y1010817
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 12:52:08 GMT
Received: from moss-huskers.epoch.ncsc.mil (moss-huskers [144.51.25.140])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h38Ctku1011354
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 08:55:46 -0400 (EDT)
Subject: Re: ptrace flaw
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 08 Apr 2003 08:56:00 -0400
Message-Id: <1049806561.1606.29.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> As some of you may have already noticed, Alan Cox has posted a patch
> for a flaw in ptrace in the Linux 2.4 kernel to the linux-kernel
> mailing list.  See
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104791735604202&w=2.
> That patch has been merged into the sourceforge lsm-2.4 CVS tree, along
> with a corresponding change to the SELinux kernel code.

Hi all,

Just for your information, the patch for the ptrace flaw in the base
Linux kernel is _not_ included in the lsm-2.4 kernel tree or kernel
patch in the new release.  Including the patch posted by Alan Cox for
the ptrace flaw in our tree is not consistent with our usual practice,
i.e.  only maintaining the LSM/SELinux patches in our tree, not
committing other bug fix patches for the base kernel like the ptrace
fix or the earlier ext3 fixes for 2.4.20 (until they happen to be
picked up by mainline, e.g. when 2.4.21 is released).  As a reminder,
NSA SELinux is _not_ a Linux distribution (although one could certainly
integrate it into a Linux distribution), and we simply track the
mainline kernels with the LSM/SELinux patches.

At present, the patch for the ptrace flaw is merged into the
sourceforge CVS tree, since I merged it when Alan posted it without
thinking about the fact that doing so wasn't really consistent with our
usual practice.  I'd prefer to remove it from the sourceforge CVS tree
for consistency with our release, but am open to being argued into
waiting until 2.4.21 is merged, at which point the patch will be included
as part of the base kernel.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
