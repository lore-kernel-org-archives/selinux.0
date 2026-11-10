Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308878;
	b=FRbQwW5iBCaHQGiCABpvxkShJlljx8vv67fES2OsWX/urHMsDnCpw9tM3q7fBNjWMpkj
	 gldwPEaeLWjZv1QDcbZ69JZgzhYRAmLszlRbHJgRVobmyIIekPdmdqc1dtZj97jIJXhAD
	 +NvRI4/PtaDNF5vR0mRJ1DWvPuT0I9YopnBw0dULlGgfL2wksuWf2ZhOVaOd143PXrn0c
	 dUjdTeFjhyzkrJRTjPECcCmEvFSqj/JohbCLLwZgzdHWvg1NHlrs61dq14mJRy+BUU1KY
	 NP+JNT1TPgNEYSPjNdygb2x2R+BDLPjM8xSVu4aMHE3soRX03Xcv3LVLP4IT22/CSrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308878;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bHgiwaho1irmCE6r+gx8nNIF5wLDl9TmH8/rfJyoavM=;
	b=OiJ1TJ5b+KX7XaB1+n8LFUO2kIz6RqSRLyZXPsqAGtLgG1+RSPwpuugJ+l40q36njXG+
	 /q9PR8GJnlpXB5quLQTTN6Jv3ynaZ3be/HxcqPjWeD420647B1NUc7eTlV2clrEBy2TFr
	 I02GjlteHDikNEdOmIAVW+Qry8lWZ+L6eceYF+5VG61FcMmP/RjKiGM9GMJQBk5h25UIO
	 J3wJndpHBzCTsXXNz6ztiYwV7SELTEvTtlOVRKpnUOBabU/YRKR4Gd12rIa4NdKEO/zVJ
	 XZNOyYIBz6XxfCb5Lqy0iirSEbfDsKqD77QhmdIYgVUK+va7GmeoddB7Oq6KkIyii/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=c09qeyPb;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A142606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A142606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=c09qeyPb
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308874;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHgiwaho1irmCE6r+gx8nNIF5wLDl9TmH8/rfJyoavM=;
	b=c09qeyPbC3HoRT9DZhdHu+X6pvrpDH4Bp0NeGfpgBWAydjz1I29pnG+tYtKCoGpgwSSeaE
	Njmkt5oKBAAd3ltQ2vdetfuUM4EiKctno5ub9THUEQUvRs0C3fUDtLDKSWTrkH+qOblZao
	m1HMz5968Hg+eQVe85kP3xPT7ilh0WFcjgG0MX4RXsPyPSzBZkbzBKa0Au1Z6eCOdaG6fn
	oZcdDy3+7+MN+FDT8GkBZsTOPdglBzFfKsYpGzc/rP1Al4x2LDJAsF9TX4yPFQaQcM9Bse
	gM1S7PSz1eK/6dkGHFUZ0u3846zogk75lwa20qi4bb60be4ynCr8sqQ0y11dgA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 1/6] libsepol/cil: shrink the avtabs before checking neverallow rules
Date: Tue, 10 Nov 2026 12:07:39 +0100
Message-ID: <20261110110739.67209-6-cgoettsche@seltendoof.de>
In-Reply-To: <20261110110739.67209-1-cgoettsche@seltendoof.de>
References: <20261110110739.67209-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The number of rules is not known when CIL starts to build the policydb,
so both the unconditional and the conditional avtab are allocated with
the maximum number of 2^20 buckets. Every neverallow rule is checked by
walking both tables with avtab_map(), which thus visits two million
mostly empty buckets per rule, regardless of the size of the policy.

Add avtab_rehash() to resize a table to the number of entries it holds
and call it once all rules have been inserted. The nodes are relinked,
so the pointers held by the conditional lists stay valid, and the
chains are kept sorted as avtab_search() and friends require. Add unit
tests for it.

Compiling a policy of 101 modules with about 30000 avtab entries, 853
neverallow and 64 neverallowx rules takes 1.5s instead of 2.85s.

Since the entries of the unconditional avtab are written in the order
of the hash table, the order of the rules in the binary policy
changes. The policies are semantically identical. Diagnostics derived
from walking the avtab, like the truncated list of rules violating a
type bounds, might show different rules.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c           |  11 ++
 libsepol/include/sepol/policydb/avtab.h |   1 +
 libsepol/src/avtab.c                    |  88 +++++++++-
 libsepol/tests/libsepol-tests.c         |   2 +
 libsepol/tests/test-avtab.c             | 224 ++++++++++++++++++++++++
 libsepol/tests/test-avtab.h             |  10 ++
 6 files changed, 330 insertions(+), 6 deletions(-)
 create mode 100644 libsepol/tests/test-avtab.c
 create mode 100644 libsepol/tests/test-avtab.h

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index db25d409..fbce5a2e 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -6179,6 +6179,17 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db,
 	cond_optimize_lists(pdb->cond_list);
 	__cil_set_conditional_state_and_flags(pdb);
 
