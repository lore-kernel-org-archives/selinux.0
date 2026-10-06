Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7B457E46
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291853; cv=none; b=JgbfeE4luLpY6Wm9jhWIlDMohh+m170Leuxwhz1bnW+8YE4MkJ0P4iluuMorp8kFdZne4MBybX03QqYwK1BQ0Nlrrf58xzJ4HLB+uiUf/oiJYRw/e0j3zbvLdTdr+PJ6q4lWCYo7JNcVH5AEwaXDGx8CX+eUS0BMA3NNRxG4Lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291853; c=relaxed/simple;
	bh=KSkASGm1M7+Bv7TfvShpGwojHatnD0jR7LBSz69SuF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUR9JUk20+eMvJJgdC3S0hhAWTt54/AhKY4h8Q3ic+D+5kGPV4NnS5BTUJ9rRZ0s0qJPxjI17s6sLTgdUooYjUaUpMDkkyGtqoV1aGi3J3fGoMRQyqRO9WsRBj1N/KW7epQiYo8A0QMNk2Gj+0FFNS/D4wSKdy8ny5zKFmGPVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ip7NURAN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip7NURAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmEj5n0PHpv6bvJZc/u4tITu53cMz1Zd8XuWKIyfx0Y=;
	b=ip7NURANpFb9k8+eSg49XYksVxZMphek7a5LSUG+qwDJ1auzFpEoO8mdrBGTVPr+kDf4Pu
	Z5WBBXYDBJZo+TF6/jRplOUfoVdu8SpBVBS/6X1C7g0KYUH0hqOTeYadDCub6by09CO53w
	qpF1n8CQRHf2m+Sb0QGl4VeIxyuwink=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-Jj5sfrRtPmu-rU7sQRZhVA-1; Tue,
 06 Oct 2026 09:04:09 -0400
X-MC-Unique: Jj5sfrRtPmu-rU7sQRZhVA-1
X-Mimecast-MFC-AGG-ID: Jj5sfrRtPmu-rU7sQRZhVA_1791291848
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7070D195E932;
	Tue,  6 Oct 2026 13:04:08 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E5D01944CC0;
	Tue,  6 Oct 2026 13:04:07 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 04/17] libsepol: add test infrastructure and type iterator tests
Date: Tue,  6 Oct 2026 15:02:02 +0200
Message-ID: <20261006130215.128405-5-jjanasek@redhat.com>
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

Add a shared test-iter policy fixture and helper routines for tests
that need a loaded, expanded source policy, and cover the new type
iterator/record API against it.

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/tests/helpers.c                    |   5 +
 libsepol/tests/helpers.h                    |   5 +
 libsepol/tests/libsepol-tests.c             |   2 +
 libsepol/tests/policies/test-iter/iter.conf | 124 ++++++++++++++++++
 libsepol/tests/test-iter-types.c            | 137 ++++++++++++++++++++
 libsepol/tests/test-iter-types.h            |   7 +
 libsepol/tests/test-iter.c                  |  96 ++++++++++++++
 libsepol/tests/test-iter.h                  |  10 ++
 8 files changed, 386 insertions(+)
 create mode 100644 libsepol/tests/policies/test-iter/iter.conf
 create mode 100644 libsepol/tests/test-iter-types.c
 create mode 100644 libsepol/tests/test-iter-types.h
 create mode 100644 libsepol/tests/test-iter.c
 create mode 100644 libsepol/tests/test-iter.h

diff --git a/libsepol/tests/helpers.c b/libsepol/tests/helpers.c
index 439ceae1..bd846e34 100644
--- a/libsepol/tests/helpers.c
+++ b/libsepol/tests/helpers.c
@@ -84,3 +84,8 @@ avrule_decl_t *test_find_decl_by_sym(policydb_t *p, int symtab, const char *sym)
 
 	return p->decl_val_to_struct[scope->decl_ids[0] - 1];
 }
