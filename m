Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0PEhAHU025846
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 09:43:10 -0500
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0PEi5XE019513
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 14:44:09 GMT
Received: by wx-out-0506.google.com with SMTP id s17so554583wxc
        for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 06:44:10 -0800 (PST)
Message-ID: <45B8C232.8030001@kaigai.gr.jp>
Date: Thu, 25 Jan 2007 23:44:02 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: busybox@busybox.net, selinux@tycho.nsa.gov
CC: rob@landley.net, dwalsh@redhat.com, russell@coker.com.au,
        busybox@kaigai.gr.jp
Subject: [PATCH 2/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp>
In-Reply-To: <45B8C039.10907@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------010606080703020408050407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010606080703020408050407
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

[2/8] busybox-libselinux-02-getenforce.patch
  getenforce - get the current mode of SELinux.
  SELinux has two mode. 'Enforcing' is the one, it enables
  mandatory access control based on the security policy.
  The other is 'Permissive' mode. It enables to evaluate
  security policy and output audit messages, if violated.
  But mandatory access control was not done. It was used
  to debug policy.

Signed-off-by: Hiroshi Shinji <shiroshi@my.email.ne.jp>
Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>

--
KaiGai Kohei <kaigai@kaigai.gr.jp>


--------------010606080703020408050407
Content-Type: text/x-patch;
 name="busybox-libselinux-02-getenforce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-02-getenforce.patch"

Index: selinux/getenforce.c
===================================================================
--- selinux/getenforce.c	(revision 0)
+++ selinux/getenforce.c	(revision 0)
@@ -0,0 +1,40 @@
+/*
+ * getenforce
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
+#include <selinux/selinux.h>
+
+int getenforce_main(int argc, char **argv)
+{
+	int rc;
+
+	rc = is_selinux_enabled();
+	if (rc < 0) {
+		bb_error_msg("is_selinux_enabled() failed");
+		return 2;
+	}
+	if (rc == 1) {
+		rc = security_getenforce();
+		if (rc < 0) {
+			bb_error_msg("getenforce() failed");
+			return 2;
+		}
+
+		if (rc)
+			puts("Enforcing");
+		else
+			puts("Permissive");
+	} else {
+		puts("Disabled");
+	}
+
+	return 0;
+}

--------------010606080703020408050407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
