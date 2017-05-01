Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v41DKhYT012599
 for <selinux@tycho.nsa.gov>; Mon, 1 May 2017 09:20:43 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Add selinux_check_access utility
Date: Mon,  1 May 2017 14:20:14 +0100
Message-Id: <20170501132014.25520-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/utils/.gitignore             |  1 +
 libselinux/utils/selinux_check_access.c | 52 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 libselinux/utils/selinux_check_access.c

diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index ed3bf0b..0af903d 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -25,3 +25,4 @@ selinuxexeccon
 setenforce
 setfilecon
 togglesebool
+selinux_check_access
diff --git a/libselinux/utils/selinux_check_access.c b/libselinux/utils/selinux_check_access.c
new file mode 100644
index 0000000..88762b4
--- /dev/null
+++ b/libselinux/utils/selinux_check_access.c
@@ -0,0 +1,52 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <selinux/selinux.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr, "usage:  %s [-a auditdata] scon tcon class perm\n"
+		"\nWhere:\n\t"
+		"-a  Optional information added to audit message.\n",
+		progname);
+	exit(1);
+}
+
+static int cb_auditinfo(void *auditdata,
+			__attribute__((unused))security_class_t class,
+			char *msgbuf, size_t msgbufsize)
+{
+	return snprintf(msgbuf, msgbufsize, "%s", (char *)auditdata);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc;
+	char *audit_msg = NULL;
+
+	while ((opt = getopt(argc, argv, "a:")) != -1) {
+		switch (opt) {
+		case 'a':
+			audit_msg = optarg;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 4)
+		usage(argv[0]);
+
+	if (audit_msg)
+		selinux_set_callback(SELINUX_CB_AUDIT,
+				     (union selinux_callback)cb_auditinfo);
+
+	rc = selinux_check_access(argv[optind], argv[optind + 1],
+				  argv[optind + 2], argv[optind + 3],
+				  audit_msg);
+	if (rc < 0)
+		perror("selinux_check_access");
+
+	return rc;
+}
-- 
2.9.3
