Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB8456E10
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291860; cv=none; b=iNpyHVj2s77TmEvyLFmT0h4KNdQ3ieLyA2OXEjRUdJ3gAZaDSrnSr5bx0FhKBJ7GR8CTEQ8lzTOhpgX53mbR47p0vIyGvf3KrU+4YdHN7nObhqXoCPGwEQFSVPCeGjnsWxT+A+PB67bltPJeLKRJXmwaXf9IhX2k/LwkPyYUJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291860; c=relaxed/simple;
	bh=1+78wfiqynhgI4EQf3b7k2d8wIMc61e/P8GFxsD+Z4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhLed1sXiW27L3SEygz7vqeMnkq1WdPNJbt/N8mNx+6gfpXcBeLaTm5CnMTGk3nFICYvDSudbVrNuAJSHlkByCPSNFaQOzUevHdpBoWsXZDmBct44T84SryQbBFd5MI5C5eve8RBRfW2GI6rgsr1JRCsNys+87+H1sDobOmS/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8j34f7r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8j34f7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqEDHRVTy2YWbcJpUzVCtqB9/WhCe2oU23uZQj/ZD0I=;
	b=J8j34f7raDt4pdwgDEFQc6feVLZyKA+zm35MnEuNlG4JLVUiKhGoCp2U3Qnl587CMRHeOS
	3Ev8eC1Fve+DDh7QrlVXRzr4jgUbGFXM4BtFhr0XZd6nzijyp1Q2y4HbJW4gxKb6g/JByB
	WFtfDYP08cC8yX8FUnaxZ/XlpAx96Vg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-zYHuwnmpNemKvrfbhqkgsQ-1; Tue,
 06 Oct 2026 09:04:14 -0400
X-MC-Unique: zYHuwnmpNemKvrfbhqkgsQ-1
X-Mimecast-MFC-AGG-ID: zYHuwnmpNemKvrfbhqkgsQ_1791291853
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DCBF1830304;
	Tue,  6 Oct 2026 13:04:13 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F1C61956047;
	Tue,  6 Oct 2026 13:04:12 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 06/17] libsepol: add public role record structure and iterator
Date: Tue,  6 Oct 2026 15:02:04 +0200
Message-ID: <20261006130215.128405-7-jjanasek@redhat.com>
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

Introduce sepol_role_t with getter/setter API for role name, value,
type membership, dominance, bounds, and flavor. Add sepol_role_iter,
sepol_role_value_to_name(), and sepol_role_query_by_value().

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/role_record.h        |  79 +++++
 libsepol/include/sepol/roles.h              |  57 ++++
 libsepol/src/role_record.c                  | 316 ++++++++++++++++++++
 libsepol/src/roles.c                        | 253 ++++++++++++++++
 libsepol/tests/policies/test-iter/iter.conf |   2 +
 libsepol/tests/test-iter-roles.c            | 165 ++++++++++
 libsepol/tests/test-iter-roles.h            |   7 +
 libsepol/tests/test-iter.c                  |   7 +
 8 files changed, 886 insertions(+)
 create mode 100644 libsepol/include/sepol/role_record.h
 create mode 100644 libsepol/include/sepol/roles.h
 create mode 100644 libsepol/src/role_record.c
 create mode 100644 libsepol/src/roles.c
 create mode 100644 libsepol/tests/test-iter-roles.c
 create mode 100644 libsepol/tests/test-iter-roles.h

