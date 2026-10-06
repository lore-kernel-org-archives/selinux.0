Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93097456E10
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291854; cv=none; b=HPzcKrZg5kqwnAYG+bcaA+RJHSoSZx6uYonFZf2oqbuO1a/2X5d7yWpGy+sp5ASMSoInZ5YsKEl9Gf9ANJ/Va4BCGGuTSObO/tVyk22b/AKJu+ouwQ3e/jyRAG7JJ9YkHLhDXXNRlQaMq2TKiRFVbhr+N/wZF75d6g5GK0gvvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291854; c=relaxed/simple;
	bh=2A9rlYIiJgvWcPI5nU9iKz7oxX+jisxW9FvrhmkDogU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQjloWHF7B1kpoLoD2Ww5uO26WNbiNKjmfn6iM1z1i4ygcfYVKpuK/d/rA/zlmUHRyNj+vTihWk9oI9dn3MexfJGv7EWufvwoesdjB/PUfl09IkHZDvX8DPtR21nH+6s7vg+4N2s3PRN82otcMIqYrlfFQwO9tE0ZT68HoXEH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNzFNege; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNzFNege"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BZjpD2TpOy8FejcJcZJdaDi1nHYPXKaVlaSxef/mPg=;
	b=NNzFNege7x4sJOb5Ve4Y5pMqRhoOXfMwT9HWVhykMwbVptOuCduMXZB7T96oGCiWHL/TxK
	DJqUxgZuTY2R9wnYwUkCA6hnjozhI5gccBkmrrN8EBufCbbgMt8BYGivPGL52GnDsh4jhT
	a2rl+w+KTColAePWZq2dLdz6dUnRW38=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-XhqwVqXwOA-Hs8zg6ugAnA-1; Tue,
 06 Oct 2026 09:04:07 -0400
X-MC-Unique: XhqwVqXwOA-Hs8zg6ugAnA-1
X-Mimecast-MFC-AGG-ID: XhqwVqXwOA-Hs8zg6ugAnA_1791291846
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ECEB19539A5;
	Tue,  6 Oct 2026 13:04:06 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E2F51944CC0;
	Tue,  6 Oct 2026 13:04:04 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 03/17] libsepol: add public type record structure and iterator
Date: Tue,  6 Oct 2026 15:02:01 +0200
Message-ID: <20261006130215.128405-4-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-1-jjanasek@redhat.com>
References: <20261006130215.128405-1-jjanasek@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Introduce sepol_type_t with getter/setter API for type name, value,
flavor, bounds, and subtypes. Add sepol_type_iter for iterating all
types in a policy via the hashtab iterator, plus
sepol_type_value_to_name() and sepol_type_query_by_value() for
resolving a 1-based type value without touching internal symtab
structures.

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/type_record.h |  95 +++++
 libsepol/include/sepol/types.h       |  84 ++++
 libsepol/src/type_record.c           | 351 +++++++++++++++++
 libsepol/src/types.c                 | 552 +++++++++++++++++++++++++++
 4 files changed, 1082 insertions(+)
 create mode 100644 libsepol/include/sepol/type_record.h
 create mode 100644 libsepol/include/sepol/types.h
 create mode 100644 libsepol/src/type_record.c
 create mode 100644 libsepol/src/types.c

