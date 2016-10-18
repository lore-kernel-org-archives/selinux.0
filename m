Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVjY022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:31 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/7] libsepol/cil: Fix bugs found by Nicolas Looss with AFL
Date: Tue, 18 Oct 2016 14:58:41 -0400
Message-Id: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A series of patches to fix bugs found by Nicolas Looss while fuzzing
secilc with AFL.

James Carter (7):
  libsepol/cil: Check for improper category range
  libsepol/cil: Use empty list for category expression evaluated as
    empty
  libsepol/cil: Use an empty list to represent an unknown permission
  libsepol/cil: Check if identifier is NULL when verifying name
  libsepol/cil: Check that permission is not an empty list
  libsepol/cil: Verify alias in aliasactual statement is really an alias
  libsepol/cil: Verify neither child nor parent in a bounds is an
    attribute

 libsepol/cil/src/cil_build_ast.c   |  7 +++++
 libsepol/cil/src/cil_post.c        | 13 ++++----
 libsepol/cil/src/cil_resolve_ast.c | 61 +++++++++++++++++++-------------------
 libsepol/cil/src/cil_verify.c      |  8 ++++-
 4 files changed, 51 insertions(+), 38 deletions(-)

-- 
2.7.4
