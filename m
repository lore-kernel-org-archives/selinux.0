Message-ID: <47041CB6.8070408@tycho.nsa.gov>
Date: Wed, 03 Oct 2007 18:50:30 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/3] libselinux: minor updates to AVC, mapping, callbacks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces the selinux_get_callback() companion
to selinux_set_callback() that was discussed on-list recently.

Added a format attribute to the callback union definition to
squash a gcc warning.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/selinux.h |    4 +++-
 src/callbacks.c           |   25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)


Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2628)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -142,7 +142,8 @@
 union selinux_callback {
 	/* log the printf-style format and arguments,
 	   with the type code indicating the type of message */
-	int (*func_log) (int type, const char *fmt, ...);
+	int __attribute__((format(printf, 2, 3)))
+	(*func_log) (int type, const char *fmt, ...);
 	/* store a string representation of auditdata (corresponding
 	   to the given security class) into msgbuf. */
 	int (*func_audit) (void *auditdata, security_class_t cls,
@@ -155,6 +156,7 @@
 #define SELINUX_CB_AUDIT	1
 #define SELINUX_CB_VALIDATE	2
 
+extern union selinux_callback selinux_get_callback(int type);
 extern void selinux_set_callback(int type, union selinux_callback cb);
 
 	/* Logging type codes, passed to the logging callback */
Index: libselinux/src/callbacks.c
===================================================================
--- libselinux/src/callbacks.c	(revision 2628)
+++ libselinux/src/callbacks.c	(working copy)
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <errno.h>
 #include <selinux/selinux.h>
 #include "callbacks.h"
 
@@ -65,3 +66,27 @@
 		break;
 	}
 }
+
+/* callback getting function */
+union selinux_callback
+selinux_get_callback(int type)
+{
+	union selinux_callback cb;
+
+	switch (type) {
+	case SELINUX_CB_LOG:
+		cb.func_log = selinux_log;
+		break;
+	case SELINUX_CB_AUDIT:
+		cb.func_audit = selinux_audit;
+		break;
+	case SELINUX_CB_VALIDATE:
+		cb.func_validate = selinux_validate;
+		break;
+	default:
+		memset(&cb, 0, sizeof(cb));
+		errno = EINVAL;
+		break;
+	}
+	return cb;
+}


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
