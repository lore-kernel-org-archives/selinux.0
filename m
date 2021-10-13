Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBAC433FE
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34AD60EE9
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 12:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhJMM4N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhJMM4M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 08:56:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B9C061746
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 05:54:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d3so9857638edp.3
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MwMbXlOcmo43uB4c38qqpr4amJfzqtXlCIvxpgstWbg=;
        b=eQxEBUiQ/Qi40+ca38i4N7CMNsNGYvd2l/wnK4mA9YpSuv8j+LUsmKu/gvpYOgNq2e
         ziekq+oInnLIHpf/YjIeEwP0fLD1JwwkrrX2RoUCABXugPo445HMoT8fkMrdkA7TPR/J
         gfzzO0NRJzRqzLKMJhTY0q0mxNqxerGDJbKSqZLcRodMlCSuAd8fM7f3ybgrl20SoOfd
         l3ev4Juqp1skj31ZONNHjh1u0997NPgLSflqg1nNEjiGAz/FTAfB3AOXO4Jo2BCPUhjS
         FIsPtmdVXONoTlpJxsjUnUX3WJev6u5O+J3A8n8Mdx3pVaZCo7eYn2WV9DdgQ86f7M1P
         OTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwMbXlOcmo43uB4c38qqpr4amJfzqtXlCIvxpgstWbg=;
        b=AfCjQRNFPPFfho5R/XRCehMO8IDb+78sORJ+vGqJBbKXTs2M5hPSpQ57+biRaXBV1j
         sx2jWgh7NE8rTcilx+0SYJ4ljJcWIszI7CsDFmb+ccXK+xYz5yDoO7JI5YLKNeOga29t
         ZkoVuI5iFoUpTBdjFk4xAGV580sLM2jqbkqpbW1m2YDXCGgm+C8qE80bB3AxouII8H3b
         HsSPzO78wXIdsh6qZPwM4IWc0/kW3hrCyojOWhec9Vtzp0LjfXHcZ0L6jY2X1ca0nPNl
         aDNHjaRG3upBWLDjgxoDwcOt+q4wzqzskLBzhWBY0qVkFGZM1OczyNEWpijDFWBwZL2Y
         I4VA==
X-Gm-Message-State: AOAM530yoK24Sk44E/qKXVEF/fRO5IXz2Y5Pm7H7rk1jIFE4iJEw4+Y2
        iwH5iZtphAH5Sf5iq4Afp48JE/CHNQU=
X-Google-Smtp-Source: ABdhPJw9tfSuUeKdWb51YzLGhLXVEcoYVxHIgdkJq84h9qdB3j6y9BMbLZ7ioZh71sujbxqIt4O2jQ==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr9468003ede.377.1634129646473;
        Wed, 13 Oct 2021 05:54:06 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-105-029.77.3.pool.telefonica.de. [77.3.105.29])
        by smtp.gmail.com with ESMTPSA id u16sm6745880ejy.14.2021.10.13.05.54.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:54:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsemanage/tests: free memory
Date:   Wed, 13 Oct 2021 14:53:58 +0200
Message-Id: <20211013125358.15534-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013125358.15534-1-cgzones@googlemail.com>
References: <20211013125358.15534-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Free all memory in test cases, reported by LeakSanitizer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/tests/test_bool.c      | 33 +++++++++++++++++++++++++++++-
 libsemanage/tests/test_fcontext.c  | 31 +++++++++++++++++++++++++++-
 libsemanage/tests/test_ibendport.c | 13 ++++++++++++
 libsemanage/tests/test_iface.c     | 24 ++++++++++++++++++++++
 libsemanage/tests/test_node.c      | 29 ++++++++++++++++++++++++++
 libsemanage/tests/test_other.c     |  6 ++++++
 libsemanage/tests/test_port.c      | 24 ++++++++++++++++++++++
 libsemanage/tests/test_user.c      | 17 +++++++++++++++
 libsemanage/tests/utilities.c      |  5 ++++-
 libsemanage/tests/utilities.h      |  2 ++
 10 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/libsemanage/tests/test_bool.c b/libsemanage/tests/test_bool.c
index ae80d448..558eab78 100644
--- a/libsemanage/tests/test_bool.c
+++ b/libsemanage/tests/test_bool.c
@@ -132,6 +132,8 @@ semanage_bool_t *get_bool_nth(int idx)
 		if (i != (unsigned int) idx)
 			semanage_bool_free(records[i]);
 
+	free(records);
+
 	return boolean;
 }
 
