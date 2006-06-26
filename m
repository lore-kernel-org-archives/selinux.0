Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5QGlnMu029254
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:49 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5QGlmdE011142
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 16:47:48 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5QGlmjM016481
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:48 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5QGlmcB012406
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:48 -0400
Received: from vpn50-132.rdu.redhat.com (vpn50-132.rdu.redhat.com [172.16.50.132])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id k5QGllLp031525
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:47 -0400
Subject: [PATCH] libselinux: 1/2 Introduce {get,set}procattrcon
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 26 Jun 2006 12:48:55 -0400
Message-Id: <1151340535.21012.150.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The below attached patch implements two new function, get and set
procattrcon.  These are generic functions that take a context and a path
and attempt to write that context to that path.  These are used by of
exported libselinux interfaces, like getfscreatecon, as a generic
backend to reduce duplication of code.

-Eric

 include/selinux/selinux.h |    8 +++++
 src/getprocattrcon.c      |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 src/selinux_internal.h    |    4 ++
 src/setprocattrcon.c      |   48 +++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)

--- libselinux-1.30.15/src/setprocattrcon.c.p1	2006-06-26 12:00:54.000000000 -0400
+++ libselinux-1.30.15/src/setprocattrcon.c	2006-06-26 12:20:21.000000000 -0400
@@ -0,0 +1,48 @@
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include "selinux_internal.h"
+
+int setprocattrcon_raw(char *context, char *proc_entry)
+{
+	int fd;
+	ssize_t ret;
+	int errno_hold;
+
+	fd = open(proc_entry, O_RDWR);
+	if (fd < 0)
+		return -1;
+	if (context) 
+		do {
+			ret = write(fd, context, strlen(context)+1);
+		} while (ret < 0 && errno == EINTR);
+	else
+		do {
+			ret = write(fd, NULL, 0); /* clear */
+		} while (ret < 0 && errno == EINTR);
+	errno_hold = errno;
+	close(fd);
+	errno = errno_hold;
+	if (ret < 0)
+		return -1;
+	else
+		return 0;
+}
+hidden_def(setprocattrcon_raw)
+
+int setprocattrcon(char *context, char *proc_entry)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (selinux_trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = setprocattrcon_raw(rcontext, proc_entry);
+
+	freecon(rcontext);
+
+	return ret;
+}
+hidden_def(setprocattrcon)
--- libselinux-1.30.15/src/selinux_internal.h.p1	2006-06-16 15:08:51.000000000 -0400
+++ libselinux-1.30.15/src/selinux_internal.h	2006-06-26 12:00:54.000000000 -0400
@@ -26,6 +26,10 @@ hidden_proto(is_selinux_enabled)
 hidden_proto(is_selinux_mls_enabled)
 hidden_proto(freecon)
 hidden_proto(freeconary)
+hidden_proto(getprocattrcon)
+hidden_proto(getprocattrcon_raw)
+hidden_proto(setprocattrcon)
+hidden_proto(setprocattrcon_raw)
 hidden_proto(getprevcon)
 hidden_proto(getprevcon_raw)
 hidden_proto(getcon)
--- libselinux-1.30.15/src/getprocattrcon.c.p1	2006-06-26 12:00:54.000000000 -0400
+++ libselinux-1.30.15/src/getprocattrcon.c	2006-06-26 12:19:23.000000000 -0400
@@ -0,0 +1,70 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include "selinux_internal.h"
+#include "policy.h"
+
+int getprocattrcon_raw(security_context_t *context, char *proc_entry)
+{
+	char *buf;
+	size_t size;
+	int fd;
+	ssize_t ret;
+	int errno_hold;
+
+	fd = open(proc_entry, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	size = selinux_page_size;
+	buf = malloc(size);
+	if (!buf) {
+		ret = -1;
+		goto out;
+	}
+	memset(buf, 0, size);
+
+	do {
+		ret = read(fd, buf, size-1);
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0)
+		goto out2;
+
+	if (ret == 0) {
+		*context = NULL;
+		goto out2;
+	}
+
+	*context = strdup(buf);
+	if (!(*context)) {
+		ret = -1;
+		goto out2;
+	}
+	ret = 0;
+out2:			
+	free(buf);
+out:
+	errno_hold = errno;
+	close(fd);
+	errno = errno_hold;
+	return ret;
+}
+hidden_def(getprocattrcon_raw)
+
+int getprocattrcon(security_context_t *context, char *proc_entry)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getprocattrcon_raw(&rcontext, proc_entry);
+
+	if (!ret) {
+		ret = selinux_raw_to_trans_context(rcontext, context);
+		freecon(rcontext);
+	} 
+
+	return ret;
+}
+hidden_def(getprocattrcon)
--- libselinux-1.30.15/include/selinux/selinux.h.p1	2006-06-26 12:00:54.000000000 -0400
+++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-26 12:00:54.000000000 -0400
@@ -24,6 +24,14 @@ extern void freeconary(security_context_
 
 /* Wrappers for the /proc/pid/attr API. */
 
+/* Generic /proc pid attr handlers.  These will either get or set the context
+   from or into the proc location passed to them.  Should only be called from 
+   inside libselinux */
+extern int getprocattrcon(security_context_t *con, char *path);
+extern int getprocattrcon_raw(security_context_t *con, char *path);
+extern int setprocattrcon(security_context_t con, char *path);
+extern int setprocattrcon_raw(security_context_t con, char *path);
+
 /* Get current context, and set *con to refer to it.
    Caller must free via freecon. */
 extern int getcon(security_context_t *con);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
