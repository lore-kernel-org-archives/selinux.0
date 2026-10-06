Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58973DE456
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291874; cv=none; b=bc7d6wseCX5/SeIYvoQ5lgwZ99zP2Uo2drtlIacq1sfNLhHAkb8RgvvR6U3+LbTk897QHPSX22bo0OfEFsK1KJgkrpctSEjuc0Ma6EjW9zogAW6D0Zr4st0ZFjhr/9HyIdpjKmh5ENcOkN7kGWrudw8oF9nkrT7d7bz4zW2WnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291874; c=relaxed/simple;
	bh=4D5lKQAdNIvt8cfWosrBf1FMr8IRH+zC7g0cQ4FKgx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl/khRVz1z973yhUvNjijzuSGX5469SnTuh2DLtFcNyC/kB5gwHRslgKoas5aHGvEw1iDQJHQbsoxKvH478RZikEn6EJNvq323mvQp+kTcT9zgQerx9jKwCAsg1+raQHXZvHqnLBbRu9MQQjxavLYgooEq9jQGk9nhYjNocjPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkU4X+59; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkU4X+59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=923ZnBWwIMrdhEKxgxlxMbWvHtAE/ZEpGOW2vkE111o=;
	b=NkU4X+596lXFWaxBnKBWoOFtHER+Cnuc3Zbf4SYSBVmN23k9EYTaxyG1G/wbAjlvyK2ZiT
	q/MnFSDAmI7uLOQa61iYRyQDDO6JCnDYRW/THktGoDkiruhiA5fzr9LbpDCpWk0EZPQ4XF
	VInJQC9kuW6BzxutIn2+sNQooz7HYd8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-sAStibtKPFSToBqKFWUEtQ-1; Tue, 6
 Oct 2026 13:04:29 +0000
X-MC-Unique: sAStibtKPFSToBqKFWUEtQ-1
X-Mimecast-MFC-AGG-ID: sAStibtKPFSToBqKFWUEtQ_1791291869
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD58D18007F3
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:28 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E45BE1956047;
	Tue,  6 Oct 2026 13:04:27 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 12/17] libsepol: add AV rule and conditional iterator tests
Date: Tue,  6 Oct 2026 15:02:10 +0200
Message-ID: <20261006130215.128405-13-jjanasek@redhat.com>
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

Cover sepol_avtab_iter, sepol_perm_iter, sepol_xperm_iter,
sepol_cond_iter/cond_expr_iter/cond_rule_iter, and sepol_bool_iter
against the test-iter fixture, including NULL-argument and
out-of-range value_to_name regression tests.

Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/tests/libsepol-tests.c |   2 +
 libsepol/tests/test-av-rule.c   | 733 ++++++++++++++++++++++++++++++++
 libsepol/tests/test-av-rule.h   |  10 +
 3 files changed, 745 insertions(+)
 create mode 100644 libsepol/tests/test-av-rule.c
 create mode 100644 libsepol/tests/test-av-rule.h

diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index c404937b..707937cf 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -27,6 +27,7 @@
 #include "test-neverallow.h"
 #include "test-iter.h"
 #include "test-context-api.h"
+#include "test-av-rule.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -78,6 +79,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(neverallow);
 	DECLARE_SUITE(iter);
 	DECLARE_SUITE(context_api);
