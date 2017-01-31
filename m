Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJfgG9019171
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:41:42 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/5] checkpolicy: Cleanup declare and require functions
Date: Tue, 31 Jan 2017 14:41:53 -0500
Message-Id: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Cleanup declare and require functions in module_compiler.c to improve
maintainability and clarity. Functionality is not changed.

James Carter (5):
  checkpolicy: Create common function for type declares and requires
  checkpolicy: Create common function for role declares and requires
  checkpolicy: Create common function for user declares and requires
  checkpolicy: Cleanup error messages
  checkpolicy: Move common require and declare code into new function

 checkpolicy/module_compiler.c | 892 +++++++++++++++++++-----------------------
 1 file changed, 395 insertions(+), 497 deletions(-)

-- 
2.7.4
