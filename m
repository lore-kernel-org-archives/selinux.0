Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38F1FTg004320
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 11:01:15 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2 v3] Check if module name different than output filename
Date: Fri,  8 Apr 2016 11:02:31 -0400
Message-Id: <1460127753-29728-1-git-send-email-jwcart2@tycho.nsa.gov>
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
package to CIL and fail when compiling a module if the output base
filename is different than the module name.

Changes from v1:
- Added a "Warning:" prefix
- Removed checks against the input filename
- Since there are now only two checks and the base filename is used in the
warning message, it no longer made sense to create common helper functions
in libsepol.

Changes from v2:
- Check if strdup() returns NULL
- Have checkmodule fail rather than give a warning

James Carter (2):
  policycoreutils/hll/pp: Warn if module name different than output
    filename
  checkpolicy: Fail if module name different than output base filename

 checkpolicy/checkmodule.c   | 20 ++++++++++++++++++++
 policycoreutils/hll/pp/pp.c | 33 +++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.5.5
