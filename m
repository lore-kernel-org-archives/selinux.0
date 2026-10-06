Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB34457E6D
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291879; cv=none; b=AFW3ChjuCyhf8X4bVjkY7t7AXLRDQVVIYRCmVmcLhT9TAqNCsIiPrp2OB6D/77NgjMXlOIGoRfir2tmfMpwXmWo0dJby6QhUdPqmGUTpIEX4B74zvHED3tJUavQ6sb+FCQhNOorGVjnUVg1emio0xiFVS2TOecPxvk0AwwcEyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291879; c=relaxed/simple;
	bh=XB06YvtDcynQUrj8xedjScVru0aSvigiAmh+Zqb1vsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZT2GBuNvO4ECWfo4/tGd7hDuxxzWC/igCQlbxUzvaSSomKppf2pxI8Uf6g0QWhI6CiE4saKSmOvt+BybktzI8QOis7enpUGxXI6MRIbEsNlO77V6AlhSNjx9MN6KxsL7Q9M8FTdAVv0fkX0M+VbFkH1atWBV3y9P/qeFqGylVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFk3FEjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFk3FEjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leeBrhZzXcyknxaB7W/jCAUyCFTOBo4C5Q1fQXQZet0=;
	b=IFk3FEjXGvf1x71Ha9OTaDDsyT4AXXmfxwGWAJytTTuGZcAtktznrXhy84lHdwdgyyxSum
	0ud16jFgZlp8kRMQ4gOq3BM/5WR6y2EJ9n5KUe1kTkuS8lwV8lBE9/CJx6k1I46DyvNo5o
	uEtiNP9Y7KIlOtJqcsBz2z2SLBAeB1g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-Kz8n0fVTNlWoZN1WnpL36w-1; Tue,
 06 Oct 2026 09:04:35 -0400
X-MC-Unique: Kz8n0fVTNlWoZN1WnpL36w-1
X-Mimecast-MFC-AGG-ID: Kz8n0fVTNlWoZN1WnpL36w_1791291873
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FFF0195C261
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:33 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65C5C1956047;
	Tue,  6 Oct 2026 13:04:32 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 14/17] libsepol: add filename transition, permissive, polcap, range transition, and role rule iterators
Date: Tue,  6 Oct 2026 15:02:12 +0200
Message-ID: <20261006130215.128405-15-jjanasek@redhat.com>
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

Add sepol_filename_trans_iter for filename_trans rules,
sepol_permissive_iter for permissive types, sepol_polcap_iter plus
sepol_polcap_getname() for policy capabilities, sepol_range_trans_iter
for MLS range transition rules, and sepol_role_rule_iter for
role-allow/role-transition rules.

Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/filename_trans.h |  42 ++++++++
 libsepol/include/sepol/permissive.h     |  33 +++++++
 libsepol/include/sepol/polcap.h         |  41 ++++++++
 libsepol/include/sepol/range_trans.h    |  55 +++++++++++
 libsepol/include/sepol/role_rule.h      |  41 ++++++++
 libsepol/src/filename_trans.c           | 123 ++++++++++++++++++++++++
 libsepol/src/permissive_iter.c          |  65 +++++++++++++
 libsepol/src/polcap_iter.c              |  67 +++++++++++++
 libsepol/src/range_trans.c              | 119 +++++++++++++++++++++++
 libsepol/src/role_rule.c                | 117 ++++++++++++++++++++++
 10 files changed, 703 insertions(+)
 create mode 100644 libsepol/include/sepol/filename_trans.h
 create mode 100644 libsepol/include/sepol/permissive.h
 create mode 100644 libsepol/include/sepol/polcap.h
 create mode 100644 libsepol/include/sepol/range_trans.h
 create mode 100644 libsepol/include/sepol/role_rule.h
 create mode 100644 libsepol/src/filename_trans.c
 create mode 100644 libsepol/src/permissive_iter.c
 create mode 100644 libsepol/src/polcap_iter.c
 create mode 100644 libsepol/src/range_trans.c
 create mode 100644 libsepol/src/role_rule.c

