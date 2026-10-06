Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50D457E53
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291872; cv=none; b=C9CWvlyMZ/xkWIgqEPZwjPUd2dRAN5zfXscfmtqGSwZog+m7VJTFtZcyy9/6M7Z3YPQW2xRDgSoRlFiqYQQ1pnVRiDHVI2TuXr3/fwYEsIiaNM8EiI2cNN6WqyNXufepnVmMVsE09LoHyWFx3wOaQ0/2cKo+sCg1iD4wStXYF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291872; c=relaxed/simple;
	bh=JHn7xhw8/xCK6uT0TzODAQ9N5jxFM2ImMKd/3d5Fg3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjX9/rpNFNC8umlYB3aP7cpjeqaFlTSbRgfoH4J7U5UF0X8cKrX0IEpJ/KyStV1JJtIystXhXGyMei+KQXofjl3sAgNWK4AWuiZiSGuhA+PkAllLFsaJFJDhTtrKaeLyH47qZq+NrJ+XGd178D/9bxo4VMPa1gqHIvHtYfm3YBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjleSFjp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjleSFjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPtqS9F5AeT9oYnyXrExe8eavctOZHGakvOdlMX5eGY=;
	b=FjleSFjpL6TZ3KvFEOQYaIZR2SsuDV/oUJvFPYF3fydllVQsgjetufizQpEgPS3OizDSn4
	nOMc9Jg94bXxVB7p0vB2+58LZyhx4wxXwkq/iaDE4vdzr3ABAjb1VlnmbaBhZ8qATxV9X6
	jN85iEoY829+FMxPrUFNImaC8vKI1FA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-lDfTTj3BMeSxsXSLKpr3bw-1; Tue,
 06 Oct 2026 09:04:27 -0400
X-MC-Unique: lDfTTj3BMeSxsXSLKpr3bw-1
X-Mimecast-MFC-AGG-ID: lDfTTj3BMeSxsXSLKpr3bw_1791291867
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCA77196C40B
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:26 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C07051944CC0;
	Tue,  6 Oct 2026 13:04:25 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 11/17] libsepol: add AV rule, conditional, and boolean iterators
Date: Tue,  6 Oct 2026 15:02:09 +0200
Message-ID: <20261006130215.128405-12-jjanasek@redhat.com>
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

Add sepol_avtab_iter for iterating AV/type/xperm rules with
source/target type, class, and permission accessors, plus
sepol_perm_iter and sepol_xperm_iter sub-iterators for decoding a
permission bitmask or xperm bitmap into names/values.

Add sepol_cond_iter, sepol_cond_expr_iter, and sepol_cond_rule_iter
for inspecting conditional expressions and their true/false rule
lists, sharing accessor helpers with sepol_avtab_iter via
av_rule_internal.h.

Add sepol_bool_iter, sepol_bool_value_to_name(), and
sepol_bool_query_by_value() for boolean definitions. Fix a potential
out-of-bounds access in bool_to_record and harden boolean_record
accessors against NULL arguments.

Add sepol_policydb_av_to_string() and
sepol_policydb_extended_perms_to_string(), public wrappers around the
existing internal av-to-string helpers that take a sepol_policydb_t
instead of an internal policydb_t.

Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/av_rule.h     | 119 ++++++++++
 libsepol/include/sepol/booleans.h    |  29 +++
 libsepol/include/sepol/conditional.h | 109 +++++++++
 libsepol/src/av_rule.c               | 328 +++++++++++++++++++++++++++
 libsepol/src/av_rule_internal.h      |  60 +++++
 libsepol/src/boolean_record.c        |  41 +++-
 libsepol/src/booleans.c              | 174 +++++++++++---
 libsepol/src/conditional_public.c    | 261 +++++++++++++++++++++
 8 files changed, 1085 insertions(+), 36 deletions(-)
 create mode 100644 libsepol/include/sepol/av_rule.h
 create mode 100644 libsepol/include/sepol/conditional.h
 create mode 100644 libsepol/src/av_rule.c
 create mode 100644 libsepol/src/av_rule_internal.h
 create mode 100644 libsepol/src/conditional_public.c

