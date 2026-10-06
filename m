Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82A4570E2
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291861; cv=none; b=cSPPCTgFBO1PxkOdSzwYMMPYgkhwef/AoZf6lq9m31on5bJ2p6hgndG2sW/JAtEnDMsnqOnCLx7M7CahSDbOZ4OODpZToDj6M4Yy0ehN/I/yO2o1gJ2blVxsX2HnOI6lFMBLstlqmP//jJn91Zz//BLyJH0lQDB0GD53GdJM+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291861; c=relaxed/simple;
	bh=GJECM8zxavUDRIQRpbuTYvT90bf6shuf+81roTvyVP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRjBPH+IsNJC6BfDwwhtMvNfNRJgK8McG/ENh4tJCIXW+v7q8oNE3PIgRJHveBm1ooilbtQWQmH2eDD4ITOU++aNpwZ1q94S65i+V/aK+e9vueLPc3wnF9GWEK4WncDoWEs2s80ZWPaPtwBmSLf+/NjKIx85QR14xHwKyLCcOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVP+JKSC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVP+JKSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NncJfeu0cM/fhxU/40gzkUMAlKh9JzZFR9hxT2ZqkUU=;
	b=MVP+JKSCi/AZ0R/qD0pec6h48ewaLiIVfmn1gk+ug6TmDyR+7it5ba1eQyXIHVxhYBIvXU
	BMlamm5KjpZQvd/gf6pqcLzBBwlgtnbaY7/VFTfsHGVEFPsMOZCg5Vlc80hfRMgU2SsLf3
	kAj2ba/xBIVR/U742TJf+WSxmhpVXkw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-wrA5Wm2qOJWOdDKDD04NMw-1; Tue,
 06 Oct 2026 09:04:16 -0400
X-MC-Unique: wrA5Wm2qOJWOdDKDD04NMw-1
X-Mimecast-MFC-AGG-ID: wrA5Wm2qOJWOdDKDD04NMw_1791291856
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E14911844BD7;
	Tue,  6 Oct 2026 13:04:15 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3E6D1956047;
	Tue,  6 Oct 2026 13:04:14 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 07/17] libsepol: add public class record structure
Date: Tue,  6 Oct 2026 15:02:05 +0200
Message-ID: <20261006130215.128405-8-jjanasek@redhat.com>
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

Introduce sepol_class_t with getter/setter API for class name, value,
common, permissions, constraints, and validatetrans expressions,
without exposing internal class_datum_t or constraint_node_t.

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/class_record.h | 253 +++++++
 libsepol/src/class_record.c           | 950 ++++++++++++++++++++++++++
 2 files changed, 1203 insertions(+)
 create mode 100644 libsepol/include/sepol/class_record.h
 create mode 100644 libsepol/src/class_record.c

