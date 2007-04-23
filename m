Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUN07001491
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:23 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUMSG027787
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:22 GMT
Message-Id: <20070423213721.090230000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:34:56 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 01/33] libsepol: basic serilization support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serialization versioning added to the sepol handle.

Serialization utility functions added in serialize.[ch]
---
 libsepol/include/sepol/handle.h |   17 +
 libsepol/src/handle.c           |   89 +++++++++
 libsepol/src/handle.h           |    5 
 libsepol/src/libsepol.map       |    1 
 libsepol/src/serialize.c        |  389 ++++++++++++++++++++++++++++++++++++++++
 libsepol/src/serialize.h        |   45 ++++
 6 files changed, 546 insertions(+)

Index: selinux-pms-support/libsepol/include/sepol/handle.h
===================================================================
--- selinux-pms-support.orig/libsepol/include/sepol/handle.h
+++ selinux-pms-support/libsepol/include/sepol/handle.h
@@ -1,6 +1,11 @@
 #ifndef _SEPOL_HANDLE_H_
 #define _SEPOL_HANDLE_H_
 
+#include <inttypes.h>
+
+#define SEPOL_SERIAL_VERSION_MAJOR 1
+#define SEPOL_SERIAL_VERSION_MINOR 0
+
 struct sepol_handle;
 typedef struct sepol_handle sepol_handle_t;
 