diff --git a/libsepol/include/sepol/av_rule.h b/libsepol/include/sepol/av_rule.h
new file mode 100644
index 00000000..0716bd22
--- /dev/null
+++ b/libsepol/include/sepol/av_rule.h
@@ -0,0 +1,119 @@
+#ifndef _SEPOL_AV_RULE_H_
+#define _SEPOL_AV_RULE_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* --- Avtab entry iterator --- */
+
+struct sepol_avtab_iter;
+typedef struct sepol_avtab_iter sepol_avtab_iter_t;
+
+/*
+ * Create an iterator over unconditional TE rules (te_avtab).
+ * If 'specified' is 0, all rule types are returned. Otherwise it is a
+ * bitmask of AVTAB_* flags (from constants.h) to filter by.
+ *
+ * Iteration order is unspecified (currently hash-bucket order of the
+ * internal avtab) and may change between library versions or policydb
+ * loads; callers must not rely on it matching rule declaration order.
+ */
+extern int sepol_avtab_iter_create(sepol_handle_t *handle,
+				   const sepol_policydb_t *p,
+				   uint32_t specified,
+				   sepol_avtab_iter_t **iter);
+
+extern void sepol_avtab_iter_destroy(sepol_avtab_iter_t *iter);
+
+/*
+ * Advance to the next entry. When done, sets *ruletype to 0.
+ * Values are 1-based; resolve with sepol_*_value_to_name().
+ */
+extern int sepol_avtab_iter_next(sepol_handle_t *handle,
+				 sepol_avtab_iter_t *iter, uint32_t *ruletype,
+				 uint32_t *source_type, uint32_t *target_type,
+				 uint32_t *target_class);
+
+/* For AV rules: permission bitmask (inverted for AVTAB_AUDITDENY). */
+extern uint32_t sepol_avtab_iter_get_av_data(const sepol_avtab_iter_t *iter);
+
+/* For type rules: 1-based default type value. */
+extern uint32_t sepol_avtab_iter_get_type_data(const sepol_avtab_iter_t *iter);
+
+/* For xperm rules: kind (AVTAB_XPERMS_IOCTLFUNCTION etc.). */
+extern uint8_t sepol_avtab_iter_get_xperm_type(const sepol_avtab_iter_t *iter);
+
+/* For xperm rules: driver/command group. */
+extern uint8_t
+sepol_avtab_iter_get_xperm_driver(const sepol_avtab_iter_t *iter);
+
+/* --- Permission name sub-iterator --- */
+
+struct sepol_perm_iter;
+typedef struct sepol_perm_iter sepol_perm_iter_t;
+
+/*
+ * Decode a permission bitmask into individual permission names for
+ * the given class. 'target_class' is 1-based.
+ */
+extern int sepol_perm_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  uint32_t target_class, uint32_t perm_data,
+				  sepol_perm_iter_t **iter);
+
+extern void sepol_perm_iter_destroy(sepol_perm_iter_t *iter);
+
+/* Returns the next permission name, or NULL when done.
+ * The pointer is borrowed from the policydb and must not be freed.
+ * It remains valid only while the sepol_policydb_t is alive. */
+extern int sepol_perm_iter_next(sepol_handle_t *handle, sepol_perm_iter_t *iter,
+				const char **perm_name);
+
+/* --- Extended permission value sub-iterator --- */
+
+struct sepol_xperm_iter;
+typedef struct sepol_xperm_iter sepol_xperm_iter_t;
+
+/*
+ * Create an iterator over xperm values (0-255) from the current
+ * avtab entry's xperms bitmap.
+ */
+extern int sepol_xperm_iter_create(sepol_handle_t *handle,
+				   const sepol_avtab_iter_t *iter,
+				   sepol_xperm_iter_t **xperm_iter);
+
+extern void sepol_xperm_iter_destroy(sepol_xperm_iter_t *xperm_iter);
+
+/* Get the next xperm value. Sets *has_next to 0 when done. */
+extern int sepol_xperm_iter_next(sepol_handle_t *handle,
+				 sepol_xperm_iter_t *xperm_iter,
+				 uint16_t *value, int *has_next);
+
+/*
+ * Format an access-vector permission bitmask as a space-separated list of
+ * permission names for the given class (1-based). Returns a newly allocated
+ * string (caller must free), or NULL on error.
+ */
+extern char *sepol_policydb_av_to_string(const sepol_policydb_t *policydb,
+					 uint32_t class_val, uint32_t av);
+
+/*
+ * Format extended permissions (ioctl driver/function or netlink message) as a
+ * human-readable string. 'specified' is an AVTAB_XPERMS_* kind,
+ * 'driver' is the driver/group byte, and 'perms' is the 8-byte bitmap.
+ * Returns a newly allocated string (caller must free), or NULL on error.
+ */
+extern char *sepol_policydb_extended_perms_to_string(uint8_t specified,
+						     uint8_t driver,
+						     const uint32_t perms[8]);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/booleans.h b/libsepol/include/sepol/booleans.h
index 55029901..ed68558d 100644
--- a/libsepol/include/sepol/booleans.h
+++ b/libsepol/include/sepol/booleans.h
@@ -2,6 +2,7 @@
 #define _SEPOL_BOOLEANS_H_
 
 #include <stddef.h>
+#include <stdint.h>
 #include <sepol/policydb.h>
 #include <sepol/boolean_record.h>
 #include <sepol/handle.h>
@@ -40,6 +41,34 @@ sepol_bool_iterate(sepol_handle_t *handle, const sepol_policydb_t *policydb,
 		   int (*fn)(const sepol_bool_t *boolean, void *fn_arg),
 		   void *arg);
 
