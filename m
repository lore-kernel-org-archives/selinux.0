Subject: [PATCH 2/5] libselinux: labeling API basic front-end implementation
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
In-Reply-To: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-aaG2SepfayEdEI1k4xOg"
Date: Wed, 15 Nov 2006 21:51:12 -0500
Message-Id: <1163645472.15225.70.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aaG2SepfayEdEI1k4xOg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the front-end implementation.

---
 src/label.c          |  233 +++++++++++++++++++++++++++++++++++
 src/label_internal.c |   25 +++
 src/label_internal.h |  128 +++++++++++++++++++
 3 files changed, 386 insertions(+)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-aaG2SepfayEdEI1k4xOg
Content-Description: 
Content-Disposition: inline; filename=label2.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: src/label_internal.h
===================================================================
--- src/label_internal.h	(revision 0)
+++ src/label_internal.h	(revision 0)
@@ -0,0 +1,128 @@
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
+struct label_ops {
+	int (*func_configure) (struct label_ops *h, int flags, void *arg);
+	void (*func_destroy) (struct label_ops *h);
+	int (*func_lookup) (struct label_ops *h,
+			    const char *key, security_context_t *ctx);
+	void (*func_cache_stats) (struct label_ops *h);
+	void (*func_op_stats) (struct label_ops *h);
+
+	void *data;
+};
+
+struct label_backend {
+	security_class_t cls;
+	int (*func_init) (security_class_t cls, const char *prefix,
+			  struct label_ops *ops);
+};
+
+/* installed backends */
+int backend_file_init(security_class_t cls, const char *name,
+		      struct label_ops *ops) hidden;
+
+int backend_simple_init(security_class_t cls, const char *name,
+			struct label_ops *ops) hidden;
+
+/* callback pointers */
+extern void *(*label_func_malloc) (size_t) hidden;
+extern void (*label_func_free) (void *) hidden;
+
+extern int (*label_func_log) (int type, const char *, ...) hidden;
+
+extern int (*label_func_validate) (security_class_t cls, char **ctx) hidden;
+
+extern void *(*label_func_alloc_lock) (void) hidden;
+extern void (*label_func_get_lock) (void *) hidden;
+extern void (*label_func_release_lock) (void *) hidden;
+extern void (*label_func_free_lock) (void *) hidden;
+
+static inline void set_callbacks(const struct label_memory_callback *mem_cb,
+				 const struct label_log_callback *log_cb,
+				 const struct label_action_callback *action_cb,
+				 const struct label_lock_callback *lock_cb)
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
+}
+
+/* prefix size */
+#define LABEL_PREFIX_SIZE 128
+
+/* user-supplied callback interface for avc */
+static inline void *label_malloc(size_t size)
+{
+	return label_func_malloc ? label_func_malloc(size) : malloc(size);
+}
+
+static inline void label_free(void *ptr)
+{
+	if (label_func_free)
+		label_func_free(ptr);
+	else
+		free(ptr);
+}
+
+/* this is a macro in order to use the variadic capability. */
+#define label_log(type, format...)				\
+	(label_func_log ? label_func_log(type, format) :	\
+	 fprintf(stderr, format))
+
+static inline int label_validate(security_class_t cls, char **ctx)
+{
+	return label_func_validate ? 
+		label_func_validate(cls, ctx) : security_check_context(*ctx);
+}
+
+static inline void *label_alloc_lock(void)
+{
+	return label_func_alloc_lock ? label_func_alloc_lock() : NULL;
+}
+
+static inline void label_get_lock(void *lock)
+{
+	if (label_func_get_lock)
+		label_func_get_lock(lock);
+}
+
+static inline void label_release_lock(void *lock)
+{
+	if (label_func_release_lock)
+		label_func_release_lock(lock);
+}
+
+static inline void label_free_lock(void *lock)
+{
+	if (label_func_free_lock)
+		label_func_free_lock(lock);
+}
+
+#endif				/* _SELINUX_LABEL_INTERNAL_H_ */
Index: src/label.c
===================================================================
--- src/label.c	(revision 0)
+++ src/label.c	(revision 0)
@@ -0,0 +1,233 @@
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
+struct label_backend_rec {
+	security_class_t cls;
+	char name[LABEL_PREFIX_SIZE];
+	int configured;
+	struct label_ops ops;
+	struct label_backend_rec *next;
+};
+
+static char label_prefix[LABEL_PREFIX_SIZE] = "";
+static struct label_backend_rec *open_backends = NULL;
+static struct label_backend_rec *last_backend = NULL;
+static void *label_lock = NULL;
+static void *label_log_lock = NULL;
+
+struct label_backend backends[] = {
+	{SECCLASS_XEXTENSION, &backend_simple_init}
+};
+
+static int open_backend(struct label_backend *backend)
+{
+	int rc = 0;
+	struct label_backend_rec *rec;
+
+	rec = (struct label_backend_rec *)label_malloc(sizeof(*rec));
+	if (!rec) {
+		rc = -1;
+		goto out;
+	}
+
+	memset(rec, 0, sizeof(*rec));
+	rc = backend->func_init(backend->cls, label_prefix, &rec->ops);
+	if (rc) {
+		label_log(LABEL_ERROR,
+			  "failed to open labeling backend for class %d\n",
+			  backend->cls);
+		label_free(rec);
+		goto out;
+	}
+
+	rec->cls = backend->cls;
+	strncpy(rec->name, label_prefix, LABEL_PREFIX_SIZE - 1);
+	rec->next = open_backends;
+	open_backends = last_backend = rec;
+out:
+	return rc;
+}
+
+static inline int match_backend(struct label_backend_rec *rec,
+				security_class_t cls)
+{
+	return (rec->cls == cls) && 
+		!strncmp(rec->name, label_prefix, LABEL_PREFIX_SIZE);
+}
+
+static int get_backend(security_class_t cls, struct label_backend_rec **rec)
+{
+	int rc = 0;
+	unsigned int i;
+
+	label_get_lock(label_lock);
+
+	if (last_backend && match_backend(last_backend, cls)) {
+		*rec = last_backend;
+		goto out;
+	}
+
+	last_backend = open_backends;
+	while (last_backend) {
+		if (match_backend(last_backend, cls)) {
+			*rec = last_backend;
+			goto out;
+		}
+		last_backend = last_backend->next;
+	}
+
+	/* need to open backend at this point */
+	for (i = 0; i < ARRAY_SIZE(backends); i++)
+		if (backends[i].cls == cls) {
+			rc = open_backend(backends+i);
+			if (!rc)
+				*rec = last_backend;
+			goto out;
+		}
+
+	/* backend not supported! this is highly irregular */
+	rc = -1;
+	errno = ENOENT;
+	label_log(LABEL_ERROR,
+		  "no labeling backend is available for class %d\n",
+		  cls);
+out:
+	label_release_lock(label_lock);
+	return rc;
+}
+
+int label_init(const char *prefix,
+	       const struct label_memory_callback *mem_cb,
+	       const struct label_log_callback *log_cb,
+	       const struct label_action_callback *action_cb,
+	       const struct label_lock_callback *lock_cb)
+{
+	int rc = 0;
+
+	if (prefix == NULL || prefix[0] == '\0') {
+		errno = EINVAL;
+		rc = -1;
+		goto out;
+	}
+	strncpy(label_prefix, prefix, LABEL_PREFIX_SIZE - 1);
+
+	set_callbacks(mem_cb, log_cb, action_cb, lock_cb);
+
+	label_lock = label_alloc_lock();
+	label_log_lock = label_alloc_lock();
+out:
+	return rc;
+}
+
+void label_change_name(const char *prefix)
+{
+	if (prefix == NULL || prefix[0] == '\0')
+		return;
+
+	label_get_lock(label_lock);
+
+	memset(label_prefix, 0, LABEL_PREFIX_SIZE);
+	strncpy(label_prefix, prefix, LABEL_PREFIX_SIZE - 1);
+
+	label_release_lock(label_lock);
+}
+
+int label_configure(security_class_t cls, int flags, void *arg)
+{
+	struct label_backend_rec *rec;
+	int rc = 0;
+
+	rc = get_backend(cls, &rec);
+	if (rc)
+		goto out;
+
+	rc = rec->ops.func_configure(&rec->ops, flags, arg);
+	if (!rc)
+		rec->configured = 1;
+
+out:
+	return rc;
+}
+
+int label_reset(security_class_t cls)
+{
+	return label_configure(cls, 0, NULL);
+}
+
+int label_lookup(const char *key, security_class_t cls,
+		  security_context_t *con)
+{
+	struct label_backend_rec *rec;
+	int rc = 0;
+
+	rc = get_backend(cls, &rec);
+	if (rc)
+		goto out;
+
+	if (!rec->configured) {
+		rc = rec->ops.func_configure(&rec->ops, 0, NULL);
+		if (rc)
+			goto out;
+		else
+			rec->configured = 1;
+	}
+
+	rc = rec->ops.func_lookup(&rec->ops, key, con);
+out:
+	return rc;
+}
+
+void label_destroy(void)
+{
+	struct label_backend_rec *be = open_backends;
+
+	label_get_lock(label_lock);
+
+	while (be) {
+		last_backend = be;
+		be->ops.func_destroy(&be->ops);
+		be = be->next;
+		label_free(last_backend);
+	}
+
+	open_backends = last_backend = NULL;
+	memset(label_prefix, 0, LABEL_PREFIX_SIZE);
+	label_release_lock(label_lock);
+
+	label_free_lock(label_lock);
+	label_free_lock(label_log_lock);
+}
+
+void label_cache_stats(security_class_t cls)
+{
+	struct label_backend_rec *rec;
+
+	if (get_backend(cls, &rec))
+		return;
+
+	rec->ops.func_cache_stats(&rec->ops);
+}
+
+void label_op_stats(security_class_t cls)
+{
+	struct label_backend_rec *rec;
+
+	if (get_backend(cls, &rec))
+		return;
+
+	rec->ops.func_op_stats(&rec->ops);
+}
Index: src/label_internal.c
===================================================================
--- src/label_internal.c	(revision 0)
+++ src/label_internal.c	(revision 0)
@@ -0,0 +1,25 @@
+/*
+ * Callbacks for user-supplied memory allocation, supplemental
+ * auditing, and locking routines.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+
+#include <sys/types.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+#include "label_internal.h"
+
+/* callback pointers */
+void *(*label_func_malloc) (size_t) = NULL;
+void (*label_func_free) (void *) = NULL;
+
+int (*label_func_log) (int, const char *, ...) = NULL;
+
+int (*label_func_validate) (security_class_t cls, char **ctx) = NULL;
+
+void *(*label_func_alloc_lock) (void) = NULL;
+void (*label_func_get_lock) (void *) = NULL;
+void (*label_func_release_lock) (void *) = NULL;
+void (*label_func_free_lock) (void *) = NULL;
+

--=-aaG2SepfayEdEI1k4xOg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
