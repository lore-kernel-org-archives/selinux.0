Message-ID: <46732239.2070704@tycho.nsa.gov>
Date: Fri, 15 Jun 2007 19:35:21 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [PATCH 2/7] libselinux: labeling support (try 4)
References: <467320D6.5040703@tycho.nsa.gov>
In-Reply-To: <467320D6.5040703@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch includes the interface and generic handle code.  Tested
with some sample input values, worked OK.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/label.h |  124 ++++++++++++++++++++++++++++++++++++++++++
 src/label.c             |  140 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/label_internal.h    |   74 +++++++++++++++++++++++++
 3 files changed, 338 insertions(+)


Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 0)
+++ libselinux/include/selinux/label.h	(revision 0)
@@ -0,0 +1,124 @@
+/*
+ * Labeling interface for userspace object managers and others.
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+#ifndef _SELABEL_H_
+#define _SELABEL_H_
+
+#include <sys/types.h>
+#include <selinux/selinux.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Opaque type used for all label handles.
+ */
+
+struct selabel_handle;
+
+/* 
+ * Available backends.
+ */
+
+/* file contexts */
+#define SELABEL_CTX_FILE	0
+/* media contexts */
+#define SELABEL_CTX_MEDIA	1
+/* x contexts */
+#define SELABEL_CTX_X		2
+
+/*
+ * Available options
+ */
+
+/* no-op option, useful for unused slots in an array of options */
+#define SELABEL_OPT_UNUSED	0
+/* validate contexts before returning them (boolean value) */
+#define SELABEL_OPT_VALIDATE	1
+/* don't use local customizations to backend data (boolean value) */
+#define SELABEL_OPT_BASEONLY	2
+/* specify an alternate path to use when loading backend data */
+#define SELABEL_OPT_PATH	3
+/* select a subset of the search space as an optimization (file backend) */
+#define SELABEL_OPT_SUBSET	4
+/* total number of options */
+#define SELABEL_NOPT		6
+
+struct selabel_opt {
+	int type;
+	const char *value;
+};
+
+/*
+ * Label operations
+ */
+
+/**
+ * selabel_open - Create a labeling handle.
+ * @backend: one of the constants specifying a supported labeling backend.
+ * @opts: array of selabel_opt structures specifying label options or NULL.
+ * @nopts: number of elements in opts array or zero for no options.
+ *
+ * Open a labeling backend for use.  The available backend identifiers are
+ * listed above.  Options may be provided via the opts parameter; available
+ * options are listed above.  Not all options may be supported by every
+ * backend.  Return value is the created handle on success or NULL with
+ * @errno set on failure.
+ */
+struct selabel_handle *selabel_open(unsigned int backend,
+				    struct selabel_opt *opts, size_t nopts);
+
+/**
+ * selabel_close - Close a labeling handle.
+ * @handle: specifies handle to close
+ *
+ * Destroy the specified handle, closing files, freeing allocated memory,
+ * etc.  The handle may not be further used after it has been closed.
+ */
+void selabel_close(struct selabel_handle *handle);
+
+/**
+ * selabel_lookup - Perform labeling lookup operation.
+ * @handle: specifies backend instance to query
+ * @con: returns the appropriate context with which to label the object
+ * @key: string input to lookup operation
+ * @type: numeric input to the lookup operation
+ *
+ * Perform a labeling lookup operation.  Return %0 on success, -%1 with
+ * @errno set on failure.  The key and type arguments are the inputs to the
+ * lookup operation; appropriate values are dictated by the backend in use.
+ * The result is returned in the memory pointed to by @con and must be freed
+ * by the user with freecon().
+ */
+int selabel_lookup(struct selabel_handle *handle, security_context_t *con,
+		   const char *key, int type);
+int selabel_lookup_raw(struct selabel_handle *handle, security_context_t *con,
+		       const char *key, int type);
+
+/**
+ * selabel_stats - log labeling operation statistics.
+ * @handle: specifies backend instance to query
+ *
+ * Log a message with information about the number of queries performed,
+ * number of unused matching entries, or other operational statistics.
+ * Message is backend-specific, some backends may not output a message.
+ */
+void selabel_stats(struct selabel_handle *handle);
+
+/*
+ * Type codes used by specific backends
+ */
+
+/* X backend */
+#define SELABEL_X_PROP		1
+#define SELABEL_X_EXT		2
+#define SELABEL_X_CLIENT	3
+
+
+#ifdef __cplusplus
+}
+#endif
+#endif	/* _SELABEL_H_ */
Index: libselinux/src/label_internal.h
===================================================================
--- libselinux/src/label_internal.h	(revision 0)
+++ libselinux/src/label_internal.h	(revision 0)
@@ -0,0 +1,74 @@
+/*
+ * This file describes the internal interface used by the labeler
+ * for calling the user-supplied memory allocation, validation,
+ * and locking routine.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+#ifndef _SELABEL_INTERNAL_H_
+#define _SELABEL_INTERNAL_H_
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#include "dso.h"
+
+/*
+ * Installed backends
+ */
+int selabel_file_init(struct selabel_handle *rec, struct selabel_opt *opts,
+		      size_t nopts) hidden;
+int selabel_media_init(struct selabel_handle *rec, struct selabel_opt *opts,
+		      size_t nopts) hidden;
+int selabel_x_init(struct selabel_handle *rec, struct selabel_opt *opts,
+		   size_t nopts) hidden;
+
+/*
+ * Labeling internal structures
+ */
+struct selabel_lookup_rec {
+	security_context_t ctx_raw;
+	security_context_t ctx_trans;
+	int validated;
+};
+
+struct selabel_handle {
+	/* arguments that were passed to selabel_open */
+	unsigned int backend;
+	int validating;
+
+	/* labeling operations */
+	struct selabel_lookup_rec *(*func_lookup) (struct selabel_handle *h,
+						   const char *key, int type);
+	void (*func_close) (struct selabel_handle *h);
+	void (*func_stats) (struct selabel_handle *h);
+
+	/* supports backend-specific state information */
+	void *data;
+};
+
+/*
+ * Validation function
+ */
+extern int
+selabel_validate(struct selabel_handle *rec,
+		 struct selabel_lookup_rec *contexts) hidden;
+
+/*
+ * Compatibility support
+ */
+extern void __attribute__ ((format(printf, 1, 2)))
+(*myprintf) (const char *fmt,...);
+
+#define COMPAT_LOG(type, fmt...) if (myprintf)		  \
+		myprintf(fmt);				  \
+	else						  \
+		selinux_log(type, fmt);
+
+extern int
+compat_validate(struct selabel_handle *rec,
+		struct selabel_lookup_rec *contexts,
+		const char *path, unsigned lineno) hidden;
+
+#endif				/* _SELABEL_INTERNAL_H_ */
Index: libselinux/src/label.c
===================================================================
--- libselinux/src/label.c	(revision 0)
+++ libselinux/src/label.c	(revision 0)
@@ -0,0 +1,140 @@
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
+#include "callbacks.h"
+#include "label_internal.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef int (*selabel_initfunc)(struct selabel_handle *rec,
+				struct selabel_opt *opts, size_t nopts);
+
+static selabel_initfunc initfuncs[] = {
+	&selabel_file_init,
+	&selabel_media_init,
+	&selabel_x_init
+};
+
+/*
+ * Validation functions
+ */
+
+static inline int selabel_is_validate_set(struct selabel_opt *opts, size_t n)
+{
+	while (n--)
+		if (opts[n].type == SELABEL_OPT_VALIDATE)
+			return !!opts[n].value;
+
+	return 0;
+}
+
+int selabel_validate(struct selabel_handle *rec,
+		     struct selabel_lookup_rec *contexts)
+{
+	int rc = 0;
+
+	if (!rec->validating || contexts->validated)
+		goto out;
+
+	rc = selinux_validate(&contexts->ctx_raw);
+	if (rc < 0)
+		goto out;
+
+	contexts->validated = 1;
+out:
+	return rc;
+}
+
+/*
+ * Public API
+ */
+
+struct selabel_handle *selabel_open(unsigned int backend,
+				    struct selabel_opt *opts, size_t nopts)
+{
+	struct selabel_handle *rec = NULL;
+
+	if (backend >= ARRAY_SIZE(initfuncs)) {
+		errno = EINVAL;
+		goto out;
+	}
+
+	rec = (struct selabel_handle *)malloc(sizeof(*rec));
+	if (!rec)
+		goto out;
+
+	memset(rec, 0, sizeof(*rec));
+	rec->backend = backend;
+	rec->validating = selabel_is_validate_set(opts, nopts);
+
+	if ((*initfuncs[backend])(rec, opts, nopts)) {
+		free(rec);
+		rec = NULL;
+	}
+
+out:
+	return rec;
+}
+
+static struct selabel_lookup_rec *
+selabel_lookup_common(struct selabel_handle *rec, int translating,
+		      const char *key, int type)
+{
+	struct selabel_lookup_rec *lr = rec->func_lookup(rec, key, type);
+	if (!lr)
+		return NULL;
+
+	if (compat_validate(rec, lr, "file_contexts", 0))
+		return NULL;
+
+	if (translating &&
+	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
+		return NULL;
+
+	return lr;
+}
+
+int selabel_lookup(struct selabel_handle *rec, security_context_t *con,
+		   const char *key, int type)
+{
+	struct selabel_lookup_rec *lr;
+
+	lr = selabel_lookup_common(rec, 1, key, type);
+	if (!lr)
+		return -1;
+
+	*con = strdup(lr->ctx_trans);
+	return *con ? 0 : -1;
+}
+
+int selabel_lookup_raw(struct selabel_handle *rec, security_context_t *con,
+		       const char *key, int type)
+{
+	struct selabel_lookup_rec *lr;
+
+	lr = selabel_lookup_common(rec, 0, key, type);
+	if (!lr)
+		return -1;
+
+	*con = strdup(lr->ctx_raw);
+	return *con ? 0 : -1;
+}
+
+void selabel_close(struct selabel_handle *rec)
+{
+	rec->func_close(rec);
+	free(rec);
+}
+
+void selabel_stats(struct selabel_handle *rec)
+{
+	rec->func_stats(rec);
+}


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
