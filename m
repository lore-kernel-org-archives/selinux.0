Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89551457E53
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291867; cv=none; b=F89C26TPlgfLvV5ZQzV+0IDlZJT4N7O7Q0nGgdR1+WgqGxyFSYiEyAWChRVRznkm8i5sQwxMnl/5xYN4IEDk6K7+ztvY3NVEdzTsRYqiGeE2a+elhaHAvIouD/3221Kd0lgmrY3NktxHS4klxzxnwFoc4XoxClvbgaC9nTFHU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291867; c=relaxed/simple;
	bh=+PLP6GLUAB3wltuMtcDTwP5KbA4nYGQnPTkojClERrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWww7uvhwoaCwqvedQ65k1USuiLncxGHA8YBSFTjOrXMcWcyqNYXbiii72VjW6Tm+SuMzHW1OafUqlAmk81ZZHAch7PNWo2TqllTN+MzIjoCx4rK+kKd4+QR1crVC+E+Ks4TVg3dNnjgdJ+VABCJeo27CAvRw7VkjcswE6d3sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBMbt6Aw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBMbt6Aw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQsmDxiM/v/ZpueJfPUjvz9aU328FVZKJ13lYQTb99w=;
	b=iBMbt6Aw81IDr8yDLp+22ctKXgc1iKMmhUYmNVfkk1Cw1E5FI3Zi8rdr+bSPsjy82x0HLI
	lRT+bQvDD+FT+eNLZvX41YVBR+6MIIy9zxrrv0qx4Gk+b4xkEWcr3tauT/5jziLhsoCxdj
	dzEsybLTSpfVqvNbydn7PbG6mkRYB8I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-p1hxbjBwMHaSrE2eOvLBeA-1; Tue,
 06 Oct 2026 09:04:20 -0400
X-MC-Unique: p1hxbjBwMHaSrE2eOvLBeA-1
X-Mimecast-MFC-AGG-ID: p1hxbjBwMHaSrE2eOvLBeA_1791291859
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1968195FD12;
	Tue,  6 Oct 2026 13:04:19 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22DFD197703E;
	Tue,  6 Oct 2026 13:04:16 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 08/17] libsepol: add public class iterator and tests
Date: Tue,  6 Oct 2026 15:02:06 +0200
Message-ID: <20261006130215.128405-9-jjanasek@redhat.com>
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

Add sepol_class_iter, sepol_class_value_to_name(),
sepol_class_query_by_value(), and sepol_class_perm_value_to_name()
for resolving classes and their permissions by value, with tests
covering constraint and validatetrans data on real policy classes.

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/classes.h   |  69 ++++
 libsepol/src/classes.c             | 581 +++++++++++++++++++++++++++++
 libsepol/tests/test-iter-classes.c | 220 +++++++++++
 libsepol/tests/test-iter-classes.h |   7 +
 libsepol/tests/test-iter.c         |   7 +
 5 files changed, 884 insertions(+)
 create mode 100644 libsepol/include/sepol/classes.h
 create mode 100644 libsepol/src/classes.c
 create mode 100644 libsepol/tests/test-iter-classes.c
 create mode 100644 libsepol/tests/test-iter-classes.h

