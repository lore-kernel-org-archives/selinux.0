Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0PEi1lu025945
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 09:44:01 -0500
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0PEi5XI019513
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 14:44:59 GMT
Received: by wx-out-0506.google.com with SMTP id s17so554583wxc
        for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 06:45:00 -0800 (PST)
Message-ID: <45B8C264.5090402@kaigai.gr.jp>
Date: Thu, 25 Jan 2007 23:44:52 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: busybox@busybox.net, selinux@tycho.nsa.gov
CC: rob@landley.net, dwalsh@redhat.com, russell@coker.com.au,
        busybox@kaigai.gr.jp
Subject: [PATCH 6/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp>
In-Reply-To: <45B8C039.10907@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------060207050106010402010005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060207050106010402010005
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

[6/8] busybox-libselinux-06-togglesebool.patch
  togglesebool - flip the current value of a SELinux
  boolean variable.

Signed-off-by: Hiroshi Shinji <shiroshi@my.email.ne.jp>
Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>

--
KaiGai Kohei <kaigai@kaigai.gr.jp>


--------------060207050106010402010005
Content-Type: text/x-patch;
 name="busybox-libselinux-06-togglesebool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-06-togglesebool.patch"

Index: selinux/togglesebool.c
===================================================================
--- selinux/togglesebool.c	(revision 0)
+++ selinux/togglesebool.c	(revision 0)
@@ -0,0 +1,106 @@
+/*
+ * togglesebool
+ * 
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ * Copyright 1999-2004 Gentoo Technologies, Inc.
+ * Distributed under the terms of the GNU General Public License v2
+ * $Header: /var/cvsroot/gentoo-projects/hardened/policycoreutils-extra/src/toggle_bool.c,v 1.2 2004/06/18 04:09:04 pebenito Exp $
+ */
+
+#include "busybox.h"
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <libgen.h>
+#include <errno.h>
+#include <selinux/selinux.h>
+#include <syslog.h>
+#include <pwd.h>
+#include <string.h>
+
+/* Attempt to rollback the transaction. No need to check error
+   codes since this is rolling back something that blew up. */
+static void rollback(int argc, char **argv)
+{
+	int i;
+
+	for (i = 1; i < argc; i++)
+		security_set_boolean(argv[i],
+				     security_get_boolean_active(argv[i]));
+	exit(1);
+}
+
+int togglesebool_main(int argc, char **argv)
+{
+
+	int rc, i, commit = 0;
+
+	if (is_selinux_enabled() <= 0) {
+		bb_error_msg_and_die("SELinux is disabled");
+	}
+
+	if (argc < 2) {
+		bb_show_usage();
+	}
+
+	for (i = 1; i < argc; i++) {
+		printf("%s: ", argv[i]);
+		rc = security_get_boolean_active(argv[i]);
+		switch (rc) {
+		case 1:
+			if (security_set_boolean(argv[i], 0) >= 0) {
+				printf("inactive\n");
+				commit++;
+			} else {
+				printf("%s - rolling back all changes\n",
+				       strerror(errno));
+				rollback(i, argv);
+			}
+			break;
+		case 0:
+			if (security_set_boolean(argv[i], 1) >= 0) {
+				printf("active\n");
+				commit++;
+			} else {
+				printf("%s - rolling back all changes\n",
+				       strerror(errno));
+				rollback(i, argv);
+			}
+			break;
+		default:
+			if (errno == ENOENT)
+				printf
+				    ("Boolean does not exist - rolling back all changes.\n");
+			else
+				printf("%s - rolling back all changes.\n",
+				       strerror(errno));
+			rollback(i, argv);
+			break;	/* Not reached. */
+		}
+	}
+
+	if (commit > 0) {
+		if (security_commit_booleans() < 0) {
+			printf("Commit failed. (%s)  No change to booleans.\n",
+			       strerror(errno));
+		} else {
+			/* syslog all the changes */
+			struct passwd *pwd = getpwuid(getuid());
+			for (i = 1; i < argc; i++) {
+				if (pwd && pwd->pw_name)
+					syslog(LOG_NOTICE,
+					       "The %s policy boolean was toggled by %s",
+					       argv[i], pwd->pw_name);
+				else
+					syslog(LOG_NOTICE,
+					       "The %s policy boolean was toggled by uid:%d",
+					       argv[i], getuid());
+
+			}
+			return 0;
+		}
+	}
+	return 1;
+}

--------------060207050106010402010005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
