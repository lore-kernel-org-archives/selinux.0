Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4HIstVK009136
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 14:54:57 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] Selinux tests for Infinfiband
Date: Wed, 17 May 2017 21:54:31 +0300
Message-Id: <1495047273-96339-1-git-send-email-danielj@mellanox.com>
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

Daniel Jurgens (2):
  selinux-testsuite: Infiniband pkey tests
  selinux-testsuite: Infiniband endport tests

 README                                       |  14 +++
 policy/Makefile                              |   3 +-
 policy/test_ibendport.te                     |  37 +++++++
 policy/test_ibpkey.te                        |  23 +++++
 tests/Makefile                               |   8 +-
 tests/infiniband_endport/ibendport_test.conf |  14 +++
 tests/infiniband_endport/test                |  49 +++++++++
 tests/infiniband_pkey/Makefile               |   7 ++
 tests/infiniband_pkey/create_modify_qp.c     | 144 +++++++++++++++++++++++++++
 tests/infiniband_pkey/ibpkey_test.conf       |  14 +++
 tests/infiniband_pkey/test                   |  45 +++++++++
 11 files changed, 354 insertions(+), 4 deletions(-)
 create mode 100644 policy/test_ibendport.te
 create mode 100644 policy/test_ibpkey.te
 create mode 100644 tests/infiniband_endport/ibendport_test.conf
 create mode 100644 tests/infiniband_endport/test
 create mode 100644 tests/infiniband_pkey/Makefile
 create mode 100644 tests/infiniband_pkey/create_modify_qp.c
 create mode 100644 tests/infiniband_pkey/ibpkey_test.conf
 create mode 100644 tests/infiniband_pkey/test

-- 
2.12.2
