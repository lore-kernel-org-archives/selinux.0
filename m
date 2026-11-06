Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968527;
	b=hj/QLs9aZdYwifok19Jz6nLgaUGPjRG+DHBBY0P5Ja2F2hYd5woVMwIXb+ctJP+44NlO
	 +AP3dXtutggwmVCEF79FxKBoLB7hJcDC5snjxe3L1U1mycAYUW2CNf4oEytn020lZRQ9Y
	 eOgO/+98/N22/0lU/vyVh/wdcMUiKZQrjTfISaZw3zJjZsKi1muhAeoAVKIluJp0eddN7
	 j0rjTiMWCmRsgFYtLNNRf2IN/gm3O8q8zcLbY4aUoPgH+Qml/bg0UD9V8bTzcQzK3rzsZ
	 9NPVaXD1AKTvUXFpCSET3iZ9GQgT9nWfI6WgBFCW+dlKmTsAtRDIhJR26JJZYr5TgnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968527;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Sjkm7qQdupaX4EC/9qP2nZy8WiXnMvPjDpRylKYaHVo=;
	b=BZ7lkoxdIGgDgg5C5sAHhVvhMG0Kk7lUU2Gn4+UmAtlTLRrDVPFTFreGs6wkH3sq0Luv
	 QzCEHPlejN3dF0PGWt0KOZFl389ECwMa17DIEtOXULrpWjTgFSCHTYB01ofdffMN4qinD
	 YuyCRGt8dou48IAyuFWyef3mK+aGKTWw5CrZ4xsVIrQEG4yrIRQUyt4FVu6IJWKj08iz/
	 PAls11uUbfsYJt6x/exPNQK/GHwwV2WPl/1r93RpbDIJC+42DCVatG7u7w2+poVks2dlr
	 7EPPFr7DOv2aYYyZwrkWkLEu9ZaOzoj+7FcqBWC1VzrAEyDGkQLDYSKyA+5ees/7YTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=XoR4qrI8;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C42606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C42606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=XoR4qrI8
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968523;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Sjkm7qQdupaX4EC/9qP2nZy8WiXnMvPjDpRylKYaHVo=;
	b=XoR4qrI8R6Q5jaWdYSZPM/BGWXt6bX/Pezbi9sFWhp+LCSE4IpZHl2nAQYTdyufPpE64Mu
	Zlz5kYbFkjWtlOU5bDFWBafh3gv9qMTjwSewyAjfkKWULgD7mXj79a7tHOgAJsiHto5Av3
	MRq1vGtGakygfA97E9n65+VESZgbarsg6KUbFtQVtpkG9uL7Ci186WM3u2blhINWpc8pnP
	0UWuraRRTundmd6ZbaNHGSI7U7rXlfjyHrNCCz4bescSBSMiFo7wfRjftfsWtIBfJLm6Kf
	8d3BzKQPg1EqnyCiurm1c4aRQFVFfLPG3zd7yS47emdSyyhHbTKIfYPYn9mgiw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 02/16] libsepol: expand every class of a type rule after a duplicate
Date: Fri,  6 Nov 2026 13:34:55 +0100
Message-ID: <20261106123510.76727-1-cgoettsche@seltendoof.de>
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

expand_terule_helper() walks the classes of a type_transition,
type_member or type_change rule and returns success as soon as one class
maps to an identical rule already present in the same scope. The
remaining classes of the rule are never expanded and are lost without a
diagnostic.

For example, with dup_src_t carrying the attribute dup_src_a,

    type_transition dup_src_t dup_tgt_t:dir dup_new_t;
    type_transition dup_src_a dup_tgt_t:{ dir file } dup_new_t;

expands only the dir transition; the file transition is dropped, so a
file created by dup_src_t in dup_tgt_t is labeled dup_tgt_t instead of
dup_new_t. Reversing the two statements keeps both. Refpolicy hits this
with kubelet_t and kubectl_domain, losing
type_transition kubelet_t tmp_t:file kubernetes_tmp_t.

