Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CM0qVH030674
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 18:00:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id u18so6181268wrc.1
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 15:00:53 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: add security_checkreqprot
Date: Thu, 13 Apr 2017 00:00:37 +0200
Message-Id: <20170412220038.9792-2-cgzones@googlemail.com>
In-Reply-To: <20170412220038.9792-1-cgzones@googlemail.com>
References: <20170412220038.9792-1-cgzones@googlemail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: cgzones <cgzones@googlemail.com>

Add security_checkreqprot() function, returning the current active
checkreqprot value
---
 libselinux/include/selinux/selinux.h      |  3 +++
 libselinux/man/man3/security_getenforce.3 |  8 ++++++-
 libselinux/man/man3/selinux_status_open.3 | 11 +++++++--
 libselinux/src/checkreqprot.c             | 40 +++++++++++++++++++++++++++++++
 libselinux/src/selinux_internal.h         |  1 +
 5 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 libselinux/src/checkreqprot.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 45dd6ca5..938393f6 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -331,6 +331,9 @@ extern int security_setenforce(int value);
 /* Get the behavior for undefined classes/permissions */
 extern int security_deny_unknown(void);
 
+/* Get the checkreqprot value */
+extern int security_checkreqprot(void);
+
 /* Disable SELinux at runtime (must be done prior to initial policy load). */
 extern int security_disable(void);
 
diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
index 7658014a..e27b6c80 100644
--- a/libselinux/man/man3/security_getenforce.3
+++ b/libselinux/man/man3/security_getenforce.3
@@ -1,6 +1,6 @@
 .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
-security_getenforce, security_setenforce, security_deny_unknown \- get or set the enforcing state of SELinux
+security_getenforce, security_setenforce, security_deny_unknown security_checkreqprot\- get or set the enforcing state of SELinux
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -10,6 +10,8 @@ security_getenforce, security_setenforce, security_deny_unknown \- get or set th
 .BI "int security_setenforce(int "value );
 .sp
 .B int security_deny_unknown(void);
+.sp
+.B int security_checkreqprot(void);
 .
 .SH "DESCRIPTION"
 .BR security_getenforce ()
@@ -24,6 +26,10 @@ returned.
 .BR security_deny_unknown ()
 returns 0 if SELinux treats policy queries on undefined object classes or
 permissions as being allowed, 1 if such queries are denied, and \-1 on error.
+
+.BR security_checkreqprot ()
+returns 0 if SELinux checks the protection applied by the kernel, 1 if SELinux
+checks the protection requested by the application, and \-1 on error.
 .
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index 2d44be57..e70ab014 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -1,8 +1,9 @@
 .TH "selinux_status_open" "3" "22 January 2011" "kaigai@ak.jp.nec.com" "SELinux API documentation"
 .SH "NAME"
 selinux_status_open, selinux_status_close, selinux_status_updated,
-selinux_status_getenforce, selinux_status_policyload and
-selinux_status_deny_unknown \- reference the SELinux kernel status
+selinux_status_getenforce, selinux_status_policyload,
+selinux_status_deny_unknown and security_checkreqprot \- reference
+the SELinux kernel status
 without invocation of system calls
 .
 .SH "SYNOPSIS"
@@ -19,6 +20,8 @@ without invocation of system calls
 .BI "int selinux_status_policyload(void);"
 .sp
 .BI "int selinux_status_deny_unknown(void);"
+.sp
+.BI "int security_checkreqprot(void);"
 .
 .SH "DESCRIPTION"
 Linux 2.6.37 or later provides a SELinux kernel status page; being mostly
@@ -78,6 +81,10 @@ Thus, don't use this value to know actual times of policy reloaded.
 returns 0 if SELinux treats policy queries on undefined object classes or
 permissions as being allowed, 1 if such queries are denied, or \-1 on error.
 .sp
+.BR security_checkreqprot ()
+returns 0 if SELinux checks the protection applied by the kernel, 1 if SELinux
+checks the protection requested by the application, and \-1 on error.
+.sp
 Also note that these interfaces are not thread-safe, so you have to protect
 them from concurrent calls using exclusive locks when multiple threads are
 performing.
diff --git a/libselinux/src/checkreqprot.c b/libselinux/src/checkreqprot.c
new file mode 100644
index 00000000..009a0ff0
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
+int security_checkreqprot(void)
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
+hidden_def(security_checkreqprot);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 3d5c9fb4..e4650c92 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -59,6 +59,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_getenforce)
     hidden_proto(security_setenforce)
     hidden_proto(security_deny_unknown)
+    hidden_proto(security_checkreqprot)
     hidden_proto(selinux_boolean_sub)
     hidden_proto(selinux_current_policy_path)
     hidden_proto(selinux_binary_policy_path)
-- 
2.11.0
