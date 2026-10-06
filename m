Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066A4570DC
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291845; cv=none; b=YftDwMKWJdofQvsDHKmCZ9RptNQ+KoBHE0e2n+uvBLLlKGOt+8SpEeU4AeeAqfPdj9xxTx3zV5PgI/AX6KUTA+m6bKy7PC36YVMEPBW3FTWXLSDx/n6kI3KxYcwJdbA7Rjlb9ZKLoC5mq5grduBmWOCcoK41PO6yKz1VP6M3cIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291845; c=relaxed/simple;
	bh=Hra5led1z2CimOSGau6ltxXuh6hEZtacb54UlXfzhgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjSKXBwmr/ew6IJX3Taa/wXE3E6ShVs4Jyb+1iQhRwArpaN5Hd3QGbu8c3dBYCA667TRaGWotUE1NB2AdNDmB6n97XZmrJpXTw75gbe/1bWqT/gyALgHIqBF/48zsMsHWncS/OT29hEmMY0k34fXGCtYx6y9S3TJcHukYBG61us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Buv8YFiG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Buv8YFiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+r2KSwVz7OTDofF4Nj3jWVirK3QMkZq4oWBlhfJhY4s=;
	b=Buv8YFiGnKVvy78I4Mo23cRqcVNPXQiShxOK/KxQEpwQnVMSLotNpqZWLKe/dhFtnpKJ/6
	fCJowgo6W1U0NwnYLFHikB2Y3UrRX9lmzo3MDrrhyeFQoMuc2FnaS0zJ8A76XqVeaoWzVu
	MpaRDGzQ1a3AuZ2SZ+2ZSS1WCe0D810=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-hF1-enkdOj21Jl71WBZpgA-1; Tue,
 06 Oct 2026 09:04:00 -0400
X-MC-Unique: hF1-enkdOj21Jl71WBZpgA-1
X-Mimecast-MFC-AGG-ID: hF1-enkdOj21Jl71WBZpgA_1791291839
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3611D1865D94;
	Tue,  6 Oct 2026 13:03:59 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 148A31956047;
	Tue,  6 Oct 2026 13:03:57 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 01/17] libsepol: add hashtab iterator and string list utilities
Date: Tue,  6 Oct 2026 15:01:59 +0200
Message-ID: <20261006130215.128405-2-jjanasek@redhat.com>
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

