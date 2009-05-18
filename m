From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: move SELINUX_MAGIC into magic.h
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@redhat.com
Date: Mon, 18 May 2009 10:26:10 -0400
Message-ID: <20090518142609.31208.20946.stgit@dhcp231-142.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The selinuxfs superblock magic is used inside the IMA code, but is being
defined in two places and could someday get out of sync.  This patch moves the
declaration into magic.h so it is only done once.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/magic.h               |    1 +
 security/integrity/ima/ima_policy.c |    8 +++-----
 security/selinux/include/security.h |    3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/magic.h b/include/linux/magic.h
index 4596c9e..2fb570c 100644
--- a/include/linux/magic.h
+++ b/include/linux/magic.h
@@ -10,6 +10,7 @@
 #define DEBUGFS_MAGIC		0x64626720
 #define SYSFS_MAGIC		0x62656572
 #define SECURITYFS_MAGIC	0x73636673
+#define SELINUX_MAGIC		0xf97cff8c
 #define TMPFS_MAGIC		0x01021994
 #define SQUASHFS_MAGIC		0x73717368
 #define EFS_SUPER_MAGIC		0x414A53
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index dec6dcb..31d677f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -49,14 +49,12 @@ struct ima_measure_rule_entry {
  * written in terms of .action, .func, .mask, .fsmagic, and .uid
  */
 static struct ima_measure_rule_entry default_rules[] = {
-	{.action = DONT_MEASURE,.fsmagic = PROC_SUPER_MAGIC,
-	 .flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE,.fsmagic = PROC_SUPER_MAGIC,.flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE,.fsmagic = SYSFS_MAGIC,.flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE,.fsmagic = DEBUGFS_MAGIC,.flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE,.fsmagic = TMPFS_MAGIC,.flags = IMA_FSMAGIC},
-	{.action = DONT_MEASURE,.fsmagic = SECURITYFS_MAGIC,
-	 .flags = IMA_FSMAGIC},
-	{.action = DONT_MEASURE,.fsmagic = 0xF97CFF8C,.flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE,.fsmagic = SECURITYFS_MAGIC,.flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE,.fsmagic = SELINUX_MAGIC,.flags = IMA_FSMAGIC},
 	{.action = MEASURE,.func = FILE_MMAP,.mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
 	{.action = MEASURE,.func = BPRM_CHECK,.mask = MAY_EXEC,
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a7be3f0..ca83579 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -8,14 +8,13 @@
 #ifndef _SELINUX_SECURITY_H_
 #define _SELINUX_SECURITY_H_
 
+#include <linux/magic.h>
 #include "flask.h"
 
 #define SECSID_NULL			0x00000000 /* unspecified SID */
 #define SECSID_WILD			0xffffffff /* wildcard SID */
 #define SECCLASS_NULL			0x0000 /* no class */
 
-#define SELINUX_MAGIC 0xf97cff8c
-
 /* Identify specific policy version changes */
 #define POLICYDB_VERSION_BASE		15
 #define POLICYDB_VERSION_BOOL		16


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
