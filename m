Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43MBIQs018900
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 18:11:18 -0400
Received: from g6t0186.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o43MCNbl004887
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 22:12:23 GMT
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g6t0186.atlanta.hp.com (Postfix) with ESMTP id A03A82C232
	for <selinux@tycho.nsa.gov>; Mon,  3 May 2010 22:11:17 +0000 (UTC)
Subject: [RFC PATCH v1 0/6] UNIX domain socket fixes and other cleanups
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Mon, 03 May 2010 18:11:15 -0400
Message-ID: <20100503220455.8177.91177.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

This patchset grew out of the SELinux UNIX domain socket patch that I
kicked around on this list several weeks ago that fixed a problem where
we weren't always setting a UNIX socket's peer label correctly.  This
patchset still includes this fix but it also includes a number of other
improvements.  I'm posting these patches as an RFC for two main reasons,
I haven't had a chance to give them the testing I want (they boot and
there are no obvious regressions in light usage) and they are based of
Linus' tree and not security-testing (I will fix that before submission).
However, if you want to give the patches a shot or even just review them
I would appreciate any feedback you care to send along.

For those of you who like to get your patches via git, this patchset can
also be found at the URL below:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

---

Paul Moore (6):
      selinux: Update socket's label alongside inode's label
      selinux: Set the peer label correctly on connected UNIX domain sockets
      selinux: Consolidate sockcreate_sid logic
      selinux: Shuffle the sk_security_struct alloc and free routines
      selinux: Convert socket related access controls to use socket labels
      selinux: Use current_security() when possible


 security/selinux/hooks.c            |  282 ++++++++++++++++-------------------
 security/selinux/include/netlabel.h |    5 -
 security/selinux/netlabel.c         |    8 +
 3 files changed, 139 insertions(+), 156 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
