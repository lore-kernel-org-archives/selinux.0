Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PEllLK022987
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 10:47:47 -0400
Subject: [PATCH] Export sepol handle
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@epoch.ncsc.mil
Content-Type: text/plain
Date: Tue, 25 Jul 2006 10:54:14 -0400
Message-Id: <1153839254.19259.13.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Attached is a patch to export the error reporting handle in libsepol.
The setools team needs this so that we can create, destroy, set the
callback, and invoke the error reporting from outside libsepol.  This
will allow us to better propagate the errors into our analysis
libraries.

diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/include/sepol/handle.h branch/setools_public-policydb-components/libsepol/include/sepol/handle.h
--- trunk/libsepol/include/sepol/handle.h	2005-11-22 11:31:29.000000000 -0500
+++ trunk/libsepol/include/sepol/handle.h	2006-05-31 17:18:27.000000000 -0400
@@ -3,11 +3,22 @@
 
 struct sepol_handle;
 typedef struct sepol_handle sepol_handle_t;
+typedef void (*sepol_handle_callback_fn_t) (void* varg, sepol_handle_t* handle, const char* fmt, ...);
 
 /* Create and return a sepol handle. */
-sepol_handle_t *sepol_handle_create(void);
+extern sepol_handle_t *sepol_handle_create(void);
+
+/* Set the callback for a sepol handle */
+extern void sepol_handle_set_callback(sepol_handle_t *h, sepol_handle_callback_fn_t fn, void *varg);
+
+/* Call the callback for a sepol handle */
+extern void sepol_handle_do_callback(sepol_handle_t* handle, const char* fmt, ...);
+
+/* Get the severity level of the last message */
+extern int sepol_handle_get_level(sepol_handle_t *h);
 
 /* Destroy a sepol handle. */
-void sepol_handle_destroy(sepol_handle_t *);
+extern void sepol_handle_destroy(sepol_handle_t *);
+
 
 #endif

diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/src/handle.c branch/setools_public-policydb-components/libsepol/src/handle.c
--- trunk/libsepol/src/handle.c	2006-07-13 10:19:21.000000000 -0400
+++ trunk/libsepol/src/handle.c	2006-07-13 12:42:07.000000000 -0400
@@ -1,4 +1,6 @@
 #include <stdlib.h>
+#include <stdarg.h>
+#include <errno.h>
 #include "handle.h"
 #include "debug.h"
 
@@ -16,7 +18,42 @@ sepol_handle_t *sepol_handle_create(void
 	return sh;
 }
 
-void sepol_handle_destroy(sepol_handle_t * sh)
+void sepol_handle_set_callback(sepol_handle_t *h, sepol_handle_callback_fn_t fn, void *varg)
 {
+	if (h == NULL)
+		return;
+
+	h->msg_callback = fn;
+	h->msg_callback_arg = varg;
+}
+
+void sepol_handle_do_callback(sepol_handle_t* handle, const char* fmt, ...)
+{
+	char *tmp = NULL;
+	va_list ap;
+
+	if (handle == NULL)
+		return;
+
+	va_start(ap, fmt);
+	vasprintf(&tmp, fmt, ap);
+	va_end(ap);
+
+	ERR(handle, "%s", tmp);
+	free(tmp);
+}
+
+int sepol_handle_get_level(sepol_handle_t *h)
+{
+	if (h == NULL) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	return h->msg_level;
+}
+
+void sepol_handle_destroy(sepol_handle_t * sh) {
 	free(sh);
 }
+
diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/src/handle.h branch/setools_public-policydb-components/libsepol/src/handle.h
--- trunk/libsepol/src/handle.h	2006-07-13 10:19:21.000000000 -0400
+++ trunk/libsepol/src/handle.h	2006-07-13 12:41:15.000000000 -0400
@@ -11,8 +11,7 @@ struct sepol_handle {
 #ifdef __GNUC__
 	__attribute__ ((format(printf, 3, 4)))
 #endif
-	void (*msg_callback) (void *varg,
-			      sepol_handle_t * handle, const char *fmt, ...);
+	sepol_handle_callback_fn_t msg_callback;
 	void *msg_callback_arg;
 };
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