diff --git a/libsepol/include/sepol/classes.h b/libsepol/include/sepol/classes.h
new file mode 100644
index 00000000..3ca52b94
--- /dev/null
+++ b/libsepol/include/sepol/classes.h
@@ -0,0 +1,69 @@
+#ifndef _SEPOL_CLASSES_H_
+#define _SEPOL_CLASSES_H_
+
+#include <sepol/policydb.h>
+#include <sepol/class_record.h>
+#include <sepol/handle.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sepol_class_iter;
+typedef struct sepol_class_iter sepol_class_iter_t;
+
+/* Return the number of classes */
+extern int sepol_class_count(sepol_handle_t *handle, const sepol_policydb_t *p,
+			     unsigned int *response);
+
+/* Check if the specified class exists */
+extern int sepol_class_exists(sepol_handle_t *handle,
+			      const sepol_policydb_t *policydb,
+			      const sepol_class_key_t *key, int *response);
+
+/* Query a class - returns the class or NULL if not found */
+extern int sepol_class_query(sepol_handle_t *handle, const sepol_policydb_t *p,
+			     const sepol_class_key_t *key,
+			     sepol_class_t **response);
+
+/* Resolve a class value to its name.  Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_class_value_to_name(sepol_handle_t *handle,
+				     const sepol_policydb_t *p, uint32_t value,
+				     const char **name);
+
+/* Query a class by value - returns the class or NULL if not found */
+extern int sepol_class_query_by_value(sepol_handle_t *handle,
+				      const sepol_policydb_t *p, uint32_t value,
+				      sepol_class_t **response);
+
+/* Resolve a permission value to its name within a class.
+ * Returns non-zero on invalid class value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_class_perm_value_to_name(sepol_handle_t *handle,
+					  const sepol_policydb_t *p,
+					  uint32_t class_value,
+					  uint32_t perm_value,
+					  const char **name);
+
+/*
+ * Iterating classes. Iteration order is unspecified (currently
+ * hash-bucket order of the internal symbol table) and may change between
+ * library versions or policydb loads; callers must not rely on it
+ * matching declaration order or being stable across calls.
+ */
+extern int sepol_class_iter_create(sepol_handle_t *handle,
+				   const sepol_policydb_t *p,
+				   sepol_class_iter_t **iter);
+extern void sepol_class_iter_destroy(sepol_class_iter_t *iter);
+extern int sepol_class_iter_next(sepol_handle_t *handle,
+				 sepol_class_iter_t *iter,
+				 sepol_class_t **item);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/classes.c b/libsepol/src/classes.c
new file mode 100644
index 00000000..2ec50e3b
--- /dev/null
+++ b/libsepol/src/classes.c
@@ -0,0 +1,581 @@
+#include <sepol/classes.h>
+
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "debug.h"
+#include "sepol/handle.h"
+#include "sepol/policydb/constraint.h"
+#include "sepol/policydb/ebitmap.h"
+#include "sepol/policydb/hashtab.h"
+#include "sepol/class_record.h"
+#include "private.h"
+
+struct sepol_class_iter {
+	const sepol_policydb_t *p;
+	hashtab_iter_t hashtab_iter;
+};
+
+struct class_add_perm_args {
+	sepol_handle_t *handle;
+	sepol_class_t *cls;
+};
+
+static int class_add_perm(hashtab_key_t key,
+			  hashtab_datum_t datum __attribute__((unused)),
+			  void *arg)
+{
+	const char *perm = key;
+	struct class_add_perm_args *args = arg;
+
+	return sepol_class_add_perm(args->handle, args->cls, perm);
+}
+
+static char map_default(char from)
+{
+	switch (from) {
+	case DEFAULT_SOURCE:
+		return SEPOL_CLASS_DEFAULT_SOURCE;
+	case DEFAULT_TARGET:
+		return SEPOL_CLASS_DEFAULT_TARGET;
+	}
+	return 0;
+}
+
+static int constraint_expr_datum_to_record(sepol_handle_t *handle,
+					   const policydb_t *p,
+					   const constraint_expr_t *expr_datum,
+					   sepol_constraint_expr_t **expr)
+{
+	sepol_constraint_expr_t *tmp;
+	if (sepol_constraint_expr_create(handle, &tmp))
+		return STATUS_ERR;
+
+	/* Expr type */
+	switch (expr_datum->expr_type) {
+	case CEXPR_NOT:
+		if (sepol_constraint_expr_set_type(handle, tmp,
+						   SEPOL_CEXPR_TYPE_NOT))
+			goto err;
+		break;
+	case CEXPR_AND:
+		if (sepol_constraint_expr_set_type(handle, tmp,
+						   SEPOL_CEXPR_TYPE_AND))
+			goto err;
+		break;
+	case CEXPR_OR:
+		if (sepol_constraint_expr_set_type(handle, tmp,
+						   SEPOL_CEXPR_TYPE_OR))
+			goto err;
+		break;
+	case CEXPR_ATTR:
+		if (sepol_constraint_expr_set_type(handle, tmp,
+						   SEPOL_CEXPR_TYPE_ATTR))
+			goto err;
+		break;
+	case CEXPR_NAMES:
+		if (sepol_constraint_expr_set_type(handle, tmp,
+						   SEPOL_CEXPR_TYPE_NAMES))
+			goto err;
+		break;
+	default:
+		ERR(handle, "unknown constraint expression type %d",
+		    expr_datum->expr_type);
+		goto err;
+	}
+
+	if (expr_datum->expr_type == CEXPR_ATTR ||
+	    expr_datum->expr_type == CEXPR_NAMES) {
+		/* Expr attr - use bitmask checks since attr can be a combined value */
+		if (expr_datum->attr & CEXPR_USER)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_USER))
+				goto err;
+		if (expr_datum->attr & CEXPR_ROLE)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_ROLE))
+				goto err;
+		if (expr_datum->attr & CEXPR_TYPE)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_TYPE))
+				goto err;
+		if (expr_datum->attr & CEXPR_TARGET)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_TARGET))
+				goto err;
+		if (expr_datum->attr & CEXPR_XTARGET)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_XTARGET))
+				goto err;
+		if (expr_datum->attr & CEXPR_L1L2)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_L1L2))
+				goto err;
+		if (expr_datum->attr & CEXPR_L1H2)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_L1H2))
+				goto err;
+		if (expr_datum->attr & CEXPR_H1L2)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_H1L2))
+				goto err;
+		if (expr_datum->attr & CEXPR_H1H2)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_H1H2))
+				goto err;
+		if (expr_datum->attr & CEXPR_L1H1)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_L1H1))
+				goto err;
+		if (expr_datum->attr & CEXPR_L2H2)
+			if (sepol_constraint_expr_set_attr(
+				    handle, tmp, SEPOL_CEXPR_ATTR_L2H2))
+				goto err;
+		/* Expr op */
+		switch (expr_datum->op) {
+		case CEXPR_EQ:
+			if (sepol_constraint_expr_set_op(handle, tmp,
+							 SEPOL_CEXPR_OP_EQ))
+				goto err;
+			break;
+		case CEXPR_NEQ:
+			if (sepol_constraint_expr_set_op(handle, tmp,
+							 SEPOL_CEXPR_OP_NEQ))
+				goto err;
+			break;
+		case CEXPR_DOM:
+			if (sepol_constraint_expr_set_op(handle, tmp,
+							 SEPOL_CEXPR_OP_DOM))
+				goto err;
+			break;
+		case CEXPR_DOMBY:
+			if (sepol_constraint_expr_set_op(handle, tmp,
+							 SEPOL_CEXPR_OP_DOMBY))
+				goto err;
+			break;
+		case CEXPR_INCOMP:
+			if (sepol_constraint_expr_set_op(handle, tmp,
+							 SEPOL_CEXPR_OP_INCOMP))
+				goto err;
+			break;
+		default:
+			ERR(handle, "unknown constraint expression operator %d",
+			    expr_datum->op);
+			goto err;
+		}
+	}
+
+	/* Expr names */
+	if (expr_datum->expr_type == CEXPR_NAMES) {
+		const ebitmap_t *names = &expr_datum->names;
+		char **val_to_name = NULL;
+		uint32_t nprim = 0;
+		if (expr_datum->attr & CEXPR_USER) {
+			val_to_name = p->p_user_val_to_name;
+			nprim = p->p_users.nprim;
+		} else if (expr_datum->attr & CEXPR_ROLE) {
+			val_to_name = p->p_role_val_to_name;
+			nprim = p->p_roles.nprim;
+		} else if (expr_datum->attr & CEXPR_TYPE) {
+			/*
+			 * type_names->types is always populated here:
+			 * constraint_expr_init() unconditionally allocates
+			 * and initializes type_names, and both
+			 * type_set_read()/type_set_write() (policydb.c,
+			 * write.c) are called unconditionally for every
+			 * CEXPR_NAMES expression regardless of policy
+			 * version or policy_type. There used to be a
+			 * version carve-out here for kernel policies older
+			 * than POLICYDB_VERSION_CONSTRAINT_NAMES, but that
+			 * constant (and the policy versions it gated) were
+			 * removed upstream once POLICYDB_VERSION_MIN moved
+			 * past it (see commit "libsepol: drop support for
+			 * policy versions before xperms_ioctl/
+			 * xen_devicetree") -- every policy version this
+			 * library still supports already has it.
+			 */
+			if (expr_datum->type_names) {
+				names = &expr_datum->type_names->types;
+			} else {
+				goto err;
+			}
+			val_to_name = p->p_type_val_to_name;
+			nprim = p->p_types.nprim;
+		}
+		if (!val_to_name)
+			goto err;
+		ebitmap_node_t *n;
+		uint32_t bit;
+		ebitmap_for_each_positive_bit(names, n, bit) {
+			if (bit >= nprim)
+				goto err;
+			if (sepol_constraint_expr_add_name(handle, tmp,
+							   val_to_name[bit]))
+				goto err;
+		}
+	}
+
+	*expr = tmp;
+	return STATUS_SUCCESS;
+err:
+	sepol_constraint_expr_free(tmp);
+	*expr = NULL;
+	return STATUS_ERR;
+}
+
+struct add_perm_helper_args {
+	sepol_handle_t *handle;
+	const constraint_node_t *datum;
+	sepol_constraint_t *constraint;
+};
+
+static int add_perm_helper(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	perm_datum_t *perm = datum;
+	struct add_perm_helper_args *args = data;
+
+	if (args->datum->permissions & (UINT32_C(1) << (perm->s.value - 1)))
+		return sepol_constraint_add_perm(args->handle, args->constraint,
+						 key);
+	return 0;
+}
+
+static int constraint_datum_to_record(sepol_handle_t *handle,
+				      const policydb_t *p,
+				      const class_datum_t *class_datum,
+				      const constraint_node_t *constraint_datum,
+				      sepol_constraint_t **constraint)
+{
+	sepol_constraint_t *tmp;
+	sepol_constraint_expr_t *expr = NULL;
+	if (sepol_constraint_create(handle, &tmp))
+		return STATUS_ERR;
+
+	struct add_perm_helper_args args = {
+		.handle = handle,
+		.datum = constraint_datum,
+		.constraint = tmp,
+	};
+	if (hashtab_map(class_datum->permissions.table, add_perm_helper, &args))
+		goto err;
+	if (class_datum->comdatum &&
+	    hashtab_map(class_datum->comdatum->permissions.table,
+			add_perm_helper, &args))
+		goto err;
+
+	constraint_expr_t *expr_datum = constraint_datum->expr;
+	uint32_t index = 0;
+	while (expr_datum) {
+		if (constraint_expr_datum_to_record(handle, p, expr_datum,
+						    &expr))
+			goto err;
+		int rc = sepol_constraint_insert_expr(handle, tmp, index, expr);
+		if (rc)
+			goto err;
+		expr = NULL;
+		index++;
+		expr_datum = expr_datum->next;
+	}
+
+	*constraint = tmp;
+	return STATUS_SUCCESS;
+err:
+	sepol_constraint_free(tmp);
+	sepol_constraint_expr_free(expr);
+	*constraint = NULL;
+	return STATUS_ERR;
+}
+
+static int class_datum_to_record(sepol_handle_t *handle, const policydb_t *p,
+				 const class_datum_t *class_datum,
+				 sepol_class_t **cls)
+{
+	sepol_class_t *new_class = NULL;
+	sepol_constraint_t *constraint = NULL;
+
+	if (sepol_class_create(handle, &new_class))
+		goto err;
+
+	/* Copy name */
+	if (class_datum->s.value == 0 ||
+	    class_datum->s.value > p->p_classes.nprim)
+		goto err;
+	const char *name = p->p_class_val_to_name[class_datum->s.value - 1];
+	if (sepol_class_set_name(handle, new_class, name))
+		goto err;
+
+	/* Copy common */
+	if (sepol_class_set_common(handle, new_class, class_datum->comkey))
+		goto err;
+
+	/* Copy perms */
+	struct class_add_perm_args args = {
+		.handle = handle,
+		.cls = new_class,
+	};
+	if (hashtab_map(class_datum->permissions.table, class_add_perm, &args))
+		goto err;
+
+	for (constraint_node_t *constraint_datum = class_datum->constraints;
+	     constraint_datum != NULL;
+	     constraint_datum = constraint_datum->next) {
+		if (constraint_datum_to_record(handle, p, class_datum,
+					       constraint_datum, &constraint))
+			goto err;
+		if (sepol_class_add_constraint(handle, new_class, constraint))
+			goto err;
+		constraint = NULL;
+	}
+	for (constraint_node_t *validatetrans_datum =
+		     class_datum->validatetrans;
+	     validatetrans_datum != NULL;
+	     validatetrans_datum = validatetrans_datum->next) {
+		if (constraint_datum_to_record(handle, p, class_datum,
+					       validatetrans_datum,
+					       &constraint))
+			goto err;
+		if (sepol_class_add_validatetrans(handle, new_class,
+						  constraint))
+			goto err;
+		constraint = NULL;
+	}
+
+	/* Copy default */
+	if (sepol_class_set_default_user(
+		    handle, new_class, map_default(class_datum->default_user)))
+		goto err;
+	if (sepol_class_set_default_role(
+		    handle, new_class, map_default(class_datum->default_role)))
+		goto err;
+	if (sepol_class_set_default_type(
+		    handle, new_class, map_default(class_datum->default_type)))
+		goto err;
+	char default_range = 0;
+	switch (class_datum->default_range) {
+	case DEFAULT_SOURCE_LOW:
+		default_range = SEPOL_CLASS_DEFAULT_SOURCE_LOW;
+		break;
+	case DEFAULT_SOURCE_HIGH:
+		default_range = SEPOL_CLASS_DEFAULT_SOURCE_HIGH;
+		break;
+	case DEFAULT_SOURCE_LOW_HIGH:
+		default_range = SEPOL_CLASS_DEFAULT_SOURCE_LOW_HIGH;
+		break;
+	case DEFAULT_TARGET_LOW:
+		default_range = SEPOL_CLASS_DEFAULT_TARGET_LOW;
+		break;
+	case DEFAULT_TARGET_HIGH:
+		default_range = SEPOL_CLASS_DEFAULT_TARGET_HIGH;
+		break;
+	case DEFAULT_TARGET_LOW_HIGH:
+		default_range = SEPOL_CLASS_DEFAULT_TARGET_LOW_HIGH;
+		break;
+	case DEFAULT_GLBLUB:
+		default_range = SEPOL_CLASS_DEFAULT_GLBLUB;
+		break;
+	}
+	if (sepol_class_set_default_range(handle, new_class, default_range))
+		goto err;
+
+	*cls = new_class;
+	return STATUS_SUCCESS;
+
+err:
+	*cls = NULL;
+	if (new_class)
+		sepol_class_free(new_class);
+	sepol_constraint_free(constraint);
+
+	return STATUS_ERR;
+}
+
+DEFINE_VALUE_TO_NAME(sepol_class_value_to_name, "class", p_classes,
+		     p_class_val_to_name)
+
+int sepol_class_query_by_value(sepol_handle_t *handle,
+			       const sepol_policydb_t *p, uint32_t value,
+			       sepol_class_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	if (value < 1 || value > p->p.p_classes.nprim) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	class_datum_t *class_datum = p->p.class_val_to_struct[value - 1];
+	if (!class_datum) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return class_datum_to_record(handle, &p->p, class_datum, response);
+}
+
+struct perm_search {
+	uint32_t val;
+	const char *name;
+};
+
+static int match_perm_value(hashtab_key_t key, hashtab_datum_t datum,
+			    void *data)
+{
+	struct perm_search *s = data;
+	perm_datum_t *perm = (perm_datum_t *)datum;
+	if (perm->s.value == s->val) {
+		s->name = key;
+		return 1;
+	}
+	return 0;
+}
+
+int sepol_class_perm_value_to_name(sepol_handle_t *handle,
+				   const sepol_policydb_t *p,
+				   uint32_t class_value, uint32_t perm_value,
+				   const char **name)
+{
+	if (!name)
+		return STATUS_ERR;
+	if (!p) {
+		ERR(handle,
+		    "invalid argument to sepol_class_perm_value_to_name");
+		*name = NULL;
+		return STATUS_ERR;
+	}
+
+	if (class_value < 1 || class_value > p->p.p_classes.nprim) {
+		ERR(handle, "invalid class value %u", class_value);
+		*name = NULL;
+		return STATUS_ERR;
+	}
+
+	const class_datum_t *cladatum =
+		p->p.class_val_to_struct[class_value - 1];
+	if (!cladatum) {
+		ERR(handle, "no class datum for value %u", class_value);
+		*name = NULL;
+		return STATUS_ERR;
+	}
+
+	struct perm_search s = { .val = perm_value, .name = NULL };
+	int rc = hashtab_map(cladatum->permissions.table, match_perm_value, &s);
+	if (!rc && cladatum->comdatum)
+		rc = hashtab_map(cladatum->comdatum->permissions.table,
+				 match_perm_value, &s);
+
+	*name = (rc == 1) ? s.name : NULL;
+	return STATUS_SUCCESS;
+}
+
+/* Return the number of classes */
+int sepol_class_count(sepol_handle_t *handle __attribute__((unused)),
+		      const sepol_policydb_t *p, unsigned int *response)
+{
+	if (!p || !response)
+		return STATUS_ERR;
+
+	*response = p->p.p_classes.table->nel;
+	return STATUS_SUCCESS;
+}
+
+/* Check if the specified class exists */
+int sepol_class_exists(sepol_handle_t *handle __attribute__((unused)),
+		       const sepol_policydb_t *policydb,
+		       const sepol_class_key_t *key, int *response)
+{
+	if (!policydb || !response)
+		return STATUS_ERR;
+
+	const char *name;
+	sepol_class_key_unpack(key, &name);
+
+	*response = name &&
+		    hashtab_search(policydb->p.p_classes.table, name) != NULL;
+
+	return STATUS_SUCCESS;
+}
+
+/* Query a class - returns the class or NULL if not found */
+int sepol_class_query(sepol_handle_t *handle, const sepol_policydb_t *p,
+		      const sepol_class_key_t *key, sepol_class_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	const char *name;
+	sepol_class_key_unpack(key, &name);
+
+	if (!name) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	class_datum_t *class_datum = hashtab_search(p->p.p_classes.table, name);
+	if (!class_datum) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return class_datum_to_record(handle, &p->p, class_datum, response);
+}
+
+/* Iterators */
+int sepol_class_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			    sepol_class_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		ERR(handle, "invalid argument to sepol_class_iter_create");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	sepol_class_iter_t *new = malloc(sizeof(sepol_class_iter_t));
+	if (!new) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	new->p = p;
+	hashtab_iter_init(p->p.p_classes.table, &new->hashtab_iter);
+
+	*iter = new;
+
+	return STATUS_SUCCESS;
+}
+
+void sepol_class_iter_destroy(sepol_class_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_class_iter_next(sepol_handle_t *handle, sepol_class_iter_t *iter,
+			  sepol_class_t **item)
+{
+	char *key;
+	class_datum_t *datum;
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
+	return class_datum_to_record(handle, &iter->p->p, datum, item);
+}
diff --git a/libsepol/tests/test-iter-classes.c b/libsepol/tests/test-iter-classes.c
new file mode 100644
index 00000000..0d6b83dd
--- /dev/null
+++ b/libsepol/tests/test-iter-classes.c
@@ -0,0 +1,220 @@
+#include "test-iter-classes.h"
+
+#include <CUnit/CUnit.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/policydb.h>
+#include <sepol/class_record.h>
+#include <sepol/classes.h>
+#include <sepol/policydb/constraint.h>
+#include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/symtab.h>
+
+#include "helpers.h"
+
+extern sepol_handle_t *handle;
+extern sepol_policydb_t *empty_policy;
+extern sepol_policydb_t *iter_policy;
+extern int mls;
+
+/*
+ * CLASS1's constraints, from policies/test-iter/iter.conf:
+ *
+ *   constrain CLASS1 { PERM1 } ( t1 == { TYPE1 } );
+ *   constrain CLASS1 { PERM1 } ( ( r1 == ROLE1 ) or ( u2 == USER1 ) );
+ *   mlsconstrain CLASS1 { PERM1 } ( h1 dom h2 );   -- MLS builds only
+ *
+ * The middle constraint's expression is a boolean combination (`or`),
+ * which is represented as multiple constraint_expr nodes in an
+ * unspecified (postfix) order, so it is not practical to assert its
+ * exact expression list here. Instead, verify_class1_constraints()
+ * below checks the one property shared by every CLASS1 constraint
+ * (permissions == {PERM1}) plus the exact expression contents of the
+ * single unambiguous, single-expression constraint (`t1 == TYPE1`).
+ */
+
+struct expected_class {
+	int seen;
+
+	const char *name;
+	const char *common;
+	uint32_t nperms;
+	const char *perms[32];
+	char default_user;
+	char default_role;
+	char default_type;
+	char default_range;
+};
+
+struct expected_class expected_classes[] = {
+	{ 0, "CLASS1", "COMMON1", 2, { "PERM1", "ioctl" }, 0, 0, 0, 0 },
+	{ 0, "CLASS01", NULL, 1, { "PERM01" }, 0, 0, 0, 0 },
+	{ 0, "CLASS02", NULL, 1, { "PERM02" }, 0, 0, 0, 0 },
+	{ 0, "CLASS03", NULL, 1, { "PERM03" }, 0, 0, 0, 0 },
+	{ 0, "CLASS04", NULL, 1, { "PERM04" }, 0, 0, 0, 0 },
+	{ 0, "CLASS05", NULL, 1, { "PERM05" }, 0, 0, 0, 0 },
+	{ 0, "CLASS06", NULL, 1, { "PERM06" }, 0, 0, 0, 0 },
+	{ 0, NULL, NULL, 0, { NULL }, 0, 0, 0, 0 },
+};
+
+static void verify_class1_constraints(const sepol_constraint_t **constraints,
+				      uint32_t nconstraints)
+{
+	int found_type_names_constraint = 0;
+
+	/* Two plain `constrain` statements always apply; the `mlsconstrain`
+	 * only applies to MLS builds. */
+	CU_ASSERT_EQUAL(nconstraints, mls ? 3u : 2u);
+
+	for (uint32_t i = 0; i < nconstraints; i++) {
+		const char **perms = NULL;
+		uint32_t nperms = 0;
+		CU_ASSERT_EQUAL_FATAL(
+			sepol_constraint_get_perms(handle, constraints[i],
+						   &perms, &nperms),
+			0);
+		CU_ASSERT_EQUAL(nperms, 1);
+		if (nperms == 1)
+			CU_ASSERT_STRING_EQUAL(perms[0], "PERM1");
+		free(perms);
+
+		const sepol_constraint_expr_t **exprs = NULL;
+		uint32_t nexprs = 0;
+		CU_ASSERT_EQUAL_FATAL(
+			sepol_constraint_get_exprs(handle, constraints[i],
+						   &exprs, &nexprs),
+			0);
+
+		if (nexprs == 1 &&
+		    sepol_constraint_expr_get_type(exprs[0]) ==
+			    SEPOL_CEXPR_TYPE_NAMES &&
+		    sepol_constraint_expr_get_op(exprs[0]) ==
+			    SEPOL_CEXPR_OP_EQ &&
+		    sepol_constraint_expr_has_attr(exprs[0],
+						   SEPOL_CEXPR_ATTR_TYPE)) {
+			const char **names = NULL;
+			uint32_t nnames = 0;
+			CU_ASSERT_EQUAL_FATAL(sepol_constraint_expr_get_names(
+						      handle, exprs[0], &names,
+						      &nnames),
+					      0);
+			if (nnames == 1 && names[0] &&
+			    !strcmp(names[0], "TYPE1"))
+				found_type_names_constraint = 1;
+			free(names);
+		}
+		free(exprs);
+	}
+
+	CU_ASSERT_TRUE(found_type_names_constraint);
+}
+
+static void unseen(void)
+{
+	for (struct expected_class *e = expected_classes; e->name; e++) {
+		e->seen = 0;
+	}
+}
+
+static void seen(const sepol_class_t *item)
+{
+	const char *actual_name = sepol_class_get_name(item);
+	const char *actual_common = sepol_class_get_common(item);
+	uint32_t nactual_perms;
+	const char **actual_perms;
+	CU_ASSERT_EQUAL_FATAL(sepol_class_get_perms(handle, item, &actual_perms,
+						    &nactual_perms),
+			      0);
+	uint32_t nactual_constraints;
+	const sepol_constraint_t **actual_constraints;
+	CU_ASSERT_EQUAL_FATAL(sepol_class_get_constraints(handle, item,
+							  &actual_constraints,
+							  &nactual_constraints),
+			      0);
+	char actual_default_user = sepol_class_get_default_user(item);
+	char actual_default_role = sepol_class_get_default_role(item);
+	char actual_default_type = sepol_class_get_default_type(item);
+	char actual_default_range = sepol_class_get_default_range(item);
+
+	struct expected_class *e;
+	for (e = expected_classes; e->name; e++) {
+		if (strcmp(actual_name, e->name) == 0)
+			break;
+	}
+	CU_ASSERT_PTR_NOT_NULL_FATAL(e->name);
+	e->seen = 1;
+
+	if (e->common) {
+		CU_ASSERT_STRING_EQUAL(actual_common, e->common);
+	} else {
+		CU_ASSERT_PTR_NULL(actual_common);
+	}
+
+	CU_ASSERT_EQUAL(nactual_perms, e->nperms);
+	/* qsort()'s base is declared nonnull; skip the call entirely for
+	 * an empty (possibly NULL) array rather than relying on nmemb==0
+	 * making the NULL harmless. */
+	if (nactual_perms > 0)
+		qsort(actual_perms, nactual_perms, sizeof(char *), qstrcmp);
+	for (size_t i = 0; i < nactual_perms && i < e->nperms; i++) {
+		CU_ASSERT_STRING_EQUAL(actual_perms[i], e->perms[i]);
+	}
+
+	if (strcmp(e->name, "CLASS1") == 0)
+		verify_class1_constraints(actual_constraints,
+					  nactual_constraints);
+	else
+		CU_ASSERT_EQUAL(nactual_constraints, 0);
+
+	CU_ASSERT_EQUAL(actual_default_user, e->default_user);
+	CU_ASSERT_EQUAL(actual_default_role, e->default_role);
+	CU_ASSERT_EQUAL(actual_default_type, e->default_type);
+	CU_ASSERT_EQUAL(actual_default_range, e->default_range);
+
+	free(actual_perms);
+	free(actual_constraints);
+}
+
+void test_iter_classes_empty(void)
+{
+	sepol_class_iter_t *class_iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_class_iter_create(handle, empty_policy, &class_iter), 0);
+
+	sepol_class_t *item;
+	CU_ASSERT_EQUAL(sepol_class_iter_next(handle, class_iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+	CU_ASSERT_EQUAL(sepol_class_iter_next(handle, class_iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+
+	sepol_class_iter_destroy(class_iter);
+}
+
+void test_iter_classes_non_empty(void)
+{
+	unseen();
+	sepol_class_t *item;
+	sepol_class_iter_t *class_iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_class_iter_create(handle, iter_policy, &class_iter), 0);
+
+	while (1) {
+		CU_ASSERT_EQUAL(
+			sepol_class_iter_next(handle, class_iter, &item), 0);
+		if (!item)
+			break;
+		seen(item);
+		sepol_class_free(item);
+	}
+	CU_ASSERT_EQUAL(sepol_class_iter_next(handle, class_iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+
+	for (struct expected_class *e = expected_classes; e->name; e++) {
+		CU_ASSERT_TRUE(e->seen);
+	}
+
+	sepol_class_iter_destroy(class_iter);
+}
diff --git a/libsepol/tests/test-iter-classes.h b/libsepol/tests/test-iter-classes.h
new file mode 100644
index 00000000..e85bab43
--- /dev/null
+++ b/libsepol/tests/test-iter-classes.h
@@ -0,0 +1,7 @@
+#ifndef TEST_ITER_CLASSES_H
+#define TEST_ITER_CLASSES_H
+
+void test_iter_classes_empty(void);
+void test_iter_classes_non_empty(void);
+
+#endif
diff --git a/libsepol/tests/test-iter.c b/libsepol/tests/test-iter.c
index 7c58c36d..4c57459a 100644
--- a/libsepol/tests/test-iter.c
+++ b/libsepol/tests/test-iter.c
@@ -13,6 +13,7 @@
 #include "test-iter-types.h"
 #include "test-iter-users.h"
 #include "test-iter-roles.h"
+#include "test-iter-classes.h"
 
 extern int mls;
 
@@ -106,5 +107,11 @@ int iter_add_tests(CU_pSuite suite)
 	if (CU_add_test(suite, "iter_roles_non_empty",
 			test_iter_roles_non_empty) == NULL)
 		return CU_get_error();
+	if (CU_add_test(suite, "iter_classes_empty", test_iter_classes_empty) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "iter_classes_non_empty",
+			test_iter_classes_non_empty) == NULL)
+		return CU_get_error();
 	return 0;
 }
-- 
2.55.0