+	/*
+	 * The avtabs were allocated with the maximum number of buckets since
+	 * the number of rules was not known. Walking that many empty buckets
+	 * for every neverallow rule is expensive, so shrink them now.
+	 */
+	if (avtab_rehash(&pdb->te_avtab) || avtab_rehash(&pdb->te_cond_avtab)) {
+		cil_log(CIL_ERR, "Out of memory\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 	if (db->disable_neverallow != CIL_TRUE) {
 		int violation = CIL_FALSE;
 		cil_log(CIL_INFO, "Checking Neverallows\n");
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 83e1033f..7f6c496c 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -108,6 +108,7 @@ typedef struct avtab {
 
 extern int avtab_init(avtab_t *);
 extern int avtab_alloc(avtab_t *, uint32_t);
+extern int avtab_rehash(avtab_t *h);
 extern int avtab_insert(avtab_t *h, avtab_key_t *k, avtab_datum_t *d);
 
 extern avtab_datum_t *avtab_search(avtab_t *h, avtab_key_t *k);
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index bb3893aa..afee7a34 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -360,15 +360,11 @@ int avtab_init(avtab_t *h)
 	return 0;
 }
 
-int avtab_alloc(avtab_t *h, uint32_t nrules)
+static uint32_t avtab_nslot(uint32_t nrules)
 {
-	uint32_t mask = 0;
 	uint32_t shift = 0;
 	uint32_t work = nrules;
-	uint32_t nslot = 0;
-
-	if (nrules == 0)
-		goto out;
+	uint32_t nslot;
 
 	while (work) {
 		work = work >> 1;
@@ -379,6 +375,19 @@ int avtab_alloc(avtab_t *h, uint32_t nrules)
 	nslot = UINT32_C(1) << shift;
 	if (nslot > MAX_AVTAB_HASH_BUCKETS)
 		nslot = MAX_AVTAB_HASH_BUCKETS;
+
+	return nslot;
+}
+
+int avtab_alloc(avtab_t *h, uint32_t nrules)
+{
+	uint32_t mask = 0;
+	uint32_t nslot = 0;
+
+	if (nrules == 0)
+		goto out;
+
+	nslot = avtab_nslot(nrules);
 	mask = nslot - 1;
 
 	h->htable = calloc(nslot, sizeof(avtab_ptr_t));
@@ -391,6 +400,73 @@ out:
 	return 0;
 }
 
+static int avtab_key_cmp(const avtab_key_t *a, const avtab_key_t *b)
+{
+	if (a->source_type != b->source_type)
+		return a->source_type < b->source_type ? -1 : 1;
+	if (a->target_type != b->target_type)
+		return a->target_type < b->target_type ? -1 : 1;
+	if (a->target_class != b->target_class)
+		return a->target_class < b->target_class ? -1 : 1;
+	return 0;
+}
+
+/*
+ * Resize the hash table to fit the number of entries it currently holds.
+ * Useful for tables allocated before their final size was known: walking
+ * a mostly empty table (see avtab_map()) is expensive.
+ * The nodes are kept, so pointers to them stay valid.
+ */
+int avtab_rehash(avtab_t *h)
+{
+	avtab_ptr_t *htable;
+	avtab_ptr_t cur, next, prev, pos;
+	uint32_t i, nslot, mask;
+	int hvalue;
+
+	if (!h || !h->htable)
+		return 0;
+
+	nslot = avtab_nslot(h->nel);
+	if (nslot == h->nslot)
+		return 0;
+	mask = nslot - 1;
+
+	htable = calloc(nslot, sizeof(avtab_ptr_t));
+	if (!htable)
+		return -1;
+
+	for (i = 0; i < h->nslot; i++) {
+		for (cur = h->htable[i]; cur; cur = next) {
+			next = cur->next;
+
+			/*
+			 * Keep the chains sorted, and entries with an equal
+			 * source, target and class (which always share a
+			 * chain) in their existing order.
+			 */
+			hvalue = avtab_hash(&cur->key, mask);
+			for (prev = NULL, pos = htable[hvalue]; pos;
+			     prev = pos, pos = pos->next) {
+				if (avtab_key_cmp(&cur->key, &pos->key) < 0)
+					break;
+			}
+
+			cur->next = pos;
+			if (prev)
+				prev->next = cur;
+			else
+				htable[hvalue] = cur;
+		}
+	}
+
+	free(h->htable);
+	h->htable = htable;
+	h->nslot = nslot;
+	h->mask = mask;
+	return 0;
+}
+
 void avtab_hash_eval(avtab_t *h, char *tag)
 {
 	unsigned int i, chain_len, slots_used, max_chain_len;
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 1b70be01..9d5fa9ef 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include "test-avtab.h"
 #include "test-cond.h"
 #include "test-ebitmap.h"
 #include "test-linker.h"
@@ -69,6 +70,7 @@ static bool do_tests(int interactive, int verbose)
 	if (CUE_SUCCESS != CU_initialize_registry())
 		return CU_get_error();
 
+	DECLARE_SUITE(avtab);
 	DECLARE_SUITE(ebitmap);
 	DECLARE_SUITE(cond);
 	DECLARE_SUITE(linker);
diff --git a/libsepol/tests/test-avtab.c b/libsepol/tests/test-avtab.c
new file mode 100644
index 00000000..5e51d64d
--- /dev/null
+++ b/libsepol/tests/test-avtab.c
@@ -0,0 +1,224 @@
+#include "test-avtab.h"
+
+#include <stdlib.h>
+
+#include <sepol/policydb/avtab.h>
+
+#define NUM_TYPES 40
+#define NUM_CLASSES 3
+#define NUM_XPERMS 3
+
+static int key_cmp(const avtab_key_t *a, const avtab_key_t *b)
+{
+	if (a->source_type != b->source_type)
+		return a->source_type < b->source_type ? -1 : 1;
+	if (a->target_type != b->target_type)
+		return a->target_type < b->target_type ? -1 : 1;
+	if (a->target_class != b->target_class)
+		return a->target_class < b->target_class ? -1 : 1;
+	return 0;
+}
+
+/* Insert rules, among them several with the same source, target and class */
+static void fill_avtab(avtab_t *a)
+{
+	avtab_extended_perms_t xperms = { 0 };
+	avtab_datum_t datum = { 0 };
+	avtab_key_t key;
+	unsigned int s, t, c, x;
+
+	xperms.specified = AVTAB_XPERMS_IOCTLFUNCTION;
+
+	for (s = 1; s <= NUM_TYPES; s++) {
+		for (t = 1; t <= NUM_TYPES; t++) {
+			for (c = 1; c <= NUM_CLASSES; c++) {
+				key.source_type = s;
+				key.target_type = t;
+				key.target_class = c;
+
+				key.specified = AVTAB_ALLOWED;
+				datum.data = s + t + c;
+				datum.xperms = NULL;
+				CU_ASSERT_PTR_NOT_NULL_FATAL(
+					avtab_insert_nonunique(a, &key,
+							       &datum));
+
+				if ((s + t) % 3 == 0) {
+					key.specified = AVTAB_AUDITDENY;
+					CU_ASSERT_PTR_NOT_NULL_FATAL(
+						avtab_insert_nonunique(a, &key,
+								       &datum));
+				}
+
+				if ((s + t) % 5 != 0)
+					continue;
+
+				key.specified = AVTAB_XPERMS_ALLOWED;
+				datum.xperms = &xperms;
+				for (x = 0; x < NUM_XPERMS; x++) {
+					xperms.driver = x;
+					CU_ASSERT_PTR_NOT_NULL_FATAL(
+						avtab_insert_nonunique(a, &key,
+								       &datum));
+				}
+			}
+		}
+	}
+}
+
+/* Collect the nodes in the order a search for each key returns them */
+static avtab_ptr_t *collect_nodes(avtab_t *a)
+{
+	static const uint16_t specified[] = { AVTAB_ALLOWED, AVTAB_AUDITDENY,
+					      AVTAB_XPERMS_ALLOWED };
+	avtab_ptr_t *nodes, node;
+	avtab_key_t key;
+	unsigned int s, t, c, i;
+	uint32_t n = 0;
+
+	nodes = calloc(a->nel, sizeof(*nodes));
+	CU_ASSERT_PTR_NOT_NULL_FATAL(nodes);
+
+	for (s = 1; s <= NUM_TYPES; s++) {
+		for (t = 1; t <= NUM_TYPES; t++) {
+			for (c = 1; c <= NUM_CLASSES; c++) {
+				key.source_type = s;
+				key.target_type = t;
+				key.target_class = c;
+
+				for (i = 0; i < 3; i++) {
+					key.specified = specified[i];
+					for (node = avtab_search_node(a, &key);
+					     node;
+					     node = avtab_search_node_next(
+						     node, key.specified)) {
+						CU_ASSERT_FATAL(n < a->nel);
+						nodes[n++] = node;
+					}
+				}
+			}
+		}
+	}
+
+	/* every node was found */
+	CU_ASSERT_EQUAL_FATAL(n, a->nel);
+
+	return nodes;
+}
+
+static void check_sorted(const avtab_t *a)
+{
+	avtab_ptr_t cur;
+	uint32_t i, nel = 0;
+
+	for (i = 0; i < a->nslot; i++) {
+		for (cur = a->htable[i]; cur; cur = cur->next) {
+			nel++;
+			if (cur->next)
+				CU_ASSERT(key_cmp(&cur->key, &cur->next->key) <=
+					  0);
+		}
+	}
+
+	CU_ASSERT_EQUAL(nel, a->nel);
+}
+
+static void check_rehash(uint32_t alloc_size, int shrinks)
+{
+	avtab_ptr_t *before, *after;
+	avtab_t a;
+	uint32_t nel, nslot, i;
+
+	CU_ASSERT_EQUAL_FATAL(avtab_init(&a), 0);
+	CU_ASSERT_EQUAL_FATAL(avtab_alloc(&a, alloc_size), 0);
+
+	fill_avtab(&a);
+	nel = a.nel;
+	nslot = a.nslot;
+	before = collect_nodes(&a);
+
+	CU_ASSERT_EQUAL_FATAL(avtab_rehash(&a), 0);
+
+	CU_ASSERT_EQUAL(a.nel, nel);
+	CU_ASSERT_EQUAL(a.mask, a.nslot - 1);
+	if (shrinks) {
+		CU_ASSERT(a.nslot < nslot);
+	} else {
+		CU_ASSERT(a.nslot > nslot);
+	}
+	/* one bucket per 2-4 elements */
+	CU_ASSERT(a.nslot * 2 <= nel && nel <= a.nslot * 4);
+
+	check_sorted(&a);
+
+	/* the same nodes are found in the same order */
+	after = collect_nodes(&a);
+	for (i = 0; i < nel; i++)
+		CU_ASSERT_PTR_EQUAL(before[i], after[i]);
+
+	/* nothing to do the second time */
+	nslot = a.nslot;
+	CU_ASSERT_EQUAL(avtab_rehash(&a), 0);
+	CU_ASSERT_EQUAL(a.nslot, nslot);
+
+	free(before);
+	free(after);
+	avtab_destroy(&a);
+}
+
+static void test_avtab_rehash_shrink(void)
+{
+	check_rehash(MAX_AVTAB_SIZE, 1);
+}
+
+static void test_avtab_rehash_grow(void)
+{
+	check_rehash(4, 0);
+}
+
+static void test_avtab_rehash_empty(void)
+{
+	avtab_t a;
+
+	/* not allocated */
+	CU_ASSERT_EQUAL_FATAL(avtab_init(&a), 0);
+	CU_ASSERT_EQUAL(avtab_rehash(&a), 0);
+	CU_ASSERT_PTR_NULL(a.htable);
+
+	CU_ASSERT_EQUAL_FATAL(avtab_alloc(&a, MAX_AVTAB_SIZE), 0);
+	CU_ASSERT_EQUAL(a.nslot, MAX_AVTAB_HASH_BUCKETS);
+
+	CU_ASSERT_EQUAL(avtab_rehash(&a), 0);
+	CU_ASSERT_EQUAL(a.nel, 0);
+	CU_ASSERT_EQUAL(a.nslot, 1);
+	CU_ASSERT_EQUAL(a.mask, 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(a.htable);
+	CU_ASSERT_PTR_NULL(a.htable[0]);
+
+	avtab_destroy(&a);
+}
+
+int avtab_test_init(void)
+{
+	return 0;
+}
+
+int avtab_test_cleanup(void)
+{
+	return 0;
+}
+
+#define ADD_TEST(name)                                                \
+	do {                                                          \
+		if (NULL == CU_add_test(suite, #name, test_##name)) { \
+			return CU_get_error();                        \
+		}                                                     \
+	} while (0)
+
+int avtab_add_tests(CU_pSuite suite)
+{
+	ADD_TEST(avtab_rehash_shrink);
+	ADD_TEST(avtab_rehash_grow);
+	ADD_TEST(avtab_rehash_empty);
+	return 0;
+}
diff --git a/libsepol/tests/test-avtab.h b/libsepol/tests/test-avtab.h
new file mode 100644
index 00000000..0b537ab9
--- /dev/null
+++ b/libsepol/tests/test-avtab.h
@@ -0,0 +1,10 @@
+#ifndef TEST_AVTAB_H__
+#define TEST_AVTAB_H__
+
+#include <CUnit/Basic.h>
+
+int avtab_test_init(void);
+int avtab_test_cleanup(void);
+int avtab_add_tests(CU_pSuite suite);
+
+#endif /* TEST_AVTAB_H__ */
-- 
2.55.0