+
+int qstrcmp(const void *a, const void *b)
+{
+	return strcmp(*(char **)a, *(char **)b);
+}
diff --git a/libsepol/tests/helpers.h b/libsepol/tests/helpers.h
index 2885173f..b9463093 100644
--- a/libsepol/tests/helpers.h
+++ b/libsepol/tests/helpers.h
@@ -89,4 +89,9 @@ extern int test_load_policy(policydb_t *p, int policy_type, int mls,
 extern avrule_decl_t *test_find_decl_by_sym(policydb_t *p, int symtab,
 					    const char *sym);
 
+/*
+ * qsort comparator for an array of strings
+ */
+extern int qstrcmp(const void *a, const void *b);
+
 #endif
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 01f45562..a73686b9 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -25,6 +25,7 @@
 #include "test-deps.h"
 #include "test-downgrade.h"
 #include "test-neverallow.h"
+#include "test-iter.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -74,6 +75,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(deps);
 	DECLARE_SUITE(downgrade);
 	DECLARE_SUITE(neverallow);
+	DECLARE_SUITE(iter);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/policies/test-iter/iter.conf b/libsepol/tests/policies/test-iter/iter.conf
new file mode 100644
index 00000000..2c27f9d4
--- /dev/null
+++ b/libsepol/tests/policies/test-iter/iter.conf
@@ -0,0 +1,124 @@
+class CLASS1
+class CLASS01
+class CLASS02
+class CLASS03
+class CLASS04
+class CLASS05
+class CLASS06
+
+sid kernel
+
+common COMMON1 { COMMONPERM1 }
+
+class CLASS1 inherits COMMON1 { PERM1 ioctl }
+class CLASS01 { PERM01 }
+class CLASS02 { PERM02 }
+class CLASS03 { PERM03 }
+class CLASS04 { PERM04 }
+class CLASS05 { PERM05 }
+class CLASS06 { PERM06 }
+
+ifdef(`enable_mls',`
+
+sensitivity s0;
+
+#
+# Define the ordering of the sensitivity levels (least to greatest)
+#
+dominance { s0 }
+
+
+#
+# Define the categories
+#
+# Each category has a name and zero or more aliases.
+#
+category c0; category c1; category c2; category c3;
+
+level s0:c0.c3;
+
+mlsconstrain CLASS1 { PERM1 }
+	( h1 dom h2 );
+')
+
+type TYPE1;
+type TYPE2;
+type TYPE3;
+
+typealias TYPE1 alias ALIAS1;
+typealias TYPE3 alias ALIAS2;
+
+attribute ATTR1;
+typeattribute TYPE2 ATTR1;
+typeattribute TYPE3 ATTR1;
+
+permissive TYPE1;
+
+allow TYPE1 self : CLASS1 { PERM1 };
+allow TYPE1 TYPE2 : CLASS01 { PERM01 };
+allow TYPE3 ATTR1 : CLASS02 { PERM02 };
+allow TYPE1 TYPE3 : CLASS03 { PERM03 };
+
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x5401 0x5402 };
+
+bool BOOL1 true;
+bool BOOL2 false;
+
+type_transition TYPE1 TYPE2 : CLASS01 TYPE3;
+
+if (BOOL1 && BOOL2) {
+	allow TYPE2 TYPE3 : CLASS01 { PERM01 };
+	type_transition TYPE1 TYPE3 : CLASS02 TYPE2;
+	allowxperm TYPE2 TYPE3 : CLASS1 ioctl { 0x5401 0x5402 };
+} else {
+	allow TYPE3 TYPE1 : CLASS01 { PERM01 };
+}
+
+type_transition TYPE1 TYPE3 : CLASS01 TYPE2 "testfile";
+
+role ROLE1;
+role ROLE1 types { TYPE1 };
+role ROLE2;
+role ROLE2 types { TYPE2 };
+
+attribute_role ATTR_ROLE1;
+roleattribute ROLE1 ATTR_ROLE1;
+roleattribute ROLE2 ATTR_ROLE1;
+
+allow ROLE1 ROLE2;
+role_transition ROLE1 TYPE1 : CLASS01 ROLE2;
+
+ifdef(`enable_mls',`
+range_transition TYPE1 TYPE2 : CLASS01 s0 - s0:c0.c3;
+')
+
+policycap network_peer_controls;
+
+gen_user(USER1,, ROLE1, s0, s0 - s0:c0.c3)
+
+constrain CLASS1 { PERM1 } ( t1 == { TYPE1 } );
+constrain CLASS1 { PERM1 } (
+    ( r1 == ROLE1 ) or
+    ( u2 == USER1 )
+);
+
+sid kernel	gen_context(USER1:ROLE1:TYPE1, s0)
+
+fs_use_xattr ext3 gen_context(USER1:ROLE1:TYPE1, s0);
+fs_use_trans devpts gen_context(USER1:ROLE1:TYPE1, s0);
+
+genfscon proc / gen_context(USER1:ROLE1:TYPE1, s0)
+genfscon proc /sys gen_context(USER1:ROLE1:TYPE1, s0)
+
+portcon tcp 80 gen_context(USER1:ROLE1:TYPE1, s0)
+portcon udp 1024-65535 gen_context(USER1:ROLE1:TYPE1, s0)
+
+netifcon eth0 gen_context(USER1:ROLE1:TYPE1, s0) gen_context(USER1:ROLE1:TYPE1, s0)
+
+nodecon 127.0.0.1 255.255.255.255 gen_context(USER1:ROLE1:TYPE1, s0)
+
+nodecon ::1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff gen_context(USER1:ROLE1:TYPE1, s0)
+
+ibpkeycon fe80:: 0x0-0xffff gen_context(USER1:ROLE1:TYPE1, s0)
+
+ibendportcon mlx4_0 1 gen_context(USER1:ROLE1:TYPE1, s0)
diff --git a/libsepol/tests/test-iter-types.c b/libsepol/tests/test-iter-types.c
new file mode 100644
index 00000000..35d864c5
--- /dev/null
+++ b/libsepol/tests/test-iter-types.c
@@ -0,0 +1,137 @@
+#include "test-iter-types.h"
+
+#include <CUnit/CUnit.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/policydb.h>
+#include <sepol/type_record.h>
+#include <sepol/types.h>
+
+#include "helpers.h"
+
+extern sepol_handle_t *handle;
+extern sepol_policydb_t *empty_policy;
+extern sepol_policydb_t *iter_policy;
+
+struct expected_type {
+	int seen;
+
+	const char *name;
+	const char *alias_of;
+	uint32_t flavor;
+	uint32_t flags;
+	size_t nsubtypes;
+	const char *subtypes[32];
+};
+
+struct expected_type expected_types[] = {
+	{ 0, "TYPE1", NULL, SEPOL_TYPE_TYPE, SEPOL_TYPE_FLAGS_PERMISSIVE, 0, {} },
+	{ 0, "TYPE2", NULL, SEPOL_TYPE_TYPE, 0, 0, {} },
+	{ 0, "TYPE3", NULL, SEPOL_TYPE_TYPE, 0, 0, {} },
+	{ 0, "ALIAS1", "TYPE1", SEPOL_TYPE_ALIAS, 0, 0, {} },
+	{ 0, "ALIAS2", "TYPE3", SEPOL_TYPE_ALIAS, 0, 0, {} },
+	{ 0, "ATTR1", NULL, SEPOL_TYPE_ATTRIB, 0, 2, { "TYPE2", "TYPE3" } },
+	{ 0, NULL, NULL, 0, 0, 0, {} },
+};
+
+static void unseen(void)
+{
+	for (struct expected_type *e = expected_types; e->name; e++) {
+		e->seen = 0;
+	}
+}
+
+void test_iter_types_empty(void)
+{
+	sepol_type_iter_t *type_iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_type_iter_create(handle, empty_policy, &type_iter), 0);
+
+	sepol_type_t *item;
+	CU_ASSERT_EQUAL(sepol_type_iter_next(handle, type_iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+	/* all values after end should return NULL as item */
+	CU_ASSERT_EQUAL(sepol_type_iter_next(handle, type_iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+
+	sepol_type_iter_destroy(type_iter);
+}
+
+static void seen(const sepol_type_t *item)
+{
+	const char *actual_name = sepol_type_get_name(item);
+	uint32_t actual_flavor = sepol_type_get_flavor(item);
+	uint32_t nactual_subtypes;
+	const char **actual_subtypes;
+	CU_ASSERT_EQUAL_FATAL(sepol_type_get_subtypes(handle, item,
+						      &actual_subtypes,
+						      &nactual_subtypes),
+			      0);
+	const char *actual_alias_of = sepol_type_get_alias_of(item);
+
+	struct expected_type *e;
+	for (e = expected_types; e->name; e++) {
+		if (strcmp(actual_name, e->name) == 0)
+			break;
+	}
+	CU_ASSERT_PTR_NOT_NULL_FATAL(e->name);
+	e->seen = 1;
+
+	CU_ASSERT_EQUAL(actual_flavor, e->flavor);
+
+	for (size_t i = 0; i < sizeof(uint32_t) * CHAR_BIT; i++) {
+		if ((1u << i) & e->flags) {
+			CU_ASSERT_TRUE(sepol_type_has_flag(item, 1u << i));
+		} else {
+			CU_ASSERT_FALSE(sepol_type_has_flag(item, 1u << i));
+		}
+	}
+
+	CU_ASSERT_EQUAL(nactual_subtypes, e->nsubtypes);
+	/* qsort()'s base is declared nonnull; skip the call entirely for
+	 * an empty (possibly NULL) array rather than relying on nmemb==0
+	 * making the NULL harmless. */
+	if (nactual_subtypes > 0)
+		qsort(actual_subtypes, nactual_subtypes, sizeof(char *),
+		      qstrcmp);
+	for (size_t i = 0; i < nactual_subtypes && i < e->nsubtypes; i++) {
+		CU_ASSERT_STRING_EQUAL(actual_subtypes[i], e->subtypes[i]);
+	}
+
+	if (e->alias_of) {
+		CU_ASSERT_STRING_EQUAL(actual_alias_of, e->alias_of);
+	} else {
+		CU_ASSERT_PTR_NULL(actual_alias_of);
+	}
+
+	free(actual_subtypes);
+}
+
+void test_iter_types_non_empty(void)
+{
+	unseen();
+	sepol_type_t *item;
+	sepol_type_iter_t *type_iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_type_iter_create(handle, iter_policy, &type_iter), 0);
+
+	while (1) {
+		CU_ASSERT_EQUAL(sepol_type_iter_next(handle, type_iter, &item),
+				0);
+		if (!item)
+			break;
+		seen(item);
+		sepol_type_free(item);
+	}
+	CU_ASSERT_EQUAL(sepol_type_iter_next(handle, type_iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+
+	for (struct expected_type *e = expected_types; e->name; e++) {
+		CU_ASSERT_TRUE(e->seen);
+	}
+
+	sepol_type_iter_destroy(type_iter);
+}
diff --git a/libsepol/tests/test-iter-types.h b/libsepol/tests/test-iter-types.h
new file mode 100644
index 00000000..39bf4523
--- /dev/null
+++ b/libsepol/tests/test-iter-types.h
@@ -0,0 +1,7 @@
+#ifndef TEST_ITER_TYPES_H
+#define TEST_ITER_TYPES_H
+
+void test_iter_types_empty(void);
+void test_iter_types_non_empty(void);
+
+#endif
diff --git a/libsepol/tests/test-iter.c b/libsepol/tests/test-iter.c
new file mode 100644
index 00000000..f9b8880f
--- /dev/null
+++ b/libsepol/tests/test-iter.c
@@ -0,0 +1,96 @@
+#include "test-iter.h"
+
+#include <CUnit/CUError.h>
+#include <CUnit/CUnit.h>
+#include <CUnit/TestDB.h>
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/policydb/policydb.h>
+#include <sepol/type_record.h>
+#include <sepol/types.h>
+
+#include "parse_util.h"
+#include "test-iter-types.h"
+
+extern int mls;
+
+sepol_handle_t *handle;
+sepol_policydb_t *empty_policy;
+sepol_policydb_t *iter_policy;
+
+struct policy_entry {
+	sepol_policydb_t **sepol_policy;
+	const char *name;
+};
+
+struct policy_entry entries[] = {
+	{ .sepol_policy = &empty_policy, .name = NULL },
+	{ .sepol_policy = &iter_policy, .name = "iter.conf" },
+	{ .sepol_policy = NULL, .name = NULL },
+};
+
+int iter_test_init(void)
+{
+	handle = sepol_handle_create();
+	if (!handle)
+		return -1;
+
+	for (struct policy_entry *entry = entries; entry->sepol_policy;
+	     entry++) {
+		if (sepol_policydb_create(entry->sepol_policy))
+			goto err;
+		policydb_t *pol = &(*entry->sepol_policy)->p;
+		pol->policy_type = POLICY_BASE;
+		pol->policyvers = MOD_POLICYDB_VERSION_MAX;
+		pol->mls = mls;
+		if (entry->name) {
+			char filename[PATH_MAX] = { 0 };
+			if (snprintf(filename, PATH_MAX,
+				     "policies/test-iter/%s%s", entry->name,
+				     mls ? ".mls" : ".std") < 0)
+				goto err;
+			if (read_source_policy(pol, filename, "test"))
+				goto err;
+		} else {
+			if (policydb_index_classes(pol))
+				goto err;
+			if (policydb_index_others(handle, pol, 0))
+				goto err;
+		}
+	}
+	return 0;
+
+err:
+	for (struct policy_entry *entry = entries; entry->sepol_policy;
+	     entry++) {
+		if (*entry->sepol_policy) {
+			sepol_policydb_free(*entry->sepol_policy);
+			*entry->sepol_policy = NULL;
+		}
+	}
+	sepol_handle_destroy(handle);
+	handle = NULL;
+	return -1;
+}
+
+int iter_test_cleanup(void)
+{
+	for (struct policy_entry *entry = entries; entry->sepol_policy;
+	     entry++) {
+		sepol_policydb_free(*entry->sepol_policy);
+	}
+	sepol_handle_destroy(handle);
+
+	return 0;
+}
+
+int iter_add_tests(CU_pSuite suite)
+{
+	if (CU_add_test(suite, "iter_types_empty", test_iter_types_empty) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "iter_types_non_empty",
+			test_iter_types_non_empty) == NULL)
+		return CU_get_error();
+	return 0;
+}
diff --git a/libsepol/tests/test-iter.h b/libsepol/tests/test-iter.h
new file mode 100644
index 00000000..d3124356
--- /dev/null
+++ b/libsepol/tests/test-iter.h
@@ -0,0 +1,10 @@
+#ifndef TEST_ITER_H
+#define TEST_ITER_H
+
+#include <CUnit/Basic.h>
+
+int iter_test_init(void);
+int iter_test_cleanup(void);
+int iter_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.55.0

