Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46D92Bd002069
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 09:09:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so6231195wmh.0
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 06:08:57 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: add security_get_checkreqprot
Date: Sat,  6 May 2017 15:08:47 +0200
Message-Id: <20170506130848.9128-2-cgzones@googlemail.com>
In-Reply-To: <20170506130848.9128-1-cgzones@googlemail.com>
References: <20170506130848.9128-1-cgzones@googlemail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add security_get_checkreqprot() function, returning the current active
checkreqprot value
---
 libselinux/include/selinux/selinux.h      |  3 +++
 libselinux/man/man3/security_getenforce.3 | 11 ++++++++-
 libselinux/src/checkreqprot.c             | 40 +++++++++++++++++++++++++++++++
 libselinux/src/selinux_internal.h         |  1 +
 4 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/src/checkreqprot.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 45dd6ca5..01201eee 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -331,6 +331,9 @@ extern int security_setenforce(int value);
 /* Get the behavior for undefined classes/permissions */
 extern int security_deny_unknown(void);
 
+/* Get the checkreqprot value */
+extern int security_get_checkreqprot(void);
+
 /* Disable SELinux at runtime (must be done prior to initial policy load). */
 extern int security_disable(void);
 
diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
index 7658014a..29cf3de7 100644
--- a/libselinux/man/man3/security_getenforce.3
+++ b/libselinux/man/man3/security_getenforce.3
@@ -1,6 +1,6 @@
 .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
-security_getenforce, security_setenforce, security_deny_unknown \- get or set the enforcing state of SELinux
+security_getenforce, security_setenforce, security_deny_unknown, security_get_checkreqprot\- get or set the enforcing state of SELinux
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -10,6 +10,8 @@ security_getenforce, security_setenforce, security_deny_unknown \- get or set th
 .BI "int security_setenforce(int "value );
 .sp
 .B int security_deny_unknown(void);
+.sp
+.B int security_get_checkreqprot(void);
 .
 .SH "DESCRIPTION"
 .BR security_getenforce ()
@@ -24,6 +26,13 @@ returned.
 .BR security_deny_unknown ()
 returns 0 if SELinux treats policy queries on undefined object classes or
 permissions as being allowed, 1 if such queries are denied, and \-1 on error.
+
+.BR security_get_checkreqprot ()
+can be used to determine whether SELinux is configured to check the
+protection requested by the application or the actual protection that will
+be applied by the kernel (including the effects of READ_IMPLIES_EXEC) on
+mmap and mprotect calls.  It returns 0 if SELinux checks the actual
+protection, 1 if it checks the requested protection, and \-1 on error.
 .
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/src/checkreqprot.c b/libselinux/src/checkreqprot.c
new file mode 100644
index 00000000..9b4b12d7
--- /dev/null
+++ b/libselinux/src/checkreqprot.c
@@ -0,0 +1,40 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include "selinux_internal.h"
+#include "policy.h"
+#include <stdio.h>
+#include <limits.h>
+
+int security_get_checkreqprot(void)
+{
+	int fd, ret, checkreqprot = 0;
+	char path[PATH_MAX];
+	char buf[20];
+
+	if (!selinux_mnt) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	snprintf(path, sizeof(path), "%s/checkreqprot", selinux_mnt);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	memset(buf, 0, sizeof(buf));
+	ret = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (ret < 0)
+		return -1;
+
+	if (sscanf(buf, "%d", &checkreqprot) != 1)
+		return -1;
+
+	return checkreqprot;
+}
+
+hidden_def(security_get_checkreqprot);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 3d5c9fb4..54949c13 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -59,6 +59,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_getenforce)
     hidden_proto(security_setenforce)
     hidden_proto(security_deny_unknown)
+    hidden_proto(security_get_checkreqprot)
     hidden_proto(selinux_boolean_sub)
     hidden_proto(selinux_current_policy_path)
     hidden_proto(selinux_binary_policy_path)
-- 
2.11.0
