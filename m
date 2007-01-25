Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0PEhSHu025871
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 09:43:28 -0500
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0PEi5XG019513
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 14:44:27 GMT
Received: by wx-out-0506.google.com with SMTP id s17so554583wxc
        for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 06:44:27 -0800 (PST)
Message-ID: <45B8C244.7040609@kaigai.gr.jp>
Date: Thu, 25 Jan 2007 23:44:20 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: busybox@busybox.net, selinux@tycho.nsa.gov
CC: rob@landley.net, dwalsh@redhat.com, russell@coker.com.au,
        busybox@kaigai.gr.jp
Subject: [PATCH 4/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp>
In-Reply-To: <45B8C039.10907@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------030804060002070308050703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030804060002070308050703
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

[4/8] busybox-libselinux-04-getsebool.patch
  getsebool reports the a particular or all SELinux
  boolean variable.
  SELinux boolean variable is a interface to configure
  the condition of security policy. We can enable or
  disable the part of the security policy via boolean
  variable.

Signed-off-by: Hiroshi Shinji <shiroshi@my.email.ne.jp>
Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>

--
KaiGai Kohei <kaigai@kaigai.gr.jp>


--------------030804060002070308050703
Content-Type: text/x-patch;
 name="busybox-libselinux-04-getsebool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-04-getsebool.patch"

Index: selinux/getsebool.c
===================================================================
--- selinux/getsebool.c	(revision 0)
+++ selinux/getsebool.c	(revision 0)
@@ -0,0 +1,98 @@
+/*
+ * getsebool
+ *
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+
+#include "busybox.h"
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <errno.h>
+#include <string.h>
+#include <selinux/selinux.h>
+
+#define GETSEBOOL_OPT_ALL	1
+
+int getsebool_main(int argc, char **argv)
+{
+	int i, rc = 0, active, pending, len = 0;
+	char **names;
+	unsigned long opt;
+
+	opt = getopt32(argc, argv, "a");
+
+	if(opt & BB_GETOPT_ERROR) {
+		bb_show_usage();
+	}
+	if(opt & GETSEBOOL_OPT_ALL) {
+		if (argc > 2)
+			bb_show_usage();
+		if (is_selinux_enabled() <= 0) {
+			bb_error_msg_and_die("SELinux is disabled");
+		}
+		errno = 0;
+		rc = security_get_boolean_names(&names, &len);
+		if (rc) {
+			bb_error_msg_and_die("Unable to get boolean names:  %s", strerror(errno));
+		}
+		if (!len) {
+			printf("No booleans\n");
+			return 0;
+		}
+	}
+
+	if (is_selinux_enabled() <= 0) {
+		bb_error_msg_and_die("SELinux is disabled");
+	}
+
+	if (!len) {
+		if (argc < 2)
+			bb_show_usage();
+		len = argc - 1;
+		names = malloc(sizeof(char *) * len);
+		if (!names) {
+			bb_error_msg_and_die("out of memory");
+		}
+		for (i = 0; i < len; i++) {
+			names[i] = strdup(argv[i + 1]);
+			if (!names[i]) {
+				bb_error_msg_and_die("out of memory");
+			}
+		}
+	}
+
+	for (i = 0; i < len; i++) {
+		active = security_get_boolean_active(names[i]);
+		if (active < 0) {
+			bb_error_msg("Error getting active value for %s",
+				names[i]);
+			rc = -1;
+			goto out;
+		}
+		pending = security_get_boolean_pending(names[i]);
+		if (pending < 0) {
+			bb_error_msg("Error getting pending value for %s",
+				names[i]);
+			rc = -1;
+			goto out;
+		}
+		if (pending != active) {
+			printf("%s --> %s pending: %s\n", names[i],
+			       (active ? "on" : "off"),
+			       (pending ? "on" : "off"));
+		} else {
+			printf("%s --> %s\n", names[i],
+			       (active ? "on" : "off"));
+		}
+	}
+
+      out:
+	for (i = 0; i < len; i++)
+		free(names[i]);
+	free(names);
+	return rc;
+}

--------------030804060002070308050703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
