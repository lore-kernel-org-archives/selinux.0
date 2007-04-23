Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUPAj001522
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:25 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUNJc002745
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:23 GMT
Message-Id: <20070423213723.109922000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:34:58 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 03/33] libsepol: context serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds serialize/unserialize methods for context records.

---
 libsepol/include/sepol/context_record.h |   10 +++
 libsepol/src/context_internal.h         |    2 
 libsepol/src/context_record.c           |   84 ++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

Index: selinux-pms-support/libsepol/include/sepol/context_record.h
===================================================================
--- selinux-pms-support.orig/libsepol/include/sepol/context_record.h
+++ selinux-pms-support/libsepol/include/sepol/context_record.h
@@ -1,6 +1,7 @@
 #ifndef _SEPOL_CONTEXT_RECORD_H_
 #define _SEPOL_CONTEXT_RECORD_H_
 
+#include <inttypes.h>
 #include <sepol/handle.h>
 
 struct sepol_context;
@@ -43,6 +44,15 @@ extern int sepol_context_clone(sepol_han
 
 extern void sepol_context_free(sepol_context_t * con);
 
+/* Serialize/Unserialize */
+extern int sepol_context_serialize(sepol_handle_t * handle,
+				   const sepol_context_t * context,
+				   char **data, uint64_t * size);
+
+extern int sepol_context_unserialize(sepol_handle_t * handle,
+				     char **data, uint64_t * size,
+				     sepol_context_t ** context);
+
 /* Parse to/from string */
 extern int sepol_context_from_string(sepol_handle_t * handle,
 				     const char *str, sepol_context_t ** con);
Index: selinux-pms-support/libsepol/src/context_internal.h
===================================================================
--- selinux-pms-support.orig/libsepol/src/context_internal.h
+++ selinux-pms-support/libsepol/src/context_internal.h
@@ -16,4 +16,6 @@ hidden_proto(sepol_context_clone)
     hidden_proto(sepol_context_set_role)
     hidden_proto(sepol_context_set_type)
     hidden_proto(sepol_context_set_user)
+    hidden_proto(sepol_context_serialize)
+    hidden_proto(sepol_context_unserialize)
 #endif
Index: selinux-pms-support/libsepol/src/context_record.c
===================================================================
--- selinux-pms-support.orig/libsepol/src/context_record.c
+++ selinux-pms-support/libsepol/src/context_record.c
@@ -1,9 +1,11 @@
+#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
 
 #include "context_internal.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct sepol_context {
 
@@ -198,6 +200,88 @@ void sepol_context_free(sepol_context_t 
 
 hidden_def(sepol_context_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use sepol_context_calculate_serialized_size(). */
+int sepol_context_serialize(sepol_handle_t * handle,
+			    const sepol_context_t * context,
+			    char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	char *context_string = NULL;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || context == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Context. */
+	status = sepol_context_to_string(handle, context, &context_string);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	status =
+	    sepol_serialize(handle, context_string,
+			    (context_string ==
+			     NULL) ? 0 : strlen(context_string), SEPOL_SERIAL_STRING,
+			    data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(context_string);
+	return status;
+}
+
+hidden_def(sepol_context_serialize)
+
+/** Destructively modifies context, data and size.
+ *  Allocates space for context.
+ *  Caller must free. */
+int sepol_context_unserialize(sepol_handle_t * handle,
+			      char **data, uint64_t * size,
+			      sepol_context_t ** context)
+{
+	int status = STATUS_SUCCESS;
+	char *context_string = NULL;
+	size_t *context_string_size = NULL;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Context. */
+	status =
+	    sepol_unserialize(handle,
+					data, size,
+					(void **)&context_string, &context_string_size, SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (context_string != NULL) {
+		status =
+		    sepol_context_from_string(handle, context_string, context);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	} else {
+		status = sepol_context_create(handle, context);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+      cleanup:
+	free(context_string);
+	free(context_string_size);
+	return status;
+}
+
+hidden_def(sepol_context_unserialize)
+
 int sepol_context_from_string(sepol_handle_t * handle,
 			      const char *str, sepol_context_t ** con)
 {

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
