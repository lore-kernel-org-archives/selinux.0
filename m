Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2PI3jdG032616
 for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2016 14:03:45 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Add warnings if module name different from filename
Date: Fri, 25 Mar 2016 14:04:52 -0400
Message-Id: <1458929095-25819-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since CIL treats files as modules and does not have a separate
module statement it can cause confusion when a Refpolicy module
has a name that is not the same as its base filename because
older SELinux userspaces will refer to the module by its module
name, but CIL will refer to the module by its filename.

Warn when the module name is different from the filename when converting
a policy package to CIL or when compiling a module.

James Carter (3):
  libsepol: Add function to check if module name matches filename
  policycoreutils/hll/pp: Warn if module name different from filenames
  checkpolicy: Warn if module name different than filenames

 checkpolicy/checkmodule.c       | 13 +++++++++++++
 libsepol/include/sepol/module.h |  3 +++
 libsepol/src/libsepol.map.in    |  2 ++
 libsepol/src/module.c           | 36 ++++++++++++++++++++++++++++++++++++
 policycoreutils/hll/pp/pp.c     | 29 +++++++++++++++++++++++++----
 5 files changed, 79 insertions(+), 4 deletions(-)

-- 
2.5.5
