Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u88KVIGs001789
 for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2016 16:31:18 -0400
Received: by mail-pf0-f175.google.com with SMTP id p64so21605465pfb.1
 for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2016 13:31:16 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com,
 dcashman <dcashman@android.com>
Subject: [PATCH 0/5] Fix some cil_gen_policy() bugs.
Date: Thu,  8 Sep 2016 13:30:47 -0700
Message-Id: <1473366652-23929-1-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

cil_gen_policy() appears to exist to generate a policy.conf corresponding to the
original SELinux HLL from a cil_db struct.  All of libsepol/cil/src/cil_policy.c
appears to exist to support this functionality.  This patchset provides some
fixes for issues encountered when trying to go from android's policy.conf to a
CIL representation (via checkpolicy) and then back to the HLL representation via
cil_gen_policy().

dcashman (5):
  libsepol: cil: Add userrole mapping to cil_gen_policy().
  libsepol: cil: Remove duplicate sid policy declaration.
  libsepol: cil: Replace sensitivityorder statement.
  libsepol: cil: Fix CIL_OP data assignment.
  libsepol: cil: Add cil_constraint_expr_to_policy()

 libsepol/cil/src/cil_policy.c | 235 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 224 insertions(+), 11 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
