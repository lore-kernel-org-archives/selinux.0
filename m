Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5HJwjvY023081
 for <selinux@tycho.nsa.gov>; Wed, 17 Jun 2015 15:58:45 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 09/10 v2] secilc: Add a CIL policy file to test neverallow
 checking.
Date: Wed, 17 Jun 2015 15:58:53 -0400
Message-Id: <1434571134-31452-10-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 secilc/test/neverallow.cil | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 secilc/test/neverallow.cil

diff --git a/secilc/test/neverallow.cil b/secilc/test/neverallow.cil
new file mode 100644
index 0000000..6351558
--- /dev/null
+++ b/secilc/test/neverallow.cil
@@ -0,0 +1,79 @@
+(class CLASS (PERM))
+(classorder (CLASS))
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(type TYPE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(allow TYPE self (CLASS (PERM)))
+(roletype ROLE TYPE)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
+
+(class c1 (p1a p1b p1c))
+(class c2 (p2a p2b p2c))
+(class c3 (p3a p3b p3c))
+
+(classorder (CLASS c1 c2 c3))
+
+(classpermission cp1)
+(classpermissionset cp1 (c1 (p1a p1b)))
+(classpermissionset cp1 (c2 (p2a)))
+
+(classmap cm1 (mp1))
+(classmapping cm1 mp1
+	      (c1 (p1a)))
+
+(type t1)
+(type t2)
+(type t3)
+(type t4)
+(type t5)
+(type t6)
+(type t7)
+
+(typeattribute a1)
+(typeattribute a2)
+(typeattribute a3)
+(typeattribute a4)
+(typeattribute a5)
+(typeattribute a6)
+
+(typeattributeset a1 (t1 t2 t3 t4 t5))
+(typeattributeset a2 (t1 t2))
+(typeattributeset a3 (t3 t4))
+(typeattributeset a4 (t2 t3))
+(typeattributeset a5 (t5 t6))
+(typeattributeset a6 (t6 t7))
+
+(neverallow t1 t2 (c1 (p1a p1b)))
+(allow t1 t2 (c1 (p1a)))
+
+(neverallow t3 t4 (cm1 (mp1)))
+(allow t3 t4 (c1 (p1a)))
+
+(neverallow t5 t6 cp1)
+(allow t5 t6 (c1 (p1b)))
+(allow t5 t6 (c2 (p2a)))
+
+(neverallow a1 self (CLASS (PERM)))
+(allow t1 t1 (CLASS (PERM)))
+(allow t2 self (CLASS (PERM)))
+(allow a3 self (CLASS (PERM)))
+(allow a2 a4 (CLASS (PERM)))
+
+(neverallow a5 a6 (CLASS (PERM)))
+(allow t5 t7 (CLASS (PERM)))
+(allow t6 self (CLASS (PERM)))
+
+;; Should not call these violations
+(allow a1 self (c1 (p1a)))
+(allow a2 a3 (CLASS (PERM)))
+(allow t5 t6 (c2 (p2b)))
-- 
1.9.3
