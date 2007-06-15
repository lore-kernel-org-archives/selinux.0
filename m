Message-ID: <467320D6.5040703@tycho.nsa.gov>
Date: Fri, 15 Jun 2007 19:29:26 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [PATCH 1/7] libselinux: labeling support (try 4)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Changes from the third version: remove handle typedef, includes patch
for setfiles, rebases matchpathcon code to use new interface, includes
X backend, fixes setfiles -c, rolls in callback interface patch.

This is a labeling API that provides a common way to map from various
string namespaces into security contexts.

This version of the patchset simplifies the lookup model down to
(string,number) to context.  There are no void pointers or variadic
functions which was one of the objections to the previous patchsets.
A lot of the file contexts stuff such as the inode tracking support
has also been dropped with the understanding that this stuff should
be in the setfiles code, not libselinux.  This is a pure lookup
interface only.

This patchset includes 3 backends, for file contexts, media contexts
and X.  Future work would include libsemanage interfaces for
managing the data the way the file contexts data is currently done.

This patch includes the new callback interface.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/selinux.h |   25 +++++++++++++++++
 src/callbacks.c           |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 src/callbacks.h           |   24 ++++++++++++++++
 3 files changed, 116 insertions(+)


Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2474)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -132,6 +132,31 @@
 	unsigned int seqno;
 };
 
+/* Callback facilities */
+union selinux_callback {
+	/* log the printf-style format and arguments,
+	   with the type code indicating the type of message */
+	int (*func_log) (int type, const char *fmt, ...);
+	/* store a string representation of auditdata (corresponding
+	   to the given security class) into msgbuf. */
+	int (*func_audit) (void *auditdata, security_class_t cls,
+			   char *msgbuf, size_t msgbufsize);
+	/* validate the supplied context, modifying if necessary */
+	int (*func_validate) (security_context_t *ctx);
+};
+
+#define SELINUX_CB_LOG		0
+#define SELINUX_CB_AUDIT	1
+#define SELINUX_CB_VALIDATE	2
+
+extern void selinux_set_callback(int type, union selinux_callback cb);
+
+	/* Logging type codes, passed to the logging callback */
+#define SELINUX_ERROR	        0
+#define SELINUX_WARNING		1
+#define SELINUX_INFO		2
+#define SELINUX_AVC		3
+
 /* Compute an access decision. */
 extern int security_compute_av(security_context_t scon,
 			       security_context_t tcon,
Index: libselinux/src/callbacks.h
===================================================================
--- libselinux/src/callbacks.h	(revision 0)
+++ libselinux/src/callbacks.h	(revision 0)
@@ -0,0 +1,24 @@
+/*
+ * This file describes the callbacks passed to selinux_init() and available
+ * for use from the library code.  They all have default implementations.
+ */
+#ifndef _SELINUX_CALLBACKS_H_
+#define _SELINUX_CALLBACKS_H_
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <selinux/selinux.h>
+#include "dso.h"
+
+/* callback pointers */
+extern int __attribute__ ((format(printf, 2, 3)))
+(*selinux_log) (int type, const char *, ...) hidden;
+
+extern int
+(*selinux_audit) (void *, security_class_t, char *, size_t) hidden;
+
+extern int
+(*selinux_validate)(security_context_t *ctx) hidden;
+
+#endif				/* _SELINUX_CALLBACKS_H_ */
Index: libselinux/src/callbacks.c
===================================================================
--- libselinux/src/callbacks.c	(revision 0)
+++ libselinux/src/callbacks.c	(revision 0)
@@ -0,0 +1,67 @@
+/*
+ * User-supplied callbacks and default implementations.
+ * Class and permission mappings.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <selinux/selinux.h>
+#include "callbacks.h"
+
+/* default implementations */
+static int __attribute__ ((format(printf, 2, 3)))
+default_selinux_log(int type __attribute__((unused)), const char *fmt, ...)
+{
+	int rc;
+	va_list ap;
+	va_start(ap, fmt);
+	rc = vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	return rc;
+}
+
+static int
+default_selinux_audit(void *ptr __attribute__((unused)),
+		      security_class_t cls __attribute__((unused)),
+		      char *buf __attribute__((unused)),
+		      size_t len __attribute__((unused)))
+{
+	return 0;
+}
+
+static int
+default_selinux_validate(security_context_t *ctx)
+{
+	return security_check_context(*ctx);
+}
+
+/* callback pointers */
+int __attribute__ ((format(printf, 2, 3)))
+(*selinux_log)(int, const char *, ...) =
+	default_selinux_log;
+
+int
+(*selinux_audit) (void *, security_class_t, char *, size_t) =
+	default_selinux_audit;
+
+int
+(*selinux_validate)(security_context_t *ctx) =
+	default_selinux_validate;
+
+/* callback setting function */
+void
+selinux_set_callback(int type, union selinux_callback cb)
+{
+	switch (type) {
+	case SELINUX_CB_LOG:
+		selinux_log = cb.func_log;
+		break;
+	case SELINUX_CB_AUDIT:
+		selinux_audit = cb.func_audit;
+		break;
+	case SELINUX_CB_VALIDATE:
+		selinux_validate = cb.func_validate;
+		break;
+	}
+}


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