@@ -163,6 +165,8 @@ semanage_bool_key_t *get_bool_key_nth(int idx)
 	CU_ASSERT_FATAL(res >= 0);
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
+	semanage_bool_free(boolean);
+
 	return key;
 }
 
@@ -196,6 +200,9 @@ void add_local_bool(const char *name)
 	CU_ASSERT_PTR_NOT_NULL_FATAL(boolean);
 
 	CU_ASSERT_FATAL(semanage_bool_modify_local(sh, key, boolean) >= 0);
+
+	semanage_bool_key_free(key);
+	semanage_bool_free(boolean);
 }
 
 void delete_local_bool(const char *name)
@@ -208,6 +215,8 @@ void delete_local_bool(const char *name)
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
 	CU_ASSERT_FATAL(semanage_bool_del_local(sh, key) >= 0);
+
+	semanage_bool_key_free(key);
 }
 
 /* Function bool_key_create */
@@ -447,6 +456,8 @@ void helper_bool_create(level_t level)
 	CU_ASSERT_PTR_NULL(semanage_bool_get_name(boolean));
 	CU_ASSERT(semanage_bool_get_value(boolean) == 0);
 
+	semanage_bool_free(boolean);
+
 	cleanup_handle(level);
 }
 
@@ -483,6 +494,9 @@ void helper_bool_clone(level_t level, int bool_idx)
 
 	CU_ASSERT_EQUAL(val, val_clone);
 
+	semanage_bool_free(boolean_clone);
+	semanage_bool_free(boolean);
+
 	cleanup_handle(level);
 }
 
@@ -514,6 +528,9 @@ void helper_bool_query(level_t level, const char *bool_str, int exp_res)
 		CU_ASSERT_PTR_NULL(resp);
 	}
 
+	semanage_bool_free(resp);
+	semanage_bool_key_free(key);
+
 	cleanup_handle(level);
 }
 
@@ -647,6 +664,8 @@ void helper_bool_list(level_t level)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_bool_free(records[i]);
 
+	free(records);
+
 	cleanup_handle(level);
 }
 
@@ -662,7 +681,7 @@ void helper_bool_modify_del_local(level_t level, const char *name,
 				  int old_val, int exp_res)
 {
 	semanage_bool_t *boolean;
-	semanage_bool_t *boolean_local;
+	semanage_bool_t *boolean_local = NULL;
 	semanage_bool_key_t *key = NULL;
 	int res;
 	int new_val;
@@ -703,6 +722,7 @@ void helper_bool_modify_del_local(level_t level, const char *name,
 
 	/* cleanup */
 	semanage_bool_key_free(key);
+	semanage_bool_free(boolean_local);
 	semanage_bool_free(boolean);
 
 	cleanup_handle(level);
@@ -734,15 +754,18 @@ void test_bool_query_local(void)
 
 	/* transaction */
 	setup_handle(SH_TRANS);
+	semanage_bool_key_free(key);
 	CU_ASSERT(semanage_bool_key_create(sh, BOOL1_NAME, &key) >= 0);
 	CU_ASSERT_PTR_NOT_NULL(key);
 
 	CU_ASSERT(semanage_bool_query_local(sh, key, &resp) < 0);
 	CU_ASSERT_PTR_NULL(resp);
+	semanage_bool_free(resp);
 
 	add_local_bool(BOOL1_NAME);
 	CU_ASSERT(semanage_bool_query_local(sh, key, &resp) >= 0);
 	CU_ASSERT_PTR_NOT_NULL(resp);
+	semanage_bool_free(resp);
 
 	semanage_bool_key_free(key);
 	CU_ASSERT(semanage_bool_key_create(sh, BOOL2_NAME, &key) >= 0);
@@ -751,8 +774,10 @@ void test_bool_query_local(void)
 	add_local_bool(BOOL2_NAME);
 	CU_ASSERT(semanage_bool_query_local(sh, key, &resp) >= 0);
 	CU_ASSERT_PTR_NOT_NULL(resp);
+	semanage_bool_free(resp);
 
 	/* cleanup */
+	semanage_bool_key_free(key);
 	delete_local_bool(BOOL1_NAME);
 	delete_local_bool(BOOL2_NAME);
 	cleanup_handle(SH_TRANS);
@@ -784,6 +809,7 @@ void test_bool_exists_local(void)
 	CU_ASSERT(resp == 0);
 
 	/* cleanup */
+	semanage_bool_key_free(key);
 	cleanup_handle(SH_TRANS);
 }
 
@@ -918,12 +944,17 @@ void test_bool_list_local(void)
 	CU_ASSERT(semanage_bool_list_local(sh, &records, &count) >= 0);
 	CU_ASSERT(count == init_count + 1);
 	CU_ASSERT_PTR_NOT_NULL(records[0]);
+	semanage_bool_free(records[0]);
+	free(records);
 
 	add_local_bool(BOOL2_NAME);
 	CU_ASSERT(semanage_bool_list_local(sh, &records, &count) >= 0);
 	CU_ASSERT(count == init_count + 2);
 	CU_ASSERT_PTR_NOT_NULL(records[0]);
 	CU_ASSERT_PTR_NOT_NULL(records[1]);
+	semanage_bool_free(records[0]);
+	semanage_bool_free(records[1]);
+	free(records);
 
 	/* cleanup */
 	delete_local_bool(BOOL1_NAME);
diff --git a/libsemanage/tests/test_fcontext.c b/libsemanage/tests/test_fcontext.c
index 62af711f..a012c5dd 100644
--- a/libsemanage/tests/test_fcontext.c
+++ b/libsemanage/tests/test_fcontext.c
@@ -214,6 +214,8 @@ semanage_fcontext_t *get_fcontext_nth(int idx)
 		if (i != (unsigned int) idx)
 			semanage_fcontext_free(records[i]);
 
+	free(records);
+
 	return fcontext;
 }
 
