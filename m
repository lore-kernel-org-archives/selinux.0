Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAII5o81004033
 for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2016 13:05:50 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] Add the ability to write policy.conf file from CIL AST
Date: Fri, 18 Nov 2016 13:05:26 -0500
Message-Id: <1479492328-12238-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The first patch adds the cil_gen_policy() function to libsepol and the second
patch adds the cil2conf program to policycoreutils.

I am open to a different name and/or location for cil2conf.

James Carter (2):
  libsepol/cil: Add ability to write policy.conf file from CIL AST
  policycoreutils: Add cil2conf which creates a policy.conf from CIL
    policy

 libsepol/cil/include/cil/cil.h      |    1 +
 libsepol/cil/src/cil.c              |    6 +
 libsepol/cil/src/cil_policy.c       | 2696 +++++++++++++++++++++--------------
 libsepol/cil/src/cil_policy.h       |   12 +-
 libsepol/src/libsepol.map.in        |    1 +
 policycoreutils/Makefile            |    2 +-
 policycoreutils/cil2conf/Makefile   |   33 +
 policycoreutils/cil2conf/cil2conf.c |  192 +++
 8 files changed, 1837 insertions(+), 1106 deletions(-)
 create mode 100644 policycoreutils/cil2conf/Makefile
 create mode 100644 policycoreutils/cil2conf/cil2conf.c

-- 
2.7.4
