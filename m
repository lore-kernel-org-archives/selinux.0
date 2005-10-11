Message-ID: <434B7FF2.2090306@cornell.edu>
Date: Tue, 11 Oct 2005 05:03:46 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEPOL ] Another debugging system
References: <434B62B8.4080309@cornell.edu>
In-Reply-To: <434B62B8.4080309@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------020804010803000203080903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020804010803000203080903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan Gyurdiev wrote:
> The attached patch replaces the current semanage debugging system, 
> with one based on callbacks. It breaks API, so the libsemanage.map 
> file needs to be updated, but I'm not sure how to do that properly, so 
> I left that part out...
Attached patch introduces the same debug system to sepol, except it does 
not break compatibility, or replace old usage here yet - this is a bit 
more difficult to do than in semanage, so I'd rather split it up in 
several patches. This one introduces a handle, but doesn't allow the 
handle to be passed in anywhere yet. A global handle is used for 
handling the compatibility functions. I've exported those interfaces via 
the map file, and included them in sepol.h.

Bugfix: can you delete the '\n' from the default handler in the semanage 
patch - it prints an extra newline.

Question: should sepol.h be including all (external api) sepol headers ? 
It does not do that currently. I added debug.h, but the others are still 
not included.

--------------020804010803000203080903
Content-Type: text/x-patch;
 name="libsepol.debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.debug.diff"

diff -Naur --exclude CVS libsepol/include/sepol/debug.h libsepol.new/include/sepol/debug.h
--- libsepol/include/sepol/debug.h	2005-07-18 10:28:43.000000000 -0400
+++ libsepol.new/include/sepol/debug.h	2005-10-11 04:25:10.000000000 -0400
@@ -1,9 +1,48 @@
 #ifndef _SEPOL_DEBUG_H_
 #define _SEPOL_DEBUG_H_
 
+#include <sepol/handle.h>
+
+/* Deprecated */
 extern void sepol_enable_debug(
 	void (*fn)(const char* fname, const char *fmt, ...));
 
 extern void sepol_disable_debug();
+extern void sepol_debug(int on);
+/* End deprecated */
+
+struct sepol_message;
+typedef struct sepol_message sepol_message_t;
+
+#define SEPOL_MSG_ERR  1
+#define SEPOL_MSG_WARN 2
+#define SEPOL_MSG_INFO 3
+
+extern const char* sepol_msg_get_message(
+	sepol_message_t* msg);
+
+extern int sepol_msg_get_level(
+	sepol_message_t* msg);
+
+extern const char* sepol_msg_get_channel(
+	sepol_message_t* msg);
+
+extern const char* sepol_msg_get_fname(
+	sepol_message_t* msg);
+
+extern void sepol_msg_free(
+	sepol_message_t* msg);
+
+/* Set the messaging callback. 
+ * By the default, the callback will print
+ * the message on standard output, in a 
+ * particular format. Passing NULL here
+ * indicates that messaging should be suppressed */
+extern void sepol_msg_set_callback(
+	sepol_handle_t* handle,
+	void (*callback) (
+		void* varg,
+		sepol_message_t* msg),
+	void* callback_arg);
 
-#endif /* _SEPOL_DEBUG_H_ */
+#endif 
diff -Naur --exclude CVS libsepol/include/sepol/handle.h libsepol.new/include/sepol/handle.h
--- libsepol/include/sepol/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol.new/include/sepol/handle.h	2005-10-11 03:41:51.000000000 -0400
@@ -0,0 +1,13 @@
+#ifndef _SEPOL_HANDLE_H_
+#define _SEPOL_HANDLE_H_
+
+struct sepol_handle;
+typedef struct sepol_handle sepol_handle_t;
+
+/* Create and return a sepol handle. */
+sepol_handle_t *sepol_handle_create(void);
+
+/* Destroy a sepol handle. */
+void sepol_handle_destroy(sepol_handle_t *);
+
+#endif
diff -Naur --exclude CVS libsepol/include/sepol/sepol.h libsepol.new/include/sepol/sepol.h
--- libsepol/include/sepol/sepol.h	2005-09-14 11:44:44.000000000 -0400
+++ libsepol.new/include/sepol/sepol.h	2005-10-11 04:24:40.000000000 -0400
@@ -4,6 +4,8 @@
 #include <stddef.h>
 #include <stdio.h>
 
+#include <sepol/debug.h>
+
 /* Given an existing binary policy (starting at 'data', with length 'len')
    and a boolean configuration file named by 'boolpath', rewrite the binary
    policy for the boolean settings in the boolean configuration file.
@@ -37,6 +39,4 @@
 /* Check context validity against currently set binary policy. */
 extern int sepol_check_context(char *context);
 