@@ -10,4 +15,16 @@ sepol_handle_t *sepol_handle_create(void
 /* Destroy a sepol handle. */
 void sepol_handle_destroy(sepol_handle_t *);
 
+/* Serialize the serialization version. */
+int sepol_handle_version_serialize(sepol_handle_t * sh, char **data, uint64_t *size);
+
+/* Unserialize the serialization version. */
+int sepol_handle_version_unserialize(sepol_handle_t * sh, char **data, uint64_t *size);
+
+/* Get the serialization version. */
+int sepol_handle_get_version(sepol_handle_t *sh, uint32_t * major, uint32_t * minor);
+
+/* Set the serialization version. */
+int sepol_handle_set_version(sepol_handle_t *sh, uint32_t major, uint32_t minor);
+
 #endif
Index: selinux-pms-support/libsepol/src/handle.c
===================================================================
--- selinux-pms-support.orig/libsepol/src/handle.c
+++ selinux-pms-support/libsepol/src/handle.c
@@ -1,6 +1,7 @@
 #include <stdlib.h>
 #include "handle.h"
 #include "debug.h"
+#include "serialize.h"
 
 sepol_handle_t *sepol_handle_create(void)
 {
@@ -9,6 +10,10 @@ sepol_handle_t *sepol_handle_create(void
 	if (sh == NULL)
 		return NULL;
 
+	/* Set default serialization version. */
+	sh->version_major = 0;
+	sh->version_minor = 0;
+
 	/* Set callback */
 	sh->msg_callback = sepol_msg_default_handler;
 	sh->msg_callback_arg = NULL;
@@ -20,3 +25,87 @@ void sepol_handle_destroy(sepol_handle_t
 {
 	free(sh);
 }
+
+int sepol_handle_get_version(sepol_handle_t *sh, uint32_t * major, uint32_t * minor)
+{
+	*major = sh->version_major;
+	*minor = sh->version_minor;
+	return STATUS_SUCCESS;
+}
+
+int sepol_handle_set_version(sepol_handle_t *sh, uint32_t major, uint32_t minor)
+{
+	sh->version_major = major;
+	sh->version_minor = minor;
+	return STATUS_SUCCESS;
+}
+
+int sepol_handle_version_serialize(sepol_handle_t * sh, char **data, uint64_t *size)
+{
+	int status = STATUS_SUCCESS;
+	char *ptr;
+
+	/* Sundry sanity checks. */
+	if (data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Calculate size. */
+	status = sepol_serialize(sh, &(sh->version_major), 0, SEPOL_SERIAL_UINT32_T, NULL, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	status = sepol_serialize(sh, &(sh->version_minor), 0, SEPOL_SERIAL_UINT32_T, NULL, size);
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
+	/* Serialize. */
+	status = sepol_serialize(sh, &(sh->version_major), 0, SEPOL_SERIAL_UINT32_T, &ptr, NULL);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	status = sepol_serialize(sh, &(sh->version_minor), 0, SEPOL_SERIAL_UINT32_T, &ptr, NULL);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+cleanup:
+	return status;
+}
+
+int sepol_handle_version_unserialize(sepol_handle_t * sh, char **data, uint64_t *size)
+{
+	int status = STATUS_SUCCESS;
+	uint32_t *major = NULL;
+	uint32_t *minor = NULL;
+	size_t *datum_length = NULL;
+	char *ptr = *data;
+
+	/* Sundry sanity checks. */
+	if (data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	status = sepol_unserialize(sh, &ptr, size, (void **)&major, &datum_length, SEPOL_SERIAL_UINT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	status = sepol_unserialize(sh, &ptr, size, (void **)&minor, &datum_length, SEPOL_SERIAL_UINT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	sh->version_major = *major;
+	sh->version_minor = *minor;
+
+cleanup:
+	free(major);
+	free(minor);
+	free(datum_length);
+	return status;
+}
Index: selinux-pms-support/libsepol/src/handle.h
===================================================================
--- selinux-pms-support.orig/libsepol/src/handle.h
+++ selinux-pms-support/libsepol/src/handle.h
@@ -1,9 +1,14 @@
 #ifndef _SEPOL_INTERNAL_HANDLE_H_
 #define _SEPOL_INTERNAL_HANDLE_H_
 
+#include <inttypes.h>
 #include <sepol/handle.h>
 
 struct sepol_handle {
+	/* Serialization version. */
+	uint32_t version_major;
+	uint32_t version_minor;
+
 	/* Error handling */
 	int msg_level;
 	const char *msg_channel;
Index: selinux-pms-support/libsepol/src/libsepol.map
===================================================================
--- selinux-pms-support.orig/libsepol/src/libsepol.map
+++ selinux-pms-support/libsepol/src/libsepol.map
@@ -12,5 +12,6 @@
 	sepol_policydb_*; sepol_set_policydb_from_file; 
 	sepol_policy_kern_*;
 	sepol_policy_file_*;
+	sepol_*_serialize; sepol_*_unserialize;
   local: *;
 };
Index: selinux-pms-support/libsepol/src/serialize.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsepol/src/serialize.c
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
+#include "private.h"
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
+ *  SEPOL_SERIAL_INT32_T
+ *    Serializes datum to a int32_t as defined in inttypes.h
+ *    datum may NOT be NULL.
+ *    datum_length is not utilized.
+ *  SEPOL_SERIAL_UINT32_T
+ *    Serializes datum to a uint32_t as defined in inttypes.h
+ *    datum may NOT be NULL.
+ *    datum_length is not utilized.
+ *  SEPOL_SERIAL_SIZE_T
+ *    Serializes datum to a size_t as defined in stddef.h
+ *    datum may NOT be NULL.
+ *    datum_length is not utilized.
+ *  SEPOL_SERIAL_STRING
+ *    Serializes a char*.
+ *    datum may be NULL.
+ *    datum_length should be the length of the string as returned by strlen.
+ *  SEPOL_SERIAL_STRING_ARRAY
+ *    Serializes a char**.
+ *    datum may be NULL.
+ *    datum_length should be the size of the array.
+ *    Each string will be serialized as per SEPOL_SERIAL_STRING and its size
+ *    determined via strlen.
+ *
+ *  NULL pointers are distinguished (where they are allowed at all).
+ *  In the case of strings this means that a NULL char* has a different
+ *  serialization from the empty string "".
+ *
+ */
+int sepol_serialize(sepol_handle_t * handle,
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
+		case SEPOL_SERIAL_INT32_T:
+		case SEPOL_SERIAL_UINT32_T:
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
+		case SEPOL_SERIAL_SIZE_T:
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
+		case SEPOL_SERIAL_STRING:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			flags = (datum == NULL) ? 0 : 1;
+
+			status =
+				sepol_serialize(handle, &flags, 0, SEPOL_SERIAL_UINT32_T, data,
+						size);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			/* Write if not null. */
+			if (flags & 1) {
+				/* Size. */
+				status =
+					sepol_serialize(handle, &datum_length, 0,
+							SEPOL_SERIAL_SIZE_T, data, size);
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
+		case SEPOL_SERIAL_STRING_ARRAY:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			flags = (datum == NULL) ? 0 : 1;
+
+			status =
+				sepol_serialize(handle, &flags, 0, SEPOL_SERIAL_UINT32_T, data,
+						size);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			/* Write if not null. */
+			if (flags & 1) {
+				/* Size. */
+				status =
+					sepol_serialize(handle, &datum_length, 0,
+							SEPOL_SERIAL_UINT32_T, data, size);
+				if (status != STATUS_SUCCESS)
+					goto cleanup;
+
+				/* Datum. */
+				for (i = 0; i < datum_length; i++) {
+					status =
+						sepol_serialize(handle, ((char **)datum)[i],
+								strlen(((char **)datum)[i]),
+								SEPOL_SERIAL_STRING, data, size);
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
+/** Unserializes various kinds of datum as serialized by sepol_serialize.
+ *
+ *  This function acts iteratively moving the *data AND size values.
+ *  size is decremented as data is unserialized.
+ *
+ *  It also allocates memory for datum and, depending on datum_type, datum_length.
+ *  Caller must free.
+ *
+ *  Supported datum_types (defined in serialize.h):
+ *
+ *  SEPOL_SERIAL_INT32_T
+ *    Unserializes data into an int32_t as defined in inttypes.h.
+ *    datum_length may be NULL.
+ *  SEPOL_SERIAL_UINT32_T
+ *    Unserializes data into an uint32_t as defined in inttypes.h.
+ *    datum_length may be NULL.
+ *  SEPOL_SERIAL_SIZE_T
+ *    Unserializes data into an size_t as defined in stddef.h.
+ *    datum_length may be NULL.
+ *  SEPOL_SERIAL_STRING
+ *    Unserializes data into a NULL terminated char*.
+ *    datum_length may NOT be NULL and will be the size of the string.
+ *  SEPOL_SERIAL_STRING_ARRAY
+ *    Unserializes data into a char**.
+ *    Each entry in the array will be unserialized as per SEPOL_SERIAL_STRING.
+ *    datum_length may NOT be NULL and will be the size of the array.
+ */
+int sepol_unserialize(sepol_handle_t * handle,
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
+		case SEPOL_SERIAL_INT32_T:
+		case SEPOL_SERIAL_UINT32_T:
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
+		case SEPOL_SERIAL_SIZE_T:
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
+		case SEPOL_SERIAL_STRING:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			status =
+				sepol_unserialize(handle,
+						data, size,
+						(void **)(&flags), NULL,
+						SEPOL_SERIAL_UINT32_T);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			if (*flags & 1) {
+				/* Size. */
+				status =
+					sepol_unserialize(handle,
+							data, size,
+							(void **)datum_length, NULL,
+							SEPOL_SERIAL_SIZE_T);
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
+		case SEPOL_SERIAL_STRING_ARRAY:
+			/* Flags (intended as a bitmap):
+			 * 0 == NULL
+			 * 1 == Non NULL
+			 */
+			status =
+				sepol_unserialize(handle,
+						data, size,
+						(void **)(&flags), NULL,
+						SEPOL_SERIAL_UINT32_T);
+			if (status != STATUS_SUCCESS)
+				goto cleanup;
+
+			/* Write if not null. */
+			if (*flags & 1) {
+				/* Size. */
+				status =
+					sepol_unserialize(handle,
+							data, size,
+							(void **)datum_length, NULL,
+							SEPOL_SERIAL_UINT32_T);
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
+					status = sepol_unserialize(handle,
+							data,
+							size,
+							(void **)&(((char **)(*datum))[i]),
+							&temp_length,
+							SEPOL_SERIAL_STRING);
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
Index: selinux-pms-support/libsepol/src/serialize.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsepol/src/serialize.h
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
+#ifndef _SEPOL_SERIALIZE_INTERNAL_H_
+#define _SEPOL_SERIALIZE_INTERNAL_H_
+
+#include <inttypes.h>
+#include "handle.h"
+
+/* Datum types. */
+#define SEPOL_SERIAL_INT32_T 0
+#define SEPOL_SERIAL_UINT32_T 1
+#define SEPOL_SERIAL_SIZE_T 2
+#define SEPOL_SERIAL_STRING 3
+#define SEPOL_SERIAL_STRING_ARRAY 4
+
+extern int sepol_serialize(sepol_handle_t * handle,
+		    const void *datum,
+		    size_t datum_size,
+		    unsigned int datum_type, char **data, uint64_t * size);
+
+extern int sepol_unserialize(sepol_handle_t * handle,
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
