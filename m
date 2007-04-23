Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUY7N001638
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:34 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUWSG027830
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:33 GMT
Message-Id: <20070423213731.972575000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:07 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 12/33] libsemanage: basic serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the serialization infrastructure for libsemanage.

---
 libsemanage/include/semanage/handle.h |   17 +
 libsemanage/src/handle.c              |   28 ++
 libsemanage/src/handle_internal.h     |    5 
 libsemanage/src/libsemanage.map       |    1 
 libsemanage/src/serialize.c           |  389 ++++++++++++++++++++++++++++++++++
 libsemanage/src/serialize.h           |   45 +++
 6 files changed, 485 insertions(+)

Index: selinux-pms-support/libsemanage/include/semanage/handle.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/handle.h
+++ selinux-pms-support/libsemanage/include/semanage/handle.h
@@ -21,6 +21,11 @@
 #ifndef _SEMANAGE_HANDLE_H_
 #define _SEMANAGE_HANDLE_H_
 
+#define SEMANAGE_SERIAL_VERSION_MAJOR 1
+#define SEMANAGE_SERIAL_VERSION_MINOR 0
+
+#include <inttypes.h>
+
 /* All accesses with semanage are through a "semanage_handle".  The
  * handle may ultimately reference local config files,
  * the binary policy file, a module store, or a policy management server. 
@@ -38,6 +43,18 @@ semanage_handle_t *semanage_handle_creat
  * previously called if the handle was connected. */
 void semanage_handle_destroy(semanage_handle_t *);
 
+/* Get the serialization version. */
+int semanage_handle_get_version(semanage_handle_t *sh, uint32_t * major, uint32_t * minor);
+
+/* Set the serialization version. */
+int semanage_handle_set_version(semanage_handle_t *sh, uint32_t major, uint32_t minor);
+
+/* Serialize the serialization version. */
+int semanage_handle_version_serialize(semanage_handle_t *sh, char **data, uint64_t *size);
+
+/* Unserialize the serialization version. */
+int semanage_handle_version_unserialize(semanage_handle_t *sh, char **data, uint64_t *size);
+
 /* This is the type of connection to the store, for now only
  * direct is supported */
 enum semanage_connect_type {
Index: selinux-pms-support/libsemanage/src/handle.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/handle.c
+++ selinux-pms-support/libsemanage/src/handle.c
@@ -82,6 +82,34 @@ semanage_handle_t *semanage_handle_creat
 	return NULL;
 }
 
+int semanage_handle_get_version(semanage_handle_t *sh, uint32_t * major, uint32_t * minor)
+{
+	return sepol_handle_get_version(sh->sepolh, major, minor);
+}
+
+hidden_def(semanage_handle_get_version)
+
+int semanage_handle_set_version(semanage_handle_t *sh, uint32_t major, uint32_t minor)
+{
+	return sepol_handle_set_version(sh->sepolh, major, minor);
+}
+
+hidden_def(semanage_handle_set_version)
+
+int semanage_handle_version_serialize(semanage_handle_t *sh, char **data, uint64_t *size)
+{
+	return sepol_handle_version_serialize(sh->sepolh, data, size);
+}
+
+hidden_def(semanage_handle_version_serialize)
+
+int semanage_handle_version_unserialize(semanage_handle_t *sh, char **data, uint64_t *size)
+{
+	return sepol_handle_version_unserialize(sh->sepolh, data, size);
+}
+
+hidden_def(semanage_handle_version_unserialize)
+
 void semanage_set_rebuild(semanage_handle_t * sh, int do_rebuild)
 {
 
Index: selinux-pms-support/libsemanage/src/handle_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/handle_internal.h
+++ selinux-pms-support/libsemanage/src/handle_internal.h
@@ -8,4 +8,9 @@ hidden_proto(semanage_begin_transaction)
     hidden_proto(semanage_handle_destroy)
     hidden_proto(semanage_reload_policy)
     hidden_proto(semanage_access_check)
+hidden_proto(semanage_handle_get_version)
+hidden_proto(semanage_handle_set_version)
+hidden_proto(semanage_handle_version_serialize)
+hidden_proto(semanage_handle_version_unserialize)
+
 #endif
Index: selinux-pms-support/libsemanage/src/libsemanage.map
===================================================================
--- selinux-pms-support.orig/libsemanage/src/libsemanage.map
+++ selinux-pms-support/libsemanage/src/libsemanage.map
@@ -13,6 +13,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
+	  semanage_*_serialize; semanage_*_unserialize;
 	  semanage_is_connected;
   local: *;
 };
