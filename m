Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0PEievt026017
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 09:44:40 -0500
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0PEi5XK019513
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 14:45:39 GMT
Received: by wx-out-0506.google.com with SMTP id s17so554583wxc
        for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 06:45:40 -0800 (PST)
Message-ID: <45B8C28C.3030201@kaigai.gr.jp>
Date: Thu, 25 Jan 2007 23:45:32 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: busybox@busybox.net, selinux@tycho.nsa.gov
CC: rob@landley.net, dwalsh@redhat.com, russell@coker.com.au,
        busybox@kaigai.gr.jp
Subject: [PATCH 8/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp>
In-Reply-To: <45B8C039.10907@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------020905020506080405070801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020905020506080405070801
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

[8/8] busybox-libselinux-08-setenforce.patch
  setenforce - modify the mode SELinux is running in Enforcing
  mode or Permissive.

Signed-off-by: Hiroshi Shinji <shiroshi@my.email.ne.jp>
Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>

--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------020905020506080405070801
Content-Type: text/x-patch;
 name="busybox-libselinux-08-setenforce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-08-setenforce.patch"

Index: selinux/setenforce.c
===================================================================
--- selinux/setenforce.c	(revision 0)
+++ selinux/setenforce.c	(revision 0)
@@ -0,0 +1,44 @@
+/*
+ * setenforce
+ *
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+
+#include "busybox.h"
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <string.h>
+#include <strings.h>
+#include <selinux/selinux.h>
+
+int setenforce_main(int argc, char **argv)
+{
+	int rc = 0;
+	if (argc != 2) {
+		bb_show_usage();
+	}
+
+	if (is_selinux_enabled() <= 0) {
+		bb_error_msg("SELinux is disabled");
+		return 1;
+	}
+	if (strlen(argv[1]) == 1 && (argv[1][0] == '0' || argv[1][0] == '1')) {
+		rc = security_setenforce(atoi(argv[1]));
+	} else {
+		if (strcasecmp(argv[1], "enforcing") == 0) {
+			rc = security_setenforce(1);
+		} else if (strcasecmp(argv[1], "permissive") == 0) {
+			rc = security_setenforce(0);
+		} else
+			bb_show_usage();
+	}
+	if (rc < 0) {
+		bb_error_msg("setenforce() failed");
+		return 2;
+	}
+	return 0;
+}

--------------020905020506080405070801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
