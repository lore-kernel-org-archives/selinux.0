Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2VHFejv025987
 for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2015 13:15:40 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3 v3] libsepol, policycoreutils,
 and checkpolicy: Add support for generating CIL to libsepol and
 checkpolicy
Date: Tue, 31 Mar 2015 13:17:58 -0400
Message-Id: <1427822281-14769-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

V3 fixes another whitespace issue.
V2 fixes some whitespace issues and make the new libsepol file LGPL instead of GPL.

This patch set moves the code to generate CIL from pp.c in policycoreutils/hll/pp to libsepol, adds a new function to generate CIL from a module policydb, and modifies checkpolicy and checkmodule to support generating CIL as their output.

The primary motivation of this work is to allow SE for Android to use the CIl compiler. Converting the policy.conf to CIL and then compiling to the kernel binary policy results in a policy that is about 20% smaller. The smaller size is because type expressions with negations are converted to type attribute sets in CIL instead of being expanded. 

James Carter (3):
  libsepol, policycoreutils: Move functions to convert a module package
    to CIL
  libsepol: add function to generate CIL from a module policydb
  checkpolicy: Add support for generating CIL

 checkpolicy/checkmodule.c              |   59 +-
 checkpolicy/checkpolicy.c              |   79 +-
 libsepol/include/sepol/module_to_cil.h |    8 +
 libsepol/src/module_to_cil.c           | 4010 ++++++++++++++++++++++++++++++++
 policycoreutils/hll/pp/pp.c            | 3830 +-----------------------------
 5 files changed, 4107 insertions(+), 3879 deletions(-)
 create mode 100644 libsepol/include/sepol/module_to_cil.h
 create mode 100644 libsepol/src/module_to_cil.c

-- 
1.9.3