@@ -230,6 +232,8 @@ semanage_fcontext_key_t *get_fcontext_key_nth(int idx)
 	CU_ASSERT_FATAL(semanage_fcontext_key_extract(sh, fcontext, &key) >= 0);
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
+	semanage_fcontext_free(fcontext);
+
 	return key;
 }
 
@@ -246,6 +250,10 @@ void add_local_fcontext(int fcontext_idx)
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
 	CU_ASSERT_FATAL(semanage_fcontext_modify_local(sh, key, fcontext) >= 0);
+
+	/* cleanup */
+	semanage_fcontext_key_free(key);
+	semanage_fcontext_free(fcontext);
 }
 
 void delete_local_fcontext(int fcontext_idx)
@@ -257,6 +265,8 @@ void delete_local_fcontext(int fcontext_idx)
 	key = get_fcontext_key_nth(fcontext_idx);
 
 	CU_ASSERT_FATAL(semanage_fcontext_del_local(sh, key) >= 0);
+
+	semanage_fcontext_key_free(key);
 }
 
 semanage_fcontext_key_t *get_fcontext_key_from_str(const char *str, int type)
@@ -477,6 +487,7 @@ void helper_fcontext_get_set_con(level_t level, int fcontext_idx,
 	}
 
 	/* cleanup */
+	semanage_context_free(con);
 	semanage_fcontext_free(fcontext);
 	cleanup_handle(level);
 }
@@ -587,12 +598,14 @@ void helper_fcontext_query(level_t level, const char *fcontext_expr,
 		CU_ASSERT(res >= 0);
 		const char *expr = semanage_fcontext_get_expr(resp);
 		CU_ASSERT_STRING_EQUAL(expr, fcontext_expr);
+		semanage_fcontext_free(resp);
 	} else {
 		CU_ASSERT(res < 0);
 		CU_ASSERT(resp == (void *) 42);
 	}
 
 	/* cleanup */
+	semanage_fcontext_key_free(key);
 	cleanup_handle(level);
 }
 
@@ -752,6 +765,8 @@ void helper_fcontext_list(level_t level)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_fcontext_free(records[i]);
 
+	free(records);
+
 	/* cleanup */
 	cleanup_handle(level);
 }
@@ -768,7 +783,7 @@ void helper_fcontext_modify_del_local(level_t level, int fcontext_idx,
 				      const char *con_str, int exp_res)
 {
 	semanage_fcontext_t *fcontext;
-	semanage_fcontext_t *fcontext_local;
+	semanage_fcontext_t *fcontext_local = NULL;
 	semanage_fcontext_key_t *key = NULL;
 	semanage_context_t *con = NULL;
 	int res;
@@ -811,7 +826,9 @@ void helper_fcontext_modify_del_local(level_t level, int fcontext_idx,
 	}
 
 	/* cleanup */
+	semanage_context_free(con);
 	semanage_fcontext_key_free(key);
+	semanage_fcontext_free(fcontext_local);
 	semanage_fcontext_free(fcontext);
 	cleanup_handle(level);
 }
@@ -846,6 +863,7 @@ void test_fcontext_query_local(void)
 	/* transaction */
 	setup_handle(SH_TRANS);
 
+	semanage_fcontext_key_free(key);
 	key = get_fcontext_key_nth(I_FIRST);
 	CU_ASSERT(semanage_fcontext_query_local(sh, key, &resp) < 0);
 	CU_ASSERT_PTR_NULL(resp);