Index: selinux-pms-support/libsemanage/src/serialize.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/serialize.c
@@ -0,0 +1,389 @@
+/* Author: Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C) 2004-2007 Tresys Technology, LLC
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
+#include <string.h>
+#include <limits.h>
+
+#include "handle.h"
+#include "debug.h"
+#include "serialize.h"
+#include "byteswap.h"
+
+/* This file provides general serialize and unserialize functions. */
+
+/** Serializes various kinds of datum.
+ *
+ *  Two use cases:
+ *  1) Calling serialize with a non-NULL size.
+ *     This causes serialize to calculate the expected
+ *     size of serializing.  No serialization occurs.
+ *     Destructively modifies size.  Data may be NULL.
+ *  2) Calling serialize with a NULL size.
+ *     This results in data being filled with the
+ *     serialized information.  Caller must pre-allocate
+ *     space for data.  Destructively modifies data.
+ *
+ *  This function acts iteratively moving the *data or size values.
+ *
+ *  Supported datum_types (defined in serialize.h):
+ *
+ *  SEMANAGE_SERIAL_INT32_T
+ *    Serializes datum to a int32_t as defined in inttypes.h
+ *    datum may NOT be NULL.
+ *    datum_length is not utilized.
+ *  SEMANAGE_SERIAL_UINT32_T
+ *    Serializes datum to a uint32_t as defined in inttypes.h
+ *    datum may NOT be NULL.
+ *    datum_length is not utilized.
+ *  SEMANAGE_SERIAL_SIZE_T
+ *    Serializes datum to a size_t as defined in stddef.h
+ *    datum may NOT be NULL.
+ *    datum_length is not utilized.
+ *  SEMANAGE_SERIAL_STRING
+ *    Serializes a char*.
+ *    datum may be NULL.
+ *    datum_length should be the length of the string as returned by strlen.
+ *  SEMANAGE_SERIAL_STRING_ARRAY
+ *    Serializes a char**.
+ *    datum may be NULL.
+ *    datum_length should be the size of the array.
+ *    Each string will be serialized as per SEMANAGE_SERIAL_STRING and its size
+ *    determined via strlen.
+ *
+ *  NULL pointers are distinguished (where they are allowed at all).
+ *  In the case of strings this means that a NULL char* has a different
+ *  serialization from the empty string "".
+ *
+ */
+int semanage_serialize(semanage_handle_t * handle,
+		    const void *datum,
+		    size_t datum_length,
+		    unsigned int datum_type, char **data, uint64_t * size)
+{
+	int status;
+	unsigned int flags;
+	uint32_t i;
+	void *temp = NULL;
+
+	switch (datum_type) {
+		case SEMANAGE_SERIAL_INT32_T:
+		case SEMANAGE_SERIAL_UINT32_T:
+			if (size == NULL) {
+				temp = calloc(1, sizeof(int32_t));
+				if (temp == NULL) {
+					status = STATUS_ERR;
+					goto cleanup;
+				}
+
+				*((int32_t *)temp) = cpu_to_le32(*((int32_t *) datum));
+				memcpy(*data, temp, sizeof(int32_t));
+				*data += sizeof(int32_t);
+			}
+			else
+				*size += sizeof(int32_t);
+			break;
+		case SEMANAGE_SERIAL_SIZE_T:
+			if (size == NULL) {
+				temp = calloc(1, sizeof(uint64_t));
+				if (temp == NULL) {
+					status = STATUS_ERR;
+					goto cleanup;
+				}
+
+				*((uint64_t *)temp) = cpu_to_le64(*((size_t *) datum));
+
+				memcpy(*data, temp, sizeof(uint64_t));
+				*data += sizeof(uint64_t);
+			}
+			else
+				*size += sizeof(uint64_t);
+			break;
+		case SEMANAGE_SERIAL_STRING:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			flags = (datum == NULL) ? 0 : 1;
+
+			status =
+				semanage_serialize(handle, &flags, 0, SEMANAGE_SERIAL_UINT32_T, data,
+						size);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			/* Write if not null. */
+			if (flags & 1) {
+				/* Size. */
+				status =
+					semanage_serialize(handle, &datum_length, 0,
+							SEMANAGE_SERIAL_SIZE_T, data, size);
+				if (status != STATUS_SUCCESS)
+					goto cleanup;
+
+				/* Datum. */
+				if (size == NULL) {
+					status =
+						snprintf(*data, datum_length + 1, "%s",
+								(char *)datum);
+					if (status < 0 || (unsigned)status > datum_length)
+						goto cleanup;
+					else {
+						*data += status + 1;
+						status = STATUS_SUCCESS;
+					}
+				} else {
+					*size += datum_length + 1;
+				}
+			}
+			break;
+		case SEMANAGE_SERIAL_STRING_ARRAY:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			flags = (datum == NULL) ? 0 : 1;
+
+			status =
+				semanage_serialize(handle, &flags, 0, SEMANAGE_SERIAL_UINT32_T, data,
+						size);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			/* Write if not null. */
+			if (flags & 1) {
+				/* Size. */
+				status =
+					semanage_serialize(handle, &datum_length, 0,
+							SEMANAGE_SERIAL_UINT32_T, data, size);
+				if (status != STATUS_SUCCESS)
+					goto cleanup;
+
+				/* Datum. */
+				for (i = 0; i < datum_length; i++) {
+					status =
+						semanage_serialize(handle, ((char **)datum)[i],
+								strlen(((char **)datum)[i]),
+								SEMANAGE_SERIAL_STRING, data, size);
+					if (status != STATUS_SUCCESS)
+						goto cleanup;
+				}
+			}
+			break;
+		default:
+			status = STATUS_ERR;
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+	status = STATUS_SUCCESS;
+cleanup:
+	free(temp);
+	return status;
+}
+
+/** Unserializes various kinds of datum as serialized by semanage_serialize.
+ *
+ *  This function acts iteratively moving the *data AND size values.
+ *  size is decremented as data is unserialized.
+ *
+ *  It also allocates memory for datum and, depending on datum_type, datum_length.
+ *  Caller must free.
+ *
+ *  Supported datum_types (defined in serialize.h):
+ *
+ *  SEMANAGE_SERIAL_INT32_T
+ *    Unserializes data into an int32_t as defined in inttypes.h.
+ *    datum_length may be NULL.
+ *  SEMANAGE_SERIAL_UINT32_T
+ *    Unserializes data into an uint32_t as defined in inttypes.h.
+ *    datum_length may be NULL.
+ *  SEMANAGE_SERIAL_SIZE_T
+ *    Unserializes data into an size_t as defined in stddef.h.
+ *    datum_length may be NULL.
+ *  SEMANAGE_SERIAL_STRING
+ *    Unserializes data into a NULL terminated char*.
+ *    datum_length may NOT be NULL and will be the size of the string.
+ *  SEMANAGE_SERIAL_STRING_ARRAY
+ *    Unserializes data into a char**.
+ *    Each entry in the array will be unserialized as per SEMANAGE_SERIAL_STRING.
+ *    datum_length may NOT be NULL and will be the size of the array.
+ */
+int semanage_unserialize(semanage_handle_t * handle,
+		char **data, uint64_t * size,
+		void **datum,
+		size_t ** datum_length,
+		unsigned int datum_type)
+{
+	int status;
+	unsigned int *flags = NULL;
+	uint32_t i;
+	void *temp = NULL;
+	size_t *temp_length = NULL;
+
+	switch (datum_type) {
+		case SEMANAGE_SERIAL_INT32_T:
+		case SEMANAGE_SERIAL_UINT32_T:
+			*datum = calloc(1, sizeof(int32_t));
+			if (*datum == NULL) {
+				status = STATUS_ERR;
+				goto cleanup;
+			}
+
+			memcpy(*datum, *data, sizeof(int32_t));
+			**((int32_t **)datum) = le32_to_cpu(**((int32_t **) datum));
+
+			*size -= sizeof(int32_t);
+			*data += sizeof(int32_t);
+			break;
+		case SEMANAGE_SERIAL_SIZE_T:
+			temp = calloc(1, sizeof(uint64_t));
+			if (temp == NULL) {
+				status = STATUS_ERR;
+				goto cleanup;
+			}
+
+			memcpy(temp, *data, sizeof(uint64_t));
+
+			*((uint64_t *) temp) = le64_to_cpu(*((uint64_t *) temp));
+
+			if (*((uint64_t *) temp) > UINT_MAX) {
+				status = STATUS_ERR;
+				goto cleanup;
+			}
+
+			*datum = calloc(1, sizeof(size_t));
+			if (datum == NULL) {
+				status = STATUS_ERR;
+				goto cleanup;
+			}
+
+			**((size_t **)datum) = *((uint64_t *) temp);
+
+			*size -= sizeof(uint64_t);
+			*data += sizeof(uint64_t);
+			break;
+		case SEMANAGE_SERIAL_STRING:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			status =
+				semanage_unserialize(handle,
+						data, size,
+						(void **)(&flags), NULL,
+						SEMANAGE_SERIAL_UINT32_T);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			if (*flags & 1) {
+				/* Size. */
+				status =
+					semanage_unserialize(handle,
+							data, size,
+							(void **)datum_length, NULL,
+							SEMANAGE_SERIAL_SIZE_T);
+				if (status != STATUS_SUCCESS)
+					goto cleanup;
+
+				/* Datum. */
+				*datum = calloc(**datum_length + 1, sizeof(char));
+				if (*datum == NULL) {
+					status = STATUS_ERR;
+					goto cleanup;
+				}
+
+				memcpy(*datum, *data, **datum_length + 1);
+
+				*size -= **datum_length + 1;
+				*data += **datum_length + 1;
+			} else {
+				*datum = NULL;
+				*datum_length = NULL;
+			}
+
+			free(flags);
+			flags = NULL;
+			break;
+		case SEMANAGE_SERIAL_STRING_ARRAY:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			status =
+				semanage_unserialize(handle,
+						data, size,
+						(void **)(&flags), NULL,
+						SEMANAGE_SERIAL_UINT32_T);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			/* Write if not null. */
+			if (*flags & 1) {
+				/* Size. */
+				status =
+					semanage_unserialize(handle,
+							data, size,
+							(void **)datum_length, NULL,
+							SEMANAGE_SERIAL_UINT32_T);
+				if (status != STATUS_SUCCESS)
+					goto cleanup;
+
+				/* Datum. */
+				*datum =
+					calloc(sizeof(char *),
+							sizeof(char *) * (**datum_length));
+				if (*datum == NULL) {
+					status = STATUS_ERR;
+					goto cleanup;
+				}
+
+				for (i = 0; i < **datum_length; i++) {
+					status = semanage_unserialize(handle,
+							data,
+							size,
+							(void **)&(((char **)(*datum))[i]),
+							&temp_length,
+							SEMANAGE_SERIAL_STRING);
+
+					if (status != STATUS_SUCCESS)
+						goto cleanup;
+
+					free(temp_length);
+					temp_length = NULL;
+				}
+			}
+
+			free(flags);
+			flags = NULL;
+			break;
+		default:
+			status = STATUS_ERR;
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+	status = STATUS_SUCCESS;
+cleanup:
+	free(flags);
+	free(temp);
+	free(temp_length);
+	return status;
+}
+
Index: selinux-pms-support/libsemanage/src/serialize.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/serialize.h
@@ -0,0 +1,45 @@
+/* Author: Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C) 2005-2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat Inc.
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
+#ifndef _SEMANAGE_SERIALIZE_INTERNAL_H_
+#define _SEMANAGE_SERIALIZE_INTERNAL_H_
+
+#include <inttypes.h>
+#include "handle.h"
+
+/* Datum types. */
+#define SEMANAGE_SERIAL_INT32_T 0
+#define SEMANAGE_SERIAL_UINT32_T 1
+#define SEMANAGE_SERIAL_SIZE_T 2
+#define SEMANAGE_SERIAL_STRING 3
+#define SEMANAGE_SERIAL_STRING_ARRAY 4
+
+int semanage_serialize(semanage_handle_t * handle,
+		    const void *datum,
+		    size_t datum_size,
+		    unsigned int datum_type, char **data, uint64_t * size);
+
+int semanage_unserialize(semanage_handle_t * handle,
+    char **data, uint64_t * size,
+    void **datum,
+    size_t ** datum_length,
+    unsigned int datum_type);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
