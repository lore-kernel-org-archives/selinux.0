Message-ID: <466DA23C.9080509@tycho.nsa.gov>
Date: Mon, 11 Jun 2007 15:27:56 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH 1/3] libselinux: labeling support (try 3)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The first two tries of this patchset were late last year.  This is
a labeling API that provides a common way to map from various string
namespaces into security contexts.

This version of the patchset simplifies the lookup model down to
(string,number) to context.  There are no void pointers or variadic
functions which was one of the objections to the previous patchsets.
A lot of the file contexts stuff such as the inode tracking support
has also been dropped with the understanding that this stuff should
be in the setfiles code, not libselinux.  This is a pure lookup
interface only.

This patchset includes two backends, for file contexts and media
contexts.  Future work would include libsemanage interfaces for
managing the data the way the file contexts data is currently done.

This patch includes the interface and generic handle code.  Tested
with some sample input values, worked OK.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/label.h |  108 +++++++++++++++++++++++++++++++++++++
 src/label.c             |  140 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/label_internal.h    |   49 ++++++++++++++++
 3 files changed, 297 insertions(+)


Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 0)
+++ libselinux/include/selinux/label.h	(revision 0)
@@ -0,0 +1,108 @@
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
+typedef struct selabel_rec *selabel_handle_t;
+
+/* 
+ * Available backends.
+ */
+
+/* file contexts */
+#define SELABEL_CTX_FILE	0
+/* media contexts */
+#define SELABEL_CTX_MEDIA	1
+
+/*
+ * Available options
+ */
+
+/* validate contexts before returning them (boolean value) */
+#define SELABEL_OPT_VALIDATE	1
+/* don't use local customizations to backend data (boolean value) */
+#define SELABEL_OPT_BASEONLY	2
+/* specify an alternate path to use when loading backend data */
+#define SELABEL_OPT_PATH	3
+/* specify a filename prefix to focus the search operation (file contexts) */
+#define SELABEL_OPT_PREFIX	4
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
+selabel_handle_t selabel_open(unsigned int backend, struct selabel_opt *opts,
+			      size_t nopts);
+
+/**
+ * selabel_close - Close a labeling handle.
+ * @handle: specifies handle to close
+ *
+ * Destroy the specified handle, closing files, freeing allocated memory,
+ * etc.  The handle may not be further used after it has been closed.
+ */
+void selabel_close(selabel_handle_t handle);
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
+int selabel_lookup(selabel_handle_t handle, security_context_t *con,
+		   const char *key, int type);
+int selabel_lookup_raw(selabel_handle_t handle, security_context_t *con,
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
+void selabel_stats(selabel_handle_t handle);
+
+#ifdef __cplusplus
+}
+#endif
+#endif	/* _SELABEL_H_ */
Index: libselinux/src/label_internal.h
===================================================================
--- libselinux/src/label_internal.h	(revision 0)
+++ libselinux/src/label_internal.h	(revision 0)
@@ -0,0 +1,49 @@
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
+int selabel_file_init(struct selabel_rec *rec, struct selabel_opt *opts,
+		      size_t nopts) hidden;
+int selabel_media_init(struct selabel_rec *rec, struct selabel_opt *opts,
+		      size_t nopts) hidden;
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
+struct selabel_rec {
+	/* arguments that were passed to selabel_open */
+	unsigned int backend;
+	int validating;
+
+	/* labeling operations */
+	struct selabel_lookup_rec *(*func_lookup) (struct selabel_rec *h,
+						   const char *key, int type);
+	void (*func_close) (struct selabel_rec *h);
+	void (*func_stats) (struct selabel_rec *h);
+
+	/* supports backend-specific state information */
+	void *data;
+};
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
+typedef int (*selabel_initfunc)(struct selabel_rec *rec,
+				struct selabel_opt *opts, size_t nopts);
+
+static selabel_initfunc initfuncs[] = {
+	&selabel_file_init,
+	&selabel_media_init,
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
+static int selabel_validate(struct selabel_rec *rec,
+			    struct selabel_lookup_rec *contexts)
+{
+	int rc = 0;
+
+	if (!rec->validating || contexts->validated)
+		goto out;
+
+	rc = selinux_validate(&contexts->ctx_raw);
+	if (rc < 0) {
+		selinux_log(SELINUX_ERROR, "invalid context %s\n",
+			    contexts->ctx_raw);
+		goto out;
+	}
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
+selabel_handle_t selabel_open(unsigned int backend, struct selabel_opt *opts,
+			      size_t nopts)
+{
+	struct selabel_rec *rec = NULL;
+
+	if (backend >= ARRAY_SIZE(initfuncs)) {
+		errno = EINVAL;
+		goto out;
+	}
+
+	rec = (struct selabel_rec *)malloc(sizeof(*rec));
+	if (!rec)
+		goto out;
+
+	memset(rec, 0, sizeof(*rec));
+	rec->backend = backend;
+	rec->validating = selabel_is_validate_set(opts, nopts);
+
+	if ((*initfuncs[backend])(rec, opts, nopts))
+		free(rec);
+
+out:
+	return rec;
+}
+
+static struct selabel_lookup_rec *
+selabel_lookup_common(struct selabel_rec *rec, int translating,
+		      const char *key, int type)
+{
+	struct selabel_lookup_rec *lr = rec->func_lookup(rec, key, type);
+	if (!lr)
+		return NULL;
+
+	if (selabel_validate(rec, lr))
+		return NULL;
+
+	if (translating &&
+	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
+		return NULL;
+
+	return lr;
+}
+
+int selabel_lookup(struct selabel_rec *rec, security_context_t *con,
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
+int selabel_lookup_raw(struct selabel_rec *rec, security_context_t *con,
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
+void selabel_close(struct selabel_rec *rec)
+{
+	rec->func_close(rec);
+	free(rec);
+}
+
+void selabel_stats(struct selabel_rec *rec)
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
