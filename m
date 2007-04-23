Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUi2U001755
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:44 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUhSG027880
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:43 GMT
Message-Id: <20070423213743.080113000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:18 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 23/33] libsemanage: commit number serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds support for un/serializing the database commit number.

---
 libsemanage/include/semanage/policy.h |   31 +++++++++++
 libsemanage/src/libsemanage.map       |    1 
 libsemanage/src/policy.c              |   91 ++++++++++++++++++++++++++++++++++
 libsemanage/src/policy.h              |    4 +
 4 files changed, 127 insertions(+)

Index: selinux-pms-support/libsemanage/include/semanage/policy.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/include/semanage/policy.h
@@ -0,0 +1,31 @@
+/* Authors: Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_POLICY_H_
+#define _SEMANAGE_POLICY_H_
+
+#include <semanage/handle.h>
+#include <inttypes.h>
+
+int semanage_policy_table_serialize_serial(semanage_handle_t *handle, char **data, uint64_t *size);
+
+int semanage_policy_table_unserialize_serial(semanage_handle_t *handle,
+		char **data, uint64_t *size);
+
+#endif
Index: selinux-pms-support/libsemanage/src/libsemanage.map
===================================================================
--- selinux-pms-support.orig/libsemanage/src/libsemanage.map
+++ selinux-pms-support/libsemanage/src/libsemanage.map
@@ -16,5 +16,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
 	  semanage_*_serialize; semanage_*_unserialize;
 	  semanage_is_connected;
+	  semanage_policy_table_serialize_serial;
   local: *;
 };
Index: selinux-pms-support/libsemanage/src/policy.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/policy.c
@@ -0,0 +1,91 @@
+/* Author: Caleb Case <ccase@tresys.com>
+ *         Ryan Haggerty <rhaggerty@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <stdlib.h>
+#include "debug.h"
+#include "policy.h"
+#include "serialize.h"
+
+/* Serialize the serial number into data and store the size of it in size.
+ * Returns status.
+ */
+int semanage_policy_table_serialize_serial(semanage_handle_t *handle, char **data, uint64_t *size)
+{
+	int status = STATUS_SUCCESS;
+	int serial = handle->funcs->get_serial(handle);
+	char* ptr = NULL;
+
+	/* sanity checks */
+	if (data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* calculate size */
+	status = semanage_serialize(handle, &serial, 0, SEMANAGE_SERIAL_INT32_T, NULL, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Allocate memory. */
+	ptr = *data = calloc(*size, sizeof(char));
+	if (*data == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Serialize */
+	status = semanage_serialize(handle, &serial, 0, SEMANAGE_SERIAL_INT32_T, &ptr, NULL);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+cleanup:
+	return status;
+}
+
+hidden_def(semanage_policy_table_serialize_serial)
+
+/* Unserialize the serial number from data.
+ * Function will move data pointer.
+ * Returns status if status is not equal to STATUS_SUCCESS or returns serial number.
+ */
+int semanage_policy_table_unserialize_serial(semanage_handle_t *handle,
+		char **data, uint64_t *size)
+{
+	int status = STATUS_SUCCESS;
+	int *serial = NULL;
+	int ret_serial = -1; /* assume we did not get a good serial number */
+
+	/* Sundry sanity checks. */
+	if (data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	status = semanage_unserialize(handle, data, size, (void **)&serial, 0, SEMANAGE_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	ret_serial = *serial; /* capture value so we can free */
+cleanup:
+	free(serial);
+	return status == STATUS_SUCCESS ? ret_serial : status;
+}
+
+hidden_def(semanage_policy_table_unserialize_serial)
Index: selinux-pms-support/libsemanage/src/policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/policy.h
+++ selinux-pms-support/libsemanage/src/policy.h
@@ -22,6 +22,7 @@
 #ifndef _SEMANAGE_POLICY_INTERNAL_H_
 #define _SEMANAGE_POLICY_INTERNAL_H_
 
+#include <semanage/policy.h>
 #include "modules.h"
 
 /* Circular dependency */
@@ -68,4 +69,7 @@ extern int semanage_base_merge_component
 
 extern int semanage_commit_components(struct semanage_handle *handle);
 
+hidden_proto(semanage_policy_table_serialize_serial)
+hidden_proto(semanage_policy_table_unserialize_serial)
+
 #endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