@@ -853,14 +871,19 @@ void test_fcontext_query_local(void)
 	add_local_fcontext(I_FIRST);
 	CU_ASSERT(semanage_fcontext_query_local(sh, key, &resp) >= 0);
 	CU_ASSERT_PTR_NOT_NULL(resp);
+	semanage_fcontext_free(resp);
+	resp = NULL;
 
 	semanage_fcontext_key_free(key);
 	key = get_fcontext_key_nth(I_SECOND);
 	add_local_fcontext(I_SECOND);
 	CU_ASSERT(semanage_fcontext_query_local(sh, key, &resp) >= 0);
 	CU_ASSERT_PTR_NOT_NULL(resp);
+	semanage_fcontext_free(resp);
+	resp = NULL;
 
 	/* cleanup */
+	semanage_fcontext_key_free(key);
 	delete_local_fcontext(I_FIRST);
 	delete_local_fcontext(I_SECOND);
 	cleanup_handle(SH_TRANS);
@@ -898,6 +921,7 @@ void test_fcontext_exists_local(void)
 	CU_ASSERT(resp == 0);
 
 	/* cleanup */
+	semanage_fcontext_key_free(key);
 	cleanup_handle(SH_TRANS);
 }
 
@@ -1031,12 +1055,17 @@ void test_fcontext_list_local(void)
 	CU_ASSERT(semanage_fcontext_list_local(sh, &records, &count) >= 0);
 	CU_ASSERT(count == 1);
 	CU_ASSERT_PTR_NOT_NULL(records[0]);
+	semanage_fcontext_free(records[0]);
+	free(records);
 
 	add_local_fcontext(I_SECOND);
 	CU_ASSERT(semanage_fcontext_list_local(sh, &records, &count) >= 0);
 	CU_ASSERT(count == 2);
 	CU_ASSERT_PTR_NOT_NULL(records[0]);
 	CU_ASSERT_PTR_NOT_NULL(records[1]);
+	semanage_fcontext_free(records[0]);
+	semanage_fcontext_free(records[1]);
+	free(records);
 
 	/* cleanup */
 	delete_local_fcontext(I_FIRST);
diff --git a/libsemanage/tests/test_ibendport.c b/libsemanage/tests/test_ibendport.c
index 79a8e2c8..666f8828 100644
--- a/libsemanage/tests/test_ibendport.c
+++ b/libsemanage/tests/test_ibendport.c
@@ -113,6 +113,8 @@ semanage_ibendport_t *get_ibendport_nth(int idx)
 		if (i != (unsigned int) idx)
 			semanage_ibendport_free(records[i]);
 
+	free(records);
+
 	return ibendport;
 }
 
@@ -132,6 +134,8 @@ semanage_ibendport_key_t *get_ibendport_key_nth(int idx)
 	CU_ASSERT_FATAL(res >= 0);
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
+	semanage_ibendport_free(ibendport);
+
 	return key;
 }
 
@@ -148,6 +152,9 @@ void add_local_ibendport(int idx)
 
 	CU_ASSERT_FATAL(semanage_ibendport_modify_local(sh, key,
 							ibendport) >= 0);
+
+	semanage_ibendport_key_free(key);
+	semanage_ibendport_free(ibendport);
 }
 
 void delete_local_ibendport(int idx)
@@ -155,6 +162,8 @@ void delete_local_ibendport(int idx)
 	semanage_ibendport_key_t *key = NULL;
 	key = get_ibendport_key_nth(idx);
 	CU_ASSERT_FATAL(semanage_ibendport_del_local(sh, key) >= 0);
+
+	semanage_ibendport_key_free(key);
 }
 
 /* Function semanage_ibendport_query */
@@ -195,7 +204,9 @@ void test_ibendport_query(void)
 	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
 
 	/* cleanup */
+	free(name_exp);
 	free(name);
+	semanage_ibendport_key_free(key);
 	semanage_ibendport_free(ibendport);
 	semanage_ibendport_free(ibendport_exp);
 	cleanup_handle(SH_CONNECT);
@@ -362,6 +373,8 @@ void test_ibendport_modify_del_query_local(void)
 						 &ibendport_local) < 0);
 
 	/* cleanup */
+	semanage_ibendport_key_free(key);
+	semanage_ibendport_free(ibendport_local);
 	semanage_ibendport_free(ibendport);
 	cleanup_handle(SH_TRANS);
 }