Skip only the duplicated class and continue with the next one, and add
a regression test expanding the example above.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/expand.c                         |  6 +-
 .../test-expander/terule-dup-base.conf        | 36 +++++++++++
 libsepol/tests/test-expander.c                | 61 +++++++++++++++++++
 3 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 libsepol/tests/policies/test-expander/terule-dup-base.conf

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 153b609f..268fd5b8 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2016,8 +2016,10 @@ static int expand_terule_helper(sepol_handle_t *handle, policydb_t *p,
 				/* if the duplicate is inside the same scope (eg., unconditional 
 				 * or in same conditional then ignore it */
 				if ((conflict == 1 && cond == NULL) ||
-				    node->parse_context == cond)
-					return EXPAND_RULE_SUCCESS;
+				    node->parse_context == cond) {
+					cur = cur->next;
+					continue;
+				}
 				ERR(handle, "duplicate TE rule for %s %s:%s %s",
 				    p->p_type_val_to_name[avkey.source_type - 1],
 				    p->p_type_val_to_name[avkey.target_type - 1],
diff --git a/libsepol/tests/policies/test-expander/terule-dup-base.conf b/libsepol/tests/policies/test-expander/terule-dup-base.conf
new file mode 100644
index 00000000..90480d58
--- /dev/null
+++ b/libsepol/tests/policies/test-expander/terule-dup-base.conf
@@ -0,0 +1,36 @@
+class process
+class file
+class dir
+
+sid kernel
+
+class process { transition }
+class file { read }
+class dir { read }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+
+mlsconstrain file { read } ( h1 dom h2 );
+')
+
+attribute dup_src_a;
+type dup_src_t, dup_src_a;
+type dup_tgt_t;
+type dup_new_t;
+
+allow dup_src_t dup_tgt_t : file read;
+
+# The dir mapping repeats the first class of the multi-class rule below;
+# the file mapping must still be expanded.
+type_transition dup_src_t dup_tgt_t : dir dup_new_t;
+type_transition dup_src_a dup_tgt_t : { dir file } dup_new_t;
+
+type sys_isid;
+role sys_role;
+role sys_role types { sys_isid dup_src_t dup_tgt_t dup_new_t };
+gen_user(sys_user,, sys_role, s0, s0 - s0:c0)
+sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
diff --git a/libsepol/tests/test-expander.c b/libsepol/tests/test-expander.c
index 56977e09..7fd4f421 100644
--- a/libsepol/tests/test-expander.c
+++ b/libsepol/tests/test-expander.c
@@ -261,6 +261,62 @@ static void test_expander_negset_bounds(void)
 	free(p.type_val_to_struct);
 }
 
+static uint32_t terule_dup_value(const policydb_t *p, int symtab,
+				 const char *name)
+{
+	const symtab_datum_t *datum =
+		hashtab_search(p->symtab[symtab].table, name);
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(datum);
+	return datum->value;
+}
+
+/*
+ * A type rule naming several classes must expand every class even when its
+ * mapping for an earlier class duplicates an existing rule in the same scope.
+ */
+static void test_expander_terule_multiclass_duplicate(void)
+{
+	policydb_t dup_basemod, expanded;
+	avtab_key_t key;
+	const avtab_datum_t *datum;
+	uint32_t new_type;
+
+	if (test_load_policy(&dup_basemod, POLICY_BASE, mls, "test-expander",
+			     "terule-dup-base.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	if (link_modules(NULL, &dup_basemod, NULL, 0, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	if (policydb_init(&expanded))
+		CU_FAIL_FATAL("Failed to initialize policy");
+
+	if (expand_module(NULL, &dup_basemod, &expanded, 0, 0))
+		CU_FAIL_FATAL("Failed to expand policy");
+
+	new_type = terule_dup_value(&expanded, SYM_TYPES, "dup_new_t");
+
+	key.source_type = terule_dup_value(&expanded, SYM_TYPES, "dup_src_t");
+	key.target_type = terule_dup_value(&expanded, SYM_TYPES, "dup_tgt_t");
+	key.specified = AVTAB_TRANSITION;
+
+	key.target_class = terule_dup_value(&expanded, SYM_CLASSES, "dir");
+	datum = avtab_search(&expanded.te_avtab, &key);
+	CU_ASSERT_PTR_NOT_NULL(datum);
+	if (datum)
+		CU_ASSERT_EQUAL(datum->data, new_type);
+
+	key.target_class = terule_dup_value(&expanded, SYM_CLASSES, "file");
+	datum = avtab_search(&expanded.te_avtab, &key);
+	CU_ASSERT_PTR_NOT_NULL(datum);
+	if (datum)
+		CU_ASSERT_EQUAL(datum->data, new_type);
+
+	policydb_destroy(&dup_basemod);
+	policydb_destroy(&expanded);
+}
+
 int expander_add_tests(CU_pSuite suite)
 {
 	if (NULL ==
@@ -294,5 +350,10 @@ int expander_add_tests(CU_pSuite suite)
 		CU_cleanup_registry();
 		return CU_get_error();
 	}
+	if (NULL == CU_add_test(suite, "expander_terule_multiclass_duplicate",
+				test_expander_terule_multiclass_duplicate)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
 	return 0;
 }
-- 
2.55.0

