Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B843459AC7
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291848; cv=none; b=rx7/rGmoPsLO6v7fDRqiWgwkZzIxpALWjMoK6zceJrNy/mQrPTai4dlDg4luUb7cPiq4ThCuXPNczqAWSa5NW/LklgL17a0IzHdvT5LpguxRWle41Xvc/aSJ7tL3sjn+i0ZOC5M6HqKAsXjWHaDlh4Xrd0l0RGmaAAUgzA/Pw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291848; c=relaxed/simple;
	bh=42NC8l7AKNvxrEFmE9iIer4+WSBvpr7KtpVkN5QRP9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR7AVHhrRVBHN88IzkWo96xWo1V/Np+Opkx75+yRqsTPff0LyNgIZvjgdYGBgY+9tPJ0QRd49bVZwOLrf0kPHLypmAyNNydZZRayqGeyekY8i3wNIHm72soies5CCbLtykXOaWr1UNS1NVe4pE7BiQEHRYb5y8hin6MZrLvQbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7F1cmPo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7F1cmPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Izndr9O0F9UZ3MKAG77UaRGPCsSB8rxw/oyE4WbvRbQ=;
	b=Y7F1cmPoJC7A0Aiz+YQ+l8loPvLmf2LH4HSEwqJzBnBb71CEEgPwQFur7hRjCTb8bvhQcS
	LRScKc6fZl8Z2GhWB+C4xb7IvaBx8f8k7Ft/YWnEB31GX2zgAK7BpPGhXfVC6+mVYv3iTo
	1cPkAig4KhsvU5lkgYa0tf6wnVI0YWk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-Z1BOr1YNO7qJ4ONFCgsRug-1; Tue,
 06 Oct 2026 09:04:04 -0400
X-MC-Unique: Z1BOr1YNO7qJ4ONFCgsRug-1
X-Mimecast-MFC-AGG-ID: Z1BOr1YNO7qJ4ONFCgsRug_1791291843
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C41B18413BE
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:03 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 760961944CC0;
	Tue,  6 Oct 2026 13:04:02 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 02/17] libsepol: add MLS, category set, and common permission iterators
Date: Tue,  6 Oct 2026 15:02:00 +0200
Message-ID: <20261006130215.128405-3-jjanasek@redhat.com>
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

Add sepol_cat_set_iter for iterating an ebitmap-backed category set
without exposing struct ebitmap. Add sepol_sens_iter/sepol_cat_iter
plus sepol_sens_value_to_name()/sepol_cat_value_to_name() for MLS
sensitivities and categories. Add sepol_common_iter and
sepol_common_value_to_name() for common permission sets shared across
classes.

Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/cat_set.h     |  40 +++++++
 libsepol/include/sepol/common_perm.h |  54 ++++++++++
 libsepol/include/sepol/mls_iter.h    |  80 ++++++++++++++
 libsepol/src/cat_set.c               |  60 +++++++++++
 libsepol/src/cat_set_internal.h      |  10 ++
 libsepol/src/common_perm.c           | 143 +++++++++++++++++++++++++
 libsepol/src/mls_iter.c              | 154 +++++++++++++++++++++++++++
 7 files changed, 541 insertions(+)
 create mode 100644 libsepol/include/sepol/cat_set.h
 create mode 100644 libsepol/include/sepol/common_perm.h
 create mode 100644 libsepol/include/sepol/mls_iter.h
 create mode 100644 libsepol/src/cat_set.c
 create mode 100644 libsepol/src/cat_set_internal.h
 create mode 100644 libsepol/src/common_perm.c
 create mode 100644 libsepol/src/mls_iter.c

