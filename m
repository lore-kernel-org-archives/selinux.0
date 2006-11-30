Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU45UDZ012118
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:05:30 -0500
Received: from facesaver.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAU43lbM019629
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 04:03:47 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU40Osd014724
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:00:24 -0500
Subject: [PATCH 1/5] libselinux: labeling API basic front-end interface
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
In-Reply-To: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-cdjFMp0EBDZ4z9x5E9DX"
Date: Wed, 29 Nov 2006 23:05:29 -0500
Message-Id: <1164859529.2794.201.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cdjFMp0EBDZ4z9x5E9DX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the basic front-end interface.  I will shortly post some
examples of how it would be used, including a patch for setfiles.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---
 libselinux/include/selinux/label.h         |  165 +++++++++++++
 libselinux/include/selinux/label_backend.h |   20 +
 2 files changed, 185 insertions(+)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-cdjFMp0EBDZ4z9x5E9DX
Content-Description: 
Content-Disposition: inline; filename=label1.patch
Content-Type: text/x-patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 0)
+++ libselinux/include/selinux/label.h	(revision 0)
@@ -0,0 +1,165 @@
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
+ * @mem_callbacks: user-supplied memory callbacks
+ * @log_callbacks: user-supplied logging callbacks
+ * @action_callbacks: user-supplied validation callbacks
+ * @lock_callbacks: user-supplied locking callbacks
+ *
+ * Initialize the labeling subsystem.  Return %0 on success or -%1 with @errno
+ * set on failure.  If any callback structure references are NULL, use default
+ * methods for those callbacks (see the definition of the callback structures
+ * above).
+ */
+	int label_init(const struct label_memory_callback *mem_callbacks,
+		       const struct label_log_callback *log_callbacks,
+		       const struct label_action_callback *action_callbacks,
+		       const struct label_lock_callback *lock_callbacks);
+
+/**
+ * label_open - Create a labeling handle.
+ * @name: used by the backend for selecting a configuration or package
+ * @cls: specifies the backend to open
+ * @flags: global and/or backend-specific configuration flags
+ * @arg: additional backend-specific configuration data if not NULL
+ *
+ * Open a labeling backend for use.  The backend is identified by the specified
+ * object class in conjunction with the name argument, which is typically used
+ * to select a certain data source or subset, such as a specific package.
+ * Return value is the created handle on success or NULL with @errno set on
+ * failure.  See the backend documentation for additional flags and arg value.
+ */
+	typedef struct label_rec *label_handle_t;
+	label_handle_t label_open(const char *name, security_class_t cls,
+				  int flags, void *arg);
+
+/* Global flags available for use on all backends.  Note that the first 16
+ * bits are reserved for this purpose, while the next 16 are for backend flags.
+ */
+#define LABEL_BASEONLY		1 /* Don't use local configuration overrides */
+#define LABEL_TRANS		2 /* Translate contexts */
+#define LABEL_VALIDATE		4 /* Validate/canonicalize contexts */ 
+
+/**
+ * label_close - Close a labeling handle.
+ * @handle: specifies handle to close
+ *
+ * Destroy the specified handle, closing files, freeing allocated memory,
+ * etc.  The handle may not be further used after it has been closed.
+ */
+	void label_close(label_handle_t handle);
+
+/**
+ * label_destroy - Close all handles and shut down labeling subsystem.
+ *
+ * Destroy all labeling structures, close all backends, and free all allocated
+ * memory.  Any open handles will be destroyed and may not be further used.
+ * User must call label_init() if further use of labeling subsystem is desired.
+ */
+	void label_destroy(void);
+
+/**
+ * label_lookup - Perform labeling lookup operation.
+ * @handle: specifies backend instance to query
+ * @key: backend-specific string representation of object being labeled
+ * @cls: class of object being labeled; along with prefix, selects backend
+ * @con: returns the appropriate context with which to label the object
+ *
+ * Perform a labeling lookup operation.  Return %0 on success, -%1 with
+ * @errno set on failure.  Some backends may return additional, positive
+ * values indicating qualified success.
+ */
+	int label_lookup(label_handle_t handle, const char *key,
+			 security_class_t cls, security_context_t *con);
+
+/**
+ * label_cache_stats - log caching or other internal memory usage statistics.
+ * @handle: specifies backend instance to query
+ *
+ * Log a message with information about internal caching, memory usage,
+ * table efficiency, or other such statistics.  Message is backend-specific,
+ * some backends may not output a message.  Intended for debugging purposes.
+ */
+	void label_cache_stats(label_handle_t handle);
+
+/**
+ * label_op_stats - log labeling operation statistics.
+ * @handle: specifies backend instance to query
+ *
+ * Log a message with information about the number of queries performed,
+ * number of unused matching entries, or other operational statistics.
+ * Message is backend-specific, some backends may not output a message.
+ */
+	void label_op_stats(label_handle_t handle);
+
+#ifdef __cplusplus
+}
+#endif
+#endif				/* _SELINUX_LABEL_H_ */
Index: libselinux/include/selinux/label_backend.h
===================================================================
--- libselinux/include/selinux/label_backend.h	(revision 0)
+++ libselinux/include/selinux/label_backend.h	(revision 0)
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
+/* no include file for this backend */
+
+/*
+ * File contexts backend (includes media contexts)
+ */
+#include <selinux/label_backend_file.h>
+
+#endif				/* _SELINUX_LABEL_BACKEND_H_ */

--=-cdjFMp0EBDZ4z9x5E9DX--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