diff --git a/libsepol/include/sepol/type_record.h b/libsepol/include/sepol/type_record.h
new file mode 100644
index 00000000..f88de870
--- /dev/null
+++ b/libsepol/include/sepol/type_record.h
@@ -0,0 +1,95 @@
+#ifndef _SEPOL_TYPE_RECORD_H_
+#define _SEPOL_TYPE_RECORD_H_
+
+#include <sepol/handle.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sepol_type;
+typedef struct sepol_type sepol_type_t;
+struct sepol_type_key;
+typedef struct sepol_type_key sepol_type_key_t;
+
+/* Key */
+extern int sepol_type_key_create(sepol_handle_t *handle, const char *name,
+				 sepol_type_key_t **key);
+
+extern void sepol_type_key_unpack(const sepol_type_key_t *key,
+				  const char **name);
+
+extern int sepol_type_key_extract(sepol_handle_t *handle,
+				  const sepol_type_t *type,
+				  sepol_type_key_t **key_ptr);
+
+extern void sepol_type_key_free(sepol_type_key_t *key);
+
+extern int sepol_type_compare(const sepol_type_t *type,
+			      const sepol_type_key_t *key);
+
+extern int sepol_type_compare2(const sepol_type_t *type,
+			       const sepol_type_t *type2);
+
+/* Name */
+extern const char *sepol_type_get_name(const sepol_type_t *type);
+extern int sepol_type_set_name(sepol_handle_t *handle, sepol_type_t *type,
+			       const char *name);
+
+/* Flavor */
+#define SEPOL_TYPE_TYPE 0 /* regular type */
+#define SEPOL_TYPE_ATTRIB 1 /* attribute */
+#define SEPOL_TYPE_ALIAS 2 /* alias */
+
+extern uint32_t sepol_type_get_flavor(const sepol_type_t *type);
+extern int sepol_type_set_flavor(sepol_handle_t *handle, sepol_type_t *type,
+				 uint32_t flavor);
+
+/* Subtypes/Attributes */
+extern int sepol_type_has_subtype(const sepol_type_t *type,
+				  const char *subtype);
+extern int sepol_type_get_subtypes(sepol_handle_t *handle,
+				   const sepol_type_t *type,
+				   const char ***subtypes,
+				   uint32_t *num_subtypes);
+extern int sepol_type_add_subtype(sepol_handle_t *handle, sepol_type_t *type,
+				  const char *subtype);
+extern int sepol_type_del_subtype(sepol_handle_t *handle, sepol_type_t *type,
+				  const char *subtype);
+
+/* Flags */
+#define SEPOL_TYPE_FLAGS_PERMISSIVE (1 << 0)
+#define SEPOL_TYPE_FLAGS_EXPAND_ATTR_TRUE (1 << 1)
+#define SEPOL_TYPE_FLAGS_EXPAND_ATTR_FALSE (1 << 2)
+#define SEPOL_TYPE_FLAGS_EXPAND_ATTR \
+	(SEPOL_TYPE_FLAGS_EXPAND_ATTR_TRUE | SEPOL_TYPE_FLAGS_EXPAND_ATTR_FALSE)
+extern int sepol_type_has_flag(const sepol_type_t *type, uint32_t flag);
+extern int sepol_type_set_flag(sepol_handle_t *handle, sepol_type_t *type,
+			       uint32_t flag);
+extern int sepol_type_unset_flag(sepol_handle_t *handle, sepol_type_t *type,
+				 uint32_t flag);
+
+/* Primary names of aliases */
+extern const char *sepol_type_get_alias_of(const sepol_type_t *type);
+extern int sepol_type_set_alias_of(sepol_handle_t *handle, sepol_type_t *type,
+				   const char *name);
+
+/* Bounds */
+extern const char *sepol_type_get_bounds(const sepol_type_t *type);
+extern int sepol_type_set_bounds(sepol_handle_t *handle, sepol_type_t *type,
+				 const char *bounds);
+
+/* Create/Clone/Destroy */
+extern int sepol_type_create(sepol_handle_t *handle, sepol_type_t **type_ptr);
+
+extern int sepol_type_clone(sepol_handle_t *handle, const sepol_type_t *type,
+			    sepol_type_t **type_ptr);
+
+extern void sepol_type_free(sepol_type_t *type);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/types.h b/libsepol/include/sepol/types.h
new file mode 100644
index 00000000..7a446666
--- /dev/null
+++ b/libsepol/include/sepol/types.h
@@ -0,0 +1,84 @@
+#ifndef _SEPOL_TYPES_H_
+#define _SEPOL_TYPES_H_
+
+#include <sepol/policydb.h>
+#include <sepol/type_record.h>
+#include <sepol/handle.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sepol_type_iter;
+typedef struct sepol_type_iter sepol_type_iter_t;
+
+/* Modify the type, or add it, if the key is not found.
+ * Only supported on source-format (POLICY_BASE/POLICY_MOD) policydbs,
+ * where type<->attribute membership lives directly on the type_datum;
+ * returns an error for a kernel-format (POLICY_KERN) policydb, since
+ * that format tracks membership via derived attr_type_map/
+ * type_attr_map tables that this function does not maintain. Aliases
+ * (SEPOL_TYPE_ALIAS) are not supported.
+ * On failure when adding a new type, the type may still have been
+ * inserted into the policydb in a partially-populated state; the
+ * policydb remains memory-safe to use and destroy, but should not be
+ * relied upon to be fully consistent for that type. */
+extern int sepol_type_modify(sepol_handle_t *handle, sepol_policydb_t *policydb,
+			     const sepol_type_key_t *key,
+			     const sepol_type_t *data);
+
+/* Return the number of types */
+extern int sepol_type_count(sepol_handle_t *handle, const sepol_policydb_t *p,
+			    unsigned int *response);
+
+/* Check if the specified type exists */
+extern int sepol_type_exists(sepol_handle_t *handle,
+			     const sepol_policydb_t *policydb,
+			     const sepol_type_key_t *key, int *response);
+
+/* Query a type - returns the type or NULL if not found.
+ * The subtypes/attributes reported via sepol_type_get_subtypes() on
+ * the returned record come from different sources depending on the
+ * policydb's format: for source-format (POLICY_BASE/POLICY_MOD)
+ * policydbs they are read directly off the type; for kernel-format
+ * (POLICY_KERN) policydbs they come from the derived attr_type_map/
+ * type_attr_map tables, which are only populated after loading a
+ * binary policy or expanding a module (see policydb_read()/
+ * expand_module()) -- a policydb that has neither happened to it
+ * (e.g. one freshly created via sepol_policydb_create()) will report
+ * an empty set rather than an error. */
+extern int sepol_type_query(sepol_handle_t *handle, const sepol_policydb_t *p,
+			    const sepol_type_key_t *key,
+			    sepol_type_t **response);
+
+/* Resolve a type value to its name.  Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_type_value_to_name(sepol_handle_t *handle,
+				    const sepol_policydb_t *p, uint32_t value,
+				    const char **name);
+
+/* Query a type by value - returns the type or NULL if not found */
+extern int sepol_type_query_by_value(sepol_handle_t *handle,
+				     const sepol_policydb_t *p, uint32_t value,
+				     sepol_type_t **response);
+
+/*
+ * Iterating types. Iteration order is unspecified (currently hash-bucket
+ * order of the internal symbol table) and may change between library
+ * versions or policydb loads; callers must not rely on it matching
+ * declaration order or being stable across calls.
+ */
+extern int sepol_type_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_type_iter_t **iter);
+extern void sepol_type_iter_destroy(sepol_type_iter_t *iter);
+extern int sepol_type_iter_next(sepol_handle_t *handle, sepol_type_iter_t *iter,
+				sepol_type_t **item);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/type_record.c b/libsepol/src/type_record.c
new file mode 100644
index 00000000..cd427640
--- /dev/null
+++ b/libsepol/src/type_record.c
@@ -0,0 +1,351 @@
+#include <sepol/type_record.h>
+
+#include <stdlib.h>
+#include <string.h>
+
+#include "sepol/policydb/util.h"
+#include "debug.h"
+
+struct sepol_type {
+	/* This type's name */
+	char *name;
+
+	/* This type's flavor */
+	uint32_t flavor;
+	/* This type attribute's subtypes */
+	uint32_t num_types;
+	char **types;
+	/* This type's flags */
+	uint32_t flags;
+
+	/* This type's bounds type, if exists */
+	char *bounds;
+
+	/* This alias' primary type name */
+	char *alias_of;
+};
+
+struct sepol_type_key {
+	/* This type's name */
+	char *name;
+};
+
+int sepol_type_key_create(sepol_handle_t *handle, const char *name,
+			  sepol_type_key_t **key_ptr)
+{
+	if (!key_ptr)
+		return STATUS_ERR;
+	if (!name) {
+		ERR(handle, "name is NULL");
+		*key_ptr = NULL;
+		return STATUS_ERR;
+	}
+	sepol_type_key_t *tmp_key = malloc(sizeof(sepol_type_key_t));
+
+	if (!tmp_key) {
+		ERR(handle, "out of memory, could not create selinux type key");
+		*key_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp_key->name = strdup(name);
+	if (!tmp_key->name) {
+		ERR(handle, "out of memory, could not create selinux type key");
+		free(tmp_key);
+		*key_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}
+
+void sepol_type_key_unpack(const sepol_type_key_t *key, const char **name)
+{
+	*name = key ? key->name : NULL;
+}
+
+int sepol_type_key_extract(sepol_handle_t *handle, const sepol_type_t *type,
+			   sepol_type_key_t **key_ptr)
+{
+	if (!type) {
+		ERR(handle, "type is NULL");
+		return STATUS_ERR;
+	}
+	if (!type->name) {
+		ERR(handle, "type name is NULL");
+		return STATUS_ERR;
+	}
+	if (sepol_type_key_create(handle, type->name, key_ptr) < 0)
+		return STATUS_ERR;
+	return STATUS_SUCCESS;
+}
+
+void sepol_type_key_free(sepol_type_key_t *key)
+{
+	if (!key)
+		return;
+	free(key->name);
+	free(key);
+}
+
+int sepol_type_compare(const sepol_type_t *type, const sepol_type_key_t *key)
+{
+	if (!type || !key || !type->name || !key->name)
+		return -1;
+	return strcmp(type->name, key->name);
+}
+
+int sepol_type_compare2(const sepol_type_t *type, const sepol_type_t *type2)
+{
+	if (!type || !type2 || !type->name || !type2->name)
+		return -1;
+	return strcmp(type->name, type2->name);
+}
+
+/* Name */
+const char *sepol_type_get_name(const sepol_type_t *type)
+{
+	return type ? type->name : NULL;
+}
+
+int sepol_type_set_name(sepol_handle_t *handle, sepol_type_t *type,
+			const char *name)
+{
+	if (!type || !name) {
+		ERR(handle, "type or name is NULL");
+		return STATUS_ERR;
+	}
+	char *tmp_name = strdup(name);
+	if (!tmp_name) {
+		ERR(handle, "out of memory, could not set name");
+		return STATUS_ERR;
+	}
+	free(type->name);
+	type->name = tmp_name;
+	return STATUS_SUCCESS;
+}
+
+/* Flavor */
+uint32_t sepol_type_get_flavor(const sepol_type_t *type)
+{
+	return type ? type->flavor : 0;
+}
+
+int sepol_type_set_flavor(sepol_handle_t *handle, sepol_type_t *type,
+			  uint32_t flavor)
+{
+	if (!type) {
+		ERR(handle, "type is NULL");
+		return STATUS_ERR;
+	}
+	type->flavor = flavor;
+	return STATUS_SUCCESS;
+}
+
+/* Subtypes/Attributes */
+int sepol_type_has_subtype(const sepol_type_t *type, const char *subtype)
+{
+	if (!type)
+		return 0;
+	return string_list_contains(type->types, type->num_types, subtype);
+}
+
+int sepol_type_get_subtypes(sepol_handle_t *handle, const sepol_type_t *type,
+			    const char ***subtypes, uint32_t *num_subtypes)
+{
+	if (!subtypes || !num_subtypes)
+		return STATUS_ERR;
+	if (!type) {
+		*subtypes = NULL;
+		*num_subtypes = 0;
+		return STATUS_ERR;
+	}
+
+	return string_list_scopy(handle, type->types, type->num_types, subtypes,
+				 num_subtypes);
+}
+
+int sepol_type_add_subtype(sepol_handle_t *handle, sepol_type_t *type,
+			   const char *subtype)
+{
+	if (!type || !subtype)
+		return STATUS_ERR;
+
+	if (sepol_type_has_subtype(type, subtype))
+		return STATUS_SUCCESS;
+
+	return string_list_add(handle, &type->types, &type->num_types, subtype);
+}
+
+int sepol_type_del_subtype(sepol_handle_t *handle __attribute__((unused)),
+			   sepol_type_t *type, const char *subtype)
+{
+	if (!type || !subtype)
+		return STATUS_ERR;
+
+	return string_list_del(type->types, &type->num_types, subtype);
+}
+
+/* Flags */
+int sepol_type_has_flag(const sepol_type_t *type, uint32_t flag)
+{
+	if (!type)
+		return 0;
+	return (type->flags & flag) != 0;
+}
+
+int sepol_type_set_flag(sepol_handle_t *handle, sepol_type_t *type,
+			uint32_t flag)
+{
+	if (!type) {
+		ERR(handle, "type is NULL");
+		return STATUS_ERR;
+	}
+	type->flags |= flag;
+	return STATUS_SUCCESS;
+}
+
+int sepol_type_unset_flag(sepol_handle_t *handle, sepol_type_t *type,
+			  uint32_t flag)
+{
+	if (!type) {
+		ERR(handle, "type is NULL");
+		return STATUS_ERR;
+	}
+	type->flags &= ~flag;
+	return STATUS_SUCCESS;
+}
+
+/* Aliases */
+const char *sepol_type_get_alias_of(const sepol_type_t *type)
+{
+	return type ? type->alias_of : NULL;
+}
+
+int sepol_type_set_alias_of(sepol_handle_t *handle, sepol_type_t *type,
+			    const char *name)
+{
+	if (!type) {
+		ERR(handle, "type is NULL");
+		return STATUS_ERR;
+	}
+	if (!name) {
+		free(type->alias_of);
+		type->alias_of = NULL;
+		return STATUS_SUCCESS;
+	}
+	char *tmp = strdup(name);
+	if (!tmp) {
+		ERR(handle,
+		    "out of memory, cannot set selinux alias primary type name");
+		return STATUS_ERR;
+	}
+	free(type->alias_of);
+	type->alias_of = tmp;
+	return STATUS_SUCCESS;
+}
+
+/* Bounds */
+const char *sepol_type_get_bounds(const sepol_type_t *type)
+{
+	return type ? type->bounds : NULL;
+}
+
+int sepol_type_set_bounds(sepol_handle_t *handle, sepol_type_t *type,
+			  const char *bounds)
+{
+	if (!type) {
+		ERR(handle, "type is NULL");
+		return STATUS_ERR;
+	}
+	if (!bounds) {
+		free(type->bounds);
+		type->bounds = NULL;
+		return STATUS_SUCCESS;
+	}
+	char *tmp = strdup(bounds);
+	if (!tmp) {
+		ERR(handle,
+		    "out of memory, cannot set selinux type bounds name");
+		return STATUS_ERR;
+	}
+	free(type->bounds);
+	type->bounds = tmp;
+	return STATUS_SUCCESS;
+}
+
+/* Create/Clone/Destroy */
+int sepol_type_create(sepol_handle_t *handle, sepol_type_t **type_ptr)
+{
+	sepol_type_t *tmp;
+
+	if (!type_ptr)
+		return STATUS_ERR;
+
+	tmp = malloc(sizeof(sepol_type_t));
+	if (!tmp) {
+		ERR(handle, "out of memory, could not create type record");
+		*type_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	memset(tmp, 0, sizeof(sepol_type_t));
+	*type_ptr = tmp;
+
+	return STATUS_SUCCESS;
+}
+
+int sepol_type_clone(sepol_handle_t *handle, const sepol_type_t *type,
+		     sepol_type_t **type_ptr)
+{
+	if (!type_ptr)
+		return STATUS_ERR;
+	if (!type) {
+		*type_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_type_t *tmp;
+	if (sepol_type_create(handle, &tmp)) {
+		*type_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	if (sepol_type_set_name(handle, tmp, type->name))
+		goto err;
+	if (type->bounds && sepol_type_set_bounds(handle, tmp, type->bounds))
+		goto err;
+	if (type->alias_of &&
+	    sepol_type_set_alias_of(handle, tmp, type->alias_of))
+		goto err;
+	for (size_t i = 0; i < type->num_types; i++) {
+		if (sepol_type_add_subtype(handle, tmp, type->types[i]))
+			goto err;
+	}
+	tmp->flags = type->flags;
+	if (sepol_type_set_flavor(handle, tmp, type->flavor))
+		goto err;
+
+	*type_ptr = tmp;
+	return STATUS_SUCCESS;
+
+err:
+	sepol_type_free(tmp);
+	*type_ptr = NULL;
+	return STATUS_ERR;
+}
+
+void sepol_type_free(sepol_type_t *type)
+{
+	if (!type)
+		return;
+
+	free(type->name);
+	for (size_t i = 0; i < type->num_types; i++)
+		free(type->types[i]);
+	free(type->types);
+	free(type->bounds);
+	free(type->alias_of);
+	free(type);
+}
diff --git a/libsepol/src/types.c b/libsepol/src/types.c
new file mode 100644
index 00000000..8e3dfdd1
--- /dev/null
+++ b/libsepol/src/types.c
@@ -0,0 +1,552 @@
+#include <sepol/types.h>
+
+#include <sepol/policydb/policydb.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "debug.h"
+#include "sepol/policydb/ebitmap.h"
+#include "sepol/policydb/hashtab.h"
+#include "sepol/policydb/util.h"
+#include "sepol/type_record.h"
+#include "private.h"
+
+struct sepol_type_iter {
+	const sepol_policydb_t *p;
+	hashtab_iter_t hashtab_iter;
+};
+
+static int type_datum_to_record(sepol_handle_t *handle, const policydb_t *p,
+				const type_datum_t *type_datum,
+				const char *name, sepol_type_t **type)
+{
+	sepol_type_t *new_type = NULL;
+
+	if (type_datum->s.value == 0 ||
+	    type_datum->s.value > p->p_types.nprim) {
+		*type = NULL;
+		return STATUS_ERR;
+	}
+
+	if (sepol_type_create(handle, &new_type))
+		goto err;
+
+	/* Copy name */
+	if (!name)
+		name = p->p_type_val_to_name[type_datum->s.value - 1];
+	if (sepol_type_set_name(handle, new_type, name))
+		goto err;
+
+	/* Copy flavor */
+	switch (type_datum->flavor) {
+	case TYPE_TYPE:
+		if (!type_datum->primary)
+			sepol_type_set_flavor(handle, new_type,
+					      SEPOL_TYPE_ALIAS);
+		else
+			sepol_type_set_flavor(handle, new_type,
+					      SEPOL_TYPE_TYPE);
+		break;
+	case TYPE_ATTRIB:
+		sepol_type_set_flavor(handle, new_type, SEPOL_TYPE_ATTRIB);
+		break;
+	case TYPE_ALIAS:
+		sepol_type_set_flavor(handle, new_type, SEPOL_TYPE_ALIAS);
+		break;
+	default:
+		ERR(handle, "unknown type flavor");
+		goto err;
+	}
+
+	/* Copy types */
+	const ebitmap_t *subtypes_bitmap = NULL;
+	ebitmap_node_t *node;
+	uint32_t bit;
+	if (p->policy_type == POLICY_KERN) {
+		/*
+		 * In kernel policy, attribute type relations are stored in a
+		 * global bitmap. These tables are derived/rebuilt after
+		 * loading a binary policy (see policydb_read()/
+		 * expand_module()) and may be absent -- e.g. for a policydb
+		 * freshly created via sepol_policydb_create(), which
+		 * defaults to POLICY_KERN but has no maps yet; treat that
+		 * as "no membership information available" rather than
+		 * dereferencing a NULL array.
+		 */
+		if (type_datum->flavor == TYPE_ATTRIB) {
+			if (p->attr_type_map)
+				subtypes_bitmap =
+					&p->attr_type_map[type_datum->s.value -
+							  1];
+		} else {
+			if (p->type_attr_map)
+				subtypes_bitmap =
+					&p->type_attr_map[type_datum->s.value -
+							  1];
+		}
+	} else {
+		subtypes_bitmap = &type_datum->types;
+	}
+	if (subtypes_bitmap) {
+		ebitmap_for_each_positive_bit(subtypes_bitmap, node, bit) {
+			if (bit >= p->p_types.nprim)
+				goto err;
+			if (type_datum->s.value != bit + 1 &&
+			    sepol_type_add_subtype(handle, new_type,
+						   p->p_type_val_to_name[bit]))
+				goto err;
+		}
+	}
+
+	/* Copy flags */
+	if ((type_datum->flags & TYPE_FLAGS_PERMISSIVE ||
+	     /* Kernel policy stores the permissive flag separately, in
+	      * the policydb-wide permissive_map bitmap keyed by type
+	      * value, rather than in type_datum->flags. */
+	     (p->policy_type == POLICY_KERN &&
+	      ebitmap_get_bit(&p->permissive_map, type_datum->s.value))) &&
+	    sepol_type_set_flag(handle, new_type, SEPOL_TYPE_FLAGS_PERMISSIVE))
+		goto err;
+	if (type_datum->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE &&
+	    sepol_type_set_flag(handle, new_type,
+				SEPOL_TYPE_FLAGS_EXPAND_ATTR_TRUE))
+		goto err;
+	if (type_datum->flags & TYPE_FLAGS_EXPAND_ATTR_FALSE &&
+	    sepol_type_set_flag(handle, new_type,
+				SEPOL_TYPE_FLAGS_EXPAND_ATTR_FALSE))
+		goto err;
+
+	/* Copy alias' primary name */
+	if (!type_datum->primary && type_datum->flavor == TYPE_TYPE) {
+		if (sepol_type_set_alias_of(
+			    handle, new_type,
+			    p->p_type_val_to_name[type_datum->s.value - 1]))
+			goto err;
+	} else if (type_datum->flavor == TYPE_ALIAS) {
+		if (type_datum->primary < 1 ||
+		    type_datum->primary > p->p_types.nprim)
+			goto err;
+		if (sepol_type_set_alias_of(
+			    handle, new_type,
+			    p->p_type_val_to_name[type_datum->primary - 1]))
+			goto err;
+	}
+
+	/* Copy bounds name */
+	if (type_datum->bounds &&
+	    (type_datum->bounds > p->p_types.nprim ||
+	     sepol_type_set_bounds(
+		     handle, new_type,
+		     p->p_type_val_to_name[type_datum->bounds - 1])))
+		goto err;
+
+	*type = new_type;
+	return STATUS_SUCCESS;
+
+err:
+	*type = NULL;
+	if (new_type)
+		sepol_type_free(new_type);
+
+	return STATUS_ERR;
+}
+
+int sepol_type_modify(sepol_handle_t *handle, sepol_policydb_t *p,
+		      const sepol_type_key_t *key, const sepol_type_t *data)
+{
+	policydb_t *policydb;
+	const char *cname;
+	const char *alias_of, *bounds_name;
+	const char **subtypes = NULL;
+	uint32_t num_subtypes = 0;
+	uint32_t flavor;
+	uint32_t i;
+	char *name = NULL;
+	type_datum_t *typdatum = NULL;
+	type_datum_t *bounds_datum = NULL;
+	hashtab_key_t scope_key = NULL;
+	scope_datum_t *scope_datum = NULL;
+	int new = 0;
+	/*
+	 * Built up from validated subtype names before touching any
+	 * existing type_datum, so a lookup failure never leaves a
+	 * previously-valid type wiped out in the live policydb (see
+	 * below).
+	 */
+	ebitmap_t new_types;
+
+	ebitmap_init(&new_types);
+
+	if (!handle || !p || !key || !data)
+		return STATUS_ERR;
+
+	policydb = &p->p;
+
+	/*
+	 * Kernel-format policydbs represent type<->attribute membership
+	 * via the derived attr_type_map/type_attr_map cross-reference
+	 * tables rather than type_datum->types (see type_datum_to_record()
+	 * below). This function only updates type_datum itself, so it
+	 * cannot correctly add or modify attribute membership -- and,
+	 * more importantly, cannot safely grow those tables when adding a
+	 * brand new type -- on such a policydb; refuse rather than risk
+	 * an inconsistent or corrupted policydb.
+	 */
+	if (policydb->policy_type == POLICY_KERN) {
+		ERR(handle,
+		    "sepol_type_modify is not supported on a kernel-format "
+		    "policydb");
+		return STATUS_ERR;
+	}
+
+	sepol_type_key_unpack(key, &cname);
+	if (!cname)
+		return STATUS_ERR;
+
+	flavor = sepol_type_get_flavor(data);
+	if (flavor == SEPOL_TYPE_ALIAS) {
+		ERR(handle, "sepol_type_modify does not support aliases");
+		return STATUS_ERR;
+	}
+
+	alias_of = sepol_type_get_alias_of(data);
+	if (alias_of) {
+		ERR(handle,
+		    "sepol_type_modify does not support setting alias-of "
+		    "on non-alias type %s",
+		    cname);
+		return STATUS_ERR;
+	}
+
+	bounds_name = sepol_type_get_bounds(data);
+
+	if (sepol_type_get_subtypes(handle, data, &subtypes, &num_subtypes))
+		return STATUS_ERR;
+
+	if (flavor != SEPOL_TYPE_ATTRIB && num_subtypes > 0) {
+		ERR(handle, "type %s is not an attribute but has member types",
+		    cname);
+		goto err;
+	}
+
+	/*
+	 * Resolve all name references before mutating the policydb, so a
+	 * lookup failure never leaves a partially constructed entry
+	 * behind.
+	 */
+	if (bounds_name) {
+		bounds_datum =
+			hashtab_search(policydb->p_types.table, bounds_name);
+		if (!bounds_datum) {
+			ERR(handle, "undefined bounds type %s for type %s",
+			    bounds_name, cname);
+			goto err;
+		}
+	}
+
+	for (i = 0; i < num_subtypes; i++) {
+		type_datum_t *subdatum =
+			hashtab_search(policydb->p_types.table, subtypes[i]);
+		if (!subdatum) {
+			ERR(handle, "undefined type %s for attribute %s",
+			    subtypes[i], cname);
+			goto err;
+		}
+		if (ebitmap_set_bit(&new_types, subdatum->s.value - 1, 1))
+			goto omem;
+	}
+
+	/*
+	 * All name references are validated and new_types is fully built;
+	 * only now do we look up (and possibly destroy/reinitialize) the
+	 * target type_datum. The only remaining fallible step below the
+	 * comment marker (allocation for a brand new type) leaves
+	 * `new_types` untouched, so on OOM a modified *existing* type is
+	 * never left blanked out -- it either fully succeeds or the
+	 * lookup/destroy never happened.
+	 */
+
+	/* See if the type already exists; if so, we will modify it */
+	typdatum = hashtab_search(policydb->p_types.table, cname);
+	if (typdatum) {
+		uint32_t value_cp = typdatum->s.value;
+		type_datum_destroy(typdatum);
+		type_datum_init(typdatum);
+		typdatum->s.value = value_cp;
+	} else {
+		typdatum = malloc(sizeof(type_datum_t));
+		if (!typdatum)
+			goto omem;
+		type_datum_init(typdatum);
+		new = 1;
+	}
+
+	/*
+	 * This function does not support aliases (rejected above), so the
+	 * result is always a genuine primary name rather than one sharing
+	 * another type's value.
+	 */
+	typdatum->primary = 1;
+	typdatum->flavor = (flavor == SEPOL_TYPE_ATTRIB) ? TYPE_ATTRIB :
+							   TYPE_TYPE;
+
+	if (sepol_type_has_flag(data, SEPOL_TYPE_FLAGS_PERMISSIVE))
+		typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
+	if (sepol_type_has_flag(data, SEPOL_TYPE_FLAGS_EXPAND_ATTR_TRUE))
+		typdatum->flags |= TYPE_FLAGS_EXPAND_ATTR_TRUE;
+	if (sepol_type_has_flag(data, SEPOL_TYPE_FLAGS_EXPAND_ATTR_FALSE))
+		typdatum->flags |= TYPE_FLAGS_EXPAND_ATTR_FALSE;
+
+	typdatum->bounds = bounds_datum ? bounds_datum->s.value : 0;
+
+	/* Transfer ownership of the validated subtype bitmap to typdatum */
+	typdatum->types = new_types;
+	ebitmap_init(&new_types);
+
+	/* If there were no errors, and this is a new type, add it to the policy */
+	if (new) {
+		void *tmp_ptr;
+
+		if (policydb->p_types.nprim == UINT32_MAX) {
+			ERR(handle, "too many types");
+			goto err;
+		}
+
+		/*
+		 * Prepare (but do not yet insert) a scope_datum for the new
+		 * type up front, alongside the rest of this function's
+		 * "resolve everything fallible before committing" style.
+		 * Mirrors symtab_insert()'s scope bookkeeping (policydb.c):
+		 * without a scope_datum, is_id_enabled() (avrule_block.c)
+		 * treats a type as "not declared", so it would otherwise be
+		 * silently dropped by any later expand_module()/
+		 * link_modules() call even though it is fully present in
+		 * p_types/type_val_to_struct. A type added through this
+		 * public API is always an unconditional, top-level
+		 * declaration -- there is no avrule-block/conditional
+		 * context here -- which is exactly decl_id 1, the id
+		 * checkpolicy assigns to the first declaration of a
+		 * policy's global avrule block (see module_compiler.c's
+		 * init_decl_stack()).
+		 */
+		scope_key = strdup(cname);
+		if (!scope_key)
+			goto omem;
+		scope_datum = malloc(sizeof(*scope_datum));
+		if (!scope_datum)
+			goto omem;
+		scope_datum->scope = SCOPE_DECL;
+		scope_datum->decl_ids = NULL;
+		scope_datum->decl_ids_len = 0;
+		if (add_i_to_a(1, &scope_datum->decl_ids_len,
+			       &scope_datum->decl_ids) == -1)
+			goto omem;
+
+		tmp_ptr = reallocarray(policydb->type_val_to_struct,
+				       policydb->p_types.nprim + 1,
+				       sizeof(type_datum_t *));
+		if (!tmp_ptr)
+			goto omem;
+		policydb->type_val_to_struct = tmp_ptr;
+		policydb->type_val_to_struct[policydb->p_types.nprim] = NULL;
+
+		tmp_ptr = reallocarray(policydb->sym_val_to_name[SYM_TYPES],
+				       policydb->p_types.nprim + 1,
+				       sizeof(char *));
+		if (!tmp_ptr)
+			goto omem;
+		policydb->sym_val_to_name[SYM_TYPES] = tmp_ptr;
+		policydb->p_type_val_to_name[policydb->p_types.nprim] = NULL;
+
+		name = strdup(cname);
+		if (!name)
+			goto omem;
+
+		typdatum->s.value = policydb->p_types.nprim + 1;
+		if (hashtab_insert(policydb->p_types.table, name,
+				   (hashtab_datum_t)typdatum) < 0)
+			goto omem;
+		policydb->p_types.nprim++;
+
+		policydb->p_type_val_to_name[typdatum->s.value - 1] = name;
+		policydb->type_val_to_struct[typdatum->s.value - 1] = typdatum;
+		name = NULL;
+
+		/* policydb now owns typdatum; error path must not free it */
+		new = 0;
+
+		/*
+		 * The type itself is now fully committed above; register
+		 * its scope so it survives a later expand/link pass. This
+		 * insert can only fail on OOM here -- scope[SYM_TYPES].table
+		 * and p_types.table are kept in lockstep by every insertion
+		 * path in this file and in policydb.c, so `cname` cannot
+		 * already be present. On that (OOM) failure the type is
+		 * left in the pre-existing documented, memory-safe-but-
+		 * inconsistent partially-populated state described in
+		 * types.h.
+		 */
+		if (hashtab_insert(policydb->scope[SYM_TYPES].table, scope_key,
+				   scope_datum) < 0)
+			goto omem;
+		scope_key = NULL;
+		scope_datum = NULL;
+	}
+
+	free(subtypes);
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+err:
+	ERR(handle, "could not load type %s into policy", cname);
+	free(name);
+	free(subtypes);
+	ebitmap_destroy(&new_types);
+	free(scope_key);
+	if (scope_datum) {
+		free(scope_datum->decl_ids);
+		free(scope_datum);
+	}
+	if (new && typdatum) {
+		type_datum_destroy(typdatum);
+		free(typdatum);
+	}
+	return STATUS_ERR;
+}
+
+DEFINE_VALUE_TO_NAME(sepol_type_value_to_name, "type", p_types,
+		     p_type_val_to_name)
+
+int sepol_type_query_by_value(sepol_handle_t *handle, const sepol_policydb_t *p,
+			      uint32_t value, sepol_type_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	if (value < 1 || value > p->p.p_types.nprim) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	type_datum_t *type_datum = p->p.type_val_to_struct[value - 1];
+	if (!type_datum) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return type_datum_to_record(handle, &p->p, type_datum, NULL, response);
+}
+
+/* Return the number of types */
+int sepol_type_count(sepol_handle_t *handle __attribute__((unused)),
+		     const sepol_policydb_t *p, unsigned int *response)
+{
+	if (!p || !response)
+		return STATUS_ERR;
+
+	*response = p->p.p_types.table->nel;
+	return STATUS_SUCCESS;
+}
+
+/* Check if the specified type exists */
+int sepol_type_exists(sepol_handle_t *handle __attribute__((unused)),
+		      const sepol_policydb_t *policydb,
+		      const sepol_type_key_t *key, int *response)
+{
+	if (!policydb || !response)
+		return STATUS_ERR;
+
+	const char *name;
+	sepol_type_key_unpack(key, &name);
+
+	*response = name &&
+		    hashtab_search(policydb->p.p_types.table, name) != NULL;
+
+	return STATUS_SUCCESS;
+}
+
+/* Query a type - returns the type or NULL if not found */
+int sepol_type_query(sepol_handle_t *handle, const sepol_policydb_t *p,
+		     const sepol_type_key_t *key, sepol_type_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	const char *name;
+	sepol_type_key_unpack(key, &name);
+
+	if (!name) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	type_datum_t *type_datum = hashtab_search(p->p.p_types.table, name);
+	if (!type_datum) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return type_datum_to_record(handle, &p->p, type_datum, name, response);
+}
+
+/* Iterators */
+int sepol_type_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   sepol_type_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		ERR(handle, "invalid argument to sepol_type_iter_create");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	sepol_type_iter_t *new = malloc(sizeof(sepol_type_iter_t));
+	if (!new) {
+		ERR(handle, "cannot allocate memory for sepol_type_iter_t");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	new->p = p;
+	hashtab_iter_init(p->p.p_types.table, &new->hashtab_iter);
+
+	*iter = new;
+
+	return STATUS_SUCCESS;
+}
+
+void sepol_type_iter_destroy(sepol_type_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_type_iter_next(sepol_handle_t *handle, sepol_type_iter_t *iter,
+			 sepol_type_t **item)
+{
+	char *key;
+	type_datum_t *datum;
+
+	if (!item)
+		return STATUS_ERR;
+	if (!iter) {
+		*item = NULL;
+		return STATUS_ERR;
+	}
+
+	hashtab_iter_next(&iter->hashtab_iter, &key, (hashtab_datum_t *)&datum);
+	if (!key) {
+		*item = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return type_datum_to_record(handle, &iter->p->p, datum, key, item);
+}
-- 
2.55.0

