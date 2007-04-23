Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUOT5001503
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:24 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUMSG027788
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:23 GMT
Message-Id: <20070423213722.080079000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:34:57 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/33] libsepol: boolean serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds serialize/unserialize methods for boolean records.

---
 libsepol/include/sepol/boolean_record.h |   10 +++
 libsepol/src/boolean_internal.h         |    2 
 libsepol/src/boolean_record.c           |   96 ++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

Index: selinux-pms-support/libsepol/include/sepol/boolean_record.h
===================================================================
--- selinux-pms-support.orig/libsepol/include/sepol/boolean_record.h
+++ selinux-pms-support/libsepol/include/sepol/boolean_record.h
@@ -1,6 +1,7 @@
 #ifndef _SEPOL_BOOLEAN_RECORD_H_
 #define _SEPOL_BOOLEAN_RECORD_H_
 
+#include <inttypes.h>
 #include <stddef.h>
 #include <sepol/handle.h>
 
@@ -48,4 +49,13 @@ extern int sepol_bool_clone(sepol_handle
 
 extern void sepol_bool_free(sepol_bool_t * boolean);
 
+/* Serialize/Unserialize */
+extern int sepol_bool_serialize(sepol_handle_t * handle,
+				const sepol_bool_t * boolean,
+				char **data, uint64_t * size);
+
+extern int sepol_bool_unserialize(sepol_handle_t * handle,
+				  char **data, uint64_t * size,
+				  sepol_bool_t ** boolean);
+
 #endif
Index: selinux-pms-support/libsepol/src/boolean_internal.h
===================================================================
--- selinux-pms-support.orig/libsepol/src/boolean_internal.h
+++ selinux-pms-support/libsepol/src/boolean_internal.h
@@ -13,4 +13,6 @@ hidden_proto(sepol_bool_key_create)
     hidden_proto(sepol_bool_set_value)
     hidden_proto(sepol_bool_create)
     hidden_proto(sepol_bool_free)
+    hidden_proto(sepol_bool_serialize)
+    hidden_proto(sepol_bool_unserialize)
 #endif
Index: selinux-pms-support/libsepol/src/boolean_record.c
===================================================================
--- selinux-pms-support.orig/libsepol/src/boolean_record.c
+++ selinux-pms-support/libsepol/src/boolean_record.c
@@ -1,9 +1,11 @@
+#include <assert.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
 
 #include "boolean_internal.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct sepol_bool {
 	/* This boolean's name */
@@ -178,3 +180,97 @@ void sepol_bool_free(sepol_bool_t * bool
 }
 
 hidden_def(sepol_bool_free)
+
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use sepol_bool_calculate_serialized_size(). */
+int sepol_bool_serialize(sepol_handle_t * handle,
+			 const sepol_bool_t * boolean,
+			 char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *name = NULL;
+	int value;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || boolean == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Boolean name. */
+	name = sepol_bool_get_name(boolean);
+	status =
+	    sepol_serialize(handle, name, (name == NULL) ? 0 : strlen(name),
+			    SEPOL_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Value of boolean. */
+	value = sepol_bool_get_value(boolean);
+	status = sepol_serialize(handle, &value, 0, SEPOL_SERIAL_INT32_T, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	return status;
+}
+
+hidden_def(sepol_bool_serialize)
+
+/** Destructively modifies boolean, data and size.
+ *  Allocates space for boolean.
+ *  Caller must free. */
+int sepol_bool_unserialize(sepol_handle_t * handle,
+			   char **data, uint64_t * size,
+			   sepol_bool_t ** boolean)
+{
+	int status = STATUS_SUCCESS;
+	char *name = NULL;
+	size_t *name_size = NULL;
+	int *value = NULL;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Allocate space. */
+	status = sepol_bool_create(handle, boolean);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Boolean name. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&name, &name_size, SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (name != NULL) {
+		status = sepol_bool_set_name(handle, *boolean, name);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Value of boolean. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&value, NULL, SEPOL_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	sepol_bool_set_value(*boolean, *value);
+
+	/* Cleanup. */
+      cleanup:
+	free(name);
+	free(name_size);
+	free(value);
+	return status;
+}
+
+hidden_def(sepol_bool_unserialize)

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
