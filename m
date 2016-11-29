Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uATEpEI0023914
 for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2016 09:51:14 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2 v2] Add the ability to write policy.conf file from CIL AST
Date: Tue, 29 Nov 2016 09:50:55 -0500
Message-Id: <1480431057-8768-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The first patch adds the cil_write_policy_conf() function to libsepol and
the second patch adds the secil2conf program to secilc's directory.

Changes in v2:
- Renamed cil2conf to secil2conf and moved it in with secilc.
- Will now compile with default CFLAGS
- Fixed bugs found by Stephen Smalley in attempting to compile an Android
policy with it.
- Initialize the variables that Nicolas Iooss reported clang complaining about.

James Carter (2):
  libsepol/cil: Add ability to write policy.conf file from CIL AST
  secilc: Add secil2conf which creates a policy.conf from CIL policy

 libsepol/cil/include/cil/cil.h |    1 +
 libsepol/cil/src/cil.c         |    6 +
 libsepol/cil/src/cil_policy.c  | 2714 ++++++++++++++++++++++++----------------
 libsepol/cil/src/cil_policy.h  |   12 +-
 libsepol/src/libsepol.map.in   |    1 +
 secilc/.gitignore              |    2 +
 secilc/Makefile                |   32 +-
 secilc/secil2conf.8.xml        |   82 ++
 secilc/secil2conf.c            |  192 +++
 9 files changed, 1929 insertions(+), 1113 deletions(-)
 create mode 100644 secilc/secil2conf.8.xml
 create mode 100644 secilc/secil2conf.c

-- 
2.7.4