+/* Look up the name of a boolean by its 1-based value.
+ * Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_bool_value_to_name(sepol_handle_t *handle,
+				    const sepol_policydb_t *p, uint32_t value,
+				    const char **name);
+
+extern int sepol_bool_query_by_value(sepol_handle_t *handle,
+				     const sepol_policydb_t *p, uint32_t value,
+				     sepol_bool_t **response);
+
+typedef struct sepol_bool_iter sepol_bool_iter_t;
+
+/*
+ * Iteration order follows ascending internal value assignment, which
+ * typically -- but is not guaranteed to -- match declaration order;
+ * callers should not treat it as a stable guarantee across policydb
+ * versions.
+ */
+extern int sepol_bool_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_bool_iter_t **iter);
+
+extern void sepol_bool_iter_destroy(sepol_bool_iter_t *iter);
+
+extern int sepol_bool_iter_next(sepol_handle_t *handle, sepol_bool_iter_t *iter,
+				sepol_bool_t **item);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/conditional.h b/libsepol/include/sepol/conditional.h
new file mode 100644
index 00000000..9a485243
--- /dev/null
+++ b/libsepol/include/sepol/conditional.h
@@ -0,0 +1,109 @@
+#ifndef _SEPOL_CONDITIONAL_H_
+#define _SEPOL_CONDITIONAL_H_
+
+#include <sepol/av_rule.h>
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define SEPOL_COND_BOOL 1
+#define SEPOL_COND_NOT 2
+#define SEPOL_COND_OR 3
+#define SEPOL_COND_AND 4
+#define SEPOL_COND_XOR 5
+#define SEPOL_COND_EQ 6
+#define SEPOL_COND_NEQ 7
+
+/* --- Conditional block iterator --- */
+
+struct sepol_cond_iter;
+typedef struct sepol_cond_iter sepol_cond_iter_t;
+
+extern int sepol_cond_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_cond_iter_t **iter);
+
+extern void sepol_cond_iter_destroy(sepol_cond_iter_t *iter);
+
+/*
+ * Advance to the next conditional block.
+ * Sets *has_next to 0 when done.
+ */
+extern int sepol_cond_iter_next(sepol_handle_t *handle, sepol_cond_iter_t *iter,
+				int *has_next);
+
+/* --- Conditional expression sub-iterator --- */
+
+struct sepol_cond_expr_iter;
+typedef struct sepol_cond_expr_iter sepol_cond_expr_iter_t;
+
+extern int sepol_cond_expr_iter_create(sepol_handle_t *handle,
+				       const sepol_cond_iter_t *cond_iter,
+				       sepol_cond_expr_iter_t **iter);
+
+extern void sepol_cond_expr_iter_destroy(sepol_cond_expr_iter_t *iter);
+
+/*
+ * Get the next expression node (reverse polish notation).
+ * Sets *expr_type to 0 when done.
+ * For SEPOL_COND_BOOL, *bool_value is the 1-based boolean value;
+ * for operators it is unused.
+ */
+extern int sepol_cond_expr_iter_next(sepol_handle_t *handle,
+				     sepol_cond_expr_iter_t *iter,
+				     uint32_t *expr_type, uint32_t *bool_value);
+
+/* --- Conditional rule list sub-iterator --- */
+
+struct sepol_cond_rule_iter;
+typedef struct sepol_cond_rule_iter sepol_cond_rule_iter_t;
+
+/*
+ * Create an iterator over the true (is_true_list=1) or false
+ * (is_true_list=0) rule list of the current conditional block.
+ */
+extern int sepol_cond_rule_iter_create(sepol_handle_t *handle,
+				       const sepol_cond_iter_t *cond_iter,
+				       int is_true_list,
+				       sepol_cond_rule_iter_t **iter);
+
+extern void sepol_cond_rule_iter_destroy(sepol_cond_rule_iter_t *iter);
+
+/*
+ * Get the next conditional rule. Sets *ruletype to 0 when done.
+ */
+extern int sepol_cond_rule_iter_next(sepol_handle_t *handle,
+				     sepol_cond_rule_iter_t *iter,
+				     uint32_t *ruletype, uint32_t *source_type,
+				     uint32_t *target_type,
+				     uint32_t *target_class);
+
+extern uint32_t
+sepol_cond_rule_iter_get_av_data(const sepol_cond_rule_iter_t *iter);
+
+extern uint32_t
+sepol_cond_rule_iter_get_type_data(const sepol_cond_rule_iter_t *iter);
+
+extern uint8_t
+sepol_cond_rule_iter_get_xperm_type(const sepol_cond_rule_iter_t *iter);
+
+extern uint8_t
+sepol_cond_rule_iter_get_xperm_driver(const sepol_cond_rule_iter_t *iter);
+
+/*
+ * Create an xperm sub-iterator from the current conditional rule entry.
+ * Reuses sepol_xperm_iter_t from av_rule.h.
+ */
+extern int sepol_cond_rule_xperm_iter_create(sepol_handle_t *handle,
+					     const sepol_cond_rule_iter_t *iter,
+					     sepol_xperm_iter_t **xperm_iter);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/av_rule.c b/libsepol/src/av_rule.c
new file mode 100644
index 00000000..ff5564ea
--- /dev/null
+++ b/libsepol/src/av_rule.c
@@ -0,0 +1,328 @@
+#include <sepol/av_rule.h>
+#include <sepol/constants.h>
+
+#include <sepol/policydb/avtab.h>
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/util.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "av_rule_internal.h"
+#include "debug.h"
+
+/* --- Avtab iterator --- */
+
+struct sepol_avtab_iter {
+	const sepol_policydb_t *p;
+	const avtab_t *avtab;
+	uint32_t bucket;
+	avtab_ptr_t node;
+	uint32_t specified_filter;
+	const avtab_datum_t *last_datum;
+	uint16_t last_specified;
+};
+
+static void avtab_iter_advance(sepol_avtab_iter_t *iter)
+{
+	while (iter->bucket < iter->avtab->nslot) {
+		while (iter->node) {
+			uint16_t spec = iter->node->key.specified;
+			if (!iter->specified_filter ||
+			    (spec & iter->specified_filter))
+				return;
+			iter->node = iter->node->next;
+		}
+		iter->bucket++;
+		if (iter->bucket < iter->avtab->nslot)
+			iter->node = iter->avtab->htable[iter->bucket];
+	}
+}
+
+int sepol_avtab_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			    uint32_t specified, sepol_avtab_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_avtab_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	tmp->p = p;
+	tmp->avtab = &p->p.te_avtab;
+	tmp->specified_filter = specified;
+	tmp->bucket = 0;
+	tmp->node = tmp->avtab->nslot > 0 ? tmp->avtab->htable[0] : NULL;
+	tmp->last_datum = NULL;
+	tmp->last_specified = 0;
+
+	avtab_iter_advance(tmp);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_avtab_iter_destroy(sepol_avtab_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_avtab_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			  sepol_avtab_iter_t *iter, uint32_t *ruletype,
+			  uint32_t *source_type, uint32_t *target_type,
+			  uint32_t *target_class)
+{
+	if (!iter || !ruletype || !source_type || !target_type || !target_class)
+		return STATUS_ERR;
+
+	if (iter->bucket >= iter->avtab->nslot || !iter->node) {
+		iter->last_datum = NULL;
+		iter->last_specified = 0;
+		*ruletype = 0;
+		*source_type = 0;
+		*target_type = 0;
+		*target_class = 0;
+		return STATUS_SUCCESS;
+	}
+
+	avtab_key_t *key = &iter->node->key;
+	iter->last_datum = &iter->node->datum;
+	iter->last_specified = key->specified;
+
+	*ruletype = key->specified & ~AVTAB_ENABLED;
+	*source_type = key->source_type;
+	*target_type = key->target_type;
+	*target_class = key->target_class;
+
+	iter->node = iter->node->next;
+	avtab_iter_advance(iter);
+
+	return STATUS_SUCCESS;
+}
+
+uint32_t sepol_avtab_iter_get_av_data(const sepol_avtab_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_av_data(iter->last_datum, iter->last_specified);
+}
+
+uint32_t sepol_avtab_iter_get_type_data(const sepol_avtab_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_type_data(iter->last_datum);
+}
+
+uint8_t sepol_avtab_iter_get_xperm_type(const sepol_avtab_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_xperm_type(iter->last_datum);
+}
+
+uint8_t sepol_avtab_iter_get_xperm_driver(const sepol_avtab_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_xperm_driver(iter->last_datum);
+}
+
+/* --- Permission name sub-iterator --- */
+
+struct sepol_perm_iter {
+	const policydb_t *p;
+	uint32_t target_class;
+	uint32_t perm_data;
+	uint32_t current_bit;
+};
+
+int sepol_perm_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   uint32_t target_class, uint32_t perm_data,
+			   sepol_perm_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (target_class < 1 || target_class > p->p.p_classes.nprim) {
+		ERR(handle, "invalid class value %u", target_class);
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_perm_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	tmp->p = &p->p;
+	tmp->target_class = target_class;
+	tmp->perm_data = perm_data;
+	tmp->current_bit = 0;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_perm_iter_destroy(sepol_perm_iter_t *iter)
+{
+	free(iter);
+}
+
+struct perm_search_data {
+	uint32_t val;
+	const char *name;
+};
+
+static int find_perm_name(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	struct perm_search_data *d = data;
+	perm_datum_t *perm = datum;
+	if (perm->s.value == d->val) {
+		d->name = key;
+		return 1;
+	}
+	return 0;
+}
+
+int sepol_perm_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			 sepol_perm_iter_t *iter, const char **perm_name)
+{
+	if (!iter || !perm_name)
+		return STATUS_ERR;
+
+	const class_datum_t *cladatum =
+		iter->p->class_val_to_struct[iter->target_class - 1];
+	if (!cladatum) {
+		*perm_name = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	while (iter->current_bit < cladatum->permissions.nprim &&
+	       iter->current_bit < sizeof(iter->perm_data) * 8) {
+		uint32_t bit = iter->current_bit++;
+		if (!(iter->perm_data & (UINT32_C(1) << bit)))
+			continue;
+
+		struct perm_search_data d = { .val = bit + 1, .name = NULL };
+		int rc = hashtab_map(cladatum->permissions.table,
+				     find_perm_name, &d);
+		if (!rc && cladatum->comdatum) {
+			rc = hashtab_map(cladatum->comdatum->permissions.table,
+					 find_perm_name, &d);
+		}
+		if (rc == 1 && d.name) {
+			*perm_name = d.name;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*perm_name = NULL;
+	return STATUS_SUCCESS;
+}
+
+/* --- Xperm value sub-iterator (struct in av_rule_internal.h) --- */
+
+int sepol_xperm_iter_create_from_datum(sepol_handle_t *handle,
+				       const avtab_extended_perms_t *xperms,
+				       sepol_xperm_iter_t **xperm_iter)
+{
+	if (!xperm_iter)
+		return STATUS_ERR;
+	if (!xperms) {
+		*xperm_iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_xperm_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*xperm_iter = NULL;
+		return STATUS_ERR;
+	}
+	memcpy(tmp->perms, xperms->perms, sizeof(tmp->perms));
+	tmp->current_bit = 0;
+
+	*xperm_iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+int sepol_xperm_iter_create(sepol_handle_t *handle,
+			    const sepol_avtab_iter_t *iter,
+			    sepol_xperm_iter_t **xperm_iter)
+{
+	if (!xperm_iter)
+		return STATUS_ERR;
+	if (!iter) {
+		*xperm_iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (!iter->last_datum || !iter->last_datum->xperms) {
+		ERR(handle, "no xperms data on current avtab entry");
+		*xperm_iter = NULL;
+		return STATUS_ERR;
+	}
+
+	return sepol_xperm_iter_create_from_datum(
+		handle, iter->last_datum->xperms, xperm_iter);
+}
+
+void sepol_xperm_iter_destroy(sepol_xperm_iter_t *xperm_iter)
+{
+	free(xperm_iter);
+}
+
+int sepol_xperm_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			  sepol_xperm_iter_t *xperm_iter, uint16_t *value,
+			  int *has_next)
+{
+	if (!xperm_iter || !value || !has_next)
+		return STATUS_ERR;
+
+	while (xperm_iter->current_bit < 256) {
+		uint16_t bit = xperm_iter->current_bit++;
+		if (xperm_test(bit, xperm_iter->perms)) {
+			*value = bit;
+			*has_next = 1;
+			return STATUS_SUCCESS;
+		}
+	}
+	*value = 0;
+	*has_next = 0;
+	return STATUS_SUCCESS;
+}
+
+char *sepol_policydb_av_to_string(const sepol_policydb_t *policydb,
+				  uint32_t class_val, uint32_t av)
+{
+	if (!policydb)
+		return NULL;
+	return sepol_av_to_string(&policydb->p, class_val, av);
+}
+
+char *sepol_policydb_extended_perms_to_string(uint8_t specified, uint8_t driver,
+					      const uint32_t perms[8])
+{
+	avtab_extended_perms_t xperms;
+
+	if (!perms)
+		return NULL;
+
+	memset(&xperms, 0, sizeof(xperms));
+	xperms.specified = specified;
+	xperms.driver = driver;
+	memcpy(xperms.perms, perms, sizeof(xperms.perms));
+	return sepol_extended_perms_to_string(&xperms);
+}
diff --git a/libsepol/src/av_rule_internal.h b/libsepol/src/av_rule_internal.h
new file mode 100644
index 00000000..592899d3
--- /dev/null
+++ b/libsepol/src/av_rule_internal.h
@@ -0,0 +1,60 @@
+#ifndef _SEPOL_AV_RULE_INTERNAL_H_
+#define _SEPOL_AV_RULE_INTERNAL_H_
+
+#include <sepol/av_rule.h>
+#include <sepol/constants.h>
+#include <sepol/policydb/avtab.h>
+#include <stdint.h>
+
+struct sepol_xperm_iter {
+	uint32_t perms[8];
+	uint16_t current_bit;
+};
+
+/* Internal helper - not part of the public ABI. */
+extern int
+sepol_xperm_iter_create_from_datum(sepol_handle_t *handle,
+				   const avtab_extended_perms_t *xperms,
+				   sepol_xperm_iter_t **xperm_iter);
+
+/*
+ * sepol_avtab_iter and sepol_cond_rule_iter both cache the last-visited
+ * avtab_datum_t + its "specified" bits so their get_{av,type}_data() and
+ * get_xperm_{type,driver}() accessors can be implemented identically here,
+ * rather than duplicated verbatim in av_rule.c and conditional_public.c.
+ */
+static inline uint32_t avtab_datum_get_av_data(const avtab_datum_t *last_datum,
+					       uint16_t last_specified)
+{
+	if (!last_datum)
+		return 0;
+	if (last_specified & AVTAB_AUDITDENY)
+		return ~last_datum->data;
+	return last_datum->data;
+}
+
+static inline uint32_t
+avtab_datum_get_type_data(const avtab_datum_t *last_datum)
+{
+	if (!last_datum)
+		return 0;
+	return last_datum->data;
+}
+
+static inline uint8_t
+avtab_datum_get_xperm_type(const avtab_datum_t *last_datum)
+{
+	if (!last_datum || !last_datum->xperms)
+		return 0;
+	return last_datum->xperms->specified;
+}
+
+static inline uint8_t
+avtab_datum_get_xperm_driver(const avtab_datum_t *last_datum)
+{
+	if (!last_datum || !last_datum->xperms)
+		return 0;
+	return last_datum->xperms->driver;
+}
+
+#endif
diff --git a/libsepol/src/boolean_record.c b/libsepol/src/boolean_record.c
index fa650a3c..96deadb5 100644
--- a/libsepol/src/boolean_record.c
+++ b/libsepol/src/boolean_record.c
@@ -21,6 +21,11 @@ struct sepol_bool_key {
 int sepol_bool_key_create(sepol_handle_t *handle, const char *name,
 			  sepol_bool_key_t **key_ptr)
 {
+	if (!name) {
+		ERR(handle, "name is NULL");
+		return STATUS_ERR;
+	}
+
 	sepol_bool_key_t *tmp_key =
 		(sepol_bool_key_t *)malloc(sizeof(struct sepol_bool_key));
 
@@ -44,12 +49,17 @@ int sepol_bool_key_create(sepol_handle_t *handle, const char *name,
 
 void sepol_bool_key_unpack(const sepol_bool_key_t *key, const char **name)
 {
-	*name = key->name;
+	*name = key ? key->name : NULL;
 }
 
 int sepol_bool_key_extract(sepol_handle_t *handle, const sepol_bool_t *boolean,
 			   sepol_bool_key_t **key_ptr)
 {
+	if (!boolean || !boolean->name) {
+		ERR(handle, "boolean name is NULL");
+		return STATUS_ERR;
+	}
+
 	if (sepol_bool_key_create(handle, boolean->name, key_ptr) < 0) {
 		ERR(handle, "could not extract key from boolean %s",
 		    boolean->name);
@@ -69,24 +79,32 @@ void sepol_bool_key_free(sepol_bool_key_t *key)
 
 int sepol_bool_compare(const sepol_bool_t *boolean, const sepol_bool_key_t *key)
 {
+	if (!boolean || !key || !boolean->name || !key->name)
+		return -1;
 	return strcmp(boolean->name, key->name);
 }
 
 int sepol_bool_compare2(const sepol_bool_t *boolean,
 			const sepol_bool_t *boolean2)
 {
+	if (!boolean || !boolean2 || !boolean->name || !boolean2->name)
+		return -1;
 	return strcmp(boolean->name, boolean2->name);
 }
 
 /* Name */
 const char *sepol_bool_get_name(const sepol_bool_t *boolean)
 {
-	return boolean->name;
+	return boolean ? boolean->name : NULL;
 }
 
 int sepol_bool_set_name(sepol_handle_t *handle, sepol_bool_t *boolean,
 			const char *name)
 {
+	if (!boolean || !name) {
+		ERR(handle, "boolean or name is NULL");
+		return STATUS_ERR;
+	}
 	char *tmp_name = strdup(name);
 	if (!tmp_name) {
 		ERR(handle, "out of memory, could not set boolean name");
@@ -100,22 +118,29 @@ int sepol_bool_set_name(sepol_handle_t *handle, sepol_bool_t *boolean,
 /* Value */
 int sepol_bool_get_value(const sepol_bool_t *boolean)
 {
-	return boolean->value;
+	return boolean ? boolean->value : 0;
 }
 
 void sepol_bool_set_value(sepol_bool_t *boolean, int value)
 {
+	if (!boolean)
+		return;
 	boolean->value = value;
 }
 
 /* Create */
 int sepol_bool_create(sepol_handle_t *handle, sepol_bool_t **bool_ptr)
 {
-	sepol_bool_t *boolean = (sepol_bool_t *)malloc(sizeof(sepol_bool_t));
+	sepol_bool_t *boolean;
+
+	if (!bool_ptr)
+		return STATUS_ERR;
 
+	boolean = (sepol_bool_t *)malloc(sizeof(sepol_bool_t));
 	if (!boolean) {
 		ERR(handle, "out of memory, "
 			    "could not create boolean record");
+		*bool_ptr = NULL;
 		return STATUS_ERR;
 	}
 
@@ -132,6 +157,13 @@ int sepol_bool_clone(sepol_handle_t *handle, const sepol_bool_t *boolean,
 {
 	sepol_bool_t *new_bool = NULL;
 
+	if (!bool_ptr)
+		return STATUS_ERR;
+	if (!boolean) {
+		*bool_ptr = NULL;
+		return STATUS_ERR;
+	}
+
 	if (sepol_bool_create(handle, &new_bool) < 0)
 		goto err;
 
@@ -146,6 +178,7 @@ int sepol_bool_clone(sepol_handle_t *handle, const sepol_bool_t *boolean,
 err:
 	ERR(handle, "could not clone boolean record");
 	sepol_bool_free(new_bool);
+	*bool_ptr = NULL;
 	return STATUS_ERR;
 }
 
diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
index 51a4ad6c..d61f776d 100644
--- a/libsepol/src/booleans.c
+++ b/libsepol/src/booleans.c
@@ -20,6 +20,10 @@ static int bool_update(sepol_handle_t *handle, policydb_t *policydb,
 	cond_bool_datum_t *datum;
 
 	sepol_bool_key_unpack(key, &cname);
+	if (!cname) {
+		ERR(handle, "boolean key name is NULL");
+		return STATUS_ERR;
+	}
 	name = strdup(cname);
 	value = sepol_bool_get_value(data);
 
@@ -52,12 +56,19 @@ err:
 static int bool_to_record(sepol_handle_t *handle, const policydb_t *policydb,
 			  int bool_idx, sepol_bool_t **record)
 {
-	const char *name = policydb->p_bool_val_to_name[bool_idx];
-	cond_bool_datum_t *booldatum = policydb->bool_val_to_struct[bool_idx];
-	int value = booldatum->state;
-
+	const char *name = NULL;
+	cond_bool_datum_t *booldatum;
+	int value;
 	sepol_bool_t *tmp_record = NULL;
 
+	if ((unsigned)bool_idx >= policydb->p_bools.nprim)
+		goto err;
+	name = policydb->p_bool_val_to_name[bool_idx];
+	booldatum = policydb->bool_val_to_struct[bool_idx];
+	if (!booldatum)
+		goto err;
+	value = booldatum->state;
+
 	if (sepol_bool_create(handle, &tmp_record) < 0)
 		goto err;
 
@@ -70,16 +81,23 @@ static int bool_to_record(sepol_handle_t *handle, const policydb_t *policydb,
 	return STATUS_SUCCESS;
 
 err:
-	ERR(handle, "could not convert boolean %s to record", name);
+	ERR(handle, "could not convert boolean %s to record",
+	    name ? name : "(unknown)");
 	sepol_bool_free(tmp_record);
+	*record = NULL;
 	return STATUS_ERR;
 }
 
 int sepol_bool_set(sepol_handle_t *handle, sepol_policydb_t *p,
 		   const sepol_bool_key_t *key, const sepol_bool_t *data)
 {
-	policydb_t *policydb = &p->p;
+	policydb_t *policydb;
 	const char *name;
+
+	if (!handle || !p || !key || !data)
+		return STATUS_ERR;
+
+	policydb = &p->p;
 	sepol_bool_key_unpack(key, &name);
 
 	if (bool_update(handle, policydb, key, data) < 0)
@@ -100,53 +118,56 @@ err:
 int sepol_bool_count(sepol_handle_t *handle __attribute__((unused)),
 		     const sepol_policydb_t *p, unsigned int *response)
 {
+	if (!p || !response)
+		return STATUS_ERR;
+
 	const policydb_t *policydb = &p->p;
-	*response = policydb->p_bools.nprim;
+	*response = policydb->p_bools.table->nel;
 
 	return STATUS_SUCCESS;
 }
 
-int sepol_bool_exists(sepol_handle_t *handle, const sepol_policydb_t *p,
-		      const sepol_bool_key_t *key, int *response)
+int sepol_bool_exists(sepol_handle_t *handle __attribute__((unused)),
+		      const sepol_policydb_t *p, const sepol_bool_key_t *key,
+		      int *response)
 {
+	if (!p || !response)
+		return STATUS_ERR;
+
 	const policydb_t *policydb = &p->p;
 
 	const char *cname;
-	char *name = NULL;
 	sepol_bool_key_unpack(key, &cname);
-	name = strdup(cname);
-
-	if (!name) {
-		ERR(handle,
-		    "out of memory, could not check "
-		    "if user %s exists",
-		    cname);
-		return STATUS_ERR;
-	}
 
-	*response = (hashtab_search(policydb->p_bools.table, name) != NULL);
-	free(name);
+	*response = cname &&
+		    (hashtab_search(policydb->p_bools.table, cname) != NULL);
 	return STATUS_SUCCESS;
 }
 
 int sepol_bool_query(sepol_handle_t *handle, const sepol_policydb_t *p,
 		     const sepol_bool_key_t *key, sepol_bool_t **response)
 {
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
 	const policydb_t *policydb = &p->p;
 	cond_bool_datum_t *booldatum = NULL;
 
 	const char *cname;
-	char *name = NULL;
 	sepol_bool_key_unpack(key, &cname);
-	name = strdup(cname);
 
-	if (!name)
-		goto omem;
+	if (!cname) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
 
-	booldatum = hashtab_search(policydb->p_bools.table, name);
+	booldatum = hashtab_search(policydb->p_bools.table, cname);
 	if (!booldatum) {
 		*response = NULL;
-		free(name);
 		return STATUS_SUCCESS;
 	}
 
@@ -154,15 +175,10 @@ int sepol_bool_query(sepol_handle_t *handle, const sepol_policydb_t *p,
 	    0)
 		goto err;
 
-	free(name);
 	return STATUS_SUCCESS;
 
-omem:
-	ERR(handle, "out of memory");
-
 err:
 	ERR(handle, "could not query boolean %s", cname);
-	free(name);
 	return STATUS_ERR;
 }
 
@@ -170,6 +186,11 @@ int sepol_bool_iterate(sepol_handle_t *handle, const sepol_policydb_t *p,
 		       int (*fn)(const sepol_bool_t *boolean, void *fn_arg),
 		       void *arg)
 {
+	if (!p || !fn) {
+		ERR(handle, "policydb or callback is NULL");
+		return STATUS_ERR;
+	}
+
 	const policydb_t *policydb = &p->p;
 	unsigned int nbools = policydb->p_bools.nprim;
 	sepol_bool_t *boolean = NULL;
@@ -202,3 +223,92 @@ err:
 	sepol_bool_free(boolean);
 	return STATUS_ERR;
 }
+
+DEFINE_VALUE_TO_NAME(sepol_bool_value_to_name, "boolean", p_bools,
+		     p_bool_val_to_name)
+
+int sepol_bool_query_by_value(sepol_handle_t *handle, const sepol_policydb_t *p,
+			      uint32_t value, sepol_bool_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	if (value < 1 || value > p->p.p_bools.nprim) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	if (!p->p.bool_val_to_struct[value - 1]) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return bool_to_record(handle, &p->p, value - 1, response);
+}
+
+/* ---- Boolean iterator ---- */
+
+struct sepol_bool_iter {
+	const policydb_t *policydb;
+	uint32_t idx;
+};
+
+int sepol_bool_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   sepol_bool_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_bool_iter_t *new_iter = malloc(sizeof(sepol_bool_iter_t));
+	if (!new_iter) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	new_iter->policydb = &p->p;
+	new_iter->idx = 0;
+
+	*iter = new_iter;
+	return STATUS_SUCCESS;
+}
+
+void sepol_bool_iter_destroy(sepol_bool_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_bool_iter_next(sepol_handle_t *handle, sepol_bool_iter_t *iter,
+			 sepol_bool_t **item)
+{
+	if (!item)
+		return STATUS_ERR;
+	if (!iter) {
+		*item = NULL;
+		return STATUS_ERR;
+	}
+
+	while (iter->idx < iter->policydb->p_bools.nprim) {
+		unsigned int idx = iter->idx;
+		cond_bool_datum_t *datum =
+			iter->policydb->bool_val_to_struct[idx];
+		iter->idx++;
+		if (datum) {
+			int status = bool_to_record(handle, iter->policydb, idx,
+						    item);
+			if (status)
+				return status;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*item = NULL;
+	return STATUS_SUCCESS;
+}
diff --git a/libsepol/src/conditional_public.c b/libsepol/src/conditional_public.c
new file mode 100644
index 00000000..21d58160
--- /dev/null
+++ b/libsepol/src/conditional_public.c
@@ -0,0 +1,261 @@
+#include <sepol/conditional.h>
+#include <sepol/constants.h>
+
+#include <sepol/policydb/avtab.h>
+#include <sepol/policydb/conditional.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "av_rule_internal.h"
+#include "debug.h"
+
+/* --- Conditional block iterator --- */
+
+struct sepol_cond_iter {
+	const cond_node_t *cur;
+	const cond_node_t *next;
+};
+
+int sepol_cond_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   sepol_cond_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_cond_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	tmp->cur = NULL;
+	tmp->next = p->p.cond_list;
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_cond_iter_destroy(sepol_cond_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_cond_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			 sepol_cond_iter_t *iter, int *has_next)
+{
+	if (!iter || !has_next)
+		return STATUS_ERR;
+
+	iter->cur = iter->next;
+	if (!iter->cur) {
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->next = iter->cur->next;
+	*has_next = 1;
+	return STATUS_SUCCESS;
+}
+
+/* --- Conditional expression sub-iterator --- */
+
+struct sepol_cond_expr_iter {
+	const cond_expr_t *expr;
+};
+
+int sepol_cond_expr_iter_create(sepol_handle_t *handle,
+				const sepol_cond_iter_t *cond_iter,
+				sepol_cond_expr_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!cond_iter) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (!cond_iter->cur) {
+		ERR(handle, "no current conditional block");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_cond_expr_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	tmp->expr = cond_iter->cur->expr;
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_cond_expr_iter_destroy(sepol_cond_expr_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_cond_expr_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			      sepol_cond_expr_iter_t *iter, uint32_t *expr_type,
+			      uint32_t *bool_value)
+{
+	if (!iter || !expr_type || !bool_value)
+		return STATUS_ERR;
+
+	if (!iter->expr) {
+		*expr_type = 0;
+		*bool_value = 0;
+		return STATUS_SUCCESS;
+	}
+
+	*expr_type = iter->expr->expr_type;
+	*bool_value = iter->expr->boolean;
+
+	iter->expr = iter->expr->next;
+	return STATUS_SUCCESS;
+}
+
+/* --- Conditional rule list sub-iterator --- */
+
+struct sepol_cond_rule_iter {
+	const cond_av_list_t *cur;
+	const avtab_datum_t *last_datum;
+	uint16_t last_specified;
+};
+
+int sepol_cond_rule_iter_create(sepol_handle_t *handle,
+				const sepol_cond_iter_t *cond_iter,
+				int is_true_list, sepol_cond_rule_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!cond_iter) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (!cond_iter->cur) {
+		ERR(handle, "no current conditional block");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_cond_rule_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	tmp->cur = is_true_list ? cond_iter->cur->true_list :
+				  cond_iter->cur->false_list;
+	tmp->last_datum = NULL;
+	tmp->last_specified = 0;
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_cond_rule_iter_destroy(sepol_cond_rule_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_cond_rule_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			      sepol_cond_rule_iter_t *iter, uint32_t *ruletype,
+			      uint32_t *source_type, uint32_t *target_type,
+			      uint32_t *target_class)
+{
+	if (!iter || !ruletype || !source_type || !target_type || !target_class)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last_datum = NULL;
+		iter->last_specified = 0;
+		*ruletype = 0;
+		*source_type = 0;
+		*target_type = 0;
+		*target_class = 0;
+		return STATUS_SUCCESS;
+	}
+
+	/* Skip entries with NULL node (pruned/disabled rules) */
+	while (iter->cur && !iter->cur->node)
+		iter->cur = iter->cur->next;
+
+	if (!iter->cur) {
+		iter->last_datum = NULL;
+		iter->last_specified = 0;
+		*ruletype = 0;
+		*source_type = 0;
+		*target_type = 0;
+		*target_class = 0;
+		return STATUS_SUCCESS;
+	}
+
+	avtab_ptr_t node = iter->cur->node;
+	avtab_key_t *key = &node->key;
+
+	iter->last_datum = &node->datum;
+	iter->last_specified = key->specified;
+
+	*ruletype = key->specified & ~AVTAB_ENABLED;
+	*source_type = key->source_type;
+	*target_type = key->target_type;
+	*target_class = key->target_class;
+
+	iter->cur = iter->cur->next;
+	return STATUS_SUCCESS;
+}
+
+uint32_t sepol_cond_rule_iter_get_av_data(const sepol_cond_rule_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_av_data(iter->last_datum, iter->last_specified);
+}
+
+uint32_t sepol_cond_rule_iter_get_type_data(const sepol_cond_rule_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_type_data(iter->last_datum);
+}
+
+uint8_t sepol_cond_rule_iter_get_xperm_type(const sepol_cond_rule_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_xperm_type(iter->last_datum);
+}
+
+uint8_t
+sepol_cond_rule_iter_get_xperm_driver(const sepol_cond_rule_iter_t *iter)
+{
+	if (!iter)
+		return 0;
+	return avtab_datum_get_xperm_driver(iter->last_datum);
+}
+
+int sepol_cond_rule_xperm_iter_create(sepol_handle_t *handle,
+				      const sepol_cond_rule_iter_t *iter,
+				      sepol_xperm_iter_t **xperm_iter)
+{
+	if (!xperm_iter)
+		return STATUS_ERR;
+	if (!iter) {
+		*xperm_iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (!iter->last_datum || !iter->last_datum->xperms) {
+		ERR(handle, "no xperms data on current conditional rule entry");
+		*xperm_iter = NULL;
+		return STATUS_ERR;
+	}
+
+	return sepol_xperm_iter_create_from_datum(
+		handle, iter->last_datum->xperms, xperm_iter);
+}
-- 
2.55.0

