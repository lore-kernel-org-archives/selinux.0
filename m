Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUSRX001564
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:28 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIURSG027815
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:27 GMT
Message-Id: <20070423213726.158459000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:01 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 06/33] libsepol: port serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds serialize/unserialize methods for port records.

---
 libsepol/include/sepol/port_record.h |   10 ++
 libsepol/src/port_internal.h         |    2 
 libsepol/src/port_record.c           |  125 +++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

Index: selinux-pms-support/libsepol/include/sepol/port_record.h
===================================================================
--- selinux-pms-support.orig/libsepol/include/sepol/port_record.h
+++ selinux-pms-support/libsepol/include/sepol/port_record.h
@@ -1,6 +1,7 @@
 #ifndef _SEPOL_PORT_RECORD_H_
 #define _SEPOL_PORT_RECORD_H_
 
+#include <inttypes.h>
 #include <sepol/context_record.h>
 #include <sepol/handle.h>
 
@@ -63,4 +64,13 @@ extern int sepol_port_clone(sepol_handle
 
 extern void sepol_port_free(sepol_port_t * port);
 
+/* Serialize/Unserialize */
+extern int sepol_port_serialize(sepol_handle_t * handle,
+				const sepol_port_t * port,
+				char **data, uint64_t * size);
+
+extern int sepol_port_unserialize(sepol_handle_t * handle,
+				  char **data, uint64_t * size,
+				  sepol_port_t ** port);
+
 #endif
Index: selinux-pms-support/libsepol/src/port_internal.h
===================================================================
--- selinux-pms-support.orig/libsepol/src/port_internal.h
+++ selinux-pms-support/libsepol/src/port_internal.h
@@ -17,4 +17,6 @@ hidden_proto(sepol_port_create)
     hidden_proto(sepol_port_set_con)
     hidden_proto(sepol_port_set_proto)
     hidden_proto(sepol_port_set_range)
+    hidden_proto(sepol_port_serialize)
+    hidden_proto(sepol_port_unserialize)
 #endif
Index: selinux-pms-support/libsepol/src/port_record.c
===================================================================
--- selinux-pms-support.orig/libsepol/src/port_record.c
+++ selinux-pms-support/libsepol/src/port_record.c
@@ -1,9 +1,11 @@
+#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 
 #include "port_internal.h"
 #include "context_internal.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct sepol_port {
 	/* Low - High range. Same for single ports. */
@@ -286,3 +288,126 @@ int sepol_port_set_con(sepol_handle_t * 
 }
 
 hidden_def(sepol_port_set_con)
+
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use sepol_port_calculate_serialized_size(). */
+int sepol_port_serialize(sepol_handle_t * handle,
+			 const sepol_port_t * port,
+			 char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	int low;
+	int high;
+	int proto;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || port == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Port low. */
+	low = sepol_port_get_low(port);
+	status = sepol_serialize(handle, &low, 0, SEPOL_SERIAL_INT32_T, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Port high. */
+	high = sepol_port_get_high(port);
+	status = sepol_serialize(handle, &high, 0, SEPOL_SERIAL_INT32_T, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Port protocol. */
+	proto = sepol_port_get_proto(port);
+	status = sepol_serialize(handle, &proto, 0, SEPOL_SERIAL_INT32_T, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Port context. */
+	status =
+	    sepol_context_serialize(handle, sepol_port_get_con(port), data,
+				    size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	return status;
+}
+
+hidden_def(sepol_port_serialize)
+
+/** Destructively modifies port, data and size.
+ *  Allocates space for port.
+ *  Caller must free. */
+int sepol_port_unserialize(sepol_handle_t * handle,
+				 char **data, uint64_t * size,
+			   sepol_port_t ** port)
+{
+	int status = STATUS_SUCCESS;
+	int *low = NULL;
+	int *high = NULL;
+	int *proto = NULL;
+	sepol_context_t *con = NULL;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Allocate space. */
+	status = sepol_port_create(handle, port);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Port low. */
+	status =
+	    sepol_unserialize(handle,
+					data,
+			      size,
+					(void **)&low, NULL, SEPOL_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	/* Note that there is no set_low/set_high only set_range (used below) */
+
+	/* Port high. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&high, NULL, SEPOL_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	sepol_port_set_range(*port, *low, *high);
+
+	/* Port protocol. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&proto, NULL, SEPOL_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	sepol_port_set_proto(*port, *proto);
+
+	/* Port context. */
+	status = sepol_context_unserialize(handle, data, size, &con);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	/* Note that sepol_*_set* calls typically create space. */
+	status = sepol_port_set_con(handle, *port, con);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(low);
+	free(high);
+	free(proto);
+	sepol_context_free(con);
+	return status;
+}
+
+hidden_def(sepol_port_unserialize)

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
