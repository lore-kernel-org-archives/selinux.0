Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUPhx001534
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:25 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUOSG027801
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:25 GMT
Message-Id: <20070423213724.222753000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:34:59 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 04/33] libsepol: interface serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds serialize/unserialize methods for iface records.

---
 libsepol/include/sepol/iface_record.h |   10 ++
 libsepol/src/iface_internal.h         |    2 
 libsepol/src/iface_record.c           |  115 ++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)

Index: selinux-pms-support/libsepol/include/sepol/iface_record.h
===================================================================
--- selinux-pms-support.orig/libsepol/include/sepol/iface_record.h
+++ selinux-pms-support/libsepol/include/sepol/iface_record.h
@@ -1,6 +1,7 @@
 #ifndef _SEPOL_IFACE_RECORD_H_
 #define _SEPOL_IFACE_RECORD_H_
 
+#include <inttypes.h>
 #include <sepol/handle.h>
 #include <sepol/context_record.h>
 
@@ -56,4 +57,13 @@ extern int sepol_iface_clone(sepol_handl
 
 extern void sepol_iface_free(sepol_iface_t * iface);
 
+/* Serialize/Unserialize */
+extern int sepol_iface_serialize(sepol_handle_t * handle,
+				 const sepol_iface_t * iface,
+				 char **data, uint64_t * size);
+
+extern int sepol_iface_unserialize(sepol_handle_t * handle,
+				   char **data, uint64_t * size,
+				   sepol_iface_t ** iface);
+
 #endif
Index: selinux-pms-support/libsepol/src/iface_internal.h
===================================================================
--- selinux-pms-support.orig/libsepol/src/iface_internal.h
+++ selinux-pms-support/libsepol/src/iface_internal.h
@@ -15,4 +15,6 @@ hidden_proto(sepol_iface_create)
     hidden_proto(sepol_iface_set_ifcon)
     hidden_proto(sepol_iface_set_msgcon)
     hidden_proto(sepol_iface_set_name)
+    hidden_proto(sepol_iface_serialize)
+    hidden_proto(sepol_iface_unserialize)
 #endif
Index: selinux-pms-support/libsepol/src/iface_record.c
===================================================================
--- selinux-pms-support.orig/libsepol/src/iface_record.c
+++ selinux-pms-support/libsepol/src/iface_record.c
@@ -1,9 +1,11 @@
+#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 
 #include "iface_internal.h"
 #include "context_internal.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct sepol_iface {
 
@@ -231,3 +233,116 @@ void sepol_iface_free(sepol_iface_t * if
 }
 
 hidden_def(sepol_iface_free)
+
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use sepol_iface_calculate_serialized_size(). */
+int sepol_iface_serialize(sepol_handle_t * handle,
+			  const sepol_iface_t * iface,
+			  char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *name = NULL;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || iface == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Iface name. */
+	name = sepol_iface_get_name(iface);
+	status =
+	    sepol_serialize(handle, name, (name == NULL) ? 0 : strlen(name),
+			    SEPOL_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Interface context. */
+	status =
+	    sepol_context_serialize(handle, sepol_iface_get_ifcon(iface), data,
+				    size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Message context. */
+	status =
+	    sepol_context_serialize(handle, sepol_iface_get_msgcon(iface), data,
+				    size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	return status;
+}
+
+hidden_def(sepol_iface_serialize)
+
+/** Destructively modifies iface, data and size.
+ *  Allocates space for iface.
+ *  Caller must free. */
+int sepol_iface_unserialize(sepol_handle_t * handle,
+			    char **data, uint64_t * size,
+			    sepol_iface_t ** iface)
+{
+	int status = STATUS_SUCCESS;
+	char *name = NULL;
+	size_t *name_size = NULL;
+	sepol_context_t *ifcon = NULL;
+	sepol_context_t *msgcon = NULL;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Allocate space. */
+	status = sepol_iface_create(handle, iface);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Iface name. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&name, &name_size, SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (name != NULL) {
+		/* Note that sepol_*_set* calls typically create space. */
+		status = sepol_iface_set_name(handle, *iface, name);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Interface context. */
+	status = sepol_context_unserialize(handle, data, size, &ifcon);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	/* Note that sepol_*_set* calls typically create space. */
+	status = sepol_iface_set_ifcon(handle, *iface, ifcon);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Message context. */
+	status = sepol_context_unserialize(handle, data, size, &msgcon);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	/* Note that sepol_*_set* calls typically create space. */
+	status = sepol_iface_set_msgcon(handle, *iface, msgcon);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(name);
+	free(name_size);
+	sepol_context_free(ifcon);
+	sepol_context_free(msgcon);
+	return status;
+}
+
+hidden_def(sepol_iface_unserialize)

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