diff --git a/libsepol/include/sepol/filename_trans.h b/libsepol/include/sepol/filename_trans.h
new file mode 100644
index 00000000..ca742fb5
--- /dev/null
+++ b/libsepol/include/sepol/filename_trans.h
@@ -0,0 +1,42 @@
+#ifndef _SEPOL_FILENAME_TRANS_H_
+#define _SEPOL_FILENAME_TRANS_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sepol_filename_trans_iter;
+typedef struct sepol_filename_trans_iter sepol_filename_trans_iter_t;
+
+/*
+ * Iteration order is unspecified (currently hash-bucket order of the
+ * internal symbol table) and may change between library versions or
+ * policydb loads; callers must not rely on it matching declaration order
+ * or being stable across calls.
+ */
+extern int sepol_filename_trans_iter_create(sepol_handle_t *handle,
+					    const sepol_policydb_t *p,
+					    sepol_filename_trans_iter_t **iter);
+
+extern void
+sepol_filename_trans_iter_destroy(sepol_filename_trans_iter_t *iter);
+
+/*
+ * Advance to the next flattened filename transition rule.
+ * Sets *source_type to 0 when done.
+ * All type/class values are 1-based.
+ */
+extern int sepol_filename_trans_iter_next(
+	sepol_handle_t *handle, sepol_filename_trans_iter_t *iter,
+	uint32_t *source_type, uint32_t *target_type, uint32_t *target_class,
+	const char **filename, uint32_t *default_type);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/permissive.h b/libsepol/include/sepol/permissive.h
new file mode 100644
index 00000000..0225bb8d
--- /dev/null
+++ b/libsepol/include/sepol/permissive.h
@@ -0,0 +1,33 @@
+#ifndef _SEPOL_PERMISSIVE_H_
+#define _SEPOL_PERMISSIVE_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef struct sepol_permissive_iter sepol_permissive_iter_t;
+
+extern int sepol_permissive_iter_create(sepol_handle_t *handle,
+					const sepol_policydb_t *p,
+					sepol_permissive_iter_t **iter);
+
+extern void sepol_permissive_iter_destroy(sepol_permissive_iter_t *iter);
+
+/* On each successful call with iteration remaining, *type_value is set
+ * to the value of a type marked permissive -- i.e. the same 1-based
+ * value returned by sepol_type_query()/used as a type_datum_t's
+ * s.value, not a 0-based bit position. Iteration is exhausted once
+ * *type_value is set to 0 (0 is never a valid type value). */
+extern int sepol_permissive_iter_next(sepol_handle_t *handle,
+				      sepol_permissive_iter_t *iter,
+				      uint32_t *type_value);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/polcap.h b/libsepol/include/sepol/polcap.h
new file mode 100644
index 00000000..7d70ca3d
--- /dev/null
+++ b/libsepol/include/sepol/polcap.h
@@ -0,0 +1,41 @@
+#ifndef _SEPOL_POLCAP_H_
+#define _SEPOL_POLCAP_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/policydb/polcaps.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef struct sepol_polcap_iter sepol_polcap_iter_t;
+
+extern int sepol_polcap_iter_create(sepol_handle_t *handle,
+				    const sepol_policydb_t *p,
+				    sepol_polcap_iter_t **iter);
+
+extern void sepol_polcap_iter_destroy(sepol_polcap_iter_t *iter);
+
+/* On each successful call with iteration remaining, *cap_num is set to
+ * a 0-based policy capability number, as defined by the
+ * POLICYDB_CAP_* enum in <sepol/policydb/polcaps.h> and accepted by
+ * sepol_polcap_getname()/sepol_polcap_getnum() -- unlike
+ * sepol_permissive_iter_next()'s 1-based type_value, 0 is a valid
+ * capability number here. Iteration is exhausted once *cap_name is
+ * set to NULL. */
+extern int sepol_polcap_iter_next(sepol_handle_t *handle,
+				  sepol_polcap_iter_t *iter, uint32_t *cap_num,
+				  const char **cap_name);
+
+/*
+ * sepol_polcap_getnum()/sepol_polcap_getname() are declared by
+ * <sepol/policydb/polcaps.h>, included above.
+ */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/range_trans.h b/libsepol/include/sepol/range_trans.h
new file mode 100644
index 00000000..4afeddc1
--- /dev/null
+++ b/libsepol/include/sepol/range_trans.h
@@ -0,0 +1,55 @@
+#ifndef _SEPOL_RANGE_TRANS_H_
+#define _SEPOL_RANGE_TRANS_H_
+
+#include <sepol/cat_set.h>
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * NOTE on sepol_cat_set_iter_t **cat_iter parameters below: see the
+ * ownership contract documented in cat_set.h. The callee always allocates
+ * a new, caller-owned iterator that must be freed with
+ * sepol_cat_set_iter_destroy().
+ */
+
+typedef struct sepol_range_trans_iter sepol_range_trans_iter_t;
+
+/*
+ * Iteration order is unspecified (currently hash-bucket order of the
+ * internal symbol table) and may change between library versions or
+ * policydb loads; callers must not rely on it matching declaration order
+ * or being stable across calls.
+ */
+extern int sepol_range_trans_iter_create(sepol_handle_t *handle,
+					 const sepol_policydb_t *p,
+					 sepol_range_trans_iter_t **iter);
+
+extern void sepol_range_trans_iter_destroy(sepol_range_trans_iter_t *iter);
+
+extern int sepol_range_trans_iter_next(sepol_handle_t *handle,
+				       sepol_range_trans_iter_t *iter,
+				       uint32_t *source_type,
+				       uint32_t *target_type,
+				       uint32_t *target_class);
+
+extern uint32_t
+sepol_range_trans_iter_get_low_sens(const sepol_range_trans_iter_t *iter);
+extern uint32_t
+sepol_range_trans_iter_get_high_sens(const sepol_range_trans_iter_t *iter);
+extern int
+sepol_range_trans_iter_get_low_cat(const sepol_range_trans_iter_t *iter,
+				   sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_range_trans_iter_get_high_cat(const sepol_range_trans_iter_t *iter,
+				    sepol_cat_set_iter_t **cat_iter);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/role_rule.h b/libsepol/include/sepol/role_rule.h
new file mode 100644
index 00000000..0c2d55ea
--- /dev/null
+++ b/libsepol/include/sepol/role_rule.h
@@ -0,0 +1,41 @@
+#ifndef _SEPOL_ROLE_RULE_H_
+#define _SEPOL_ROLE_RULE_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef struct sepol_role_allow_iter sepol_role_allow_iter_t;
+
+extern int sepol_role_allow_iter_create(sepol_handle_t *handle,
+					const sepol_policydb_t *p,
+					sepol_role_allow_iter_t **iter);
+
+extern void sepol_role_allow_iter_destroy(sepol_role_allow_iter_t *iter);
+
+extern int sepol_role_allow_iter_next(sepol_handle_t *handle,
+				      sepol_role_allow_iter_t *iter,
+				      uint32_t *role, uint32_t *new_role);
+
+typedef struct sepol_role_trans_iter sepol_role_trans_iter_t;
+
+extern int sepol_role_trans_iter_create(sepol_handle_t *handle,
+					const sepol_policydb_t *p,
+					sepol_role_trans_iter_t **iter);
+
+extern void sepol_role_trans_iter_destroy(sepol_role_trans_iter_t *iter);
+
+extern int sepol_role_trans_iter_next(sepol_handle_t *handle,
+				      sepol_role_trans_iter_t *iter,
+				      uint32_t *role, uint32_t *type,
+				      uint32_t *tclass, uint32_t *new_role);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/filename_trans.c b/libsepol/src/filename_trans.c
new file mode 100644
index 00000000..276a81bb
--- /dev/null
+++ b/libsepol/src/filename_trans.c
@@ -0,0 +1,123 @@
+#include <sepol/filename_trans.h>
+
+#include <sepol/policydb/ebitmap.h>
+#include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "debug.h"
+
+struct sepol_filename_trans_iter {
+	hashtab_iter_t ht_iter;
+	const filename_trans_key_t *cur_key;
+	const filename_trans_datum_t *cur_datum;
+	ebitmap_node_t *stype_node;
+	uint32_t stype_bit;
+	uint32_t stype_highbit;
+};
+
+static void init_ebitmap_walk(sepol_filename_trans_iter_t *iter,
+			      const ebitmap_t *e)
+{
+	iter->stype_bit = ebitmap_start(e, &iter->stype_node);
+	iter->stype_highbit = ebitmap_length(e);
+}
+
+static void advance(sepol_filename_trans_iter_t *iter)
+{
+	for (;;) {
+		if (iter->cur_datum &&
+		    ebitmap_find_next_set_bit(&iter->stype_node,
+					      &iter->stype_bit,
+					      iter->stype_highbit))
+			return;
+
+		if (iter->cur_datum && iter->cur_datum->next) {
+			iter->cur_datum = iter->cur_datum->next;
+			init_ebitmap_walk(iter, &iter->cur_datum->stypes);
+			continue;
+		}
+
+		hashtab_key_t hkey;
+		hashtab_datum_t hdatum;
+		hashtab_iter_next(&iter->ht_iter, &hkey, &hdatum);
+		if (!hkey) {
+			iter->cur_key = NULL;
+			iter->cur_datum = NULL;
+			return;
+		}
+
+		iter->cur_key = (const filename_trans_key_t *)hkey;
+		iter->cur_datum = (const filename_trans_datum_t *)hdatum;
+		init_ebitmap_walk(iter, &iter->cur_datum->stypes);
+	}
+}
+
+int sepol_filename_trans_iter_create(sepol_handle_t *handle,
+				     const sepol_policydb_t *p,
+				     sepol_filename_trans_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_filename_trans_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	hashtab_iter_init(p->p.filename_trans, &tmp->ht_iter);
+	tmp->cur_key = NULL;
+	tmp->cur_datum = NULL;
+	tmp->stype_node = NULL;
+	tmp->stype_bit = 0;
+	tmp->stype_highbit = 0;
+
+	advance(tmp);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_filename_trans_iter_destroy(sepol_filename_trans_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_filename_trans_iter_next(sepol_handle_t *handle
+				   __attribute__((unused)),
+				   sepol_filename_trans_iter_t *iter,
+				   uint32_t *source_type, uint32_t *target_type,
+				   uint32_t *target_class,
+				   const char **filename,
+				   uint32_t *default_type)
+{
+	if (!iter || !source_type || !target_type || !target_class ||
+	    !filename || !default_type)
+		return STATUS_ERR;
+
+	if (!iter->cur_key) {
+		*source_type = 0;
+		*target_type = 0;
+		*target_class = 0;
+		*filename = NULL;
+		*default_type = 0;
+		return STATUS_SUCCESS;
+	}
+
+	*source_type = iter->stype_bit + 1;
+	*target_type = iter->cur_key->ttype;
+	*target_class = iter->cur_key->tclass;
+	*filename = iter->cur_key->name;
+	*default_type = iter->cur_datum->otype;
+
+	iter->stype_bit = ebitmap_next(&iter->stype_node, iter->stype_bit);
+	advance(iter);
+
+	return STATUS_SUCCESS;
+}
diff --git a/libsepol/src/permissive_iter.c b/libsepol/src/permissive_iter.c
new file mode 100644
index 00000000..47639094
--- /dev/null
+++ b/libsepol/src/permissive_iter.c
@@ -0,0 +1,65 @@
+#include <sepol/permissive.h>
+
+#include <sepol/policydb/ebitmap.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "debug.h"
+
+struct sepol_permissive_iter {
+	const ebitmap_t *map;
+	ebitmap_node_t *node;
+	uint32_t bit;
+	uint32_t highbit;
+};
+
+int sepol_permissive_iter_create(sepol_handle_t *handle,
+				 const sepol_policydb_t *p,
+				 sepol_permissive_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_permissive_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->map = &p->p.permissive_map;
+	tmp->bit = ebitmap_start(tmp->map, &tmp->node);
+	tmp->highbit = ebitmap_length(tmp->map);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_permissive_iter_destroy(sepol_permissive_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_permissive_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			       sepol_permissive_iter_t *iter,
+			       uint32_t *type_value)
+{
+	if (!iter || !type_value)
+		return STATUS_ERR;
+
+	if (!ebitmap_find_next_set_bit(&iter->node, &iter->bit,
+				       iter->highbit)) {
+		*type_value = 0;
+		return STATUS_SUCCESS;
+	}
+
+	*type_value = iter->bit;
+
+	iter->bit = ebitmap_next(&iter->node, iter->bit);
+
+	return STATUS_SUCCESS;
+}
diff --git a/libsepol/src/polcap_iter.c b/libsepol/src/polcap_iter.c
new file mode 100644
index 00000000..546e34eb
--- /dev/null
+++ b/libsepol/src/polcap_iter.c
@@ -0,0 +1,67 @@
+#include <sepol/polcap.h>
+
+#include <sepol/policydb/ebitmap.h>
+#include <sepol/policydb/polcaps.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "debug.h"
+
+struct sepol_polcap_iter {
+	const ebitmap_t *caps;
+	ebitmap_node_t *node;
+	uint32_t bit;
+	uint32_t highbit;
+};
+
+int sepol_polcap_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			     sepol_polcap_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_polcap_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->caps = &p->p.policycaps;
+	tmp->bit = ebitmap_start(tmp->caps, &tmp->node);
+	tmp->highbit = ebitmap_length(tmp->caps);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_polcap_iter_destroy(sepol_polcap_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_polcap_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			   sepol_polcap_iter_t *iter, uint32_t *cap_num,
+			   const char **cap_name)
+{
+	if (!iter || !cap_num || !cap_name)
+		return STATUS_ERR;
+
+	if (!ebitmap_find_next_set_bit(&iter->node, &iter->bit,
+				       iter->highbit)) {
+		*cap_num = 0;
+		*cap_name = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	*cap_num = iter->bit;
+	*cap_name = sepol_polcap_getname(iter->bit);
+
+	iter->bit = ebitmap_next(&iter->node, iter->bit);
+
+	return STATUS_SUCCESS;
+}
diff --git a/libsepol/src/range_trans.c b/libsepol/src/range_trans.c
new file mode 100644
index 00000000..190aaa27
--- /dev/null
+++ b/libsepol/src/range_trans.c
@@ -0,0 +1,119 @@
+#include <sepol/range_trans.h>
+
+#include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/mls_types.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "cat_set_internal.h"
+#include "debug.h"
+
+struct sepol_range_trans_iter {
+	hashtab_iter_t ht_iter;
+	const range_trans_t *last_key;
+	const mls_range_t *last_range;
+};
+
+int sepol_range_trans_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_range_trans_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_range_trans_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	hashtab_iter_init(p->p.range_tr, &tmp->ht_iter);
+	tmp->last_key = NULL;
+	tmp->last_range = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_range_trans_iter_destroy(sepol_range_trans_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_range_trans_iter_next(sepol_handle_t *handle __attribute__((unused)),
+				sepol_range_trans_iter_t *iter,
+				uint32_t *source_type, uint32_t *target_type,
+				uint32_t *target_class)
+{
+	if (!iter || !source_type || !target_type || !target_class)
+		return STATUS_ERR;
+
+	hashtab_key_t hkey;
+	hashtab_datum_t hdatum;
+
+	hashtab_iter_next(&iter->ht_iter, &hkey, &hdatum);
+	if (!hkey) {
+		*source_type = 0;
+		*target_type = 0;
+		*target_class = 0;
+		iter->last_key = NULL;
+		iter->last_range = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last_key = (const range_trans_t *)hkey;
+	iter->last_range = (const mls_range_t *)hdatum;
+
+	*source_type = iter->last_key->source_type;
+	*target_type = iter->last_key->target_type;
+	*target_class = iter->last_key->target_class;
+
+	return STATUS_SUCCESS;
+}
+
+uint32_t
+sepol_range_trans_iter_get_low_sens(const sepol_range_trans_iter_t *iter)
+{
+	if (!iter || !iter->last_range)
+		return 0;
+	return iter->last_range->level[0].sens;
+}
+
+uint32_t
+sepol_range_trans_iter_get_high_sens(const sepol_range_trans_iter_t *iter)
+{
+	if (!iter || !iter->last_range)
+		return 0;
+	return iter->last_range->level[1].sens;
+}
+
+int sepol_range_trans_iter_get_low_cat(const sepol_range_trans_iter_t *iter,
+				       sepol_cat_set_iter_t **cat_iter)
+{
+	if (!cat_iter)
+		return STATUS_ERR;
+	if (!iter || !iter->last_range) {
+		*cat_iter = NULL;
+		return STATUS_SUCCESS;
+	}
+	return cat_set_iter_create_from_ebitmap(&iter->last_range->level[0].cat,
+						cat_iter);
+}
+
+int sepol_range_trans_iter_get_high_cat(const sepol_range_trans_iter_t *iter,
+					sepol_cat_set_iter_t **cat_iter)
+{
+	if (!cat_iter)
+		return STATUS_ERR;
+	if (!iter || !iter->last_range) {
+		*cat_iter = NULL;
+		return STATUS_SUCCESS;
+	}
+	return cat_set_iter_create_from_ebitmap(&iter->last_range->level[1].cat,
+						cat_iter);
+}
diff --git a/libsepol/src/role_rule.c b/libsepol/src/role_rule.c
new file mode 100644
index 00000000..a5c78de9
--- /dev/null
+++ b/libsepol/src/role_rule.c
@@ -0,0 +1,117 @@
+#include <sepol/role_rule.h>
+
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "debug.h"
+
+struct sepol_role_allow_iter {
+	const role_allow_t *cur;
+};
+
+int sepol_role_allow_iter_create(sepol_handle_t *handle,
+				 const sepol_policydb_t *p,
+				 sepol_role_allow_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_role_allow_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.role_allow;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_role_allow_iter_destroy(sepol_role_allow_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_role_allow_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			       sepol_role_allow_iter_t *iter, uint32_t *role,
+			       uint32_t *new_role)
+{
+	if (!iter || !role || !new_role)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		*role = 0;
+		*new_role = 0;
+		return STATUS_SUCCESS;
+	}
+
+	*role = iter->cur->role;
+	*new_role = iter->cur->new_role;
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
+
+struct sepol_role_trans_iter {
+	const role_trans_t *cur;
+};
+
+int sepol_role_trans_iter_create(sepol_handle_t *handle,
+				 const sepol_policydb_t *p,
+				 sepol_role_trans_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_role_trans_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.role_tr;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_role_trans_iter_destroy(sepol_role_trans_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_role_trans_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			       sepol_role_trans_iter_t *iter, uint32_t *role,
+			       uint32_t *type, uint32_t *tclass,
+			       uint32_t *new_role)
+{
+	if (!iter || !role || !type || !tclass || !new_role)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		*role = 0;
+		*type = 0;
+		*tclass = 0;
+		*new_role = 0;
+		return STATUS_SUCCESS;
+	}
+
+	*role = iter->cur->role;
+	*type = iter->cur->type;
+	*tclass = iter->cur->tclass;
+	*new_role = iter->cur->new_role;
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
-- 
2.55.0