diff --git a/libsepol/include/sepol/cat_set.h b/libsepol/include/sepol/cat_set.h
new file mode 100644
index 00000000..dba0575d
--- /dev/null
+++ b/libsepol/include/sepol/cat_set.h
@@ -0,0 +1,40 @@
+#ifndef _SEPOL_CAT_SET_H_
+#define _SEPOL_CAT_SET_H_
+
+#include <sepol/handle.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Category set iterators are not created directly. Obtain instances from
+ * MLS-related APIs such as sepol_sens_iter_get_level_cat(),
+ * sepol_isid_iter_get_mls_range_low_cat(), etc.
+ *
+ * Ownership: every function that hands out a sepol_cat_set_iter_t **
+ * (throughout ocontext.h, mls_iter.h, range_trans.h, and users.h) heap
+ * allocates a new, caller-owned iterator whenever it returns 0 with a
+ * non-NULL *cat_iter. The caller must call sepol_cat_set_iter_destroy()
+ * on it exactly once when done -- it is not borrowed from, and does not
+ * alias, any other iterator or the policydb. This applies even when the
+ * underlying category set is empty: *cat_iter is only left NULL on
+ * success when the *outer* iterator argument (e.g. the sepol_isid_iter_t)
+ * is itself NULL or already exhausted, not merely because the category
+ * set has no members -- an empty set still yields a real iterator whose
+ * first sepol_cat_set_iter_next() call reports no values.
+ */
+typedef struct sepol_cat_set_iter sepol_cat_set_iter_t;
+
+extern int sepol_cat_set_iter_next(sepol_handle_t *handle,
+				   sepol_cat_set_iter_t *iter,
+				   uint32_t *cat_value);
+
+extern void sepol_cat_set_iter_destroy(sepol_cat_set_iter_t *iter);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/common_perm.h b/libsepol/include/sepol/common_perm.h
new file mode 100644
index 00000000..931c49cc
--- /dev/null
+++ b/libsepol/include/sepol/common_perm.h
@@ -0,0 +1,54 @@
+#ifndef _SEPOL_COMMON_PERM_H_
+#define _SEPOL_COMMON_PERM_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef struct sepol_common_iter sepol_common_iter_t;
+
+/*
+ * Iteration order is unspecified (currently hash-bucket order of the
+ * internal symbol table) and may change between library versions or
+ * policydb loads; callers must not rely on it matching declaration order
+ * or being stable across calls.
+ */
+extern int sepol_common_iter_create(sepol_handle_t *handle,
+				    const sepol_policydb_t *p,
+				    sepol_common_iter_t **iter);
+
+extern void sepol_common_iter_destroy(sepol_common_iter_t *iter);
+
+extern int sepol_common_iter_next(sepol_handle_t *handle,
+				  sepol_common_iter_t *iter, const char **name,
+				  uint32_t *value);
+
+typedef struct sepol_common_perm_iter sepol_common_perm_iter_t;
+
+extern int sepol_common_perm_iter_create(sepol_handle_t *handle,
+					 const sepol_policydb_t *p,
+					 uint32_t common_value,
+					 sepol_common_perm_iter_t **iter);
+
+extern void sepol_common_perm_iter_destroy(sepol_common_perm_iter_t *iter);
+
+extern int sepol_common_perm_iter_next(sepol_handle_t *handle,
+				       sepol_common_perm_iter_t *iter,
+				       const char **perm_name);
+
+/* Resolve a common permission set value to its name.
+ * Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_common_value_to_name(sepol_handle_t *handle,
+				      const sepol_policydb_t *p, uint32_t value,
+				      const char **name);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/mls_iter.h b/libsepol/include/sepol/mls_iter.h
new file mode 100644
index 00000000..ae72239d
--- /dev/null
+++ b/libsepol/include/sepol/mls_iter.h
@@ -0,0 +1,80 @@
+#ifndef _SEPOL_MLS_ITER_H_
+#define _SEPOL_MLS_ITER_H_
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
+/* Category iterator */
+
+typedef struct sepol_cat_iter sepol_cat_iter_t;
+
+/*
+ * Iteration order is unspecified (currently hash-bucket order of the
+ * internal symbol table) and may change between library versions or
+ * policydb loads; callers must not rely on it matching declaration order
+ * or being stable across calls.
+ */
+extern int sepol_cat_iter_create(sepol_handle_t *handle,
+				 const sepol_policydb_t *p,
+				 sepol_cat_iter_t **iter);
+
+extern void sepol_cat_iter_destroy(sepol_cat_iter_t *iter);
+
+extern int sepol_cat_iter_next(sepol_handle_t *handle, sepol_cat_iter_t *iter,
+			       const char **name, uint32_t *value,
+			       int *isalias);
+
+/* Sensitivity iterator */
+
+typedef struct sepol_sens_iter sepol_sens_iter_t;
+
+/*
+ * Iteration order is unspecified (currently hash-bucket order of the
+ * internal symbol table) and may change between library versions or
+ * policydb loads; callers must not rely on it matching declaration order
+ * or being stable across calls.
+ */
+extern int sepol_sens_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_sens_iter_t **iter);
+
+extern void sepol_sens_iter_destroy(sepol_sens_iter_t *iter);
+
+extern int sepol_sens_iter_next(sepol_handle_t *handle, sepol_sens_iter_t *iter,
+				const char **name, uint32_t *sens_value,
+				int *isalias);
+
+extern int sepol_sens_iter_get_level_cat(sepol_handle_t *handle,
+					 const sepol_sens_iter_t *iter,
+					 sepol_cat_set_iter_t **cat_iter);
+
+/* Resolve a category value to its name.  Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_cat_value_to_name(sepol_handle_t *handle,
+				   const sepol_policydb_t *p, uint32_t value,
+				   const char **name);
+
+/* Resolve a sensitivity value to its name.  Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_sens_value_to_name(sepol_handle_t *handle,
+				    const sepol_policydb_t *p, uint32_t value,
+				    const char **name);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/cat_set.c b/libsepol/src/cat_set.c
new file mode 100644
index 00000000..43c1d8f4
--- /dev/null
+++ b/libsepol/src/cat_set.c
@@ -0,0 +1,60 @@
+#include <sepol/cat_set.h>
+
+#include <sepol/policydb/ebitmap.h>
+#include <stdlib.h>
+
+#include "cat_set_internal.h"
+#include "debug.h"
+
+struct sepol_cat_set_iter {
+	ebitmap_node_t *node;
+	uint32_t bit;
+	uint32_t highbit;
+};
+
+int cat_set_iter_create_from_ebitmap(const ebitmap_t *map,
+				     sepol_cat_set_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!map) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_cat_set_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->bit = ebitmap_start(map, &tmp->node);
+	tmp->highbit = ebitmap_length(map);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+int sepol_cat_set_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			    sepol_cat_set_iter_t *iter, uint32_t *cat_value)
+{
+	if (!iter || !cat_value)
+		return STATUS_ERR;
+
+	if (!ebitmap_find_next_set_bit(&iter->node, &iter->bit,
+				       iter->highbit)) {
+		*cat_value = 0;
+		return STATUS_SUCCESS;
+	}
+
+	*cat_value = iter->bit + 1;
+
+	iter->bit = ebitmap_next(&iter->node, iter->bit);
+
+	return STATUS_SUCCESS;
+}
+
+void sepol_cat_set_iter_destroy(sepol_cat_set_iter_t *iter)
+{
+	free(iter);
+}
diff --git a/libsepol/src/cat_set_internal.h b/libsepol/src/cat_set_internal.h
new file mode 100644
index 00000000..c8b9df41
--- /dev/null
+++ b/libsepol/src/cat_set_internal.h
@@ -0,0 +1,10 @@
+#ifndef _SEPOL_CAT_SET_INTERNAL_H_
+#define _SEPOL_CAT_SET_INTERNAL_H_
+
+#include <sepol/cat_set.h>
+#include <sepol/policydb/ebitmap.h>
+
+int cat_set_iter_create_from_ebitmap(const ebitmap_t *map,
+				     sepol_cat_set_iter_t **iter);
+
+#endif
diff --git a/libsepol/src/common_perm.c b/libsepol/src/common_perm.c
new file mode 100644
index 00000000..edac7eac
--- /dev/null
+++ b/libsepol/src/common_perm.c
@@ -0,0 +1,143 @@
+#include <sepol/common_perm.h>
+
+#include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "debug.h"
+#include "private.h"
+
+struct sepol_common_iter {
+	hashtab_iter_t ht_iter;
+};
+
+int sepol_common_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			     sepol_common_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_common_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	hashtab_iter_init(p->p.p_commons.table, &tmp->ht_iter);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_common_iter_destroy(sepol_common_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_common_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			   sepol_common_iter_t *iter, const char **name,
+			   uint32_t *value)
+{
+	if (!iter || !name || !value)
+		return STATUS_ERR;
+
+	hashtab_key_t hkey;
+	hashtab_datum_t hdatum;
+
+	hashtab_iter_next(&iter->ht_iter, &hkey, &hdatum);
+	if (!hkey) {
+		*name = NULL;
+		*value = 0;
+		return STATUS_SUCCESS;
+	}
+
+	common_datum_t *d = (common_datum_t *)hdatum;
+
+	*name = hkey;
+	*value = d->s.value;
+
+	return STATUS_SUCCESS;
+}
+
+struct sepol_common_perm_iter {
+	hashtab_iter_t ht_iter;
+};
+
+int sepol_common_perm_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  uint32_t common_value,
+				  sepol_common_perm_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (common_value == 0 || common_value > p->p.p_commons.nprim) {
+		ERR(handle, "invalid common value %u", common_value);
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	const char *name = p->p.p_common_val_to_name[common_value - 1];
+	if (!name) {
+		ERR(handle, "no name for common value %u", common_value);
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	common_datum_t *d = hashtab_search(p->p.p_commons.table, name);
+	if (!d) {
+		ERR(handle, "common %s not found", name);
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_common_perm_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	hashtab_iter_init(d->permissions.table, &tmp->ht_iter);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_common_perm_iter_destroy(sepol_common_perm_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_common_perm_iter_next(sepol_handle_t *handle __attribute__((unused)),
+				sepol_common_perm_iter_t *iter,
+				const char **perm_name)
+{
+	if (!iter || !perm_name)
+		return STATUS_ERR;
+
+	hashtab_key_t hkey;
+	hashtab_datum_t hdatum;
+
+	hashtab_iter_next(&iter->ht_iter, &hkey, &hdatum);
+	if (!hkey) {
+		*perm_name = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	*perm_name = hkey;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_VALUE_TO_NAME(sepol_common_value_to_name, "common", p_commons,
+		     p_common_val_to_name)
diff --git a/libsepol/src/mls_iter.c b/libsepol/src/mls_iter.c
new file mode 100644
index 00000000..1bf704fa
--- /dev/null
+++ b/libsepol/src/mls_iter.c
@@ -0,0 +1,154 @@
+#include <sepol/mls_iter.h>
+
+#include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "cat_set_internal.h"
+#include "debug.h"
+#include "private.h"
+
+/* ---- Category iterator ---- */
+
+struct sepol_cat_iter {
+	hashtab_iter_t ht_iter;
+};
+
+int sepol_cat_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			  sepol_cat_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_cat_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	hashtab_iter_init(p->p.p_cats.table, &tmp->ht_iter);
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_cat_iter_destroy(sepol_cat_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_cat_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			sepol_cat_iter_t *iter, const char **name,
+			uint32_t *value, int *isalias)
+{
+	if (!iter || !name || !value || !isalias)
+		return STATUS_ERR;
+
+	hashtab_key_t hkey;
+	hashtab_datum_t hdatum;
+
+	hashtab_iter_next(&iter->ht_iter, &hkey, &hdatum);
+	if (!hkey) {
+		*name = NULL;
+		*value = 0;
+		*isalias = 0;
+		return STATUS_SUCCESS;
+	}
+
+	cat_datum_t *d = (cat_datum_t *)hdatum;
+	*name = hkey;
+	*value = d->s.value;
+	*isalias = d->isalias;
+
+	return STATUS_SUCCESS;
+}
+
+/* ---- Sensitivity iterator ---- */
+
+struct sepol_sens_iter {
+	hashtab_iter_t ht_iter;
+	const level_datum_t *last;
+};
+
+int sepol_sens_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   sepol_sens_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_sens_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	hashtab_iter_init(p->p.p_levels.table, &tmp->ht_iter);
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_sens_iter_destroy(sepol_sens_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_sens_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			 sepol_sens_iter_t *iter, const char **name,
+			 uint32_t *sens_value, int *isalias)
+{
+	if (!iter || !name || !sens_value || !isalias)
+		return STATUS_ERR;
+
+	hashtab_key_t hkey;
+	hashtab_datum_t hdatum;
+
+	hashtab_iter_next(&iter->ht_iter, &hkey, &hdatum);
+	if (!hkey) {
+		*name = NULL;
+		*sens_value = 0;
+		*isalias = 0;
+		iter->last = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	level_datum_t *d = (level_datum_t *)hdatum;
+	iter->last = d;
+	*name = hkey;
+	*sens_value = d->level->sens;
+	*isalias = d->isalias;
+
+	return STATUS_SUCCESS;
+}
+
+int sepol_sens_iter_get_level_cat(sepol_handle_t *handle
+				  __attribute__((unused)),
+				  const sepol_sens_iter_t *iter,
+				  sepol_cat_set_iter_t **cat_iter)
+{
+	if (!cat_iter)
+		return STATUS_ERR;
+	if (!iter || !iter->last) {
+		*cat_iter = NULL;
+		return STATUS_SUCCESS;
+	}
+	return cat_set_iter_create_from_ebitmap(&iter->last->level->cat,
+						cat_iter);
+}
+
+DEFINE_VALUE_TO_NAME(sepol_cat_value_to_name, "category", p_cats,
+		     p_cat_val_to_name)
+
+DEFINE_VALUE_TO_NAME(sepol_sens_value_to_name, "sensitivity", p_levels,
+		     p_sens_val_to_name)
-- 
2.55.0