diff --git a/libsemanage/tests/test_iface.c b/libsemanage/tests/test_iface.c
index d5d530a8..19ac577c 100644
--- a/libsemanage/tests/test_iface.c
+++ b/libsemanage/tests/test_iface.c
@@ -139,6 +139,8 @@ semanage_iface_t *get_iface_nth(int idx)
 		if (i != (unsigned int) idx)
 			semanage_iface_free(records[i]);
 
+	free(records);
+
 	return iface;
 }
 
@@ -157,6 +159,9 @@ semanage_iface_key_t *get_iface_key_nth(int idx)
 	CU_ASSERT_FATAL(res >= 0);
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
+	/* cleanup */
+	semanage_iface_free(iface);
+
 	return key;
 }
 
@@ -171,6 +176,10 @@ void add_local_iface(int idx)
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
 	CU_ASSERT_FATAL(semanage_iface_modify_local(sh, key, iface) >= 0);
+
+	/* cleanup */
+	semanage_iface_key_free(key);
+	semanage_iface_free(iface);
 }
 
 void delete_local_iface(int idx)
@@ -178,6 +187,9 @@ void delete_local_iface(int idx)
 	semanage_iface_key_t *key = NULL;
 	key = get_iface_key_nth(idx);
 	CU_ASSERT_FATAL(semanage_iface_del_local(sh, key) >= 0);
+
+	/* cleanup */
+	semanage_iface_key_free(key);
 }
 
 /* Function semanage_iface_compare */
@@ -309,6 +321,7 @@ void test_iface_get_set_ifcon(void)
 	CU_ASSERT_CONTEXT_EQUAL(con1, con2);
 
 	/* cleanup */
+	semanage_context_free(con1);
 	semanage_iface_free(iface);
 	cleanup_handle(SH_CONNECT);
 }
@@ -332,6 +345,7 @@ void test_iface_get_set_msgcon(void)
 	CU_ASSERT_CONTEXT_EQUAL(con1, con2);
 
 	/* cleanup */
+	semanage_context_free(con1);
 	semanage_iface_free(iface);
 	cleanup_handle(SH_CONNECT);
 }
@@ -357,6 +371,8 @@ void test_iface_create(void)
 	CU_ASSERT(semanage_iface_set_msgcon(sh, iface, msgcon) >= 0);
 
 	/* cleanup */
+	semanage_context_free(msgcon);
+	semanage_context_free(ifcon);
 	semanage_iface_free(iface);
 	cleanup_handle(SH_CONNECT);
 }
@@ -393,6 +409,8 @@ void test_iface_clone(void)
 	CU_ASSERT_CONTEXT_EQUAL(msgcon, msgcon2);
 
 	/* cleanup */
+	semanage_context_free(msgcon);
+	semanage_context_free(ifcon);
 	semanage_iface_free(iface);
 	semanage_iface_free(iface_clone);
 	cleanup_handle(SH_CONNECT);
@@ -426,6 +444,7 @@ void test_iface_query(void)
 	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
 
 	/* cleanup */
+	semanage_iface_key_free(key);
 	semanage_iface_free(iface);
 	semanage_iface_free(iface_exp);
 	cleanup_handle(SH_CONNECT);
@@ -513,6 +532,8 @@ void test_iface_list(void)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_iface_free(records[i]);
 
+	free(records);
+
 	/* cleanup */
 	cleanup_handle(SH_CONNECT);
 }
@@ -546,6 +567,8 @@ void test_iface_modify_del_query_local(void)
 	CU_ASSERT(semanage_iface_query_local(sh, key, &iface_local) < 0);
 
 	/* cleanup */
+	semanage_iface_key_free(key);
+	semanage_iface_free(iface_local);
 	semanage_iface_free(iface);
 	cleanup_handle(SH_TRANS);
 }
@@ -658,6 +681,7 @@ void test_iface_list_local(void)
 	/* cleanup */
 	for (unsigned int i = 0; i < count; i++)
 		semanage_iface_free(records[i]);
+	free(records);
 
 	delete_local_iface(I_FIRST);
 	delete_local_iface(I_SECOND);
diff --git a/libsemanage/tests/test_node.c b/libsemanage/tests/test_node.c
index 53c2eb69..d715e6a4 100644
--- a/libsemanage/tests/test_node.c
+++ b/libsemanage/tests/test_node.c
@@ -148,6 +148,8 @@ semanage_node_t *get_node_nth(int idx)
 		if (i != (unsigned int) idx)
 			semanage_node_free(records[i]);
 
+	free(records);
+
 	return node;
 }
 
