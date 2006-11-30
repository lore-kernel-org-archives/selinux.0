Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU48b1s012196
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:08:37 -0500
Received: from facesaver.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAU46sbM020479
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 04:06:54 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU43V9e014832
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:03:31 -0500
Subject: [PATCH 2/5] libselinux: labeling API basic front-end implementation
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
In-Reply-To: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-Lm7N9w5bO3rfqEX+BH6+"
Date: Wed, 29 Nov 2006 23:08:36 -0500
Message-Id: <1164859716.2794.204.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Lm7N9w5bO3rfqEX+BH6+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the front-end implementation.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---
 libselinux/src/label.c          |  180 ++++++++++++++++++++++++
 libselinux/src/label_internal.c |   58 +++++++
 libselinux/src/label_internal.h |   98 +++++++++++++
 3 files changed, 336 insertions(+)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-Lm7N9w5bO3rfqEX+BH6+
Content-Description: 
Content-Disposition: inline; filename=label2.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/label_internal.h
===================================================================
--- libselinux/src/label_internal.h	(revision 0)
+++ libselinux/src/label_internal.h	(revision 0)
@@ -0,0 +1,98 @@
+/*
+ * This file describes the internal interface used by the labeler
+ * for calling the user-supplied memory allocation, validation,
+ * and locking routine.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+#ifndef _SELINUX_LABEL_INTERNAL_H_
+#define _SELINUX_LABEL_INTERNAL_H_
+
+#include <stdlib.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#include "dso.h"
+
+/* backend interface */
+struct label_rec {
+	/* linked list of all open handles */
+	struct label_rec *next;
+
+	/* object class, name, and flags for this instance */
+	security_class_t cls;
+	char *name;
+	int flags;
+
+	/* labeling operations */
+	int (*func_lookup) (struct label_rec *h, const char *key,
+			    security_class_t cls, security_context_t *ctx);
+	void (*func_destroy) (struct label_rec *h);
+	void (*func_cache_stats) (struct label_rec *h);
+	void (*func_op_stats) (struct label_rec *h);
+
+	/* supports backend-specific state information */
+	void *data;
+};
+
+struct label_backend {
+	security_class_t cls;
+	int (*func_init) (struct label_rec *rec, void *arg);
+};
+
+/* installed backends */
+int backend_file_init(struct label_rec *rec, void *arg) hidden;
+int backend_media_init(struct label_rec *rec, void *arg) hidden;
+int backend_generic_init(struct label_rec *rec, void *arg) hidden;
+
+/* callback pointers */
+extern void *(*label_func_malloc) (size_t) hidden;
+extern void (*label_func_free) (void *) hidden;
+
+extern int (*label_func_log) (int type, const char *, ...) hidden;
+extern int (*label_func_validate) (security_class_t cls, char **ctx) hidden;
+
+extern void *(*label_func_alloc_lock) (void) hidden;
+extern void (*label_func_get_lock) (void *) hidden;
+extern void (*label_func_release_lock) (void *) hidden;
+extern void (*label_func_free_lock) (void *) hidden;
+
+/* user-supplied callback interface for avc */
+static inline void *label_malloc(size_t size)
+{
+	return label_func_malloc(size);
+}
+
+static inline void label_free(void *ptr)
+{
+	label_func_free(ptr);
+}
+
+/* this is a macro in order to use the variadic capability. */
+#define label_log(type, format...) label_func_log(type, format)
+
+static inline int label_validate(security_class_t cls, char **ctx)
+{
+	return label_func_validate(cls, ctx);
+}
+
+static inline void *label_alloc_lock(void)
+{
+	return label_func_alloc_lock();
+}
+
+static inline void label_get_lock(void *lock)
+{
+	label_func_get_lock(lock);
+}
+
+static inline void label_release_lock(void *lock)
+{
+	label_func_release_lock(lock);
+}
+
+static inline void label_free_lock(void *lock)
+{
+	label_func_free_lock(lock);
+}
+
+#endif				/* _SELINUX_LABEL_INTERNAL_H_ */
Index: libselinux/src/label.c
===================================================================
--- libselinux/src/label.c	(revision 0)
+++ libselinux/src/label.c	(revision 0)
@@ -0,0 +1,180 @@
+/*
+ * Generalized labeling frontend for userspace object managers.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+
+#include <sys/types.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <selinux/flask.h>
+#include <selinux/label.h>
+#include "label_internal.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static struct label_rec *rec_list = NULL;
+
+static void *label_lock = NULL;
+static void *label_log_lock = NULL;
+
+struct label_backend backends[] = {
+	{SECCLASS_FILE, &backend_file_init},
+	{SECCLASS_XEXTENSION, &backend_generic_init}
+};
+
+static struct label_rec *open_backend(struct label_backend *backend,
+				      const char *name, int flags, void *arg)
+{
+	int rc;
+	struct label_rec *rec = (struct label_rec *)label_malloc(sizeof(*rec));
+	if (!rec)
+		goto err1;
+
+	memset(rec, 0, sizeof(*rec));
+	rec->cls = backend->cls;
+	rec->flags = flags;
+	rec->name = strdup(name);
+	if (!rec->name)
+		goto err2;
+
+	rc = backend->func_init(rec, arg);
+	if (rc) {
+		label_log(LABEL_ERROR,
+			  "failed to open labeling backend for class %d\n",
+			  backend->cls);
+		goto err3;
+	}
+
+	rec->next = rec_list;
+	rec_list = rec;
+	return rec;
+
+err3:
+	label_free(rec->name);
+err2:
+	label_free(rec);
+err1:
+	return NULL;
+}
+
+int label_init(const struct label_memory_callback *mem_cb,
+	       const struct label_log_callback *log_cb,
+	       const struct label_action_callback *action_cb,
+	       const struct label_lock_callback *lock_cb)
+{
+	if (mem_cb) {
+		label_func_malloc = mem_cb->func_malloc;
+		label_func_free = mem_cb->func_free;
+	}
+	if (log_cb) {
+		label_func_log = log_cb->func_log;
+	}
+	if (action_cb) {
+		label_func_validate = action_cb->func_validate;
+	}
+	if (lock_cb) {
+		label_func_alloc_lock = lock_cb->func_alloc_lock;
+		label_func_get_lock = lock_cb->func_get_lock;
+		label_func_release_lock = lock_cb->func_release_lock;
+		label_func_free_lock = lock_cb->func_free_lock;
+	}
+
+	label_lock = label_alloc_lock();
+	label_log_lock = label_alloc_lock();
+
+	return 0;
+}
+
+struct label_rec *label_open(const char *name, security_class_t cls,
+			     int flags, void *arg)
+{
+	struct label_rec *rec = NULL;
+	unsigned int i;
+
+	if (name == NULL || name[0] == '\0') {
+		errno = EINVAL;
+		goto out;
+	}
+
+	label_get_lock(label_lock);
+
+	/* need to open backend at this point */
+	for (i = 0; i < ARRAY_SIZE(backends); i++)
+		if (backends[i].cls == cls) {
+			rec = open_backend(backends+i, name, flags, arg);
+			goto out;
+		}
+
+	/* backend not supported! this is highly irregular */
+	errno = ENOENT;
+	label_log(LABEL_ERROR,
+		  "no labeling backend is available for class %d\n",
+		  cls);
+
+out:
+	label_release_lock(label_lock);
+	return rec;
+}
+
+int label_lookup(struct label_rec *rec, const char *key,
+		 security_class_t cls, security_context_t *con)
+{
+	return rec->func_lookup(rec, key, cls, con);
+}
+
+void label_close(struct label_rec *rec)
+{
+	label_get_lock(label_lock);
+
+	if (!rec_list)
+		return; /* list of open handles is empty! */
+
+	if (rec_list == rec)
+		rec_list = rec->next;
+	else {
+		struct label_rec *ptr = rec_list;
+		while (ptr->next && ptr->next != rec)
+			ptr = ptr->next;
+		if (!ptr->next)
+			return; /* handle not in list of open handles! */
+		ptr->next = ptr->next->next;
+	}
+
+	rec->func_destroy(rec);
+	label_free(rec->name);
+	label_free(rec);
+	label_release_lock(label_lock);
+}
+
+void label_destroy(void)
+{
+	struct label_rec *rec = rec_list;
+
+	label_get_lock(label_lock);
+
+	while (rec) {
+		rec->func_destroy(rec);
+		rec = rec->next;
+		label_free(rec->name);
+		label_free(rec);
+	}
+
+	rec_list = NULL;
+	label_release_lock(label_lock);
+
+	label_free_lock(label_lock);
+	label_free_lock(label_log_lock);
+}
+
+void label_cache_stats(struct label_rec *rec)
+{
+	rec->func_cache_stats(rec);
+}
+
+void label_op_stats(struct label_rec *rec)
+{
+	rec->func_op_stats(rec);
+}
Index: libselinux/src/label_internal.c
===================================================================
--- libselinux/src/label_internal.c	(revision 0)
+++ libselinux/src/label_internal.c	(revision 0)
@@ -0,0 +1,58 @@
+/*
+ * Callbacks for user-supplied memory allocation, supplemental
+ * auditing, and locking routines.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+
+#include <sys/types.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <selinux/selinux.h>
+#include "label_internal.h"
+
+/* default callbacks */
+static void def_stub(void *arg __attribute__ ((unused)))
+{
+}
+
+static void *def_alloc_lock(void)
+{
+	return NULL;
+}
+
+static int __attribute__ ((format(printf, 2, 3)))
+def_log(int type __attribute__ ((unused)),
+		   const char *format, ...)
+{
+	int rc;
+	va_list ap;
+
+	va_start(ap, format);
+	rc = vfprintf(stderr, format, ap);
+	va_end(ap);
+
+	return rc;
+}
+
+static int def_validate(security_class_t cls __attribute__ ((unused)),
+			char **ctx)
+{
+	return security_check_context(*ctx);
+}
+
+/* callback pointers */
+void *(*label_func_malloc) (size_t) = malloc;
+void (*label_func_free) (void *) = free;
+
+int (*label_func_log) (int, const char *, ...)
+	__attribute__ ((format(printf, 2, 3))) = &def_log;
+
+int (*label_func_validate) (security_class_t cls, char **ctx) = &def_validate;
+
+void *(*label_func_alloc_lock) (void) = &def_alloc_lock;
+void (*label_func_get_lock) (void *) = &def_stub;
+void (*label_func_release_lock) (void *) = &def_stub;
+void (*label_func_free_lock) (void *) = &def_stub;
+

--=-Lm7N9w5bO3rfqEX+BH6+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
