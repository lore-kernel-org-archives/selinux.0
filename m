Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4TLrJAC025212
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 17:53:19 -0400
Received: from g4t0017.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4TLqXlY000986
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:52:34 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 7FDC63815B
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:53:18 +0000 (UTC)
Subject: [PATCH 0/6] SELinux UNIX domain socket fixes/cleanup
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Sat, 29 May 2010 17:53:16 -0400
Message-ID: <20100529214628.4042.88276.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I finally got a chance to cobble together some tests to verify both
getpeercon() on the client end of a connected UNIX domain socket as well
as the proper operation of fsetxattr() on sockets.  I'm happy to report
that everything worked as I expected it to (UNIX sockets now behave like
INET sockets) and nothing exploded.  This latest version of the patchset
should include all the feedback I've received so far as well as my
sign-off on each patch so I think we should be in good shape at this
point.  As a result, I'm submitting these patches for whatever kernel
release looks most appropriate - maybe to late for .35, but you might
be able to make a weak argument that some of the patches are
bugfixes - regardless, I'll let you guys make that call; as long as
they go somewhere I'll be happy.

For those of you using git, you can also find a copy of the patches at
the URL below.

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

Thanks.

---

Paul Moore (6):
      selinux: Update socket's label alongside inode's label
      selinux: Set the peer label correctly on connected UNIX domain sockets
      selinux: Consolidate sockcreate_sid logic
      selinux: Shuffle the sk_security_struct alloc and free routines
      selinux: Convert socket related access controls to use socket labels
      selinux: Use current_security() when possible


 security/selinux/hooks.c            |  286 +++++++++++++++++------------------
 security/selinux/include/netlabel.h |    5 -
 security/selinux/netlabel.c         |    8 +
 3 files changed, 144 insertions(+), 155 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
