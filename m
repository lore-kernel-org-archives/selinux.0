From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: only mount /proc if necessary
Date: Mon, 29 Feb 2016 11:10:23 -0500
Message-Id: <1456762223-8702-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 9df498884665d ("libselinux: Mount procfs before checking
/proc/filesystems") changed selinuxfs_exists() to always try
mounting /proc before reading /proc/filesystems.  However, this is
unnecessary if /proc is already mounted and can produce avc denials
if the process is not allowed to perform the mount.  Check first
to see if /proc is already present and only try the mount if it is not.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/init.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 3db4de0..3530594 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -12,6 +12,7 @@
 #include <stdint.h>
 #include <limits.h>
 #include <sys/mount.h>
+#include <linux/magic.h>
 
 #include "dso.h"
 #include "policy.h"
@@ -57,13 +58,19 @@ static int verify_selinuxmnt(const char *mnt)
 
 int selinuxfs_exists(void)
 {
-	int exists = 0, mnt_rc = 0;
+	int exists = 0, mnt_rc = -1, rc;
+	struct statfs sb;
 	FILE *fp = NULL;
 	char *buf = NULL;
 	size_t len;
 	ssize_t num;
 
-	mnt_rc = mount("proc", "/proc", "proc", 0, 0);
+	do {
+		rc = statfs("/proc", &sb);
+	} while (rc < 0 && errno == EINTR);
+
+	if (rc == 0 && ((uint32_t)sb.f_type != (uint32_t)PROC_SUPER_MAGIC))
+		mnt_rc = mount("proc", "/proc", "proc", 0, 0);
 
 	fp = fopen("/proc/filesystems", "r");
 	if (!fp) {
-- 
2.4.3