-/* Turn on or off sepol error messages. */
-extern void sepol_debug(int on);
 #endif
diff -Naur --exclude CVS libsepol/src/debug.c libsepol.new/src/debug.c
--- libsepol/src/debug.c	2005-09-14 15:04:54.000000000 -0400
+++ libsepol.new/src/debug.c	2005-10-11 04:52:05.000000000 -0400
@@ -1,50 +1,143 @@
 #include <stdarg.h>
+#include <stdlib.h>
 #include <stdio.h>
-
-#include <sepol/sepol.h>
-#include <sepol/debug.h>
+#include "handle.h"
 #include "debug.h"
 
-#ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3))) 
-#endif
-static void default_printf(
-	const char* fname, 
-	const char *fmt, ...) {
+/* Deprecated */
+void msg_compat_handler(
+	void* varg,
+	sepol_message_t* msg) {
+
+	void (*compat_fn)
+		(const char* fname, const char* fmt, ...) = varg;
+
+	if (compat_fn) {
+		compat_fn(sepol_msg_get_fname(msg),
+			"%s", sepol_msg_get_message(msg));
+	}
+}
 
-	va_list ap;
-	va_start(ap, fmt);
-	fprintf(stderr, "libsepol.%s: ", fname);
-	vfprintf (stderr, fmt, ap);
-	va_end(ap);
+struct sepol_handle compat_handle = {
+	.callback = msg_default_handler,
+	.callback_arg = NULL,
+};
+
+void sepol_debug(int on) {
+	compat_handle.callback = (on)? msg_default_handler : NULL;
 }
 
-#ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
-#endif
-static void suppress_printf(
-	const char* unused1, 
-	const char* unused2, ...) { 
-		unused1 = NULL;
-		unused2 = NULL;
+void sepol_enable_debug(
+	void (*fn)(const char* fname, const char *fmt, ...)) {
+
+	compat_handle.callback = (fn)? msg_compat_handler: msg_default_handler;
+	compat_handle.callback_arg = fn;
 }
 
-void (*DEBUG) (const char* fname, const char* fmt, ...) = default_printf;
+void sepol_disable_debug() {
+	compat_handle.callback = NULL;
+}
+/* End deprecated */
 
-/* Compatibility */
-void sepol_debug(int on) {
-        sepol_debug_compat(on);
+
+#define SEPOL_ERRBUFSZ 1024
+
+struct sepol_message {
+	char message[SEPOL_ERRBUFSZ];
+	int level;
+	const char* channel;
+	const char* fname;
+};
+
+const char* sepol_msg_get_message(sepol_message_t* msg) {
+	return msg->message;
 };
 
-void sepol_debug_compat(int on) {
-	DEBUG = (on)? default_printf : suppress_printf;
+int sepol_msg_get_level(sepol_message_t* msg) {
+	return msg->level;
 }
 
-void sepol_enable_debug(
-	void (*fn)(const char* fname, const char *fmt, ...)) {
-	DEBUG = (fn)? fn: default_printf;	
+const char* sepol_msg_get_channel(sepol_message_t* msg) {
+	return msg->channel;
 }
 
-void sepol_disable_debug() {
-	DEBUG = suppress_printf;
+const char* sepol_msg_get_fname(sepol_message_t* msg) {
+	return msg->fname;
+}
+
+void sepol_msg_free(sepol_message_t* msg) {
+	if (!msg)
+		return;
+
+	free(msg);
+}
+
+void msg_default_handler(
+	void* varg,
+	sepol_message_t* msg) {
+
+	FILE* stream = NULL;
+
+	switch(sepol_msg_get_level(msg)) {
+	
+		case SEPOL_MSG_ERR:
+		case SEPOL_MSG_WARN:
+			stream = stderr;
+			break;
+		case SEPOL_MSG_INFO:
+		default:
+			stream = stdout;
+			break;
+	}
+
+	fprintf(stream, "%s.%s: %s",
+		sepol_msg_get_channel(msg),
+		sepol_msg_get_fname(msg),
+		sepol_msg_get_message(msg));
+
+	sepol_msg_free(msg);
+	varg = NULL;
+}
+
+#ifdef __GNUC__
+__attribute__ ((format (printf, 5, 6)))
+#endif
+void msg_write(
+	sepol_handle_t* handle,
+	int level,
+	const char* channel,
+	const char* fname,
+	char* fmt,
+	...) {
+
+	sepol_message_t* msg;
+
+	if (!handle->callback)
+		return;
+
+	msg = (sepol_message_t*) malloc(sizeof(sepol_message_t));
+	if (!msg)
+		return;
+
+	msg->fname = fname;
+	msg->channel = channel;
+	msg->level = level;
+
+	va_list ap;
+	va_start(ap, fmt);
+	vsnprintf(msg->message, SEPOL_ERRBUFSZ, fmt, ap);
+	va_end(ap);
+
+	handle->callback(handle->callback_arg, msg);
+}
+
+extern void sepol_msg_set_callback(
+	sepol_handle_t* handle,
+	void (*callback) (
+		void* varg,
+		sepol_message_t* msg),
+	void* callback_arg) {
+
+	handle->callback = callback;
+	handle->callback_arg = callback_arg;
 }
diff -Naur --exclude CVS libsepol/src/debug.h libsepol.new/src/debug.h
--- libsepol/src/debug.h	2005-07-18 10:28:43.000000000 -0400
+++ libsepol.new/src/debug.h	2005-10-11 04:51:31.000000000 -0400
@@ -1,17 +1,52 @@
 #ifndef _SEPOL_INTERNAL_DEBUG_H_
 #define _SEPOL_INTERNAL_DEBUG_H_
 
+#include "handle.h"
+#include <stdio.h>
+#include <sepol/debug.h>
+
 #define STATUS_SUCCESS 0
 #define STATUS_ERR -1
 #define STATUS_NODATA 1
 
-extern void sepol_debug_compat(int on);
+#define ERR(handle, ...) \
+	msg_write(handle, SEPOL_MSG_ERR, "libsepol", \
+	__func__, __VA_ARGS__)
+
+#define INFO(handle, fmt, ...) \
+	msg_write(handle, SEPOL_MSG_INFO, "libsepol", \
+	__func__, __VA_ARGS__)
+
+#define WARN(handle, fmt, ...) \
+	msg_write(handle, SEPOL_MSG_WARN, "libsepol", \
+	__func__, __VA_ARGS__)
 
 #ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
+__attribute__ ((format (printf, 5, 6)))
 #endif
-extern void (*DEBUG) (
+extern void msg_write(
+	sepol_handle_t* handle,
+	int level,
+	const char* channel,
 	const char* fname,
-	const char* fmt, ...);
+	char* fmt,
+	...);
+
+extern void msg_default_handler(
+	void* varg,
+	sepol_message_t* msg);
+
+/* Deprecated */
+extern void msg_compat_handler(
+	void* varg,
+	sepol_message_t* msg);
+
+extern struct sepol_handle compat_handle;
+
+#define DEBUG(fname, ...) \
+	msg_write(&compat_handle, SEPOL_MSG_ERR, "libsepol", \
+	fname, __VA_ARGS__)
+/* End deprecated */
+
 
-#endif /* _SEPOL_INTERNAL_DEBUG_H_ */
+#endif 
diff -Naur --exclude CVS libsepol/src/handle.c libsepol.new/src/handle.c
--- libsepol/src/handle.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol.new/src/handle.c	2005-10-11 04:40:50.000000000 -0400
@@ -0,0 +1,21 @@
+#include <stdlib.h>
+#include "handle.h"
+#include "debug.h"
+
+sepol_handle_t *sepol_handle_create(void) {
+
+	sepol_handle_t *sh = malloc(sizeof(sepol_handle_t));
+	if (sh == NULL)
+		return NULL;
+	
+	/* Set callback */
+	sh->callback = msg_default_handler;
+	sh->callback_arg = NULL;
+
+	return sh;
+}
+
+void sepol_handle_destroy(sepol_handle_t *sh) {
+	free(sh);
+}
+
diff -Naur --exclude CVS libsepol/src/handle.h libsepol.new/src/handle.h
--- libsepol/src/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol.new/src/handle.h	2005-10-11 04:31:25.000000000 -0400
@@ -0,0 +1,17 @@
+#ifndef _SEPOL_INTERNAL_HANDLE_H_
+#define _SEPOL_INTERNAL_HANDLE_H_
+
+#include <sepol/handle.h>
+#include <sepol/debug.h>
+
+struct sepol_handle {
+
+	/* Error callback */
+	void (*callback) (
+		void* varg,
+		sepol_message_t* msg);
+	void* callback_arg;
+
+};
+
+#endif
diff -Naur --exclude CVS libsepol/src/libsepol.map libsepol.new/src/libsepol.map
--- libsepol/src/libsepol.map	2005-10-07 18:38:02.000000000 -0400
+++ libsepol.new/src/libsepol.map	2005-10-11 04:54:39.000000000 -0400
@@ -17,5 +17,6 @@
 	sepol_bool*; sepol_context*; sepol_disable_debug; sepol_enable_debug;
 	sepol_iface*; sepol_port*; sepol_user*; sepol_clear_unused_users;
 	sepol_role_is_valid; sepol_set_delusers;
+	sepol_msg_*; sepol_handle_*;
   local: *;
 };

--------------020804010803000203080903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
