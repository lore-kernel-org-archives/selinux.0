Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BEkWoj009155
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 10:46:33 -0400
Subject: libselinux: Introduce interfaces to use context_dom selinuxfs entry
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>, bwhalen@tresys.com
In-Reply-To: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
References: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 10:37:57 -0400
Message-Id: <1213195077.16897.64.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces libselinux interfaces to make use of the new context_dom entry in selinuxfs. It uses standard strcmp semantics for returning the ordering (-1 c1 before c2, 0 c1 == c2, 1 c1 after c2).

Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2903)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -180,6 +180,14 @@
 				   access_vector_t requested,
 				   struct av_decision *avd);
 
+/* Compute dominance of one label over another */
+extern int security_compute_dom(security_context_t scon1,
+				security_context_t scon2,
+				int *result);
+extern int security_compute_dom_raw(security_context_t scon1,
+				    security_context_t scon2,
+				    int *result);
+
 /* Compute a labeling decision and set *newcon to refer to it.
    Caller must free via freecon. */
 extern int security_compute_create(security_context_t scon,
Index: libselinux/src/compute_dom.c
===================================================================
--- libselinux/src/compute_dom.c	(revision 0)
+++ libselinux/src/compute_dom.c	(revision 0)
@@ -0,0 +1,82 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include "selinux_internal.h"
+#include "policy.h"
+#include <limits.h>
+
+int security_compute_dom_raw(security_context_t scon1,
+			     security_context_t scon2,
+			     int *result)
+{
+	char path[PATH_MAX];
+	char *buf;
+	size_t size;
+	int fd, ret;
+
+	if (!selinux_mnt) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	snprintf(path, sizeof path, "%s/context_dom", selinux_mnt);
+	fd = open(path, O_RDWR);
+	if (fd < 0)
+		return -1;
+
+	size = selinux_page_size;
+	buf = malloc(size);
+	if (!buf) {
+		ret = -1;
+		goto out;
+	}
+	snprintf(buf, size, "%s %s", scon1, scon2);
+	
+	ret = write(fd, buf, strlen(buf));
+	if (ret < 0)
+		goto out2;
+
+	memset(buf, 0, size);
+	ret = read(fd, buf, size - 1);
+	if (ret < 0)
+		goto out2;
+
+	if (sscanf(buf, "%d", result) != 1) {
+		ret = -1;
+		goto out2;
+	}
+	ret = 0;
+out2:
+	free(buf);
+out:
+	close(fd);
+	return ret;
+}
+
+int security_compute_dom(security_context_t scon1,
+			security_context_t scon2,
+			int *result)
+{
+	int ret;
+	security_context_t rscon1 = scon1;
+	security_context_t rscon2 = scon2;
+
+	if (selinux_trans_to_raw_context(scon1, &rscon1))
+		return -1;
+	if (selinux_trans_to_raw_context(scon2, &rscon2)) {
+		freecon(rscon1);
+		return -1;
+	}
+
+	ret = security_compute_dom_raw(rscon1, rscon2, result);
+
+	freecon(rscon1);
+	freecon(rscon2);
+
+	return ret;
+}
+


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
