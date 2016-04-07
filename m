Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37F4mpm018217
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 11:04:48 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2 v2] Warn if module name different than output filename
Date: Thu,  7 Apr 2016 11:06:04 -0400
Message-Id: <1460041566-7173-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since CIL treats files as modules and does not have a separate
module statement it can cause confusion when a Refpolicy module
has a name that is not the same as its base filename because older
SELinux userspaces will refer to the module by its module name while
a CIL-based userspace will refer to it by its filename.

Because of this, provide a warning message when converting a policy
package to CIL or compiling a module and the output filename is different
than the module name.

Changes from v1:
- Added a "Warning:" prefix
- Removed checks against the input filename
- Since there are now only two checks and the base filename is used in the
warning message, it no longer made sense to create common helper functions
in libsepol.

James Carter (2):
  policycoreutils/hll/pp: Warn if module name different than output
    filename
  checkpolicy: Warn if module name different than output filename

 checkpolicy/checkmodule.c   | 15 +++++++++++++++
 policycoreutils/hll/pp/pp.c | 28 ++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.5.5