@@ -167,6 +169,8 @@ semanage_node_key_t *get_node_key_nth(int idx)
 	CU_ASSERT_FATAL(res >= 0);
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
+	semanage_node_free(node);
+
 	return key;
 }
 
@@ -181,6 +185,10 @@ void add_local_node(int idx)
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
 	CU_ASSERT_FATAL(semanage_node_modify_local(sh, key, node) >= 0);
+
+	/* cleanup */
+	semanage_node_key_free(key);
+	semanage_node_free(node);
 }
 
 void delete_local_node(int idx)
@@ -190,6 +198,9 @@ void delete_local_node(int idx)
 	key = get_node_key_nth(idx);
 
 	CU_ASSERT_FATAL(semanage_node_del_local(sh, key) >= 0);
+
+	/* cleanup */
+	semanage_node_key_free(key);
 }
 
 /* Function semanage_node_compare */
@@ -305,6 +316,7 @@ void test_node_get_set_addr(void)
 	CU_ASSERT_STRING_EQUAL(addr, "192.168.0.1");
 
 	/* cleanup */
+	free(addr);
 	semanage_node_free(node);
 	cleanup_handle(SH_CONNECT);
 }
@@ -334,6 +346,7 @@ void test_node_get_set_addr_bytes(void)
 		CU_ASSERT(addr1[i] == addr2[i]);
 
 	/* cleanup */
+	free(addr2);
 	semanage_node_free(node);
 	cleanup_handle(SH_CONNECT);
 }
@@ -357,6 +370,7 @@ void test_node_get_set_mask(void)
 	CU_ASSERT_STRING_EQUAL(mask, "255.255.255.0");
 
 	/* cleanup */
+	free(mask);
 	semanage_node_free(node);
 	cleanup_handle(SH_CONNECT);
 }
@@ -386,6 +400,7 @@ void test_node_get_set_mask_bytes(void)
 		CU_ASSERT(mask1[i] == mask2[i]);
 
 	/* cleanup */
+	free(mask2);
 	semanage_node_free(node);
 	cleanup_handle(SH_CONNECT);
 }
@@ -436,6 +451,7 @@ void test_node_get_set_con(void)
 	CU_ASSERT_CONTEXT_EQUAL(con1, con2);
 
 	/* cleanup */
+	semanage_context_free(con1);
 	semanage_node_free(node);
 	cleanup_handle(SH_CONNECT);
 }
@@ -461,6 +477,7 @@ void test_node_create(void)
 	CU_ASSERT(semanage_node_set_con(sh, node, con) >= 0);
 
 	/* cleanup */
+	semanage_context_free(con);
 	semanage_node_free(node);
 	cleanup_handle(SH_CONNECT);
 }
@@ -508,6 +525,9 @@ void test_node_clone(void)
 	CU_ASSERT_CONTEXT_EQUAL(con, con2);
 
 	/* cleanup */
+	free(mask2);
+	free(addr2);
+	semanage_context_free(con);
 	semanage_node_free(node);
 	semanage_node_free(node_clone);
 	cleanup_handle(SH_CONNECT);
@@ -552,6 +572,8 @@ void test_node_query(void)
 	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
 
 	/* cleanup */
+	semanage_node_key_free(key);
+	semanage_node_free(node_exp);
 	semanage_node_free(node);
 	cleanup_handle(SH_CONNECT);
 }
@@ -638,6 +660,8 @@ void test_node_list(void)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_node_free(records[i]);
 
+	free(records);
+
 	/* cleanup */
 	cleanup_handle(SH_CONNECT);
 }
@@ -686,6 +710,9 @@ void test_node_modify_del_query_local(void)
 	CU_ASSERT(semanage_node_query_local(sh, key, &node_local) < 0);
 
 	/* cleanup */
+	semanage_node_key_free(key_tmp);
+	semanage_node_key_free(key);
+	semanage_node_free(node_local);
 	semanage_node_free(node);
 	semanage_node_free(node_tmp);
 	cleanup_handle(SH_TRANS);
@@ -800,6 +827,8 @@ void test_node_list_local(void)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_node_free(records[i]);
 
+	free(records);
+
 	delete_local_node(I_FIRST);
 	delete_local_node(I_SECOND);
 	delete_local_node(I_THIRD);
diff --git a/libsemanage/tests/test_other.c b/libsemanage/tests/test_other.c
index c4ee0ed8..0a57e247 100644
--- a/libsemanage/tests/test_other.c
+++ b/libsemanage/tests/test_other.c
@@ -81,6 +81,9 @@ void test_semanage_context(void)
 	assert(str);
 	CU_ASSERT_STRING_EQUAL(str, "user_u:role_r:type_t:s0");
 
