Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UGZJSj022976
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 12:35:19 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul@paul-moore.com
Subject: [PATCH v2 0/2] Selinux tests for Infinfiband
Date: Tue, 30 May 2017 19:34:49 +0300
Message-Id: <1496162091-129822-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Implements new tests for Infiniband pkeys and endports. Because infiniband
isn't widely used, and when it is the configuration is site specific,
configuration files are used to enable the tests and set environment
specific settings. When the tests are disable they always show as passed.

If enabled, the tests require correstponding updates to selinux, refpolicy,
and the linux kernel.

---

v1:
- Synchronize intefrace names with changes to refpolicy.
- Change tests to not assume that default pkey is labeled.
- See patches v1 notes for more detail.

v2:
- Use ifdefs around new corenet_ib* interfaces.
- Exclude endport policy if infiniband_endport class is undefined.
- Use a stub makefile in tests/infinband_endport vs a new SUBDIRS_NO_MAKE
  list in the makefile.
- Style cleanup in new pkey test program.
- Updated README for new dependency.

Daniel Jurgens (2):
  selinux-testsuite: Infiniband pkey tests
  selinux-testsuite: Infiniband endport tests

 README                                       |  17 +++-
 policy/Makefile                              |   7 +-
 policy/test_ibendport.te                     |  40 ++++++++
 policy/test_ibpkey.te                        |  30 ++++++
 tests/Makefile                               |   4 +-
 tests/infiniband_endport/Makefile            |   2 +
 tests/infiniband_endport/ibendport_test.conf |  14 +++
 tests/infiniband_endport/test                |  49 ++++++++++
 tests/infiniband_pkey/Makefile               |   7 ++
 tests/infiniband_pkey/create_modify_qp.c     | 136 +++++++++++++++++++++++++++
 tests/infiniband_pkey/ibpkey_test.conf       |  18 ++++
 tests/infiniband_pkey/test                   |  84 +++++++++++++++++
 12 files changed, 404 insertions(+), 4 deletions(-)
 create mode 100644 policy/test_ibendport.te
 create mode 100644 policy/test_ibpkey.te
 create mode 100644 tests/infiniband_endport/Makefile
 create mode 100644 tests/infiniband_endport/ibendport_test.conf
 create mode 100755 tests/infiniband_endport/test
 create mode 100644 tests/infiniband_pkey/Makefile
 create mode 100644 tests/infiniband_pkey/create_modify_qp.c
 create mode 100644 tests/infiniband_pkey/ibpkey_test.conf
 create mode 100755 tests/infiniband_pkey/test

-- 
2.12.2
