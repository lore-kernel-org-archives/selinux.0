Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54KvwoM021361
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 16:57:58 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 8AA8DC9426
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 20:57:55 +0000 (UTC)
Subject: [PATCH v3 0/6] SELinux testsuite compilation fixes
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 16:57:54 -0400
Message-ID: <20150604205708.19614.64746.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Third times the charm ... compilation fixes, blah blah blah ...

---

Paul Moore (6):
      selinux-testsuite: add _GNU_SOURCE to tests/Makefile
      selinux-testsuite: add some default CFLAGS
      selinux-testsuite: fix some compile warnings in tests/nnp
      selinux-testsuite: fix compile warnings in tests/setnice
      selinux-testsuite: fix compile problems in tests/shm
      selinux-testsuite: fix compile problems in tests/capable_file


 tests/Makefile                  |    3 +++
 tests/capable_file/test_lease.c |    9 +++++----
 tests/msg/msgrcv.c              |    9 ++++-----
 tests/msg/msgsnd.c              |   11 +++++------
 tests/nnp/execnnp.c             |    2 ++
 tests/setnice/parent.c          |    2 ++
 tests/shm/shmat.c               |    6 +-----
 tests/shm/shmctl.c              |    6 +-----
 tests/shm/shmget.c              |    6 +-----
 9 files changed, 24 insertions(+), 30 deletions(-)
