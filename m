Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3FKvLkJ016518
 for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2015 16:57:21 -0400
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-chan1-1338.natinst.com
 [130.164.19.134])
 by us-aus-skprod2.natinst.com (8.15.0.59/8.15.0.59) with ESMTP id
 t3FKvIfw022809
 for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2015 15:57:18 -0500
From: Ben Shelton <ben.shelton@ni.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] libselinux: Mount procfs before checking /proc/filesystems
Date: Wed, 15 Apr 2015 15:56:57 -0500
Message-Id: <1429131417-8986-1-git-send-email-ben.shelton@ni.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In the case where the SELinux security module is not loaded in the
kernel and it's early enough in the boot process that /proc has not yet
been mounted, selinuxfs_exists() will incorrectly return 1, and
selinux_init_load_policy() will print a message like this to the
console:

Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory

To fix this, mount the procfs before attempting to open
/proc/filesystems, and unmount it when done if it was initially not
mounted.  This is the same thing that selinux_init_load_policy() does
when reading /proc/cmdline.

Signed-off-by: Ben Shelton <ben.shelton@ni.com>
---
 libselinux/src/init.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 6d1ef33..179e0d0 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -11,6 +11,7 @@
 #include <sys/vfs.h>
 #include <stdint.h>
 #include <limits.h>
+#include <sys/mount.h>
 
 #include "dso.h"
 #include "policy.h"
@@ -54,15 +55,20 @@ static int verify_selinuxmnt(const char *mnt)
 
 int selinuxfs_exists(void)
 {
-	int exists = 0;
+	int exists = 0, mnt_rc = 0;
 	FILE *fp = NULL;
 	char *buf = NULL;
 	size_t len;
 	ssize_t num;
 
+	mnt_rc = mount("proc", "/proc", "proc", 0, 0);
+
 	fp = fopen("/proc/filesystems", "r");
-	if (!fp)
-		return 1; /* Fail as if it exists */
+	if (!fp) {
+		exists = 1; /* Fail as if it exists */
+		goto out;
+	}
+
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
 	num = getline(&buf, &len, fp);
@@ -76,6 +82,14 @@ int selinuxfs_exists(void)
 
 	free(buf);
 	fclose(fp);
+
+out:
+#ifndef MNT_DETACH
+#define MNT_DETACH 2
+#endif
+	if (mnt_rc == 0)
+		umount2("/proc", MNT_DETACH);
+
 	return exists;
 }
 hidden_def(selinuxfs_exists)
-- 
2.3.5
