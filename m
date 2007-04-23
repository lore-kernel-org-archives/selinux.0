Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUSWR001567
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:28 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIURJc002778
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:27 GMT
Message-Id: <20070423213727.185303000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:02 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 07/33] libsepol: user serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds serialize/unserialize methods for user records.

---
 libsepol/include/sepol/user_record.h |   10 +
 libsepol/src/user_internal.h         |    2 
 libsepol/src/user_record.c           |  178 +++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)

Index: selinux-pms-support/libsepol/include/sepol/user_record.h
===================================================================
--- selinux-pms-support.orig/libsepol/include/sepol/user_record.h
+++ selinux-pms-support/libsepol/include/sepol/user_record.h
@@ -1,6 +1,7 @@
 #ifndef _SEPOL_USER_RECORD_H_
 #define _SEPOL_USER_RECORD_H_
 
+#include <inttypes.h>
 #include <stddef.h>
 #include <sepol/handle.h>
 
@@ -73,4 +74,13 @@ extern int sepol_user_clone(sepol_handle
 
 extern void sepol_user_free(sepol_user_t * user);
 
+/* Serialize/Unserialize */
+extern int sepol_user_serialize(sepol_handle_t * handle,
+				const sepol_user_t * user,
+				char **data, uint64_t * size);
+
+extern int sepol_user_unserialize(sepol_handle_t * handle,
+				  char **data, uint64_t * size,
+				  sepol_user_t ** user);
+
 #endif
Index: selinux-pms-support/libsepol/src/user_internal.h
===================================================================
--- selinux-pms-support.orig/libsepol/src/user_internal.h
+++ selinux-pms-support/libsepol/src/user_internal.h
@@ -17,4 +17,6 @@ hidden_proto(sepol_user_add_role)
     hidden_proto(sepol_user_set_mlslevel)
     hidden_proto(sepol_user_set_mlsrange)
     hidden_proto(sepol_user_set_name)
+    hidden_proto(sepol_user_serialize)
+    hidden_proto(sepol_user_unserialize)
 #endif
Index: selinux-pms-support/libsepol/src/user_record.c
===================================================================
--- selinux-pms-support.orig/libsepol/src/user_record.c
+++ selinux-pms-support/libsepol/src/user_record.c
@@ -1,9 +1,11 @@
+#include <assert.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
 
 #include "user_internal.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct sepol_user {
 	/* This user's name */
@@ -377,3 +379,179 @@ void sepol_user_free(sepol_user_t * user
 }
 
 hidden_def(sepol_user_free)
+
+/* Serialize/Unserialize */
+/** Destructively modifies rec_data and size.
+ *  Caller must pre-allocate space for rec_data.
+ *  Use sepol_user_calculate_serialized_size(). */
+int sepol_user_serialize(sepol_handle_t * handle,
+			 const sepol_user_t * user,
+			 char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *name = NULL;
+	const char *mlslevel = NULL;
+	const char *mlsrange = NULL;
+	const char **roles_array = NULL;
+	unsigned int roles_array_size;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || user == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* User name. */
+	name = sepol_user_get_name(user);
+	status =
+	    sepol_serialize(handle, name, (name == NULL) ? 0 : strlen(name),
+			    SEPOL_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User mls level. */
+	mlslevel = sepol_user_get_mlslevel(user);
+	status =
+	    sepol_serialize(handle, mlslevel,
+			    (mlslevel == NULL) ? 0 : strlen(mlslevel),
+			    SEPOL_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User mls range. */
+	mlsrange = sepol_user_get_mlsrange(user);
+	status =
+	    sepol_serialize(handle, mlsrange,
+			    (mlsrange == NULL) ? 0 : strlen(mlsrange),
+			    SEPOL_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User roles. */
+	status =
+	    sepol_user_get_roles(handle, user, &roles_array, &roles_array_size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	status =
+	    sepol_serialize(handle, (void *)roles_array, roles_array_size,
+			    SEPOL_SERIAL_STRING_ARRAY, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(roles_array);
+	return status;
+}
+
+hidden_def(sepol_user_serialize)
+
+/** Destructively modifies user, rec_data and size.
+ *  Allocates space for user.
+ *  Caller must free. */
+int sepol_user_unserialize(sepol_handle_t * handle,
+				 char **data, uint64_t * size,
+			   sepol_user_t ** user)
+{
+	int status = STATUS_SUCCESS;
+	char *name = NULL;
+	size_t *name_size = NULL;
+	char *mlslevel = NULL;
+	size_t *mlslevel_size = NULL;
+	char *mlsrange = NULL;
+	size_t *mlsrange_size = NULL;
+	char **roles_array = NULL;
+	size_t *roles_array_size = NULL;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Allocate space. */
+	status = sepol_user_create(handle, user);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User name. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&name, &name_size, SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (name != NULL) {
+		status = sepol_user_set_name(handle, *user, name);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* User mls level. */
+	status =
+	    sepol_unserialize(handle,
+						data, size,
+					(void **)&mlslevel, &mlslevel_size,
+			      SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (mlslevel != NULL) {
+		status = sepol_user_set_mlslevel(handle, *user, mlslevel);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* User mls range. */
+	status =
+	    sepol_unserialize(handle,
+					data, size,
+					(void **)&mlsrange, &mlsrange_size, SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (mlsrange != NULL) {
+		status = sepol_user_set_mlsrange(handle, *user, mlsrange);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* User roles. */
+	status =
+		sepol_unserialize(handle,
+				data, size,
+				(void **)&roles_array, &roles_array_size, SEPOL_SERIAL_STRING_ARRAY);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (roles_array != NULL) {
+		status =
+			sepol_user_set_roles(handle, *user,
+					(const char **)roles_array,
+					*roles_array_size);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+cleanup:
+
+	if (roles_array != NULL) {
+		unsigned int i;
+		for (i = 0; i < *roles_array_size; i++) {
+			if (!roles_array[i])
+				break;
+			free(roles_array[i]);
+		}
+	}
+
+	free(name);
+	free(name_size);
+	free(mlslevel);
+	free(mlslevel_size);
+	free(mlsrange);
+	free(mlsrange_size);
+	free(roles_array);
+	free(roles_array_size);
+	return status;
+}
+
+hidden_def(sepol_user_unserialize)

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
