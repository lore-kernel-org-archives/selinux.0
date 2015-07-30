Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6UFrhoH018937
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 11:53:43 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id 3E0AE72
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 15:53:24 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: Comment constraint rules in audit2allow and
 sepolgen output
Date: Thu, 30 Jul 2015 17:53:18 +0200
Message-Id: <1438271598-3776-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Constraint rules in output need to be commented in order to make a policy
compilable.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1155974

Patch-by: Miroslav Grepl <mgrepl@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/audit2allow/audit2allow | 2 +-
 sepolgen/src/sepolgen/policygen.py      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index 62338a0..6bbab40 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -273,7 +273,7 @@ class AuditToPolicy:
             if rc == audit2why.CONSTRAINT:
                 print()  # !!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access.\n"
                 print("#Constraint rule:")
-                print("\n\t" + data[0])
+                print("\n#\t" + data[0])
                 for reason in data[1:]:
                     print("#\tPossible cause is the source %s and target %s are different.\n" % reason)
 
diff --git a/sepolgen/src/sepolgen/policygen.py b/sepolgen/src/sepolgen/policygen.py
index 9cacc35..4438a11 100644
--- a/sepolgen/src/sepolgen/policygen.py
+++ b/sepolgen/src/sepolgen/policygen.py
@@ -177,7 +177,7 @@ class PolicyGenerator:
             if av.type == audit2why.CONSTRAINT:
                 rule.comment += "\n#!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access."
                 rule.comment += "\n#Constraint rule: "
-                rule.comment += "\n\t" + av.data[0]
+                rule.comment += "\n#\t" + av.data[0]
                 for reason in av.data[1:]:
                     rule.comment += "\n#\tPossible cause is the source %s and target %s are different." % reason
 
-- 
2.4.6
