Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2KFIa8N027563
 for <selinux@tycho.nsa.gov>; Mon, 20 Mar 2017 11:18:36 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] libsepol: Allow hexadecimal numbers in Xen context rules
Date: Mon, 20 Mar 2017 11:18:56 -0400
Message-Id: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Allow the use of hexadecimal numbers in iomemcon, ioportcon, and
pcidevicecon statements. The use of hexadecimal numbers is often
the natural choice for these rules.

James Carter (3):
  libsepol/cil: Allow hexadecimal numbers in Xen context rules
  libsepol: Update module_to_cil to output hexadecimal for Xen rules
  libsepol/cil: Use hexadecimal numbers when writing Xen rules

 libsepol/cil/src/cil_build_ast.c | 30 +++++++++++++++---------------
 libsepol/cil/src/cil_build_ast.h |  4 ++--
 libsepol/cil/src/cil_policy.c    | 10 +++++++---
 libsepol/src/module_to_cil.c     | 11 ++++++-----
 4 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.7.4
