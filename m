Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4F8PvZQ024262
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 04:25:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID13.oob.disa.mil (Postfix) with SMTP id 40lVxs6mFxz3S6lN
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 08:25:37 +0000 (UTC)
Received: from USFB3CPA06_EEMSG_MP28.eemsg.mil (unknown [192.168.16.23])
 by USFBF3ID13.oob.disa.mil (Postfix) with ESMTP id 40lVxs3PTWz3S6kd
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 08:25:37 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Tue, 15 May 2018 09:25:24 +0100
Message-Id: <20180515082524.30252-1-richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1]  selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Not sure how useful this is but saw [1] and thought I'll have a go out
of idle curiosity.

I've only tested on Fedora 27 with kernel-4.16.3-200.fc27.x86_64

Use ./test -v to see the flow of binder info

I just added the following to the standard kernel-x86_64.config:
CONFIG_ANDROID_BINDER_DEVICES="binder"
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set

[1] https://github.com/SELinuxProject/selinux-testsuite/issues/27

Richard Haines (1):
  selinux-testsuite: Add binder tests

 README.md                   |   8 +
 defconfig                   |   8 +
 policy/Makefile             |   2 +-
 policy/test_binder.te       |  83 +++++++
 tests/Makefile              |   2 +-
 tests/binder/Makefile       |   7 +
 tests/binder/check_binder.c |  80 +++++++
 tests/binder/test           | 131 +++++++++++
 tests/binder/test_binder.c  | 543 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 862 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_binder.te
 create mode 100644 tests/binder/Makefile
 create mode 100644 tests/binder/check_binder.c
 create mode 100644 tests/binder/test
 create mode 100644 tests/binder/test_binder.c

-- 
2.14.3
