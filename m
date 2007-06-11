Message-ID: <466D9BA1.3050901@tycho.nsa.gov>
Date: Mon, 11 Jun 2007 14:59:45 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: new callback mechanism
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current method of setting callbacks, as implemented in
avc_init(), is to pass in a large number of structures with
individual fields for each callback.  This is cumbersome
and as a lead-up to the labeling support patchset, I have
come up with another solution to this problem.

This new selinux_set_callback() function takes a type code and
a function pointer that comes from a union of callback types.

This hopefully can become the way to set callbacks; the
avc_init() call will be deprecated and replaced with another
call that doesn't require passing in all the callbacks.

This patchset includes three callbacks.  The various threading
and locking ones can be added subsequently.

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

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
