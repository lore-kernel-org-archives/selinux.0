Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4QFwOM6005345
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 11:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C20D3DBF6
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 15:57:58 +0000 (UTC)
Subject: [PATCH 0/2] Add a file syntax checker/fixer to the testsuite
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 26 May 2017 11:57:57 -0400
Message-ID: <149581413266.13714.10451742889870299166.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Two patches: the first adds a syntax checking/fixing script and
the second uses this script to fix the C sources/headers.

An additional patch will be sent shortly which adds Perl support
but I think we need some discussion on what Perl style we want to
adopt for the testsuite.

---

Paul Moore (2):
      tools: add a syntax checker/fixer
      all: use ./tools/check-syntax to fix the existing code


 Makefile                             |    9 -
 tests/cap_userns/userns_child_exec.c |  455 ++++++++++++++++++----------------
 tests/mmap/mprotect_stack_thread.c   |    3 
 tests/mmap/shmat.c                   |    2 
 tests/unix_socket/client.c           |   14 +
 tests/unix_socket/server.c           |    8 -
 tools/check-syntax                   |  146 +++++++++++
 7 files changed, 405 insertions(+), 232 deletions(-)
 create mode 100755 tools/check-syntax
