Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIURKu001550
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:27 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUPSG027804
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:26 GMT
Message-Id: <20070423213725.202604000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:00 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 05/33] libsepol: node serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds serialize/unserialize methods for node records.

---
 libsepol/include/sepol/node_record.h |   10 ++
 libsepol/src/node_internal.h         |    2 
 libsepol/src/node_record.c           |  155 +++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

Index: selinux-pms-support/libsepol/include/sepol/node_record.h
===================================================================
--- selinux-pms-support.orig/libsepol/include/sepol/node_record.h
+++ selinux-pms-support/libsepol/include/sepol/node_record.h
@@ -1,6 +1,7 @@
 #ifndef _SEPOL_NODE_RECORD_H_
 #define _SEPOL_NODE_RECORD_H_
 
+#include <inttypes.h>
 #include <stddef.h>
 #include <sepol/context_record.h>
 #include <sepol/handle.h>
@@ -89,4 +90,13 @@ extern int sepol_node_clone(sepol_handle
 
 extern void sepol_node_free(sepol_node_t * node);
 
+/* Serialize/Unserialize */
+extern int sepol_node_serialize(sepol_handle_t * handle,
+				const sepol_node_t * node,
+				char **data, uint64_t * size);
+
+extern int sepol_node_unserialize(sepol_handle_t * handle,
+				  char **data, uint64_t * size,
+				  sepol_node_t ** node);
+
 #endif
Index: selinux-pms-support/libsepol/src/node_internal.h
===================================================================
--- selinux-pms-support.orig/libsepol/src/node_internal.h
+++ selinux-pms-support/libsepol/src/node_internal.h
@@ -23,4 +23,6 @@ hidden_proto(sepol_node_create)
     hidden_proto(sepol_node_set_mask)
     hidden_proto(sepol_node_set_mask_bytes)
     hidden_proto(sepol_node_set_proto)
+    hidden_proto(sepol_node_serialize)
+    hidden_proto(sepol_node_unserialize)
 #endif
Index: selinux-pms-support/libsepol/src/node_record.c
===================================================================
--- selinux-pms-support.orig/libsepol/src/node_record.c
+++ selinux-pms-support/libsepol/src/node_record.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include <stdlib.h>
 #include <stddef.h>
 #include <string.h>
@@ -8,6 +9,7 @@
 #include "node_internal.h"
 #include "context_internal.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct sepol_node {
 
@@ -666,3 +668,156 @@ int sepol_node_set_con(sepol_handle_t * 
 }
 
 hidden_def(sepol_node_set_con)
+
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use sepol_node_calculate_serialized_size(). */
+int sepol_node_serialize(sepol_handle_t * handle,
+			 const sepol_node_t * node,
+			 char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	char *addr = NULL;
+	char *mask = NULL;
+	int proto;
+
+	/* Sundry sanity checks. */
+	if (handle == NULL || node == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Node address. */
+	/* Note that these getters allocate space. */
+	status = sepol_node_get_addr(handle, node, &addr);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	status =
+	    sepol_serialize(handle, addr, (addr == NULL) ? 0 : strlen(addr),
+			    SEPOL_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Node mask. */
+	/* Note that these getters allocate space. */
+	status = sepol_node_get_mask(handle, node, &mask);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	status =
+	    sepol_serialize(handle, mask, (mask == NULL) ? 0 : strlen(mask),
+			    SEPOL_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Node protocol. */
+	proto = sepol_node_get_proto(node);
+	status = sepol_serialize(handle, &proto, 0, SEPOL_SERIAL_INT32_T, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Node context. */
+	status =
+	    sepol_context_serialize(handle, sepol_node_get_con(node), data,
+				    size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(addr);
+	free(mask);
+	return status;
+}
+
+hidden_def(sepol_node_serialize)
+
+/** Destructively modifies node, data and size.
+ *  Allocates space for node.
+ *  Caller must free. */
+int sepol_node_unserialize(sepol_handle_t * handle,
+				 char **data, uint64_t * size,
+			   sepol_node_t ** node)
+{
+	int status = STATUS_SUCCESS;
+	char *addr = NULL;
+	size_t *addr_size = NULL;
+	char *mask = NULL;
+	size_t *mask_size = NULL;
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
+	status = sepol_node_create(handle, node);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Node address. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&addr, &addr_size, SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	/* Waiting for protocol before setting. */
+
+	/* Node mask size. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&mask, &mask_size, SEPOL_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	/* Waiting for protocol before setting. */
+
+	/* Node protocol. */
+	status =
+	    sepol_unserialize(handle,
+			      data, size,
+					(void **)&proto, NULL, SEPOL_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	sepol_node_set_proto(*node, *proto);
+
+	/* Setting address and mask now that we know the protocol. */
+	if (addr != NULL) {
+		/* Note that sepol_*_set* calls typically create space. */
+		status = sepol_node_set_addr(handle, *node, *proto, addr);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	if (mask != NULL) {
+		/* Note that sepol_*_set* calls typically create space. */
+		status = sepol_node_set_mask(handle, *node, *proto, mask);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Node context. */
+	status = sepol_context_unserialize(handle, data, size, &con);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	/* Note that sepol_*_set* calls typically create space. */
+	status = sepol_node_set_con(handle, *node, con);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(addr);
+	free(addr_size);
+	free(mask);
+	free(mask_size);
+	free(proto);
+	sepol_context_free(con);
+	return status;
+}
+
+hidden_def(sepol_node_unserialize)

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
