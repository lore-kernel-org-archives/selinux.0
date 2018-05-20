From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Date: Sun, 20 May 2018 19:24:22 +0100
Message-Id: <20180520182422.19612-1-richard_c_haines@btinternet.com>
Subject: [RFC V2 PATCH 0/1]  selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've update this so it still tests all the binder permissions.

I didn't bother with a Client as I found another way to achieve the
same result. Plenty of comments in test_binder.c to explain. Hopefully
it is sane, otherwise a Client will be required.

I've tested on Fedora 28 with linux-4.17-rc5 so that it does not
suffer the same fate as V1 did. Also looked to see what other patches
were in the pipeline, none that should stop this version working (yet).

V2 Changes:
Fixed the policy and test Makefiles
Updated binder policy.
Updated the defconfig and now works to build linux-4.17-rc5
Updated the test to handle the -v option. Plenty of output
to see what is happening.

Richard Haines (1):
  selinux-testsuite: Add binder tests

 README.md                   |   8 +
 defconfig                   |   7 +
 policy/Makefile             |   4 +
 policy/test_binder.te       |  96 +++++
 tests/Makefile              |   4 +
 tests/binder/Makefile       |   7 +
 tests/binder/check_binder.c |  80 +++++
 tests/binder/test           |  89 +++++
 tests/binder/test_binder.c  | 685 ++++++++++++++++++++++++++++++++++++
 9 files changed, 980 insertions(+)
 create mode 100644 policy/test_binder.te
 create mode 100644 tests/binder/Makefile
 create mode 100644 tests/binder/check_binder.c
 create mode 100644 tests/binder/test
 create mode 100644 tests/binder/test_binder.c

-- 
2.17.0
