Subject: [PATCH 1/5] libselinux: labeling API basic front-end interface
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
In-Reply-To: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-hSPpoO5817QSzJCuckDx"
Date: Wed, 15 Nov 2006 21:46:10 -0500
Message-Id: <1163645170.15225.66.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-hSPpoO5817QSzJCuckDx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the basic front-end interface.  Note that backends may supply
additional values and flags, which will be seen with the file_contexts
backend.

---
 include/selinux/label.h         |  181 ++++++++++++++++++++++++
 include/selinux/label_backend.h |   20 ++
 2 files changed, 201 insertions(+)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-hSPpoO5817QSzJCuckDx
Content-Description: 
Content-Disposition: inline; filename=label1.patch
Content-Type: text/x-patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: include/selinux/label.h
===================================================================
--- include/selinux/label.h	(revision 0)
+++ include/selinux/label.h	(revision 0)
@@ -0,0 +1,181 @@
+/*
+ * Labeling interface for userspace object managers and others.
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+#ifndef _SELINUX_LABEL_H_
+#define _SELINUX_LABEL_H_
+
+#include <sys/types.h>
+#include <selinux/selinux.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * User-provided callbacks for memory, logging, locking, and extra actions
+ */
+
+/* These structures are passed by reference to label_init().  Passing
+ * a NULL reference will cause a default to be used.  The default
+ * memory callbacks are malloc() and free().  The default logging method
+ * is to print on stderr.  The default validation callback is based on
+ * selinux_check_context().  If no locking callbacks are passed, no locking
+ * will take place.
+ */
+	struct label_memory_callback {
+		/* malloc() equivalent. */
+		void *(*func_malloc) (size_t size);
+		/* free() equivalent. */
+		void (*func_free) (void *ptr);
+		/* Note that these functions should set errno on failure.
+		   If not, some routines may return -1 without errno set. */
+	};
+
+	struct label_log_callback {
+		/* log the printf-style format and arguments,
+		   with the type code indicating the type of message */
+		int (*func_log) (int type, const char *fmt, ...);
+	};
+
+	struct label_action_callback {
+		/* validate the supplied context, making changes if necessary,
+		   returning 0 if valid or -1 with errno set otherwise. */
+		int (*func_validate) (security_class_t cls, char **context);
+	};
+
+	struct label_lock_callback {
+		/* create a lock and return an opaque pointer to it. */
+		void *(*func_alloc_lock) (void);
+		/* obtain a given lock, blocking if necessary. */
+		void (*func_get_lock) (void *lock);
+		/* release a given lock. */
+		void (*func_release_lock) (void *lock);
+		/* destroy a given lock (free memory, etc.) */
+		void (*func_free_lock) (void *lock);
+	};
+
+/* Logging type codes, passed to the logging callback */
+#define LABEL_ERROR		0
+#define LABEL_WARNING		1
+#define LABEL_INFO		2
+#define LABEL_INVALIDCON	3
+
+/*
+ * Label operations
+ */
+
+/**
+ * label_init - Initialize the labeling system.
+ * @prefix: used by the backend for selecting a configuration or package
+ * @mem_callbacks: user-supplied memory callbacks
+ * @log_callbacks: user-supplied logging callbacks
+ * @action_callbacks: user-supplied validation callbacks
+ * @lock_callbacks: user-supplied locking callbacks
+ *
+ * Initialize the labeling subsystem.  Return %0 on success or -%1 with @errno
+ * set on failure.  Argument @name must not be NULL or empty.  If any callback 
+ * structure references are NULL, use default methods for those callbacks (see
+ * the definition of the callback structures above).
+ */
+	int label_init(const char *prefix,
+		       const struct label_memory_callback *mem_callbacks,
+		       const struct label_log_callback *log_callbacks,
+		       const struct label_action_callback *action_callbacks,
+		       const struct label_lock_callback *lock_callbacks);
+
+/**
+ * label_change_name - Change system prefix
+ * @prefix: used by the backend for selecting a configuration or package
+ *
+ * Change the prefix string used by the labeling system on future calls.  This
+ * function may be called multiple times.  Backend configurations are kept
+ * separately by prefix, meaning that after a call to this function, calls to
+ * label_configure() may be necessary to re-initialize backends.  However, 
+ * switching back to a prefix will preserve any configuration made previously
+ * while that prefix was in effect.
+ */
+	void label_change_name(const char *prefix);
+
+/**
+ * label_configure - Configure specific labeling backend.
+ * @cls: specifies the backend to configure
+ * @flags: global and/or backend-specific configuration flags
+ * @arg: additional backend-specific configuration data
+ *
+ * Configure a specific labeling backend.  This function should be called
+ * after a successful call to label_init and is optional; it will be called
+ * automatically with default arguments by label_lookup if necessary.  The
+ * result of the call depends on the specific flags and the backend, although
+ * typically the backend will reset its internal state.  Return %0 on success
+ * or -%1 with @errno set on failure.  
+ */
+	int label_configure(security_class_t cls,
+			    int flags,
+			    void *arg);
+
+/* Global flags available for use on all backends.  Note that the first 16
+ * bits are reserved for this purpose, while the next 16 are for backend flags.
+ */
+#define LABEL_BASEONLY		1 /* Don't use local configuration overrides */
+#define LABEL_TRANS		2 /* Translate contexts */
+#define LABEL_VALIDATE		4 /* Validate/canonicalize contexts */ 
+
+/**
+ * label_reset - Configure specific labeling backend using the defaults.
+ * @cls: specifies the backend to configure
+ *
+ * Configure a specific labeling backend.  Equivalent to calling 
+ * label_configure with a flags argument of %0 and an arg of NULL.
+ * Return %0 on success or -%1 with @errno set on failure.
+ */
+	int label_reset(security_class_t cls);
+
+/**
+ * label_destroy - Free all labeling structures.
+ *
+ * Destroy all labeling structures, close all backends, and free all allocated
+ * memory.  User-supplied callbacks will be retained, but any backend 
+ * configuration will not.  User must call label_init() if further use
+ * of labeling subsystem is desired.
+ */
+	void label_destroy(void);
+
+/**
+ * label_lookup - Perform labeling lookup operation.
+ * @key: backend-specific string representation of object being labeled
+ * @cls: class of object being labeled; along with prefix, selects backend
+ * @con: returns the appropriate context with which to label the object
+ *
+ * Perform a labeling lookup operation.  Return %0 on success, -%1 with
+ * @errno set on failure.  Some backends may return additional, positive
+ * values indicating qualified success.
+ */
+	int label_lookup(const char *key, security_class_t cls,
+			 security_context_t * con);
+
+/**
+ * label_cache_stats - log caching or other internal memory usage statistics.
+ * @cls: selects backend to query
+ *
+ * Log a message with information about internal caching, memory usage,
+ * table efficiency, or other such statistics.  Message is backend-specific,
+ * some backends may not output a message.  Intended for debugging purposes.
+ */
+	void label_cache_stats(security_class_t cls);
+
+/**
+ * label_op_stats - log labeling operation statistics.
+ * @cls: selects backend to query
+ *
+ * Log a message with information about the number of queries performed,
+ * number of unused matching entries, or other operational statistics.
+ * Message is backend-specific, some backends may not output a message.
+ */
+	void label_op_stats(security_class_t cls);
+
+#ifdef __cplusplus
+}
+#endif
+#endif				/* _SELINUX_LABEL_H_ */
Index: include/selinux/label_backend.h
===================================================================
--- include/selinux/label_backend.h	(revision 0)
+++ include/selinux/label_backend.h	(revision 0)
@@ -0,0 +1,20 @@
+/*
+ * Labeling interface for userspace object managers and others.
+ * Backend-specific things are kept here.
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+#ifndef _SELINUX_LABEL_BACKEND_H_
+#define _SELINUX_LABEL_BACKEND_H_
+
+/*
+ * Generic labeling backend
+ */
+/* coming soon */
+
+/*
+ * File contexts backend
+ */
+/* coming soon */
+
+#endif				/* _SELINUX_LABEL_BACKEND_H_ */

--=-hSPpoO5817QSzJCuckDx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
