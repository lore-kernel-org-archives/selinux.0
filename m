Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1KLWtHw002782
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 16:32:55 -0500
Received: from g4t0017.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1KLTUsO013006
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 21:29:31 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 5A4DE3825D
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 21:32:54 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 0/2] Fixes for 2.6.29
To: selinux@tycho.nsa.gov
Date: Fri, 20 Feb 2009 16:32:49 -0500
Message-ID: <20090220212900.17416.14061.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Two small patches I'd like to propose for 2.6.29 as they are low-risk bug
fixes.  Please review and merge if acceptable - thanks.

The following changes since commit 402a917aca5daca69fcc91f43e6f1e6939cf393b:
  Linus Torvalds (1):
        Merge master.kernel.org:/home/rmk/linux-2.6-arm

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/lblnet-2.6 master

Paul Moore (2):
      cipso: Fix documentation comment
      selinux: Fix the NetLabel glue code for setsockopt()

---

Paul Moore (2):
      selinux: Fix the NetLabel glue code for setsockopt()
      cipso: Fix documentation comment


 net/ipv4/cipso_ipv4.c       |    9 +++++++--
 security/selinux/netlabel.c |    4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
