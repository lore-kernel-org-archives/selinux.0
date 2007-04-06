Subject: [patch 1/2] libselinux: add support for getting contexts for
	kernel initial SIDs from selinuxfs
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Smalley <sds@epoch.ncsc.mil>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 06 Apr 2007 15:37:20 -0400
Message-Id: <1175888240.25329.84.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds support to libselinux to get the context for a kernel initial
security identifier specified by name from the selinuxfs interface.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

---

 include/selinux/selinux.h               |    7 +++
 man/man3/security_compute_av.3          |    9 +++-
 man/man3/security_get_initial_context.3 |    1 
 src/get_initial_context.c               |   72 ++++++++++++++++++++++++++++++++
 src/selinux_internal.h                  |    2 
 5 files changed, 90 insertions(+), 1 deletion(-)

Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2318)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -189,6 +189,13 @@
 /* Load a policy configuration. */
 	extern int security_load_policy(void *data, size_t len);
 
+/* Get the context of an initial kernel security identifier by name.  
+   Caller must free via freecon */
+	extern int security_get_initial_context(const char * name, 
+						security_context_t * con);
+	extern int security_get_initial_context_raw(const char * name, 
+						    security_context_t * con);
+
 /*
  * Make a policy image and load it.
  * This function provides a higher level interface for loading policy
Index: libselinux/src/get_initial_context.c
===================================================================
--- libselinux/src/get_initial_context.c	(revision 0)
+++ libselinux/src/get_initial_context.c	(revision 0)
@@ -0,0 +1,72 @@
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
+#define SELINUX_INITCON_DIR "/initial_contexts/"
+
+int security_get_initial_context_raw(const char * name, security_context_t * con)
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
+	snprintf(path, sizeof path, "%s%s%s", 
+		 selinux_mnt, SELINUX_INITCON_DIR, name);
+	fd = open(path, O_RDONLY);
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
+	ret = read(fd, buf, size - 1);
+	if (ret < 0)
+		goto out2;
+
+	*con = strdup(buf);
+	if (!(*con)) {
+		ret = -1;
+		goto out2;
+	}
+	ret = 0;
+      out2:
+	free(buf);
+      out:
+	close(fd);
+	return ret;
+}
+
+hidden_def(security_get_initial_context_raw)
+
+int security_get_initial_context(const char * name, security_context_t * con)
+{
+	int ret;
+	security_context_t rcon;
+
+	ret = security_get_initial_context_raw(name, &rcon);
+	if (!ret) {
+		ret = selinux_raw_to_trans_context(rcon, con);
+		freecon(rcon);
+	}
+
+	return ret;
+}
+
+hidden_def(security_get_initial_context)
Index: libselinux/src/selinux_internal.h
===================================================================
--- libselinux/src/selinux_internal.h	(revision 2318)
+++ libselinux/src/selinux_internal.h	(working copy)
@@ -76,6 +76,8 @@
 hidden_proto(selinux_getpolicytype);
 hidden_proto(selinux_raw_to_trans_context);
 hidden_proto(selinux_trans_to_raw_context);
+hidden_proto(security_get_initial_context);
+hidden_proto(security_get_initial_context_raw);
 
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
Index: libselinux/man/man3/security_get_initial_context.3
===================================================================
--- libselinux/man/man3/security_get_initial_context.3	(revision 0)
+++ libselinux/man/man3/security_get_initial_context.3	(revision 0)
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
Index: libselinux/man/man3/security_compute_av.3
===================================================================
--- libselinux/man/man3/security_compute_av.3	(revision 2318)
+++ libselinux/man/man3/security_compute_av.3	(working copy)
@@ -1,6 +1,7 @@
 .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-security_compute_av, security_compute_create, security_compute_relabel, security_compute_user \- query
+security_compute_av, security_compute_create, security_compute_relabel,
+security_compute_user, security_get_initial_context \- query
 the SELinux policy database in the kernel.
 
 .SH "SYNOPSIS"
@@ -16,6 +17,9 @@
 .sp
 .BI "int security_compute_user(security_context_t "scon ", const char *" username ", security_context_t **" con );
 .sp
+.BI "int security_get_initial_context(const char *" name ", security_context_t
+"con );
+.sp
 .BI "int checkPasswdAccess(access_vector_t " requested );
 
 .SH "DESCRIPTION"
@@ -44,6 +48,9 @@
 source context. Is mainly used by
 .B get_ordered_context_list.
 
+.B security_get_initial_context
+is used to get the context of an initial kernel security identifier by name.
+
 .B checkPasswdAccess
 This functions is a helper functions that allows you to check for a permission in the passwd class. checkPasswdAccess uses getprevcon() for the source and target security contexts.
 

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
