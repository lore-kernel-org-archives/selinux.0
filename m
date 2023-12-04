Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdwNAJVp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836749B
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701708375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNsXAxLj5sSq7Lozt3ZUnmOng6BbB/ztK8ufGsL3v2M=;
	b=TdwNAJVpfiXRU7BUHWkJGdCy3dQacmoXV8/Dcoj3uLDkCYYYnjyuXJl7ltdzaYyNxU4On8
	Ng7Q08noW8amiNwED0l2vkogOunVcTp9j/YNkVOtrZ7cHzhCPueqdNUvEri+zkD32Flfqy
	C00oD57uXdD+6WBaj0xH3xJRLBaj0Jg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-_Vr0JEUMNYyZA1g-s4V6Eg-1; Mon, 04 Dec 2023 11:46:07 -0500
X-MC-Unique: _Vr0JEUMNYyZA1g-s4V6Eg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFE3F185A788
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 16:46:05 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 62C31492BE8;
	Mon,  4 Dec 2023 16:46:05 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 1/2] Revert "libsepol/tests: rename bool indentifiers"
Date: Mon,  4 Dec 2023 17:45:57 +0100
Message-ID: <20231204164558.43667-1-lautrbach@redhat.com>
In-Reply-To: <877cluszxo.fsf@redhat.com>
References: <877cluszxo.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

This reverts commit 893b50c6ce661f3ee339145e76a0bbfa199671c3.

61f21385004 ("libsepol: rename struct member") broke build of SETools:

setools/policyrep.c: In function ‘__pyx_pf_7setools_9policyrep_23ConditionalExprIterator___next__’:
setools/policyrep.c:27857:138: error: ‘cond_expr_t’ {aka ‘struct cond_expr’} has no member named ‘bool’; did you mean ‘boolean’?
27857 |     __pyx_t_3 = __pyx_f_7setools_9policyrep_13SELinuxPolicy_boolean_value_to_datum(__pyx_v_self->__pyx_base.policy, (__pyx_v_self->curr->bool - 1)); if (unlikely(PyErr_Occurred())) __PYX_ERR(1, 336, __pyx_L1_error)
      |                                                                                                                                          ^~~~
      |

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsepol/tests/test-linker-cond-map.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-linker-cond-map.c
index 142066669c0c..6ea0e4c2ac6b 100644
--- a/libsepol/tests/test-linker-cond-map.c
+++ b/libsepol/tests/test-linker-cond-map.c
@@ -51,7 +51,7 @@
  */
 
 typedef struct test_cond_expr {
-	const char *boolean;
+	const char *bool;
 	uint32_t expr_type;
 } test_cond_expr_t;
 
@@ -69,18 +69,18 @@ static void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_
 		CU_ASSERT_FATAL(expr != NULL);
 
 		CU_ASSERT(expr->expr_type == bools[i].expr_type);
-		if (bools[i].boolean) {
-			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->boolean - 1], bools[i].boolean) == 0);
+		if (bools[i].bool) {
+			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->boolean - 1], bools[i].bool) == 0);
 		}
 		expr = expr->next;
 	}
 }
 
-static void test_bool_state(policydb_t * p, const char *boolean, int state)
+static void test_bool_state(policydb_t * p, const char *bool, int state)
 {
 	cond_bool_datum_t *b;
 
-	b = hashtab_search(p->p_bools.table, boolean);
+	b = hashtab_search(p->p_bools.table, bool);
 	CU_ASSERT_FATAL(b != NULL);
 	CU_ASSERT(b->state == state);
 }
@@ -100,7 +100,7 @@ void base_cond_tests(policydb_t * base)
 	test_sym_presence(base, "g_b_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "g_b_bool_1", 0);
 	/* conditional expression mapped correctly */
-	bools[0].boolean = "g_b_bool_1";
+	bools[0].bool = "g_b_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -110,7 +110,7 @@ void base_cond_tests(policydb_t * base)
 	test_sym_presence(base, "o1_b_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "o1_b_bool_1", 1);
 	/* conditional expression mapped correctly */
-	bools[0].boolean = "o1_b_bool_1";
+	bools[0].bool = "o1_b_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -128,7 +128,7 @@ void module_cond_tests(policydb_t * base)
 	test_sym_presence(base, "g_m1_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "g_m1_bool_1", 1);
 	/* conditional expression mapped correctly */
-	bools[0].boolean = "g_m1_bool_1";
+	bools[0].bool = "g_m1_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -138,7 +138,7 @@ void module_cond_tests(policydb_t * base)
 	test_sym_presence(base, "o1_m1_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "o1_m1_bool_1", 0);
 	/* conditional expression mapped correctly */
-	bools[0].boolean = "o1_m1_bool_1";
+	bools[0].bool = "o1_m1_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -150,11 +150,11 @@ void module_cond_tests(policydb_t * base)
 	test_bool_state(base, "g_m2_bool_1", 1);
 	test_bool_state(base, "g_m2_bool_2", 0);
 	/* conditional expression mapped correctly */
-	bools[0].boolean = "g_m2_bool_1";
+	bools[0].bool = "g_m2_bool_1";
 	bools[0].expr_type = COND_BOOL;
-	bools[1].boolean = "g_m2_bool_2";
+	bools[1].bool = "g_m2_bool_2";
 	bools[1].expr_type = COND_BOOL;
-	bools[2].boolean = NULL;
+	bools[2].bool = NULL;
 	bools[2].expr_type = COND_AND;
 	test_cond_expr_mapping(base, d, bools, 3);
 }
-- 
2.41.0