+	semanage_context_free(con);
+	con = NULL;
+
 	CU_ASSERT(semanage_context_from_string(sh, "my_u:my_r:my_t:s0",
 					       &con) >= 0);
 	CU_ASSERT_STRING_EQUAL(semanage_context_get_user(con), "my_u");
@@ -95,6 +98,7 @@ void test_semanage_context(void)
 	CU_ASSERT_STRING_EQUAL(semanage_context_get_mls(con_clone), "s0");
 
 	/* cleanup */
+	free(str);
 	semanage_context_free(con);
 	semanage_context_free(con_clone);
 	cleanup_handle(SH_CONNECT);
@@ -115,6 +119,8 @@ void test_debug(void)
 	CU_ASSERT(semanage_module_info_set_priority(sh, modinfo, -42) < 0);
 
 	/* cleanup */
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
 	CU_ASSERT(semanage_disconnect(sh) >= 0);
 	semanage_handle_destroy(sh);
 }
diff --git a/libsemanage/tests/test_port.c b/libsemanage/tests/test_port.c
index 0408be4d..3b00bb73 100644
--- a/libsemanage/tests/test_port.c
+++ b/libsemanage/tests/test_port.c
@@ -146,6 +146,8 @@ semanage_port_t *get_port_nth(int idx)
 		if (i != (unsigned int) idx)
 			semanage_port_free(records[i]);
 
+	free(records);
+
 	return port;
 }
 
@@ -165,6 +167,9 @@ semanage_port_key_t *get_port_key_nth(int idx)
 	CU_ASSERT_FATAL(res >= 0);
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
+	/* cleanup */
+	semanage_port_free(port);
+
 	return key;
 }
 
@@ -181,6 +186,10 @@ void add_local_port(int port_idx)
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
 	CU_ASSERT_FATAL(semanage_port_modify_local(sh, key, port) >= 0);
+
+	/* cleanup */
+	semanage_port_key_free(key);
+	semanage_port_free(port);
 }
 
 void delete_local_port(int port_idx)
@@ -192,6 +201,8 @@ void delete_local_port(int port_idx)
 	key = get_port_key_nth(port_idx);
 
 	CU_ASSERT_FATAL(semanage_port_del_local(sh, key) >= 0);
+
+	semanage_port_key_free(key);
 }
 
 /* Function semanage_port_compare */
@@ -447,6 +458,7 @@ void test_port_clone(void)
 	CU_ASSERT_CONTEXT_EQUAL(con, con2);
 
 	/* cleanup */
+	semanage_context_free(con);
 	semanage_port_free(port);
 	semanage_port_free(port_clone);
 	cleanup_handle(SH_CONNECT);
@@ -480,6 +492,7 @@ void test_port_query(void)
 	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
 
 	/* cleanup */
+	semanage_port_key_free(key);
 	semanage_port_free(port);
 	semanage_port_free(port_exp);
 	cleanup_handle(SH_CONNECT);
@@ -567,6 +580,8 @@ void test_port_list(void)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_port_free(records[i]);
 
+	free(records);
+
 	cleanup_handle(SH_CONNECT);
 }
 
@@ -599,6 +614,9 @@ void test_port_modify_del_local(void)
 	CU_ASSERT(semanage_port_query_local(sh, key, &port_local) < 0);
 
 	/* cleanup */
+	semanage_context_free(con);
+	semanage_port_key_free(key);
+	semanage_port_free(port_local);
 	semanage_port_free(port);
 	cleanup_handle(SH_TRANS);
 }
@@ -633,6 +651,7 @@ void test_port_query_local(void)
 
 	/* cleanup */
 	delete_local_port(I_FIRST);
+	semanage_port_key_free(key);
 	semanage_port_free(port);
 	semanage_port_free(port_exp);
 	cleanup_handle(SH_TRANS);
@@ -747,6 +766,8 @@ void test_port_list_local(void)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_port_free(records[i]);
 
+	free(records);
+
 	delete_local_port(I_FIRST);
 	delete_local_port(I_SECOND);
 	delete_local_port(I_THIRD);
@@ -773,6 +794,7 @@ void helper_port_validate_local_noport(void)
 	helper_commit();
 
 	/* cleanup */
+	semanage_port_key_free(key);
 	helper_begin_transaction();
 	delete_local_port(I_FIRST);
 	cleanup_handle(SH_TRANS);
@@ -832,6 +854,8 @@ void helper_port_validate_local_twoports(void)
 	helper_begin_transaction();
 	CU_ASSERT(semanage_port_del_local(sh, key1) >= 0);
 	CU_ASSERT(semanage_port_del_local(sh, key2) >= 0);