+	DECLARE_SUITE(av_rule);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/test-av-rule.c b/libsepol/tests/test-av-rule.c
new file mode 100644
index 00000000..49c54697
--- /dev/null
+++ b/libsepol/tests/test-av-rule.c
@@ -0,0 +1,733 @@
+#include "test-av-rule.h"
+
+#include <limits.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <CUnit/CUnit.h>
+
+#include <sepol/av_rule.h>
+#include <sepol/booleans.h>
+#include <sepol/conditional.h>
+#include <sepol/constants.h>
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/link.h>
+#include <sepol/policydb/policydb.h>
+
+#include "parse_util.h"
+
+extern int mls;
+
+static sepol_handle_t *handle;
+static sepol_policydb_t *policy;
+static policydb_t basemod;
+
+int av_rule_test_init(void)
+{
+	char filename[PATH_MAX];
+	int basemod_inited = 0;
+
+	handle = sepol_handle_create();
+	if (!handle)
+		return -1;
+
+	if (sepol_policydb_create(&policy)) {
+		sepol_handle_destroy(handle);
+		handle = NULL;
+		return -1;
+	}
+
+	if (policydb_init(&basemod))
+		goto err;
+	basemod_inited = 1;
+
+	basemod.policy_type = POLICY_BASE;
+	basemod.policyvers = MOD_POLICYDB_VERSION_MAX;
+	basemod.mls = mls;
+
+	if (snprintf(filename, PATH_MAX, "policies/test-iter/%s%s", "iter.conf",
+		     mls ? ".mls" : ".std") < 0)
+		goto err;
+
+	if (read_source_policy(&basemod, filename, "test-av-rule"))
+		goto err;
+
+	if (link_modules(NULL, &basemod, NULL, 0, 0))
+		goto err;
+
+	if (expand_module(NULL, &basemod, &policy->p, 0, 0))
+		goto err;
+
+	return 0;
+
+err:
+	if (basemod_inited)
+		policydb_destroy(&basemod);
+	sepol_policydb_free(policy);
+	policy = NULL;
+	sepol_handle_destroy(handle);
+	handle = NULL;
+	return -1;
+}
+
+int av_rule_test_cleanup(void)
+{
+	sepol_policydb_free(policy);
+	policydb_destroy(&basemod);
+	sepol_handle_destroy(handle);
+	return 0;
+}
+
+static uint32_t type_value(const char *name)
+{
+	type_datum_t *d = hashtab_search(policy->p.p_types.table, name);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(d);
+	return d->s.value;
+}
+
+static uint32_t class_value(const char *name)
+{
+	class_datum_t *d = hashtab_search(policy->p.p_classes.table, name);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(d);
+	return d->s.value;
+}
+
+static void test_avtab_iter_all(void)
+{
+	sepol_avtab_iter_t *iter;
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_create(handle, policy, 0, &iter),
+			      0);
+
+	int count = 0;
+	uint32_t ruletype, src, tgt, cls;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_next(handle, iter,
+							    &ruletype, &src,
+							    &tgt, &cls),
+				      0);
+		if (ruletype == 0)
+			break;
+		CU_ASSERT(src > 0);
+		CU_ASSERT(tgt > 0);
+		CU_ASSERT(cls > 0);
+		count++;
+	}
+	CU_ASSERT(count >= 5);
+
+	sepol_avtab_iter_destroy(iter);
+}
+
+static void test_avtab_iter_filtered(void)
+{
+	sepol_avtab_iter_t *iter;
+	uint32_t ruletype, src, tgt, cls;
+	int allow_count = 0, trans_count = 0;
+
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_create(handle, policy,
+						      AVTAB_ALLOWED, &iter),
+			      0);
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_next(handle, iter,
+							    &ruletype, &src,
+							    &tgt, &cls),
+				      0);
+		if (ruletype == 0)
+			break;
+		CU_ASSERT_EQUAL(ruletype, AVTAB_ALLOWED);
+		allow_count++;
+	}
+	sepol_avtab_iter_destroy(iter);
+	CU_ASSERT(allow_count >= 4);
+
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_create(handle, policy,
+						      AVTAB_TRANSITION, &iter),
+			      0);
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_next(handle, iter,
+							    &ruletype, &src,
+							    &tgt, &cls),
+				      0);
+		if (ruletype == 0)
+			break;
+		CU_ASSERT_EQUAL(ruletype, AVTAB_TRANSITION);
+		trans_count++;
+	}
+	sepol_avtab_iter_destroy(iter);
+	CU_ASSERT(trans_count >= 1);
+}
+
+static void test_avtab_iter_av_data(void)
+{
+	sepol_avtab_iter_t *iter;
+	uint32_t ruletype, src, tgt, cls;
+
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_create(handle, policy,
+						      AVTAB_ALLOWED, &iter),
+			      0);
+
+	int found_perm = 0;
+	/*
+	 * Asserts inside this loop are intentionally non-fatal once `iter`
+	 * (and, further in, `piter`) is allocated: a CU_ASSERT_*_FATAL()
+	 * here would longjmp out of the function and skip
+	 * sepol_perm_iter_destroy()/sepol_avtab_iter_destroy(), leaking the
+	 * iterator(s).
+	 */
+	while (1) {
+		int rc = sepol_avtab_iter_next(handle, iter, &ruletype, &src,
+					       &tgt, &cls);
+		CU_ASSERT_EQUAL(rc, 0);
+		if (rc != 0 || ruletype == 0)
+			break;
+
+		uint32_t av_data = sepol_avtab_iter_get_av_data(iter);
+		CU_ASSERT(av_data != 0);
+
+		sepol_perm_iter_t *piter = NULL;
+		CU_ASSERT_EQUAL(sepol_perm_iter_create(handle, policy, cls,
+						       av_data, &piter),
+				0);
+		if (piter) {
+			const char *perm_name = NULL;
+			CU_ASSERT_EQUAL(sepol_perm_iter_next(handle, piter,
+							     &perm_name),
+					0);
+			CU_ASSERT_PTR_NOT_NULL(perm_name);
+			if (perm_name)
+				found_perm = 1;
+			sepol_perm_iter_destroy(piter);
+		}
+	}
+	sepol_avtab_iter_destroy(iter);
+	CU_ASSERT(found_perm);
+}
+
+static void test_avtab_iter_type_data(void)
+{
+	sepol_avtab_iter_t *iter;
+	uint32_t ruletype, src, tgt, cls;
+	uint32_t type3_val = type_value("TYPE3");
+
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_create(handle, policy,
+						      AVTAB_TRANSITION, &iter),
+			      0);
+
+	int found = 0;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_next(handle, iter,
+							    &ruletype, &src,
+							    &tgt, &cls),
+				      0);
+		if (ruletype == 0)
+			break;
+
+		uint32_t default_type = sepol_avtab_iter_get_type_data(iter);
+		CU_ASSERT(default_type > 0);
+		if (default_type == type3_val)
+			found = 1;
+	}
+	sepol_avtab_iter_destroy(iter);
+	CU_ASSERT(found);
+}
+
+static void test_perm_iter_class1(void)
+{
+	uint32_t cls1 = class_value("CLASS1");
+	uint32_t all_perms = 0xFFFFFFFF;
+
+	sepol_perm_iter_t *iter;
+	CU_ASSERT_EQUAL_FATAL(sepol_perm_iter_create(handle, policy, cls1,
+						     all_perms, &iter),
+			      0);
+
+	int found_perm1 = 0, found_commonperm1 = 0;
+	const char *name;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_perm_iter_next(handle, iter, &name),
+				      0);
+		if (!name)
+			break;
+		if (strcmp(name, "PERM1") == 0)
+			found_perm1 = 1;
+		if (strcmp(name, "COMMONPERM1") == 0)
+			found_commonperm1 = 1;
+	}
+	sepol_perm_iter_destroy(iter);
+	CU_ASSERT(found_perm1);
+	CU_ASSERT(found_commonperm1);
+}
+
+static void test_bool_value_to_name(void)
+{
+	policydb_t *p = &policy->p;
+	cond_bool_datum_t *b1 = hashtab_search(p->p_bools.table, "BOOL1");
+	cond_bool_datum_t *b2 = hashtab_search(p->p_bools.table, "BOOL2");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(b1);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(b2);
+
+	const char *name;
+	CU_ASSERT_EQUAL(sepol_bool_value_to_name(handle, policy, b1->s.value,
+						 &name),
+			0);
+	CU_ASSERT_STRING_EQUAL(name, "BOOL1");
+
+	CU_ASSERT_EQUAL(sepol_bool_value_to_name(handle, policy, b2->s.value,
+						 &name),
+			0);
+	CU_ASSERT_STRING_EQUAL(name, "BOOL2");
+
+	CU_ASSERT_NOT_EQUAL(sepol_bool_value_to_name(handle, policy, 0, &name),
+			    0);
+	CU_ASSERT_PTR_NULL(name);
+
+	CU_ASSERT_NOT_EQUAL(sepol_bool_value_to_name(handle, policy,
+						     p->p_bools.nprim + 1,
+						     &name),
+			    0);
+	CU_ASSERT_PTR_NULL(name);
+}
+
+static void test_cond_iter(void)
+{
+	sepol_cond_iter_t *iter;
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_create(handle, policy, &iter), 0);
+
+	int has_next;
+	int count = 0;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(
+			sepol_cond_iter_next(handle, iter, &has_next), 0);
+		if (!has_next)
+			break;
+		count++;
+	}
+	CU_ASSERT(count >= 1);
+
+	sepol_cond_iter_destroy(iter);
+}
+
+static void test_cond_expr_iter(void)
+{
+	sepol_cond_iter_t *citer;
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_create(handle, policy, &citer),
+			      0);
+
+	int has_next;
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_next(handle, citer, &has_next),
+			      0);
+	CU_ASSERT_FATAL(has_next);
+
+	sepol_cond_expr_iter_t *eiter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_cond_expr_iter_create(handle, citer, &eiter), 0);
+
+	int bool_count = 0, and_count = 0;
+	uint32_t expr_type, bool_value;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_cond_expr_iter_next(handle, eiter,
+								&expr_type,
+								&bool_value),
+				      0);
+		if (expr_type == 0)
+			break;
+		if (expr_type == SEPOL_COND_BOOL) {
+			CU_ASSERT(bool_value > 0);
+			bool_count++;
+		}
+		if (expr_type == SEPOL_COND_AND)
+			and_count++;
+	}
+	CU_ASSERT_EQUAL(bool_count, 2);
+	CU_ASSERT_EQUAL(and_count, 1);
+
+	sepol_cond_expr_iter_destroy(eiter);
+	sepol_cond_iter_destroy(citer);
+}
+
+static void test_cond_rule_iter(void)
+{
+	sepol_cond_iter_t *citer;
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_create(handle, policy, &citer),
+			      0);
+
+	int has_next;
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_next(handle, citer, &has_next),
+			      0);
+	CU_ASSERT_FATAL(has_next);
+
+	/* True list */
+	sepol_cond_rule_iter_t *riter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_cond_rule_iter_create(handle, citer, 1, &riter), 0);
+
+	uint32_t ruletype, src, tgt, cls;
+	int true_count = 0;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_cond_rule_iter_next(handle, riter,
+								&ruletype, &src,
+								&tgt, &cls),
+				      0);
+		if (ruletype == 0)
+			break;
+		CU_ASSERT(src > 0);
+		CU_ASSERT(tgt > 0);
+		CU_ASSERT(cls > 0);
+
+		/* xperm rules don't populate the plain av_data field (their
+		 * permission set lives in the xperms sub-structure instead),
+		 * so only check av_data for non-xperm rule types. */
+		if (!(ruletype & AVTAB_XPERMS)) {
+			uint32_t av = sepol_cond_rule_iter_get_av_data(riter);
+			CU_ASSERT(av != 0);
+		}
+		true_count++;
+	}
+	CU_ASSERT(true_count >= 1);
+	sepol_cond_rule_iter_destroy(riter);
+
+	/* False list */
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_cond_rule_iter_create(handle, citer, 0, &riter), 0);
+
+	int false_count = 0;
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(sepol_cond_rule_iter_next(handle, riter,
+								&ruletype, &src,
+								&tgt, &cls),
+				      0);
+		if (ruletype == 0)
+			break;
+		CU_ASSERT(src > 0);
+		uint32_t av = sepol_cond_rule_iter_get_av_data(riter);
+		CU_ASSERT(av != 0);
+		false_count++;
+	}
+	CU_ASSERT(false_count >= 1);
+	sepol_cond_rule_iter_destroy(riter);
+
+	sepol_cond_iter_destroy(citer);
+}
+
+static void test_xperm_iter(void)
+{
+	sepol_avtab_iter_t *iter;
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_create(handle, policy,
+						      AVTAB_XPERMS_ALLOWED,
+						      &iter),
+			      0);
+
+	uint32_t ruletype, src, tgt, cls;
+	int xperm_count = 0;
+	/*
+	 * Asserts inside this loop are intentionally non-fatal once `iter`
+	 * (and, further in, `xiter`) is allocated: a CU_ASSERT_*_FATAL()
+	 * here would longjmp out of the function and skip
+	 * sepol_xperm_iter_destroy()/sepol_avtab_iter_destroy(), leaking
+	 * the iterator(s).
+	 */
+	while (1) {
+		int rc = sepol_avtab_iter_next(handle, iter, &ruletype, &src,
+					       &tgt, &cls);
+		CU_ASSERT_EQUAL(rc, 0);
+		if (rc != 0 || ruletype == 0)
+			break;
+		CU_ASSERT_EQUAL(ruletype, AVTAB_XPERMS_ALLOWED);
+
+		uint8_t xtype = sepol_avtab_iter_get_xperm_type(iter);
+		CU_ASSERT(xtype == AVTAB_XPERMS_IOCTLFUNCTION ||
+			  xtype == AVTAB_XPERMS_IOCTLDRIVER);
+		CU_ASSERT(sepol_avtab_iter_get_xperm_driver(iter) > 0);
+
+		sepol_xperm_iter_t *xiter = NULL;
+		CU_ASSERT_EQUAL(sepol_xperm_iter_create(handle, iter, &xiter),
+				0);
+		if (!xiter)
+			continue;
+
+		uint16_t value;
+		int has_next;
+		int val_count = 0;
+		while (1) {
+			int xrc = sepol_xperm_iter_next(handle, xiter, &value,
+							&has_next);
+			CU_ASSERT_EQUAL(xrc, 0);
+			if (xrc != 0 || !has_next)
+				break;
+			val_count++;
+		}
+		CU_ASSERT(val_count > 0);
+		sepol_xperm_iter_destroy(xiter);
+		xperm_count++;
+	}
+	CU_ASSERT(xperm_count >= 1);
+
+	sepol_avtab_iter_destroy(iter);
+}
+
+static void test_cond_rule_xperm(void)
+{
+	sepol_cond_iter_t *citer;
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_create(handle, policy, &citer),
+			      0);
+
+	int has_next;
+	int found_xperm = 0;
+
+	/*
+	 * Asserts inside these nested loops are intentionally non-fatal
+	 * once the corresponding iterator (citer/riter/xiter) is allocated:
+	 * a CU_ASSERT_*_FATAL() here would longjmp out of the function and
+	 * skip sepol_xperm_iter_destroy()/sepol_cond_rule_iter_destroy()/
+	 * sepol_cond_iter_destroy(), leaking the iterator(s).
+	 */
+	while (1) {
+		int rc = sepol_cond_iter_next(handle, citer, &has_next);
+		CU_ASSERT_EQUAL(rc, 0);
+		if (rc != 0 || !has_next)
+			break;
+
+		/* iter.conf's `allowxperm` is in the true list. */
+		sepol_cond_rule_iter_t *riter = NULL;
+		CU_ASSERT_EQUAL(sepol_cond_rule_iter_create(handle, citer, 1,
+							    &riter),
+				0);
+		if (!riter)
+			continue;
+
+		uint32_t ruletype, src, tgt, cls;
+		while (1) {
+			int rrc = sepol_cond_rule_iter_next(
+				handle, riter, &ruletype, &src, &tgt, &cls);
+			CU_ASSERT_EQUAL(rrc, 0);
+			if (rrc != 0 || ruletype == 0)
+				break;
+			if (!(ruletype & AVTAB_XPERMS))
+				continue;
+
+			found_xperm = 1;
+			CU_ASSERT(src > 0);
+			CU_ASSERT(tgt > 0);
+			CU_ASSERT(cls > 0);
+
+			uint8_t xtype =
+				sepol_cond_rule_iter_get_xperm_type(riter);
+			CU_ASSERT(xtype == AVTAB_XPERMS_IOCTLFUNCTION ||
+				  xtype == AVTAB_XPERMS_IOCTLDRIVER);
+			CU_ASSERT(sepol_cond_rule_iter_get_xperm_driver(riter) >
+				  0);
+
+			sepol_xperm_iter_t *xiter = NULL;
+			CU_ASSERT_EQUAL(sepol_cond_rule_xperm_iter_create(
+						handle, riter, &xiter),
+					0);
+			if (!xiter)
+				continue;
+
+			uint16_t value;
+			int xhas_next;
+			int val_count = 0;
+			while (1) {
+				int xrc = sepol_xperm_iter_next(
+					handle, xiter, &value, &xhas_next);
+				CU_ASSERT_EQUAL(xrc, 0);
+				if (xrc != 0 || !xhas_next)
+					break;
+				val_count++;
+			}
+			CU_ASSERT(val_count > 0);
+			sepol_xperm_iter_destroy(xiter);
+		}
+		sepol_cond_rule_iter_destroy(riter);
+	}
+	CU_ASSERT(found_xperm);
+
+	sepol_cond_iter_destroy(citer);
+}
+
+static void test_cond_rule_type_data(void)
+{
+	sepol_cond_iter_t *citer;
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_create(handle, policy, &citer),
+			      0);
+
+	int has_next;
+	int found_type_trans = 0;
+
+	while (1) {
+		CU_ASSERT_EQUAL_FATAL(
+			sepol_cond_iter_next(handle, citer, &has_next), 0);
+		if (!has_next)
+			break;
+
+		/* Check both true and false lists */
+		for (int branch = 0; branch <= 1; branch++) {
+			sepol_cond_rule_iter_t *riter;
+			CU_ASSERT_EQUAL_FATAL(
+				sepol_cond_rule_iter_create(handle, citer,
+							    branch, &riter),
+				0);
+
+			uint32_t ruletype, src, tgt, cls;
+			while (1) {
+				CU_ASSERT_EQUAL_FATAL(sepol_cond_rule_iter_next(
+							      handle, riter,
+							      &ruletype, &src,
+							      &tgt, &cls),
+						      0);
+				if (ruletype == 0)
+					break;
+				if (ruletype == AVTAB_TRANSITION) {
+					uint32_t def_type =
+						sepol_cond_rule_iter_get_type_data(
+							riter);
+					CU_ASSERT(def_type > 0);
+					found_type_trans = 1;
+				}
+			}
+			sepol_cond_rule_iter_destroy(riter);
+		}
+	}
+	CU_ASSERT(found_type_trans);
+
+	sepol_cond_iter_destroy(citer);
+}
+
+static void test_iter_null_output_args(void)
+{
+	/* _iter_create: NULL policydb must fail and clear *iter. */
+	sepol_avtab_iter_t *aiter = (void *)0xdeadbeef;
+	CU_ASSERT(sepol_avtab_iter_create(handle, NULL, 0, &aiter) != 0);
+	CU_ASSERT_PTR_NULL(aiter);
+
+	sepol_cond_iter_t *citer = (void *)0xdeadbeef;
+	CU_ASSERT(sepol_cond_iter_create(handle, NULL, &citer) != 0);
+	CU_ASSERT_PTR_NULL(citer);
+
+	/* _iter_next: any NULL output parameter must be rejected rather
+	 * than dereferenced. */
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_avtab_iter_create(handle, policy, 0, &aiter), 0);
+	uint32_t ruletype, src, tgt, cls;
+	CU_ASSERT(sepol_avtab_iter_next(handle, aiter, NULL, &src, &tgt,
+					&cls) != 0);
+	CU_ASSERT(sepol_avtab_iter_next(handle, aiter, &ruletype, NULL, &tgt,
+					&cls) != 0);
+	CU_ASSERT(sepol_avtab_iter_next(handle, aiter, &ruletype, &src, NULL,
+					&cls) != 0);
+	CU_ASSERT(sepol_avtab_iter_next(handle, aiter, &ruletype, &src, &tgt,
+					NULL) != 0);
+	CU_ASSERT_EQUAL(sepol_avtab_iter_next(handle, aiter, &ruletype, &src,
+					      &tgt, &cls),
+			0);
+	sepol_avtab_iter_destroy(aiter);
+
+	/* _iter_create: an out-of-range class value must fail and clear
+	 * *iter, matching sepol_common_perm_iter_create()'s equivalent
+	 * validation. */
+	sepol_perm_iter_t *piter = (void *)0xdeadbeef;
+	CU_ASSERT(sepol_perm_iter_create(handle, policy, 0, ~0u, &piter) != 0);
+	CU_ASSERT_PTR_NULL(piter);
+	piter = (void *)0xdeadbeef;
+	CU_ASSERT(sepol_perm_iter_create(handle, policy, 9999, ~0u, &piter) !=
+		  0);
+	CU_ASSERT_PTR_NULL(piter);
+
+	CU_ASSERT_EQUAL_FATAL(sepol_perm_iter_create(handle, policy,
+						     class_value("CLASS1"), ~0u,
+						     &piter),
+			      0);
+	CU_ASSERT(sepol_perm_iter_next(handle, piter, NULL) != 0);
+	sepol_perm_iter_destroy(piter);
+
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_create(handle, policy,
+						      AVTAB_XPERMS_ALLOWED,
+						      &aiter),
+			      0);
+	CU_ASSERT_EQUAL_FATAL(sepol_avtab_iter_next(handle, aiter, &ruletype,
+						    &src, &tgt, &cls),
+			      0);
+	CU_ASSERT(ruletype != 0);
+	sepol_xperm_iter_t *xiter;
+	CU_ASSERT_EQUAL_FATAL(sepol_xperm_iter_create(handle, aiter, &xiter),
+			      0);
+	uint16_t value;
+	int has_next;
+	CU_ASSERT(sepol_xperm_iter_next(handle, xiter, NULL, &has_next) != 0);
+	CU_ASSERT(sepol_xperm_iter_next(handle, xiter, &value, NULL) != 0);
+	sepol_xperm_iter_destroy(xiter);
+	sepol_avtab_iter_destroy(aiter);
+
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_create(handle, policy, &citer),
+			      0);
+	CU_ASSERT(sepol_cond_iter_next(handle, citer, NULL) != 0);
+
+	CU_ASSERT_EQUAL_FATAL(sepol_cond_iter_next(handle, citer, &has_next),
+			      0);
+	CU_ASSERT_TRUE_FATAL(has_next);
+
+	sepol_cond_expr_iter_t *eiter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_cond_expr_iter_create(handle, citer, &eiter), 0);
+	uint32_t expr_type, bool_value;
+	CU_ASSERT(sepol_cond_expr_iter_next(handle, eiter, NULL, &bool_value) !=
+		  0);
+	CU_ASSERT(sepol_cond_expr_iter_next(handle, eiter, &expr_type, NULL) !=
+		  0);
+	sepol_cond_expr_iter_destroy(eiter);
+
+	sepol_cond_rule_iter_t *riter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_cond_rule_iter_create(handle, citer, 1, &riter), 0);
+	CU_ASSERT(sepol_cond_rule_iter_next(handle, riter, NULL, &src, &tgt,
+					    &cls) != 0);
+	CU_ASSERT(sepol_cond_rule_iter_next(handle, riter, &ruletype, NULL,
+					    &tgt, &cls) != 0);
+	CU_ASSERT(sepol_cond_rule_iter_next(handle, riter, &ruletype, &src,
+					    NULL, &cls) != 0);
+	CU_ASSERT(sepol_cond_rule_iter_next(handle, riter, &ruletype, &src,
+					    &tgt, NULL) != 0);
+	sepol_cond_rule_iter_destroy(riter);
+
+	sepol_cond_iter_destroy(citer);
+}
+
+int av_rule_add_tests(CU_pSuite suite)
+{
+	if (CU_add_test(suite, "avtab_iter_all", test_avtab_iter_all) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "avtab_iter_filtered",
+			test_avtab_iter_filtered) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "avtab_iter_av_data", test_avtab_iter_av_data) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "avtab_iter_type_data",
+			test_avtab_iter_type_data) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "perm_iter_class1", test_perm_iter_class1) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "bool_value_to_name", test_bool_value_to_name) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "cond_iter", test_cond_iter) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "cond_expr_iter", test_cond_expr_iter) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "cond_rule_iter", test_cond_rule_iter) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "cond_rule_xperm", test_cond_rule_xperm) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "xperm_iter", test_xperm_iter) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "cond_rule_type_data",
+			test_cond_rule_type_data) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "iter_null_output_args",
+			test_iter_null_output_args) == NULL)
+		return CU_get_error();
+	return 0;
+}
diff --git a/libsepol/tests/test-av-rule.h b/libsepol/tests/test-av-rule.h
new file mode 100644
index 00000000..7c0b9e47
--- /dev/null
+++ b/libsepol/tests/test-av-rule.h
@@ -0,0 +1,10 @@
+#ifndef TEST_AV_RULE_H
+#define TEST_AV_RULE_H
+
+#include <CUnit/Basic.h>
+
+int av_rule_test_init(void);
+int av_rule_test_cleanup(void);
+int av_rule_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.55.0

