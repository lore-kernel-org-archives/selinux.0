Message-ID: <47052A68.6030300@tycho.nsa.gov>
Date: Thu, 04 Oct 2007 14:01:12 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/3] libselinux: minor updates to AVC, mapping, callbacks
References: <47041CB6.8070408@tycho.nsa.gov>
In-Reply-To: <47041CB6.8070408@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces a replacement for avc_init(), avc_open().
The purpose of this is to move away from the callbacks specified
to avc_init() and instead set callbacks with selinux_set_callback(),
as well as to use the same option mechanism as selabel_open().

Also updated the old avc_init callbacks to call the new ones if they
are set.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/avc.h |   11 +++++++++++
 src/avc.c             |    6 ++++++
 src/avc_internal.h    |    5 ++++-
 3 files changed, 21 insertions(+), 1 deletion(-)


Index: libselinux/include/selinux/avc.h
===================================================================
--- libselinux/include/selinux/avc.h	(revision 2628)
+++ libselinux/include/selinux/avc.h	(working copy)
@@ -182,6 +182,17 @@
 	     const struct avc_lock_callback *lock_callbacks);
 
 /**
+ * avc_open - Initialize the AVC.
+ * @opts: array of selabel_opt structures specifying AVC options or NULL.
+ * @nopts: number of elements in opts array or zero for no options.
+ *
+ * This function is identical to avc_init(), except the message prefix
+ * is set to "avc" and any callbacks desired should be specified via
+ * selinux_set_callback().  No options are currently supported.
+ */
+int avc_open(struct selinux_opt *opts, unsigned nopts);
+
+/**
  * avc_cleanup - Remove unused SIDs and AVC entries.
  *
  * Search the SID table for SID structures with zero
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2628)
+++ libselinux/src/avc.c	(working copy)
@@ -157,6 +157,12 @@
 	return rc;
 }
 
+int avc_open(struct selinux_opt *opts __attribute__((unused)),
+	     unsigned nopts __attribute__((unused)))
+{
+    return avc_init("avc", NULL, NULL, NULL, NULL);
+}
+
 int avc_init(const char *prefix,
 	     const struct avc_memory_callback *mem_cb,
 	     const struct avc_log_callback *log_cb,
Index: libselinux/src/avc_internal.h
===================================================================
--- libselinux/src/avc_internal.h	(revision 2628)
+++ libselinux/src/avc_internal.h	(working copy)
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <selinux/avc.h>
+#include "callbacks.h"
 #include "dso.h"
 
 /* SID reference counter manipulation */
@@ -93,13 +94,15 @@
   if (avc_func_log) \
     avc_func_log(format); \
   else \
-    fprintf(stderr, format)
+    selinux_log(SELINUX_ERROR, format);
 
 static inline void avc_suppl_audit(void *ptr, security_class_t class,
 				   char *buf, size_t len)
 {
 	if (avc_func_audit)
 		avc_func_audit(ptr, class, buf, len);
+	else
+		selinux_audit(ptr, class, buf, len);
 }
 
 static inline void *avc_create_thread(void (*run) (void))


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