diff --git a/libsepol/include/sepol/class_record.h b/libsepol/include/sepol/class_record.h
new file mode 100644
index 00000000..ab4193a0
--- /dev/null
+++ b/libsepol/include/sepol/class_record.h
@@ -0,0 +1,253 @@
+#ifndef _SEPOL_CLASS_RECORD_H_
+#define _SEPOL_CLASS_RECORD_H_
+
+#include <stdint.h>
+
+#include <sepol/handle.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sepol_class;
+typedef struct sepol_class sepol_class_t;
+struct sepol_class_key;
+typedef struct sepol_class_key sepol_class_key_t;
+
+struct sepol_constraint;
+typedef struct sepol_constraint sepol_constraint_t;
+struct sepol_constraint_expr;
+typedef struct sepol_constraint_expr sepol_constraint_expr_t;
+
+/* Key */
+extern int sepol_class_key_create(sepol_handle_t *handle, const char *name,
+				  sepol_class_key_t **key);
+extern void sepol_class_key_unpack(const sepol_class_key_t *key,
+				   const char **name);
+extern int sepol_class_key_extract(sepol_handle_t *handle,
+				   const sepol_class_t *cls,
+				   sepol_class_key_t **key);
+extern void sepol_class_key_free(sepol_class_key_t *key);
+
+extern int sepol_class_compare(const sepol_class_t *cls,
+			       const sepol_class_key_t *key);
+extern int sepol_class_compare2(const sepol_class_t *cls,
+				const sepol_class_t *class2);
+
+/* Class name */
+extern const char *sepol_class_get_name(const sepol_class_t *cls);
+extern int sepol_class_set_name(sepol_handle_t *handle, sepol_class_t *cls,
+				const char *name);
+
+/* Common name */
+extern const char *sepol_class_get_common(const sepol_class_t *cls);
+extern int sepol_class_set_common(sepol_handle_t *handle, sepol_class_t *cls,
+				  const char *common);
+
+/* Class-specific permissions */
+extern int sepol_class_has_perm(const sepol_class_t *cls, const char *perm);
+extern int sepol_class_get_perms(sepol_handle_t *handle,
+				 const sepol_class_t *cls, const char ***perms,
+				 uint32_t *num_perms);
+extern int sepol_class_add_perm(sepol_handle_t *handle, sepol_class_t *cls,
+				const char *perm);
+extern int sepol_class_del_perm(sepol_handle_t *handle, sepol_class_t *cls,
+				const char *perm);
+
+/* Constraints */
+extern int sepol_class_get_constraints(sepol_handle_t *handle,
+				       const sepol_class_t *cls,
+				       const sepol_constraint_t ***constraints,
+				       uint32_t *num_constraints);
+/*
+ * On success, cls takes ownership of constraint: it is stored by
+ * reference (not copied) and will be freed when cls is freed or when
+ * constraint is removed via sepol_class_del_constraint(). The caller
+ * must not free or otherwise reuse constraint after a successful call.
+ * On failure, ownership is not transferred and the caller remains
+ * responsible for freeing constraint.
+ */
+extern int sepol_class_add_constraint(sepol_handle_t *handle,
+				      sepol_class_t *cls,
+				      sepol_constraint_t *constraint);
+/*
+ * Removes and frees exactly the constraint object passed in, matched by
+ * pointer identity (i.e. it must be a value previously passed to
+ * sepol_class_add_constraint() on this cls, such as one obtained from
+ * sepol_class_get_constraints()), not by comparing field values. Two
+ * structurally-identical but distinct constraint objects are never
+ * conflated: adding both and deleting one leaves the other untouched.
+ * Returns an error, without freeing anything, if constraint is not
+ * currently stored in cls.
+ */
+extern int sepol_class_del_constraint(sepol_handle_t *handle,
+				      sepol_class_t *cls,
+				      const sepol_constraint_t *constraint);
+
+/* Validate transitions */
+extern int
+sepol_class_get_validatetrans(sepol_handle_t *handle, const sepol_class_t *cls,
+			      const sepol_constraint_t ***validatetrans,
+			      uint32_t *num_validatetrans);
+/*
+ * On success, cls takes ownership of validatetrans: it is stored by
+ * reference (not copied) and will be freed when cls is freed or when
+ * validatetrans is removed via sepol_class_del_validatetrans(). The
+ * caller must not free or otherwise reuse validatetrans after a
+ * successful call. On failure, ownership is not transferred and the
+ * caller remains responsible for freeing validatetrans.
+ */
+extern int sepol_class_add_validatetrans(sepol_handle_t *handle,
+					 sepol_class_t *cls,
+					 sepol_constraint_t *validatetrans);
+/*
+ * Removes and frees exactly the validatetrans object passed in, matched
+ * by pointer identity, not by comparing field values -- see
+ * sepol_class_del_constraint()'s documentation for the rationale, which
+ * applies identically here. Returns an error, without freeing anything,
+ * if validatetrans is not currently stored in cls.
+ */
+extern int
+sepol_class_del_validatetrans(sepol_handle_t *handle, sepol_class_t *cls,
+			      const sepol_constraint_t *validatetrans);
+
+/* Defaults */
+#define SEPOL_CLASS_DEFAULT_SOURCE 1
+#define SEPOL_CLASS_DEFAULT_TARGET 2
+extern int sepol_class_get_default_user(const sepol_class_t *cls);
+extern int sepol_class_set_default_user(sepol_handle_t *handle,
+					sepol_class_t *cls, int default_user);
+extern int sepol_class_get_default_role(const sepol_class_t *cls);
+extern int sepol_class_set_default_role(sepol_handle_t *handle,
+					sepol_class_t *cls, int default_role);
+extern int sepol_class_get_default_type(const sepol_class_t *cls);
+extern int sepol_class_set_default_type(sepol_handle_t *handle,
+					sepol_class_t *cls, int default_type);
+
+#define SEPOL_CLASS_DEFAULT_SOURCE_LOW 1
+#define SEPOL_CLASS_DEFAULT_SOURCE_HIGH 2
+#define SEPOL_CLASS_DEFAULT_SOURCE_LOW_HIGH 3
+#define SEPOL_CLASS_DEFAULT_TARGET_LOW 4
+#define SEPOL_CLASS_DEFAULT_TARGET_HIGH 5
+#define SEPOL_CLASS_DEFAULT_TARGET_LOW_HIGH 6
+#define SEPOL_CLASS_DEFAULT_GLBLUB 7
+extern int sepol_class_get_default_range(const sepol_class_t *cls);
+extern int sepol_class_set_default_range(sepol_handle_t *handle,
+					 sepol_class_t *cls, int default_range);
+
+/* Create/Clone/Destroy */
+extern int sepol_class_create(sepol_handle_t *handle,
+			      sepol_class_t **class_ptr);
+extern int sepol_class_clone(sepol_handle_t *handle, const sepol_class_t *cls,
+			     sepol_class_t **class_ptr);
+extern void sepol_class_free(sepol_class_t *cls);
+
+/* Constraints */
+extern int sepol_constraint_create(sepol_handle_t *handle,
+				   sepol_constraint_t **constraint_ptr);
+extern int sepol_constraint_clone(sepol_handle_t *handle,
+				  const sepol_constraint_t *constraint,
+				  sepol_constraint_t **constraint_ptr);
+extern void sepol_constraint_free(sepol_constraint_t *constraint);
+
+/* Constrained permissions */
+extern int sepol_constraint_has_perm(const sepol_constraint_t *constraint,
+				     const char *perm);
+extern int sepol_constraint_get_perms(sepol_handle_t *handle,
+				      const sepol_constraint_t *constraint,
+				      const char ***perms, uint32_t *num_perms);
+extern int sepol_constraint_add_perm(sepol_handle_t *handle,
+				     sepol_constraint_t *constraint,
+				     const char *perm);
+extern int sepol_constraint_del_perm(sepol_handle_t *handle,
+				     sepol_constraint_t *constraint,
+				     const char *perm);
+
+/* Constraint sub expressions */
+extern int sepol_constraint_get_exprs(sepol_handle_t *handle,
+				      const sepol_constraint_t *constraint,
+				      const sepol_constraint_expr_t ***exprs,
+				      uint32_t *num_exprs);
+extern int sepol_constraint_insert_expr(sepol_handle_t *handle,
+					sepol_constraint_t *constraint,
+					uint32_t index,
+					sepol_constraint_expr_t *expr);
+extern int sepol_constraint_remove_expr(sepol_handle_t *handle,
+					sepol_constraint_t *constraint,
+					uint32_t index);
+
+/* Constraint expressions */
+extern int sepol_constraint_expr_create(sepol_handle_t *handle,
+					sepol_constraint_expr_t **expr_ptr);
+extern int sepol_constraint_expr_clone(sepol_handle_t *handle,
+				       const sepol_constraint_expr_t *expr,
+				       sepol_constraint_expr_t **expr_ptr);
+extern void sepol_constraint_expr_free(sepol_constraint_expr_t *expr);
+
+/* Constraint expr type */
+#define SEPOL_CEXPR_TYPE_NOT 1 /* not expr */
+#define SEPOL_CEXPR_TYPE_AND 2 /* expr and expr */
+#define SEPOL_CEXPR_TYPE_OR 3 /* expr or expr */
+#define SEPOL_CEXPR_TYPE_ATTR 4 /* attr op attr */
+#define SEPOL_CEXPR_TYPE_NAMES 5 /* attr op names */
+extern uint32_t
+sepol_constraint_expr_get_type(const sepol_constraint_expr_t *expr);
+extern int sepol_constraint_expr_set_type(sepol_handle_t *handle,
+					  sepol_constraint_expr_t *expr,
+					  uint32_t type);
+
+/* Constraint expr attr */
+#define SEPOL_CEXPR_ATTR_USER 1 /* user */
+#define SEPOL_CEXPR_ATTR_ROLE 2 /* role */
+#define SEPOL_CEXPR_ATTR_TYPE 4 /* type */
+#define SEPOL_CEXPR_ATTR_TARGET 8 /* target if set, source otherwise */
+#define SEPOL_CEXPR_ATTR_XTARGET \
+	16 /* special 3rd target for validatetrans rule */
+#define SEPOL_CEXPR_ATTR_L1L2 32 /* low level 1 vs. low level 2 */
+#define SEPOL_CEXPR_ATTR_L1H2 64 /* low level 1 vs. high level 2 */
+#define SEPOL_CEXPR_ATTR_H1L2 128 /* high level 1 vs. low level 2 */
+#define SEPOL_CEXPR_ATTR_H1H2 256 /* high level 1 vs. high level 2 */
+#define SEPOL_CEXPR_ATTR_L1H1 512 /* low level 1 vs. high level 1 */
+#define SEPOL_CEXPR_ATTR_L2H2 1024 /* low level 2 vs. high level 2 */
+extern int sepol_constraint_expr_has_attr(const sepol_constraint_expr_t *expr,
+					  uint32_t attr);
+extern int sepol_constraint_expr_set_attr(sepol_handle_t *handle,
+					  sepol_constraint_expr_t *expr,
+					  uint32_t attr);
+extern int sepol_constraint_expr_unset_attr(sepol_handle_t *handle,
+					    sepol_constraint_expr_t *expr,
+					    uint32_t attr);
+extern int sepol_constraint_expr_clear_attr(sepol_handle_t *handle,
+					    sepol_constraint_expr_t *expr);
+
+/* Constraint expr attr or names operator */
+#define SEPOL_CEXPR_OP_EQ 1 /* == or eq */
+#define SEPOL_CEXPR_OP_NEQ 2 /* != */
+#define SEPOL_CEXPR_OP_DOM 3 /* dom */
+#define SEPOL_CEXPR_OP_DOMBY 4 /* domby  */
+#define SEPOL_CEXPR_OP_INCOMP 5 /* incomp */
+extern uint32_t
+sepol_constraint_expr_get_op(const sepol_constraint_expr_t *expr);
+extern int sepol_constraint_expr_set_op(sepol_handle_t *handle,
+					sepol_constraint_expr_t *expr,
+					uint32_t op);
+
+/* Constraint names */
+extern int sepol_constraint_expr_has_name(const sepol_constraint_expr_t *expr,
+					  const char *name);
+extern int sepol_constraint_expr_get_names(sepol_handle_t *handle,
+					   const sepol_constraint_expr_t *expr,
+					   const char ***names,
+					   uint32_t *num_names);
+extern int sepol_constraint_expr_add_name(sepol_handle_t *handle,
+					  sepol_constraint_expr_t *expr,
+					  const char *name);
+extern int sepol_constraint_expr_del_name(sepol_handle_t *handle,
+					  sepol_constraint_expr_t *expr,
+					  const char *name);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/class_record.c b/libsepol/src/class_record.c
new file mode 100644
index 00000000..8acf7edd
--- /dev/null
+++ b/libsepol/src/class_record.c
@@ -0,0 +1,950 @@
+#include <sepol/class_record.h>
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "sepol/policydb/util.h"
+#include "debug.h"
+
+struct sepol_class {
+	char *name;
+	char *common;
+	char **perms;
+	uint32_t num_perms;
+	sepol_constraint_t **constraints;
+	uint32_t num_constraints;
+	sepol_constraint_t **validatetrans;
+	uint32_t num_validatetrans;
+	int default_user;
+	int default_role;
+	int default_type;
+	int default_range;
+};
+
+struct sepol_class_key {
+	char *name;
+};
+
+struct sepol_constraint {
+	char **perms;
+	uint32_t num_perms;
+	sepol_constraint_expr_t **exprs;
+	uint32_t num_exprs;
+};
+
+struct sepol_constraint_expr {
+	uint32_t expr_type;
+	uint32_t attr;
+	uint32_t op;
+	char **names;
+	uint32_t num_names;
+};
+
+/* Key */
+int sepol_class_key_create(sepol_handle_t *handle, const char *name,
+			   sepol_class_key_t **key)
+{
+	if (!key)
+		return STATUS_ERR;
+	if (!name) {
+		ERR(handle, "name is NULL");
+		*key = NULL;
+		return STATUS_ERR;
+	}
+	sepol_class_key_t *tmp_key = malloc(sizeof(sepol_class_key_t));
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
+void sepol_class_key_unpack(const sepol_class_key_t *key, const char **name)
+{
+	*name = key ? key->name : NULL;
+}
+
+int sepol_class_key_extract(sepol_handle_t *handle, const sepol_class_t *cls,
+			    sepol_class_key_t **key)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	if (!cls->name) {
+		ERR(handle, "class name is NULL");
+		return STATUS_ERR;
+	}
+	return sepol_class_key_create(handle, cls->name, key);
+}
+
+void sepol_class_key_free(sepol_class_key_t *key)
+{
+	if (!key)
+		return;
+	free(key->name);
+	free(key);
+}
+
+int sepol_class_compare(const sepol_class_t *cls, const sepol_class_key_t *key)
+{
+	if (!cls || !key || !cls->name || !key->name)
+		return -1;
+	return strcmp(cls->name, key->name);
+}
+
+int sepol_class_compare2(const sepol_class_t *cls, const sepol_class_t *cls2)
+{
+	if (!cls || !cls2 || !cls->name || !cls2->name)
+		return -1;
+	return strcmp(cls->name, cls2->name);
+}
+
+/* Class name */
+const char *sepol_class_get_name(const sepol_class_t *cls)
+{
+	return cls ? cls->name : NULL;
+}
+
+int sepol_class_set_name(sepol_handle_t *handle, sepol_class_t *cls,
+			 const char *name)
+{
+	if (!cls || !name) {
+		ERR(handle, "class or name is NULL");
+		return STATUS_ERR;
+	}
+	char *tmp_name = strdup(name);
+	if (!tmp_name) {
+		ERR(handle, "out of memory");
+		return STATUS_ERR;
+	}
+	free(cls->name);
+	cls->name = tmp_name;
+	return STATUS_SUCCESS;
+}
+
+/* Common name */
+const char *sepol_class_get_common(const sepol_class_t *cls)
+{
+	return cls ? cls->common : NULL;
+}
+
+int sepol_class_set_common(sepol_handle_t *handle, sepol_class_t *cls,
+			   const char *common)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	if (common) {
+		char *tmp_common = strdup(common);
+		if (!tmp_common) {
+			ERR(handle, "out of memory");
+			return STATUS_ERR;
+		}
+		free(cls->common);
+		cls->common = tmp_common;
+	} else {
+		free(cls->common);
+		cls->common = NULL;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Class-specific permissions */
+int sepol_class_has_perm(const sepol_class_t *cls, const char *perm)
+{
+	if (!cls)
+		return 0;
+	return string_list_contains(cls->perms, cls->num_perms, perm);
+}
+
+int sepol_class_get_perms(sepol_handle_t *handle, const sepol_class_t *cls,
+			  const char ***perms, uint32_t *num_perms)
+{
+	if (!perms || !num_perms)
+		return STATUS_ERR;
+	if (!cls) {
+		*perms = NULL;
+		*num_perms = 0;
+		return STATUS_ERR;
+	}
+	return string_list_scopy(handle, cls->perms, cls->num_perms, perms,
+				 num_perms);
+}
+
+int sepol_class_add_perm(sepol_handle_t *handle, sepol_class_t *cls,
+			 const char *perm)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_add_unique(handle, &cls->perms, &cls->num_perms,
+				      perm);
+}
+
+int sepol_class_del_perm(sepol_handle_t *handle, sepol_class_t *cls,
+			 const char *perm)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_del(cls->perms, &cls->num_perms, perm);
+}
+
+/*
+ * sepol_class_t stores two separate but identically-shaped arrays of
+ * sepol_constraint_t* (constraints and validatetrans). The following three
+ * helpers implement the shared get/add/del logic once; the public
+ * constraint/validatetrans functions below are thin wrappers that select
+ * which array/count pair to operate on.
+ */
+static int constraint_array_copy_out(sepol_handle_t *handle,
+				     sepol_constraint_t *const *arr,
+				     uint32_t count,
+				     const sepol_constraint_t ***out_arr,
+				     uint32_t *out_count)
+{
+	if (!out_arr || !out_count)
+		return STATUS_ERR;
+
+	if (count == 0) {
+		*out_arr = NULL;
+		*out_count = 0;
+		return STATUS_SUCCESS;
+	}
+
+	const sepol_constraint_t **tmp =
+		calloc(count, sizeof(const sepol_constraint_t *));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		return STATUS_ERR;
+	}
+
+	for (uint32_t i = 0; i < count; i++)
+		tmp[i] = arr[i];
+
+	*out_arr = tmp;
+	*out_count = count;
+
+	return STATUS_SUCCESS;
+}
+
+static int constraint_array_add(sepol_handle_t *handle,
+				sepol_constraint_t ***arr, uint32_t *count,
+				sepol_constraint_t *constraint,
+				const char *desc)
+{
+	if (!constraint) {
+		ERR(handle, "class or %s is NULL", desc);
+		return STATUS_ERR;
+	}
+	if (*count == UINT32_MAX) {
+		ERR(handle, "too many %ss", desc);
+		return STATUS_ERR;
+	}
+	sepol_constraint_t **tmp =
+		reallocarray(*arr, *count + 1, sizeof(sepol_constraint_t *));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		return STATUS_ERR;
+	}
+	*arr = tmp;
+	(*arr)[*count] = constraint;
+	(*count)++;
+
+	return STATUS_SUCCESS;
+}
+
+/*
+ * Removes exactly the constraint object identified by `constraint`'s
+ * pointer identity, not by deep value equality. sepol_class_add_constraint()/
+ * sepol_class_add_validatetrans() explicitly document that a constraint is
+ * "stored by reference (not copied)", and legitimate policies can and do
+ * have multiple structurally-identical constrain/validatetrans rules
+ * (nothing about the add path deduplicates by value) -- so matching by
+ * value here would delete every value-equal sibling object too, freeing
+ * ones the caller never asked to remove and may still hold a pointer to
+ * (a real use-after-free/double-free risk for the caller), not just the
+ * one instance actually passed in.
+ */
+static int constraint_array_del(sepol_handle_t *handle,
+				sepol_constraint_t **arr, uint32_t *count,
+				const sepol_constraint_t *constraint)
+{
+	if (!constraint)
+		return STATUS_ERR;
+
+	for (uint32_t i = *count; i > 0; i--) {
+		if (arr[i - 1] == constraint) {
+			sepol_constraint_free(arr[i - 1]);
+			(*count)--;
+			if (i - 1 < *count)
+				arr[i - 1] = arr[*count];
+			return STATUS_SUCCESS;
+		}
+	}
+	ERR(handle, "constraint not found");
+	return STATUS_ERR;
+}
+
+/* Constraints */
+int sepol_class_get_constraints(sepol_handle_t *handle,
+				const sepol_class_t *cls,
+				const sepol_constraint_t ***constraints,
+				uint32_t *num_constraints)
+{
+	if (!constraints || !num_constraints)
+		return STATUS_ERR;
+	if (!cls) {
+		*constraints = NULL;
+		*num_constraints = 0;
+		return STATUS_ERR;
+	}
+
+	return constraint_array_copy_out(handle, cls->constraints,
+					 cls->num_constraints, constraints,
+					 num_constraints);
+}
+
+int sepol_class_add_constraint(sepol_handle_t *handle, sepol_class_t *cls,
+			       sepol_constraint_t *constraint)
+{
+	if (!cls) {
+		ERR(handle, "class or constraint is NULL");
+		return STATUS_ERR;
+	}
+
+	return constraint_array_add(handle, &cls->constraints,
+				    &cls->num_constraints, constraint,
+				    "constraint");
+}
+
+int sepol_class_del_constraint(sepol_handle_t *handle, sepol_class_t *cls,
+			       const sepol_constraint_t *constraint)
+{
+	if (!cls)
+		return STATUS_ERR;
+
+	return constraint_array_del(handle, cls->constraints,
+				    &cls->num_constraints, constraint);
+}
+
+/* Validate transitions */
+int sepol_class_get_validatetrans(sepol_handle_t *handle,
+				  const sepol_class_t *cls,
+				  const sepol_constraint_t ***validatetrans,
+				  uint32_t *num_validatetrans)
+{
+	if (!validatetrans || !num_validatetrans)
+		return STATUS_ERR;
+	if (!cls) {
+		*validatetrans = NULL;
+		*num_validatetrans = 0;
+		return STATUS_ERR;
+	}
+
+	return constraint_array_copy_out(handle, cls->validatetrans,
+					 cls->num_validatetrans, validatetrans,
+					 num_validatetrans);
+}
+
+int sepol_class_add_validatetrans(sepol_handle_t *handle, sepol_class_t *cls,
+				  sepol_constraint_t *validatetrans)
+{
+	if (!cls) {
+		ERR(handle, "class or validatetrans is NULL");
+		return STATUS_ERR;
+	}
+
+	return constraint_array_add(handle, &cls->validatetrans,
+				    &cls->num_validatetrans, validatetrans,
+				    "validatetrans");
+}
+
+int sepol_class_del_validatetrans(sepol_handle_t *handle, sepol_class_t *cls,
+				  const sepol_constraint_t *validatetrans)
+{
+	if (!cls)
+		return STATUS_ERR;
+
+	return constraint_array_del(handle, cls->validatetrans,
+				    &cls->num_validatetrans, validatetrans);
+}
+
+/* Defaults */
+int sepol_class_get_default_user(const sepol_class_t *cls)
+{
+	return cls ? cls->default_user : 0;
+}
+
+int sepol_class_set_default_user(sepol_handle_t *handle, sepol_class_t *cls,
+				 int default_user)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	cls->default_user = default_user;
+	return STATUS_SUCCESS;
+}
+
+int sepol_class_get_default_role(const sepol_class_t *cls)
+{
+	return cls ? cls->default_role : 0;
+}
+
+int sepol_class_set_default_role(sepol_handle_t *handle, sepol_class_t *cls,
+				 int default_role)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	cls->default_role = default_role;
+	return STATUS_SUCCESS;
+}
+
+int sepol_class_get_default_type(const sepol_class_t *cls)
+{
+	return cls ? cls->default_type : 0;
+}
+
+int sepol_class_set_default_type(sepol_handle_t *handle, sepol_class_t *cls,
+				 int default_type)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	cls->default_type = default_type;
+	return STATUS_SUCCESS;
+}
+
+int sepol_class_get_default_range(const sepol_class_t *cls)
+{
+	return cls ? cls->default_range : 0;
+}
+
+int sepol_class_set_default_range(sepol_handle_t *handle, sepol_class_t *cls,
+				  int default_range)
+{
+	if (!cls) {
+		ERR(handle, "class is NULL");
+		return STATUS_ERR;
+	}
+	cls->default_range = default_range;
+	return STATUS_SUCCESS;
+}
+
+/* Create/Clone/Destroy */
+int sepol_class_create(sepol_handle_t *handle, sepol_class_t **class_ptr)
+{
+	sepol_class_t *tmp;
+
+	if (!class_ptr)
+		return STATUS_ERR;
+
+	tmp = malloc(sizeof(sepol_class_t));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*class_ptr = NULL;
+		return STATUS_ERR;
+	}
+	memset(tmp, 0, sizeof(sepol_class_t));
+	*class_ptr = tmp;
+	return STATUS_SUCCESS;
+}
+
+int sepol_class_clone(sepol_handle_t *handle, const sepol_class_t *cls,
+		      sepol_class_t **class_ptr)
+{
+	sepol_class_t *tmp = NULL;
+
+	if (!class_ptr)
+		return STATUS_ERR;
+	if (!cls) {
+		*class_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	if (sepol_class_create(handle, &tmp))
+		goto err;
+
+	if (sepol_class_set_name(handle, tmp, cls->name))
+		goto err;
+	if (sepol_class_set_common(handle, tmp, cls->common))
+		goto err;
+	for (size_t i = 0; i < cls->num_perms; i++) {
+		if (sepol_class_add_perm(handle, tmp, cls->perms[i]))
+			goto err;
+	}
+	for (size_t i = 0; i < cls->num_constraints; i++) {
+		sepol_constraint_t *cloned_constraint = NULL;
+		if (sepol_constraint_clone(handle, cls->constraints[i],
+					   &cloned_constraint))
+			goto err;
+		if (sepol_class_add_constraint(handle, tmp,
+					       cloned_constraint)) {
+			sepol_constraint_free(cloned_constraint);
+			goto err;
+		}
+	}
+	for (size_t i = 0; i < cls->num_validatetrans; i++) {
+		sepol_constraint_t *cloned_vt = NULL;
+		if (sepol_constraint_clone(handle, cls->validatetrans[i],
+					   &cloned_vt))
+			goto err;
+		if (sepol_class_add_validatetrans(handle, tmp, cloned_vt)) {
+			sepol_constraint_free(cloned_vt);
+			goto err;
+		}
+	}
+	if (sepol_class_set_default_user(handle, tmp, cls->default_user))
+		goto err;
+	if (sepol_class_set_default_role(handle, tmp, cls->default_role))
+		goto err;
+	if (sepol_class_set_default_type(handle, tmp, cls->default_type))
+		goto err;
+	if (sepol_class_set_default_range(handle, tmp, cls->default_range))
+		goto err;
+
+	*class_ptr = tmp;
+	return STATUS_SUCCESS;
+
+err:
+	sepol_class_free(tmp);
+	*class_ptr = NULL;
+	return STATUS_ERR;
+}
+
+void sepol_class_free(sepol_class_t *cls)
+{
+	if (!cls)
+		return;
+
+	free(cls->name);
+	free(cls->common);
+	for (size_t i = 0; i < cls->num_perms; i++)
+		free(cls->perms[i]);
+	free(cls->perms);
+	for (size_t i = 0; i < cls->num_constraints; i++)
+		sepol_constraint_free(cls->constraints[i]);
+	free(cls->constraints);
+	for (size_t i = 0; i < cls->num_validatetrans; i++)
+		sepol_constraint_free(cls->validatetrans[i]);
+	free(cls->validatetrans);
+	free(cls);
+}
+
+/* Constraints */
+int sepol_constraint_create(sepol_handle_t *handle,
+			    sepol_constraint_t **constraint_ptr)
+{
+	sepol_constraint_t *tmp;
+
+	if (!constraint_ptr)
+		return STATUS_ERR;
+
+	tmp = malloc(sizeof(sepol_constraint_t));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*constraint_ptr = NULL;
+		return STATUS_ERR;
+	}
+	memset(tmp, 0, sizeof(sepol_constraint_t));
+	*constraint_ptr = tmp;
+	return STATUS_SUCCESS;
+}
+
+int sepol_constraint_clone(sepol_handle_t *handle,
+			   const sepol_constraint_t *constraint,
+			   sepol_constraint_t **constraint_ptr)
+{
+	if (!constraint_ptr)
+		return STATUS_ERR;
+	if (!constraint) {
+		*constraint_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_constraint_t *tmp;
+	if (sepol_constraint_create(handle, &tmp)) {
+		*constraint_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	for (size_t i = 0; i < constraint->num_perms; i++) {
+		if (sepol_constraint_add_perm(handle, tmp,
+					      constraint->perms[i]))
+			goto err;
+	}
+
+	for (size_t i = 0; i < constraint->num_exprs; i++) {
+		sepol_constraint_expr_t *cloned_expr = NULL;
+		if (sepol_constraint_expr_clone(handle, constraint->exprs[i],
+						&cloned_expr))
+			goto err;
+		if (sepol_constraint_insert_expr(handle, tmp, i, cloned_expr)) {
+			sepol_constraint_expr_free(cloned_expr);
+			goto err;
+		}
+	}
+	*constraint_ptr = tmp;
+	return STATUS_SUCCESS;
+
+err:
+	sepol_constraint_free(tmp);
+	*constraint_ptr = NULL;
+	return STATUS_ERR;
+}
+
+void sepol_constraint_free(sepol_constraint_t *constraint)
+{
+	if (!constraint)
+		return;
+
+	for (size_t i = 0; i < constraint->num_perms; i++)
+		free(constraint->perms[i]);
+	free(constraint->perms);
+	for (size_t i = 0; i < constraint->num_exprs; i++)
+		sepol_constraint_expr_free(constraint->exprs[i]);
+	free(constraint->exprs);
+	free(constraint);
+}
+
+/* Constrained permissions */
+int sepol_constraint_has_perm(const sepol_constraint_t *constraint,
+			      const char *perm)
+{
+	if (!constraint)
+		return 0;
+	return string_list_contains(constraint->perms, constraint->num_perms,
+				    perm);
+}
+
+int sepol_constraint_get_perms(sepol_handle_t *handle,
+			       const sepol_constraint_t *constraint,
+			       const char ***perms, uint32_t *num_perms)
+{
+	if (!perms || !num_perms)
+		return STATUS_ERR;
+	if (!constraint) {
+		*perms = NULL;
+		*num_perms = 0;
+		return STATUS_ERR;
+	}
+	return string_list_scopy(handle, constraint->perms,
+				 constraint->num_perms, perms, num_perms);
+}
+
+int sepol_constraint_add_perm(sepol_handle_t *handle,
+			      sepol_constraint_t *constraint, const char *perm)
+{
+	if (!constraint) {
+		ERR(handle, "constraint is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_add_unique(handle, &constraint->perms,
+				      &constraint->num_perms, perm);
+}
+
+int sepol_constraint_del_perm(sepol_handle_t *handle,
+			      sepol_constraint_t *constraint, const char *perm)
+{
+	if (!constraint) {
+		ERR(handle, "constraint is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_del(constraint->perms, &constraint->num_perms, perm);
+}
+
+/* Constraint sub expresessions */
+int sepol_constraint_get_exprs(sepol_handle_t *handle,
+			       const sepol_constraint_t *constraint,
+			       const sepol_constraint_expr_t ***exprs,
+			       uint32_t *num_exprs)
+{
+	if (!exprs || !num_exprs)
+		return STATUS_ERR;
+	if (!constraint) {
+		*exprs = NULL;
+		*num_exprs = 0;
+		return STATUS_ERR;
+	}
+
+	if (constraint->num_exprs == 0) {
+		*exprs = NULL;
+		*num_exprs = 0;
+		return STATUS_SUCCESS;
+	}
+
+	const sepol_constraint_expr_t **tmp = calloc(
+		constraint->num_exprs, sizeof(const sepol_constraint_expr_t *));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		return STATUS_ERR;
+	}
+
+	for (uint32_t i = 0; i < constraint->num_exprs; i++)
+		tmp[i] = constraint->exprs[i];
+
+	*exprs = tmp;
+	*num_exprs = constraint->num_exprs;
+
+	return STATUS_SUCCESS;
+}
+
+int sepol_constraint_insert_expr(sepol_handle_t *handle,
+				 sepol_constraint_t *constraint, uint32_t index,
+				 sepol_constraint_expr_t *expr)
+{
+	if (!constraint || !expr) {
+		ERR(handle, "constraint or expr is NULL");
+		return STATUS_ERR;
+	}
+	if (index > constraint->num_exprs) {
+		ERR(handle, "index out of bounds");
+		return STATUS_ERR;
+	}
+	if (constraint->num_exprs == UINT32_MAX) {
+		ERR(handle, "too many expressions");
+		return STATUS_ERR;
+	}
+	sepol_constraint_expr_t **tmp_array =
+		reallocarray(constraint->exprs, constraint->num_exprs + 1,
+			     sizeof(sepol_constraint_expr_t *));
+	if (!tmp_array) {
+		ERR(handle, "out of memory");
+		return STATUS_ERR;
+	}
+	constraint->exprs = tmp_array;
+	constraint->exprs[constraint->num_exprs] = NULL;
+
+	constraint->num_exprs++;
+	for (uint32_t i = 0; i < constraint->num_exprs; i++) {
+		if (i >= index) {
+			sepol_constraint_expr_t *tmp = constraint->exprs[i];
+			constraint->exprs[i] = expr;
+			expr = tmp;
+		}
+	}
+	return STATUS_SUCCESS;
+}
+
+int sepol_constraint_remove_expr(sepol_handle_t *handle,
+				 sepol_constraint_t *constraint, uint32_t index)
+{
+	if (!constraint) {
+		ERR(handle, "constraint is NULL");
+		return STATUS_ERR;
+	}
+	if (index >= constraint->num_exprs)
+		return STATUS_ERR;
+
+	sepol_constraint_expr_free(constraint->exprs[index]);
+
+	for (uint32_t i = index; i < constraint->num_exprs - 1; i++)
+		constraint->exprs[i] = constraint->exprs[i + 1];
+
+	constraint->num_exprs--;
+	return STATUS_SUCCESS;
+}
+
+/* Constraint expresessions */
+int sepol_constraint_expr_create(sepol_handle_t *handle,
+				 sepol_constraint_expr_t **expr_ptr)
+{
+	sepol_constraint_expr_t *tmp;
+
+	if (!expr_ptr)
+		return STATUS_ERR;
+
+	tmp = malloc(sizeof(sepol_constraint_expr_t));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*expr_ptr = NULL;
+		return STATUS_ERR;
+	}
+	memset(tmp, 0, sizeof(sepol_constraint_expr_t));
+	*expr_ptr = tmp;
+	return STATUS_SUCCESS;
+}
+
+int sepol_constraint_expr_clone(sepol_handle_t *handle,
+				const sepol_constraint_expr_t *expr,
+				sepol_constraint_expr_t **expr_ptr)
+{
+	if (!expr_ptr)
+		return STATUS_ERR;
+	if (!expr) {
+		*expr_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_constraint_expr_t *tmp;
+	if (sepol_constraint_expr_create(handle, &tmp)) {
+		*expr_ptr = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->expr_type = expr->expr_type;
+	tmp->attr = expr->attr;
+	tmp->op = expr->op;
+	for (uint32_t i = 0; i < expr->num_names; i++) {
+		if (sepol_constraint_expr_add_name(handle, tmp, expr->names[i]))
+			goto err;
+	}
+	*expr_ptr = tmp;
+	return STATUS_SUCCESS;
+
+err:
+	sepol_constraint_expr_free(tmp);
+	*expr_ptr = NULL;
+	return STATUS_ERR;
+}
+
+void sepol_constraint_expr_free(sepol_constraint_expr_t *expr)
+{
+	if (!expr)
+		return;
+
+	for (uint32_t i = 0; i < expr->num_names; i++)
+		free(expr->names[i]);
+	free(expr->names);
+	free(expr);
+}
+
+/* Constraint expr type */
+uint32_t sepol_constraint_expr_get_type(const sepol_constraint_expr_t *expr)
+{
+	return expr ? expr->expr_type : 0;
+}
+
+int sepol_constraint_expr_set_type(sepol_handle_t *handle,
+				   sepol_constraint_expr_t *expr, uint32_t type)
+{
+	if (!expr) {
+		ERR(handle, "expr is NULL");
+		return STATUS_ERR;
+	}
+	expr->expr_type = type;
+	return STATUS_SUCCESS;
+}
+
+/* Constraint expr attr */
+int sepol_constraint_expr_has_attr(const sepol_constraint_expr_t *expr,
+				   uint32_t attr)
+{
+	return expr ? (expr->attr & attr) != 0 : 0;
+}
+
+int sepol_constraint_expr_set_attr(sepol_handle_t *handle,
+				   sepol_constraint_expr_t *expr, uint32_t attr)
+{
+	if (!expr) {
+		ERR(handle, "expr is NULL");
+		return STATUS_ERR;
+	}
+	expr->attr |= attr;
+	return STATUS_SUCCESS;
+}
+
+int sepol_constraint_expr_unset_attr(sepol_handle_t *handle,
+				     sepol_constraint_expr_t *expr,
+				     uint32_t attr)
+{
+	if (!expr) {
+		ERR(handle, "expr is NULL");
+		return STATUS_ERR;
+	}
+	expr->attr &= ~attr;
+	return STATUS_SUCCESS;
+}
+
+int sepol_constraint_expr_clear_attr(sepol_handle_t *handle,
+				     sepol_constraint_expr_t *expr)
+{
+	if (!expr) {
+		ERR(handle, "expr is NULL");
+		return STATUS_ERR;
+	}
+	expr->attr = 0;
+	return STATUS_SUCCESS;
+}
+
+/* Constraint expr attr or names operator */
+uint32_t sepol_constraint_expr_get_op(const sepol_constraint_expr_t *expr)
+{
+	return expr ? expr->op : 0;
+}
+
+int sepol_constraint_expr_set_op(sepol_handle_t *handle,
+				 sepol_constraint_expr_t *expr, uint32_t op)
+{
+	if (!expr) {
+		ERR(handle, "expr is NULL");
+		return STATUS_ERR;
+	}
+	expr->op = op;
+	return STATUS_SUCCESS;
+}
+
+/* Constraint names */
+int sepol_constraint_expr_has_name(const sepol_constraint_expr_t *expr,
+				   const char *name)
+{
+	if (!expr)
+		return 0;
+	return string_list_contains(expr->names, expr->num_names, name);
+}
+
+int sepol_constraint_expr_get_names(sepol_handle_t *handle,
+				    const sepol_constraint_expr_t *expr,
+				    const char ***names, uint32_t *num_names)
+{
+	if (!names || !num_names)
+		return STATUS_ERR;
+	if (!expr) {
+		*names = NULL;
+		*num_names = 0;
+		return STATUS_ERR;
+	}
+	return string_list_scopy(handle, expr->names, expr->num_names, names,
+				 num_names);
+}
+
+int sepol_constraint_expr_add_name(sepol_handle_t *handle,
+				   sepol_constraint_expr_t *expr,
+				   const char *name)
+{
+	if (!expr) {
+		ERR(handle, "expr is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_add_unique(handle, &expr->names, &expr->num_names,
+				      name);
+}
+
+int sepol_constraint_expr_del_name(sepol_handle_t *handle,
+				   sepol_constraint_expr_t *expr,
+				   const char *name)
+{
+	if (!expr) {
+		ERR(handle, "expr is NULL");
+		return STATUS_ERR;
+	}
+	return string_list_del(expr->names, &expr->num_names, name);
+}
-- 
2.55.0

