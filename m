Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54GFOoe032589
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 12:15:25 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 8250DBBB54
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 16:15:21 +0000 (UTC)
Subject: [PATCH 0/3] SELinux testsuite compilation fixes
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 12:15:20 -0400
Message-ID: <20150604161454.4124.77310.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A few compilation fixes found using today's Rawhide.

---

Paul Moore (3):
      selinux-testsuite: fix some compile warnings in tests/nnp
      selinux-testsuite: fix compile warnings in tests/setnice
      selinux-testsuite: fix compile warnings in tests/execshare


 tests/execshare/parent.c |    3 +++
 tests/nnp/execnnp.c      |    5 +++++
 tests/setnice/parent.c   |    2 ++
 3 files changed, 10 insertions(+)