diff --git a/libsepol/include/sepol/role_record.h b/libsepol/include/sepol/role_record.h
new file mode 100644
index 00000000..4498a126
--- /dev/null
+++ b/libsepol/include/sepol/role_record.h
@@ -0,0 +1,79 @@
+#ifndef _SEPOL_ROLE_RECORD_H_
+#define _SEPOL_ROLE_RECORD_H_
+
+#include <stdint.h>
+
+#include <sepol/handle.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sepol_role;
+typedef struct sepol_role sepol_role_t;
+struct sepol_role_key;
+typedef struct sepol_role_key sepol_role_key_t;
+
+/* Key */
+extern int sepol_role_key_create(sepol_handle_t *handle, const char *name,
+				 sepol_role_key_t **key);
+extern void sepol_role_key_unpack(const sepol_role_key_t *key,
+				  const char **name);
+extern int sepol_role_key_extract(sepol_handle_t *handle,
+				  const sepol_role_t *role,
+				  sepol_role_key_t **key);
+extern void sepol_role_key_free(sepol_role_key_t *key);
+
+extern int sepol_role_compare(const sepol_role_t *role,
+			      const sepol_role_key_t *key);
+extern int sepol_role_compare2(const sepol_role_t *role,
+			       const sepol_role_t *role2);
+
+/* Role name */
+extern const char *sepol_role_get_name(const sepol_role_t *role);
+extern int sepol_role_set_name(sepol_handle_t *handle, sepol_role_t *role,
+			       const char *name);
+
+/* Authorized types */
+extern int sepol_role_has_type(const sepol_role_t *role, const char *type);
+extern int sepol_role_get_types(sepol_handle_t *handle,
+				const sepol_role_t *role, const char ***types,
+				uint32_t *num_types);
+extern int sepol_role_add_type(sepol_handle_t *handle, sepol_role_t *role,
+			       const char *type);
+extern int sepol_role_del_type(sepol_handle_t *handle, sepol_role_t *role,
+			       const char *type);
+
+/* Bounds role */
+extern const char *sepol_role_get_bounds(const sepol_role_t *role);
+extern int sepol_role_set_bounds(sepol_handle_t *handle, sepol_role_t *role,
+				 const char *bounds);
+
+/* Flavor */
+#define SEPOL_ROLE_ROLE 0
+#define SEPOL_ROLE_ATTRIB 1
+extern uint32_t sepol_role_get_flavor(const sepol_role_t *role);
+extern int sepol_role_set_flavor(sepol_handle_t *handle, sepol_role_t *role,
+				 uint32_t flavor);
+
+/* Subroles in attribute */
+extern int sepol_role_get_subroles(sepol_handle_t *handle,
+				   const sepol_role_t *role,
+				   const char ***subroles,
+				   uint32_t *num_subroles);
+extern int sepol_role_add_subrole(sepol_handle_t *handle, sepol_role_t *role,
+				  const char *subrole);
+extern int sepol_role_del_subrole(sepol_handle_t *handle, sepol_role_t *role,
+				  const char *subrole);
+
+/* Create/Clone/Destroy */
+extern int sepol_role_create(sepol_handle_t *handle, sepol_role_t **role_ptr);
+extern int sepol_role_clone(sepol_handle_t *handle, const sepol_role_t *role,
+			    sepol_role_t **role_ptr);
+extern void sepol_role_free(sepol_role_t *role);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/roles.h b/libsepol/include/sepol/roles.h
new file mode 100644
index 00000000..f371755f
--- /dev/null
+++ b/libsepol/include/sepol/roles.h
@@ -0,0 +1,57 @@
+#ifndef _SEPOL_ROLES_H_
+#define _SEPOL_ROLES_H_
+
+#include <sepol/policydb.h>
+#include <sepol/role_record.h>
+#include <sepol/handle.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sepol_role_iter;
+typedef struct sepol_role_iter sepol_role_iter_t;
+
+/* Return the number of roles */
+extern int sepol_role_count(sepol_handle_t *handle, const sepol_policydb_t *p,
+			    unsigned int *response);
+
+/* Check if the specified role exists */
+extern int sepol_role_exists(sepol_handle_t *handle, const sepol_policydb_t *p,
+			     const sepol_role_key_t *key, int *response);
+
+/* Query a role - returns the role or NULL if not found */
+extern int sepol_role_query(sepol_handle_t *handle, const sepol_policydb_t *p,
+			    const sepol_role_key_t *key,
+			    sepol_role_t **response);
+
+/* Resolve a role value to its name.  Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_role_value_to_name(sepol_handle_t *handle,
+				    const sepol_policydb_t *p, uint32_t value,
+				    const char **name);
+
+/* Query a role by value - returns the role or NULL if not found */
+extern int sepol_role_query_by_value(sepol_handle_t *handle,
+				     const sepol_policydb_t *p, uint32_t value,
+				     sepol_role_t **response);
+
+/*
+ * Iterating roles. Iteration order follows ascending internal value
+ * assignment, which typically -- but is not guaranteed to -- match
+ * declaration order; callers should not treat it as a stable guarantee
+ * across policydb versions.
+ */
+extern int sepol_role_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_role_iter_t **iter);
+extern void sepol_role_iter_destroy(sepol_role_iter_t *iter);
+extern int sepol_role_iter_next(sepol_handle_t *handle, sepol_role_iter_t *iter,
+				sepol_role_t **item);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/role_record.c b/libsepol/src/role_record.c
new file mode 100644
index 00000000..cbc8f774
--- /dev/null
+++ b/libsepol/src/role_record.c
@@ -0,0 +1,316 @@
+#include <sepol/role_record.h>
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "sepol/policydb/util.h"
+#include "debug.h"
+
+struct sepol_role {
+	char *name; /* role name */
+	char **types; /* authorized types */
+	uint32_t num_types;
+	char *bounds; /* bounded role */
+	uint32_t flavor; /* role or attribute */
+	char **subroles; /* roles within attribute */
+	uint32_t num_subroles;
+};
+
+struct sepol_role_key {
+	char *name;
+};
+
+/* Key */
+int sepol_role_key_create(sepol_handle_t *handle, const char *name,
+			  sepol_role_key_t **key)
+{
+	if (!key)
+		return STATUS_ERR;
+	if (!name) {
+		ERR(handle, "name is NULL");
+		*key = NULL;
+		return STATUS_ERR;
+	}
+	sepol_role_key_t *tmp_key = malloc(sizeof(sepol_role_key_t));
+	if (!tmp_key)
+		goto omem;
+	tmp_key->name = strdup(name);
+	if (!tmp_key->name)
+		goto omem;
+
+	*key = tmp_key;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+	free(tmp_key);
+	*key = NULL;
+	return STATUS_ERR;
+}
+
+void sepol_role_key_unpack(const sepol_role_key_t *key, const char **name)
+{
+	*name = key ? key->name : NULL;
+}
+
+int sepol_role_key_extract(sepol_handle_t *handle, const sepol_role_t *role,
+			   sepol_role_key_t **key)
+{
+	if (!role) {
+		ERR(handle, "role is NULL");
+		return STATUS_ERR;
+	}
+	if (!role->name) {
+		ERR(handle, "role name is NULL");
+		return STATUS_ERR;
+	}
+	return sepol_role_key_create(handle, role->name, key);
+}
+
+void sepol_role_key_free(sepol_role_key_t *key)
+{
+	if (!key)
+		return;
+	free(key->name);
+	free(key);
+}
+
+int sepol_role_compare(const sepol_role_t *role, const sepol_role_key_t *key)
+{
+	if (!role || !key || !role->name || !key->name)
+		return -1;
+	return strcmp(role->name, key->name);
+}
+
+int sepol_role_compare2(const sepol_role_t *role, const sepol_role_t *role2)
+{
+	if (!role || !role2 || !role->name || !role2->name)
+		return -1;
+	return strcmp(role->name, role2->name);
+}
+
+/* Role name */
+const char *sepol_role_get_name(const sepol_role_t *role)
+{
+	return role ? role->name : NULL;
+}
+
+int sepol_role_set_name(sepol_handle_t *handle, sepol_role_t *role,
+			const char *name)
+{
+	if (!role || !name) {
+		ERR(handle, "role or name is NULL");
+		return STATUS_ERR;
+	}
+	char *tmp_name = strdup(name);
+	if (!tmp_name) {
+		ERR(handle, "out of memory, could not set name");
+		return STATUS_ERR;
+	}
+	free(role->name);
+	role->name = tmp_name;
+	return STATUS_SUCCESS;
+}
+
+/* Authorized types */
+int sepol_role_has_type(const sepol_role_t *role, const char *type)
+{
+	if (!role)
+		return 0;
+	return string_list_contains(role->types, role->num_types, type);
+}
+
+int sepol_role_get_types(sepol_handle_t *handle, const sepol_role_t *role,
+			 const char ***types, uint32_t *num_types)
+{
+	if (!types || !num_types)
+		return STATUS_ERR;
+	if (!role) {
+		*types = NULL;
+		*num_types = 0;
+		return STATUS_ERR;
+	}
+	return string_list_scopy(handle, role->types, role->num_types, types,
+				 num_types);
+}
+
+int sepol_role_add_type(sepol_handle_t *handle, sepol_role_t *role,
+			const char *type)
+{
+	if (!role) {
+		ERR(handle, "role is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_add_unique(handle, &role->types, &role->num_types,
+				      type);
+}
+
+int sepol_role_del_type(sepol_handle_t *handle, sepol_role_t *role,
+			const char *type)
+{
+	if (!role) {
+		ERR(handle, "role is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_del(role->types, &role->num_types, type);
+}
+
+/* Bounds role */
+const char *sepol_role_get_bounds(const sepol_role_t *role)
+{
+	return role ? role->bounds : NULL;
+}
+
+int sepol_role_set_bounds(sepol_handle_t *handle, sepol_role_t *role,
+			  const char *bounds)
+{
+	if (!role) {
+		ERR(handle, "role is NULL");
+		return STATUS_ERR;
+	}
+
+	if (!bounds) {
+		free(role->bounds);
+		role->bounds = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	char *tmp_bounds = strdup(bounds);
+	if (!tmp_bounds) {
+		ERR(handle, "out of memory");
+		return STATUS_ERR;
+	}
+
+	free(role->bounds);
+	role->bounds = tmp_bounds;
+
+	return STATUS_SUCCESS;
+}
+
+/* Flavor */
+uint32_t sepol_role_get_flavor(const sepol_role_t *role)
+{
+	return role ? role->flavor : 0;
+}
+
+int sepol_role_set_flavor(sepol_handle_t *handle, sepol_role_t *role,
+			  uint32_t flavor)
+{
+	if (!role) {
+		ERR(handle, "role is NULL");
+		return STATUS_ERR;
+	}
+	role->flavor = flavor;
+	return STATUS_SUCCESS;
+}
+
+/* Subroles in attribute */
+int sepol_role_get_subroles(sepol_handle_t *handle, const sepol_role_t *role,
+			    const char ***subroles, uint32_t *num_subroles)
+{
+	if (!subroles || !num_subroles)
+		return STATUS_ERR;
+	if (!role) {
+		*subroles = NULL;
+		*num_subroles = 0;
+		return STATUS_ERR;
+	}
+	return string_list_scopy(handle, role->subroles, role->num_subroles,
+				 subroles, num_subroles);
+}
+
+int sepol_role_add_subrole(sepol_handle_t *handle, sepol_role_t *role,
+			   const char *subrole)
+{
+	if (!role) {
+		ERR(handle, "role is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_add_unique(handle, &role->subroles,
+				      &role->num_subroles, subrole);
+}
+
+int sepol_role_del_subrole(sepol_handle_t *handle, sepol_role_t *role,
+			   const char *subrole)
+{
+	if (!role) {
+		ERR(handle, "role is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_del(role->subroles, &role->num_subroles, subrole);
+}
+
+/* Create/Clone/Destroy */
+int sepol_role_create(sepol_handle_t *handle, sepol_role_t **role_ptr)
+{
+	sepol_role_t *tmp;
+
+	if (!role_ptr)
+		return STATUS_ERR;
+
+	tmp = malloc(sizeof(sepol_role_t));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*role_ptr = NULL;
+		return STATUS_ERR;
+	}
+	memset(tmp, 0, sizeof(sepol_role_t));
+	*role_ptr = tmp;
+	return STATUS_SUCCESS;
+}
+
+int sepol_role_clone(sepol_handle_t *handle, const sepol_role_t *role,
+		     sepol_role_t **role_ptr)
+{
+	if (!role_ptr)
+		return STATUS_ERR;
+	if (!role) {
+		*role_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_role_t *tmp = NULL;
+	if (sepol_role_create(handle, &tmp))
+		goto err;
+
+	if (sepol_role_set_name(handle, tmp, role->name))
+		goto err;
+	for (size_t i = 0; i < role->num_types; i++) {
+		if (sepol_role_add_type(handle, tmp, role->types[i]))
+			goto err;
+	}
+	if (sepol_role_set_bounds(handle, tmp, role->bounds))
+		goto err;
+	for (size_t i = 0; i < role->num_subroles; i++) {
+		if (sepol_role_add_subrole(handle, tmp, role->subroles[i]))
+			goto err;
+	}
+
+	if (sepol_role_set_flavor(handle, tmp, role->flavor))
+		goto err;
+
+	*role_ptr = tmp;
+	return STATUS_SUCCESS;
+
+err:
+	sepol_role_free(tmp);
+	*role_ptr = NULL;
+	return STATUS_ERR;
+}
+
+void sepol_role_free(sepol_role_t *role)
+{
+	if (!role)
+		return;
+
+	free(role->name);
+	for (size_t i = 0; i < role->num_types; i++)
+		free(role->types[i]);
+	free(role->types);
+	free(role->bounds);
+	for (size_t i = 0; i < role->num_subroles; i++)
+		free(role->subroles[i]);
+	free(role->subroles);
+	free(role);
+}
diff --git a/libsepol/src/roles.c b/libsepol/src/roles.c
new file mode 100644
index 00000000..535ca28b
--- /dev/null
+++ b/libsepol/src/roles.c
@@ -0,0 +1,253 @@
+#include <sepol/roles.h>
+
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/policydb.h>
+
+#include "debug.h"
+#include "private.h"
+
+struct sepol_role_iter {
+	const policydb_t *policydb;
+	uint32_t idx;
+};
+
+static int role_datum_to_record(sepol_handle_t *handle,
+				const policydb_t *policydb,
+				const role_datum_t *role_datum,
+				sepol_role_t **record)
+{
+	sepol_role_t *new_role = NULL;
+
+	if (role_datum->s.value == 0 ||
+	    role_datum->s.value > policydb->p_roles.nprim) {
+		*record = NULL;
+		return STATUS_ERR;
+	}
+
+	if (sepol_role_create(handle, &new_role))
+		goto err;
+
+	if (sepol_role_set_name(
+		    handle, new_role,
+		    policydb->p_role_val_to_name[role_datum->s.value - 1]))
+		goto err;
+
+	/*
+	 * role_datum->types is a type_set_t: its .types ebitmap alone is
+	 * only the *positive* member list as written in policy source and
+	 * is incomplete whenever the role's type set uses "*"/"~" wildcards
+	 * or attribute negation (role_datum->types.flags / .negset). Expand
+	 * it the same way the rest of libsepol does (see policydb_role_cache()
+	 * populating role_datum->cache) to get the actual, fully resolved
+	 * type membership rather than silently reporting a partial set.
+	 */
+	ebitmap_t expanded_types;
+	if (type_set_expand((type_set_t *)&role_datum->types, &expanded_types,
+			    (policydb_t *)policydb, 1)) {
+		/*
+		 * type_set_expand() always ebitmap_init()s expanded_types
+		 * before it can fail, and may have partially populated it
+		 * before hitting the failure (e.g. OOM partway through a
+		 * negated/attribute type set); destroy it here rather than
+		 * leaking those ebitmap nodes.
+		 */
+		ebitmap_destroy(&expanded_types);
+		goto err;
+	}
+
+	ebitmap_node_t *enode;
+	uint32_t bit;
+	ebitmap_for_each_positive_bit(&expanded_types, enode, bit) {
+		if (bit >= policydb->p_types.nprim) {
+			ebitmap_destroy(&expanded_types);
+			goto err;
+		}
+		if (sepol_role_add_type(handle, new_role,
+					policydb->p_type_val_to_name[bit])) {
+			ebitmap_destroy(&expanded_types);
+			goto err;
+		}
+	}
+	ebitmap_destroy(&expanded_types);
+
+	if (role_datum->bounds &&
+	    (role_datum->bounds > policydb->p_roles.nprim ||
+	     sepol_role_set_bounds(
+		     handle, new_role,
+		     policydb->p_role_val_to_name[role_datum->bounds - 1])))
+		goto err;
+
+	switch (role_datum->flavor) {
+	case ROLE_ROLE:
+		if (sepol_role_set_flavor(handle, new_role, SEPOL_ROLE_ROLE))
+			goto err;
+		break;
+	case ROLE_ATTRIB:
+		if (sepol_role_set_flavor(handle, new_role, SEPOL_ROLE_ATTRIB))
+			goto err;
+		break;
+	default:
+		/*
+		 * role_datum->flavor is read straight from the binary
+		 * policy (policydb_read()) without being validated against
+		 * this enum, so a corrupt/crafted policy could carry an
+		 * out-of-range value here. Reject it explicitly instead of
+		 * silently reporting the zero-initialized ROLE_ROLE default
+		 * from sepol_role_create(), which would misrepresent the
+		 * actual on-disk data to API callers.
+		 */
+		goto err;
+	}
+
+	ebitmap_for_each_positive_bit(&role_datum->roles, enode, bit) {
+		if (bit >= policydb->p_roles.nprim)
+			goto err;
+		if (sepol_role_add_subrole(handle, new_role,
+					   policydb->p_role_val_to_name[bit]))
+			goto err;
+	}
+
+	*record = new_role;
+	return STATUS_SUCCESS;
+
+err:
+	*record = NULL;
+	sepol_role_free(new_role);
+	return STATUS_ERR;
+}
+
+DEFINE_VALUE_TO_NAME(sepol_role_value_to_name, "role", p_roles,
+		     p_role_val_to_name)
+
+int sepol_role_query_by_value(sepol_handle_t *handle, const sepol_policydb_t *p,
+			      uint32_t value, sepol_role_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	if (value < 1 || value > p->p.p_roles.nprim) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	role_datum_t *role_datum = p->p.role_val_to_struct[value - 1];
+	if (!role_datum) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return role_datum_to_record(handle, &p->p, role_datum, response);
+}
+
+int sepol_role_count(sepol_handle_t *handle __attribute__((unused)),
+		     const sepol_policydb_t *p, unsigned int *response)
+{
+	if (!p || !response)
+		return STATUS_ERR;
+
+	*response = p->p.p_roles.table->nel;
+	return STATUS_SUCCESS;
+}
+
+int sepol_role_exists(sepol_handle_t *handle __attribute__((unused)),
+		      const sepol_policydb_t *p, const sepol_role_key_t *key,
+		      int *response)
+{
+	if (!p || !response)
+		return STATUS_ERR;
+
+	const char *name;
+	sepol_role_key_unpack(key, &name);
+
+	*response = name && (hashtab_search(p->p.p_roles.table, name) != NULL);
+
+	return STATUS_SUCCESS;
+}
+
+int sepol_role_query(sepol_handle_t *handle, const sepol_policydb_t *p,
+		     const sepol_role_key_t *key, sepol_role_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	const char *name;
+	sepol_role_key_unpack(key, &name);
+
+	if (!name) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	role_datum_t *role_datum = hashtab_search(p->p.p_roles.table, name);
+	if (!role_datum) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return role_datum_to_record(handle, &p->p, role_datum, response);
+}
+
+int sepol_role_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   sepol_role_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		ERR(handle, "invalid argument to sepol_role_iter_create");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	sepol_role_iter_t *tmp = malloc(sizeof(sepol_role_iter_t));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	tmp->policydb = &p->p;
+	tmp->idx = 0;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_role_iter_destroy(sepol_role_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_role_iter_next(sepol_handle_t *handle, sepol_role_iter_t *iter,
+			 sepol_role_t **item)
+{
+	if (!item)
+		return STATUS_ERR;
+	if (!iter) {
+		*item = NULL;
+		return STATUS_ERR;
+	}
+
+	while (iter->idx < iter->policydb->p_roles.nprim) {
+		role_datum_t *datum =
+			iter->policydb->role_val_to_struct[iter->idx];
+		iter->idx++;
+		if (datum) {
+			sepol_role_t *role;
+			int status = role_datum_to_record(
+				handle, iter->policydb, datum, &role);
+			*item = role;
+			if (status)
+				return status;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*item = NULL;
+	return STATUS_SUCCESS;
+}
diff --git a/libsepol/tests/policies/test-iter/iter.conf b/libsepol/tests/policies/test-iter/iter.conf
index 2c27f9d4..fd27f5e0 100644
--- a/libsepol/tests/policies/test-iter/iter.conf
+++ b/libsepol/tests/policies/test-iter/iter.conf
@@ -80,6 +80,8 @@ role ROLE1;
 role ROLE1 types { TYPE1 };
 role ROLE2;
 role ROLE2 types { TYPE2 };
+role ROLE3;
+role ROLE3 types { ATTR1 -TYPE3 };
 
 attribute_role ATTR_ROLE1;
 roleattribute ROLE1 ATTR_ROLE1;
diff --git a/libsepol/tests/test-iter-roles.c b/libsepol/tests/test-iter-roles.c
new file mode 100644
index 00000000..e84a9b63
--- /dev/null
+++ b/libsepol/tests/test-iter-roles.c
@@ -0,0 +1,165 @@
+#include "test-iter-roles.h"
+
+#include <CUnit/CUnit.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/policydb.h>
+#include <sepol/role_record.h>
+#include <sepol/roles.h>
+
+#include "helpers.h"
+
+extern sepol_handle_t *handle;
+extern sepol_policydb_t *empty_policy;
+extern sepol_policydb_t *iter_policy;
+
+struct expected_role {
+	int seen;
+
+	const char *name;
+	uint32_t ntypes;
+	const char *types[32]; /* authorized types */
+	char *bounds; /* bounded role */
+	uint32_t flavor; /* role or attribute */
+	uint32_t nsubroles;
+	const char *subroles[32]; /* roles within attribute */
+};
+
+struct expected_role expected_roles[] = {
+	{ 0, "ROLE1", 1, { "TYPE1" }, NULL, SEPOL_ROLE_ROLE, 0, {} },
+	{ 0, "ROLE2", 1, { "TYPE2" }, NULL, SEPOL_ROLE_ROLE, 0, {} },
+	/*
+	 * ROLE3's types are declared as "{ ATTR1 -TYPE3 }" (iter.conf), where
+	 * ATTR1 itself has members { TYPE2, TYPE3 }. This only resolves to
+	 * the correct authorized type set, { TYPE2 }, if the attribute
+	 * membership is expanded and the negset subtraction is applied
+	 * (type_set_expand()); naively reading type_set_t.types verbatim
+	 * would instead report a single bogus "type" named "ATTR1".
+	 */
+	{ 0, "ROLE3", 1, { "TYPE2" }, NULL, SEPOL_ROLE_ROLE, 0, {} },
+	{ 0,
+	  "ATTR_ROLE1",
+	  0,
+	  {},
+	  NULL,
+	  SEPOL_ROLE_ATTRIB,
+	  2,
+	  { "ROLE1", "ROLE2" } },
+	{ 0, "object_r", 0, {}, NULL, SEPOL_ROLE_ROLE, 0, {} },
+	{ 0, NULL, 0, {}, NULL, 0, 0, {} },
+};
+
+static void unseen(void)
+{
+	for (struct expected_role *e = expected_roles; e->name; e++) {
+		e->seen = 0;
+	}
+}
+
+static void seen(const sepol_role_t *item)
+{
+	const char *actual_name = sepol_role_get_name(item);
+	uint32_t nactual_types;
+	const char **actual_types;
+	CU_ASSERT_EQUAL_FATAL(sepol_role_get_types(handle, item, &actual_types,
+						   &nactual_types),
+			      0);
+	uint32_t actual_flavor = sepol_role_get_flavor(item);
+	const char *actual_bounds = sepol_role_get_bounds(item);
+	uint32_t nactual_subroles;
+	const char **actual_subroles;
+	CU_ASSERT_EQUAL_FATAL(sepol_role_get_subroles(handle, item,
+						      &actual_subroles,
+						      &nactual_subroles),
+			      0);
+
+	struct expected_role *e;
+	for (e = expected_roles; e->name; e++) {
+		if (strcmp(actual_name, e->name) == 0)
+			break;
+	}
+	CU_ASSERT_PTR_NOT_NULL_FATAL(e->name);
+	e->seen = 1;
+
+	CU_ASSERT_EQUAL(nactual_types, e->ntypes);
+	/* qsort()'s base is declared nonnull; skip the call entirely for
+	 * an empty (possibly NULL) array rather than relying on nmemb==0
+	 * making the NULL harmless. */
+	if (nactual_types > 0)
+		qsort(actual_types, nactual_types, sizeof(char *), qstrcmp);
+	for (size_t i = 0; i < nactual_types && i < e->ntypes; i++) {
+		CU_ASSERT_STRING_EQUAL(actual_types[i], e->types[i]);
+	}
+
+	CU_ASSERT_EQUAL(actual_flavor, e->flavor);
+
+	CU_ASSERT_EQUAL(nactual_subroles, e->nsubroles);
+	/* qsort()'s base is declared nonnull; skip the call entirely for
+	 * an empty (possibly NULL) array rather than relying on nmemb==0
+	 * making the NULL harmless. */
+	if (nactual_subroles > 0)
+		qsort(actual_subroles, nactual_subroles, sizeof(char *),
+		      qstrcmp);
+	for (size_t i = 0; i < nactual_subroles && i < e->nsubroles; i++) {
+		CU_ASSERT_STRING_EQUAL(actual_subroles[i], e->subroles[i]);
+	}
+
+	if (e->bounds) {
+		CU_ASSERT_STRING_EQUAL(actual_bounds, e->bounds);
+	} else {
+		CU_ASSERT_PTR_NULL(actual_bounds);
+	}
+
+	free(actual_types);
+	free(actual_subroles);
+}
+
+void test_iter_roles_empty(void)
+{
+	sepol_role_iter_t *role_iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_role_iter_create(handle, empty_policy, &role_iter), 0);
+
+	/* object_r is always implicitly defined, so drain it */
+	sepol_role_t *item;
+	int count = 0;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(
+			sepol_role_iter_next(handle, role_iter, &item), 0);
+		if (!item)
+			break;
+		sepol_role_free(item);
+		count++;
+	}
+	CU_ASSERT(count <= 1);
+
+	sepol_role_iter_destroy(role_iter);
+}
+
+void test_iter_roles_non_empty(void)
+{
+	unseen();
+	sepol_role_t *item;
+	sepol_role_iter_t *role_iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_role_iter_create(handle, iter_policy, &role_iter), 0);
+
+	while (1) {
+		CU_ASSERT_EQUAL(sepol_role_iter_next(handle, role_iter, &item),
+				0);
+		if (!item)
+			break;
+		seen(item);
+		sepol_role_free(item);
+	}
+	CU_ASSERT_EQUAL(sepol_role_iter_next(handle, role_iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+
+	for (struct expected_role *e = expected_roles; e->name; e++) {
+		CU_ASSERT_TRUE(e->seen);
+	}
+
+	sepol_role_iter_destroy(role_iter);
+}
diff --git a/libsepol/tests/test-iter-roles.h b/libsepol/tests/test-iter-roles.h
new file mode 100644
index 00000000..dd5f2fdc
--- /dev/null
+++ b/libsepol/tests/test-iter-roles.h
@@ -0,0 +1,7 @@
+#ifndef TEST_ITER_ROLES_H
+#define TEST_ITER_ROLES_H
+
+void test_iter_roles_empty(void);
+void test_iter_roles_non_empty(void);
+
+#endif
diff --git a/libsepol/tests/test-iter.c b/libsepol/tests/test-iter.c
index 83308d4d..7c58c36d 100644
--- a/libsepol/tests/test-iter.c
+++ b/libsepol/tests/test-iter.c
@@ -12,6 +12,7 @@
 #include "parse_util.h"
 #include "test-iter-types.h"
 #include "test-iter-users.h"
+#include "test-iter-roles.h"
 
 extern int mls;
 
@@ -99,5 +100,11 @@ int iter_add_tests(CU_pSuite suite)
 	if (CU_add_test(suite, "iter_users_non_empty",
 			test_iter_users_non_empty) == NULL)
 		return CU_get_error();
+	if (CU_add_test(suite, "iter_roles_empty", test_iter_roles_empty) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "iter_roles_non_empty",
+			test_iter_roles_non_empty) == NULL)
+		return CU_get_error();
 	return 0;
 }
-- 
2.55.0