Add a generic hashtab_iter for walking any policydb symbol table, used
as the shared backend for the per-symbol public iterators added in
later commits. Add string_list_add_unique() and an ebitmap
find-next-set-bit helper shared by several ebitmap-backed iterators.

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/policydb/ebitmap.h |  18 ++++
 libsepol/include/sepol/policydb/hashtab.h |  15 +++
 libsepol/include/sepol/policydb/util.h    |  22 ++++-
 libsepol/src/hashtab.c                    |  48 +++++++++
 libsepol/src/private.h                    |  23 +++++
 libsepol/src/util.c                       | 113 +++++++++++++++++++++-
 6 files changed, 236 insertions(+), 3 deletions(-)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index fd1093b0..0da4e706 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -81,6 +81,24 @@ static inline int ebitmap_node_get_bit(const ebitmap_node_t *n,
 	ebitmap_for_each_bit(e, n, bit)          \
 		if (ebitmap_node_get_bit(n, bit))
 
+/*
+ * Resumable version of ebitmap_for_each_positive_bit(): advances the node
+ * and bit position to the next set bit at or after the current bit
+ * (exclusive of highbit), returning 1 if one was found or 0 if the walk
+ * is exhausted. Used by stateful iterators that need to pause/resume the
+ * walk across calls rather than consuming the whole bitmap in one loop.
+ */
+static inline int ebitmap_find_next_set_bit(ebitmap_node_t **n, uint32_t *bit,
+					    uint32_t highbit)
+{
+	while (*bit < highbit) {
+		if (ebitmap_node_get_bit(*n, *bit))
+			return 1;
+		*bit = ebitmap_next(n, *bit);
+	}
+	return 0;
+}
+
 extern int ebitmap_cmp(const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_or(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_union(ebitmap_t *dst, const ebitmap_t *e1);
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index 124f673e..e641dfac 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -110,6 +110,21 @@ extern int hashtab_map(hashtab_t h,
 
 extern void hashtab_hash_eval(hashtab_t h, const char *tag);
 
+struct hashtab_iter {
+	hashtab_t table;
+	hashtab_node_t *curr;
+	unsigned int bucket;
+};
+typedef struct hashtab_iter hashtab_iter_t;
+
+extern void hashtab_iter_init(hashtab_t table, hashtab_iter_t *iter);
+/*
+   Advances to the next item in hashtab, sets both pointers to NULL if no items
+   are left
+ */
+extern void hashtab_iter_next(hashtab_iter_t *iter, hashtab_key_t *key,
+			      hashtab_datum_t *datum);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
index 03b99a92..6e64247a 100644
--- a/libsepol/include/sepol/policydb/util.h
+++ b/libsepol/include/sepol/policydb/util.h
@@ -35,7 +35,8 @@ extern char *sepol_av_to_string(const policydb_t *policydbp,
 				sepol_security_class_t tclass,
 				sepol_access_vector_t av);
 
-char *sepol_extended_perms_to_string(const avtab_extended_perms_t *xperms);
+extern char *
+sepol_extended_perms_to_string(const avtab_extended_perms_t *xperms);
 
 /*
  * The tokenize function may be used to
@@ -43,6 +44,25 @@ char *sepol_extended_perms_to_string(const avtab_extended_perms_t *xperms);
  */
 extern int tokenize(const char *line_buf, char delim, int num_args, ...);
 
+extern int string_list_contains(char **const list, uint32_t num,
+				const char *string);
+extern int string_list_add(sepol_handle_t *handle, char ***list, uint32_t *num,
+			   const char *string);
+/*
+ * Like string_list_add(), but a no-op success (STATUS_SUCCESS without
+ * modifying the list) if string already appears in the list.
+ */
+extern int string_list_add_unique(sepol_handle_t *handle, char ***list,
+				  uint32_t *num, const char *string);
+extern int string_list_del(char **list, uint32_t *num, const char *string);
+extern int string_list_scopy(sepol_handle_t *handle, char **list, uint32_t num,
+			     const char ***copy, uint32_t *num_copy);
+
+/*
+ * Compare indirect strings (in qsort)
+ */
+extern int strcmp_qsort(const void *str1, const void *str2);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 663706fd..c11a27fe 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -257,6 +257,9 @@ void hashtab_hash_eval(hashtab_t h, const char *tag)
 	size_t chain_len, slots_used, max_chain_len, chain2_len_sum;
 	hashtab_ptr_t cur;
 
+	if (!h)
+		return;
+
 	slots_used = 0;
 	max_chain_len = 0;
 	chain2_len_sum = 0;
@@ -280,3 +283,48 @@ void hashtab_hash_eval(hashtab_t h, const char *tag)
 	       tag, h->nel, slots_used, h->size, max_chain_len, chain2_len_sum,
 	       chain2_len_sum ? (float)chain2_len_sum / slots_used : 0);
 }
+
+static void hashtab_iter_advance(hashtab_iter_t *iter)
+{
+	if (!iter->table || iter->bucket >= iter->table->size)
+		return;
+	if (iter->curr && iter->curr->next) {
+		iter->curr = iter->curr->next;
+		return;
+	}
+	iter->curr = NULL;
+	do {
+		iter->bucket++;
+	} while (iter->bucket < iter->table->size &&
+		 (iter->curr = iter->table->htable[iter->bucket]) == NULL);
+}
+
+void hashtab_iter_init(hashtab_t table, hashtab_iter_t *iter)
+{
+	if (!iter)
+		return;
+	memset(iter, 0, sizeof(hashtab_iter_t));
+	if (!table)
+		return;
+	iter->table = table;
+	iter->curr = table->size > 0 ? table->htable[0] : NULL;
+	if (!iter->curr)
+		hashtab_iter_advance(iter);
+}
+
+void hashtab_iter_next(hashtab_iter_t *iter, hashtab_key_t *key,
+		       hashtab_datum_t *datum)
+{
+	if (!iter || !key || !datum)
+		return;
+
+	hashtab_node_t *node = iter->curr;
+	hashtab_iter_advance(iter);
+	if (node) {
+		*key = node->key;
+		*datum = node->datum;
+	} else {
+		*key = NULL;
+		*datum = NULL;
+	}
+}
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 7f7344a8..a8eba6d7 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -103,6 +103,29 @@ extern size_t put_entry(const void *ptr, size_t size, size_t n,
 			struct policy_file *fp);
 extern int str_read(char **strp, struct policy_file *fp, size_t len);
 
+/*
+ * Generate a sepol_*_value_to_name() implementation: bounds-check "value"
+ * against p->p.NPRIM_FIELD.nprim and index p->p.VAL_TO_NAME_FIELD[value - 1].
+ * All sepol_*_value_to_name() functions share this exact shape, differing
+ * only in which symbol table / reverse-lookup array they use.
+ */
+#define DEFINE_VALUE_TO_NAME(fn, desc, nprim_field, val_to_name_field)   \
+	int fn(sepol_handle_t *handle, const sepol_policydb_t *p,        \
+	       uint32_t value, const char **name)                        \
+	{                                                                \
+		if (!p || !name)                                         \
+			return STATUS_ERR;                               \
+                                                                         \
+		if (value < 1 || value > p->p.nprim_field.nprim) {       \
+			ERR(handle, "invalid " desc " value %u", value); \
+			*name = NULL;                                    \
+			return STATUS_ERR;                               \
+		}                                                        \
+                                                                         \
+		*name = p->p.val_to_name_field[value - 1];               \
+		return STATUS_SUCCESS;                                   \
+	}
+
 #ifndef HAVE_REALLOCARRAY
 static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
 {
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 52faeaa6..921614d7 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -27,7 +27,9 @@
 #include <sepol/policydb/flask_types.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/util.h>
+#include <string.h>
 
+#include "debug.h"
 #include "private.h"
 
 struct val_to_name {
@@ -87,14 +89,19 @@ char *sepol_av_to_string(const policydb_t *policydbp,
 			 sepol_access_vector_t av)
 {
 	struct val_to_name v;
-	const class_datum_t *cladatum =
-		policydbp->class_val_to_struct[tclass - 1];
+	const class_datum_t *cladatum;
 	uint32_t i;
 	int rc;
 	char *buffer = NULL, *p;
 	int len;
 	size_t remaining, size = 64;
 
+	if (!policydbp || tclass < 1 || tclass > policydbp->p_classes.nprim)
+		return NULL;
+	cladatum = policydbp->class_val_to_struct[tclass - 1];
+	if (!cladatum)
+		return NULL;
+
 retry:
 	if (__builtin_mul_overflow(size, 2, &size))
 		goto err;
@@ -332,3 +339,105 @@ exit:
 	va_end(ap);
 	return items;
 }
+
+int string_list_contains(char **const list, uint32_t num, const char *string)
+{
+	if (!list || !string)
+		return 0;
+	for (uint32_t i = 0; i < num; i++) {
+		if (!strcmp(list[i], string))
+			return 1;
+	}
+	return 0;
+}
+
+int string_list_add(sepol_handle_t *handle, char ***list, uint32_t *num,
+		    const char *string)
+{
+	if (!list || !num || !string)
+		return STATUS_ERR;
+	if (*num == UINT32_MAX)
+		goto omem;
+	char **tmp = reallocarray(*list, *num + 1, sizeof(char *));
+	if (!tmp)
+		goto omem;
+	*list = tmp;
+
+	(*list)[*num] = strdup(string);
+	if (!(*list)[*num])
+		goto omem;
+	(*num)++;
+
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+	/* tmp is assigned to list, no separate free needed */
+	return STATUS_ERR;
+}
+
+int string_list_add_unique(sepol_handle_t *handle, char ***list, uint32_t *num,
+			   const char *string)
+{
+	if (!list || !num || !string)
+		return STATUS_ERR;
+	if (string_list_contains(*list, *num, string))
+		return STATUS_SUCCESS;
+	return string_list_add(handle, list, num, string);
+}
+
+int string_list_del(char **list, uint32_t *num, const char *string)
+{
+	if (!num || !string)
+		return STATUS_ERR;
+	if (!list)
+		return (*num == 0) ? STATUS_SUCCESS : STATUS_ERR;
+
+	for (uint32_t i = 0; i < *num;) {
+		if (!strcmp(list[i], string)) {
+			free(list[i]);
+			(*num)--;
+			if (i < *num)
+				list[i] = list[*num];
+		} else {
+			i++;
+		}
+	}
+	return STATUS_SUCCESS;
+}
+
+/* shallow copy, does not copy strings in the list */
+int string_list_scopy(sepol_handle_t *handle, char **list, uint32_t num,
+		      const char ***copy, uint32_t *num_copy)
+{
+	if (!copy || !num_copy)
+		return STATUS_ERR;
+
+	*copy = NULL;
+	*num_copy = 0;
+
+	if (num == 0)
+		return STATUS_SUCCESS;
+
+	if (!list)
+		return STATUS_ERR;
+
+	const char **tmp = calloc(num, sizeof(char *));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		return STATUS_ERR;
+	}
+
+	for (uint32_t i = 0; i < num; i++)
+		tmp[i] = list[i];
+
+	*copy = tmp;
+	*num_copy = num;
+
+	return STATUS_SUCCESS;
+}
+
+int strcmp_qsort(const void *str1, const void *str2)
+{
+	return strcmp(*((const char **)str1), *((const char **)str2));
+}
-- 
2.55.0