+	semanage_context_free(con2);
+	semanage_context_free(con1);
 	semanage_port_key_free(key1);
 	semanage_port_key_free(key2);
 	semanage_port_free(port1);
diff --git a/libsemanage/tests/test_user.c b/libsemanage/tests/test_user.c
index cd082030..c30dca86 100644
--- a/libsemanage/tests/test_user.c
+++ b/libsemanage/tests/test_user.c
@@ -130,6 +130,8 @@ semanage_user_t *get_user_nth(int idx)
 		if (i != (unsigned int) idx)
 			semanage_user_free(records[i]);
 
+	free(records);
+
 	return user;
 }
 
@@ -149,6 +151,8 @@ semanage_user_key_t *get_user_key_nth(int idx)
 	CU_ASSERT_FATAL(res >= 0);
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
+	semanage_user_free(user);
+
 	return key;
 }
 
@@ -165,6 +169,9 @@ void add_local_user(int user_idx)
 	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
 
 	CU_ASSERT_FATAL(semanage_user_modify_local(sh, key, user) >= 0);
+
+	semanage_user_key_free(key);
+	semanage_user_free(user);
 }
 
 void delete_local_user(int user_idx)
@@ -176,6 +183,8 @@ void delete_local_user(int user_idx)
 	key = get_user_key_nth(user_idx);
 
 	CU_ASSERT_FATAL(semanage_user_del_local(sh, key) >= 0);
+
+	semanage_user_key_free(key);
 }
 
 /* Function semanage_user_compare */
@@ -391,6 +400,7 @@ void test_user_roles(void)
 	CU_ASSERT(semanage_user_get_num_roles(user) == 0);
 
 	/* cleanup */
+	free(roles_arr);
 	semanage_user_free(user);
 	cleanup_handle(SH_CONNECT);
 }
@@ -459,6 +469,7 @@ void test_user_query(void)
 	CU_ASSERT_PTR_NOT_NULL(user);
 
 	/* cleanup */
+	semanage_user_key_free(key);
 	semanage_user_free(user);
 	cleanup_handle(SH_CONNECT);
 }
@@ -546,6 +557,8 @@ void test_user_list(void)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_user_free(records[i]);
 
+	free(records);
+
 	cleanup_handle(SH_CONNECT);
 }
 
@@ -577,6 +590,8 @@ void test_user_modify_del_query_local(void)
 	CU_ASSERT(semanage_user_query_local(sh, key, &user_local) < 0);
 
 	/* cleanup */
+	semanage_user_key_free(key);
+	semanage_user_free(user_local);
 	semanage_user_free(user);
 	cleanup_handle(SH_TRANS);
 }
@@ -683,6 +698,8 @@ void test_user_list_local(void)
 	for (unsigned int i = 0; i < count; i++)
 		semanage_user_free(records[i]);
 
+	free(records);
+
 	delete_local_user(I_FIRST);
 	delete_local_user(I_SECOND);
 	delete_local_user(I_THIRD);
diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilities.c
index 18393215..b28ae155 100644
--- a/libsemanage/tests/utilities.c
+++ b/libsemanage/tests/utilities.c
@@ -99,6 +99,7 @@ int write_test_policy_from_file(const char *filename) {
 	char *buf = NULL;
 	size_t len = 0;
 	FILE *fptr = fopen(filename, "rb");
+	int rc;
 
 	if (!fptr) {
 		perror("fopen");
@@ -120,7 +121,9 @@ int write_test_policy_from_file(const char *filename) {
 	fread(buf, len, 1, fptr);
 	fclose(fptr);
 
-	return write_test_policy(buf, len);
+	rc = write_test_policy(buf, len);
+	free(buf);
+	return rc;
 }
 
 int write_test_policy_src(unsigned char *data, unsigned int data_len) {
diff --git a/libsemanage/tests/utilities.h b/libsemanage/tests/utilities.h
index db4dabf9..298b3280 100644
--- a/libsemanage/tests/utilities.h
+++ b/libsemanage/tests/utilities.h
@@ -39,6 +39,8 @@
 		CU_ASSERT(semanage_context_to_string(sh, CON1, &__str) >= 0); \
 		CU_ASSERT(semanage_context_to_string(sh, CON2, &__str2) >= 0); \
 		CU_ASSERT_STRING_EQUAL(__str, __str2); \
+		free(__str2); \
+		free(__str); \
 	} while (0)
 
 
-- 
2.33.0

