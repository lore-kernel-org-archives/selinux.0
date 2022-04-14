Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C079FC3527D
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiDNOnB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347715AbiDNN7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 09:59:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7438BC85A
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:52:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r25so3542920qtp.8
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1h23yMQkxYInpbFlGLKeyrB7Ejsz3O7PMkoww12M3Lg=;
        b=M1hwsUBVXaQeF61veQFyqaQF/HTx7C0giqiNWaNv0BwD+iwuHRBJKRUrJJvrEo96FC
         c+a477dGPv13o2G9O05g7TwjreslAdQVEnRswmDz8ejUSfkFPCYbLulSnv/an/hD0iu0
         a5OOTp7J500EPPaudfRVkEdfOSBBri+U/xjQ/ohOxpfItbK1R9+cixMufSkkXi1IjMfj
         vv1ylGu3kpZVx3OV936+qKE6lB7c7t3dKT+/4gjAy2x8iKArl4iaPv/OTmqd8C/3+4bx
         u6LNCvexd+87EKmqUD/7TFlfVCrtvY2etQd9/XRWgitGammaqMsoFOEANFis2aTpM8hE
         WTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1h23yMQkxYInpbFlGLKeyrB7Ejsz3O7PMkoww12M3Lg=;
        b=TUjpwDIgosbqzJ0QsSA7S6e6LWeDjYS0rlwhmfYirr7ck2O95clupzVEz6PM5OcSpG
         UA99oaV6acDRpyjA4bg69nnSXH8F8kSIVtgTXcQ6B0Tjk1z8jDs2Y88VXR7ZJfKYVPwf
         fZ6KfnyF9z+j0hvXMiAeRdYGSHC7JfRyPjBMVn4WrQ8kK9fFHajdzzcjBv1EZ93itFQ9
         ezCmbrP8xUW5JlS5qZ+/dDoUL82KAIGTTdd2nIq2N5xWeQvtwztJ5N5k81ZMt6p2Hcyr
         thJD5+WqQwvcTCTzZgdge/ntI99+cRn5YHZDBA2oaI1v4z3suUnAIJ7XEzE68Ydu/3hB
         nSlg==
X-Gm-Message-State: AOAM532Hb5c5IxaO/Gj1fV4pxGBuSNClE3KbeYWnIH2j83Py5QQZLNfU
        eM94DnClT+jcdBArGyz4k4f69iuBgCA=
X-Google-Smtp-Source: ABdhPJwRG9IwPMdIS7plSitxlJ3qHWP+1Aa7cLOjMUticZiy7f0uLgn0X/aTOIz/kMh7BFgWENS+gQ==
X-Received: by 2002:a05:622a:c4:b0:2e1:cb5b:9b5c with SMTP id p4-20020a05622a00c400b002e1cb5b9b5cmr1845307qtw.69.1649944322949;
        Thu, 14 Apr 2022 06:52:02 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id 14-20020a37090e000000b0069bfe98662csm999748qkj.17.2022.04.14.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:52:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5] libsemanage/tests: Declare file local functions as static
Date:   Thu, 14 Apr 2022 09:51:40 -0400
Message-Id: <20220414135141.1723610-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414135141.1723610-1-jwcart2@gmail.com>
References: <20220414135141.1723610-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is needed to use "-Wmissing-prototypes".

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsemanage/tests/test_bool.c      | 118 +++++++++++++--------------
 libsemanage/tests/test_fcontext.c  | 126 ++++++++++++++---------------
 libsemanage/tests/test_handle.c    |  54 ++++++-------
 libsemanage/tests/test_ibendport.c |  60 +++++++-------
 libsemanage/tests/test_iface.c     |  88 ++++++++++----------
 libsemanage/tests/test_node.c      | 104 ++++++++++++------------
 libsemanage/tests/test_port.c      | 114 +++++++++++++-------------
 libsemanage/tests/test_user.c      |  96 +++++++++++-----------
 libsemanage/tests/test_utilities.c |  41 +++++-----
 libsemanage/tests/utilities.c      |   2 +-
 10 files changed, 402 insertions(+), 401 deletions(-)

diff --git a/libsemanage/tests/test_bool.c b/libsemanage/tests/test_bool.c
index 7bf5225b..672544bb 100644
--- a/libsemanage/tests/test_bool.c
+++ b/libsemanage/tests/test_bool.c
@@ -31,29 +31,29 @@
 #define BOOL_NONEXISTENT "asdf"
 
 /* boolean_record.h */
-void test_bool_key_create(void);
-void test_bool_key_extract(void);
-void test_bool_compare(void);
-void test_bool_compare2(void);
-void test_bool_get_set_name(void);
-void test_bool_get_set_value(void);
-void test_bool_create(void);
-void test_bool_clone(void);
+static void test_bool_key_create(void);
+static void test_bool_key_extract(void);
+static void test_bool_compare(void);
+static void test_bool_compare2(void);
+static void test_bool_get_set_name(void);
+static void test_bool_get_set_value(void);
+static void test_bool_create(void);
+static void test_bool_clone(void);
 
 /* booleans_policy.h */
-void test_bool_query(void);
-void test_bool_exists(void);
-void test_bool_count(void);
-void test_bool_iterate(void);
-void test_bool_list(void);
+static void test_bool_query(void);
+static void test_bool_exists(void);
+static void test_bool_count(void);
+static void test_bool_iterate(void);
+static void test_bool_list(void);
 
 /* booleans_local.h */
-void test_bool_modify_del_local(void);
-void test_bool_query_local(void);
-void test_bool_exists_local(void);
-void test_bool_count_local(void);
-void test_bool_iterate_local(void);
-void test_bool_list_local(void);
+static void test_bool_modify_del_local(void);
+static void test_bool_query_local(void);
+static void test_bool_exists_local(void);
+static void test_bool_count_local(void);
+static void test_bool_iterate_local(void);
+static void test_bool_list_local(void);
 
 extern semanage_handle_t *sh;
 
@@ -111,7 +111,7 @@ int bool_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-semanage_bool_t *get_bool_nth(int idx)
+static semanage_bool_t *get_bool_nth(int idx)
 {
 	int res;
 	semanage_bool_t **records;
@@ -137,7 +137,7 @@ semanage_bool_t *get_bool_nth(int idx)
 	return boolean;
 }
 
-semanage_bool_t *get_bool_new(void)
+static semanage_bool_t *get_bool_new(void)
 {
 	int res;
 	semanage_bool_t *boolean;
@@ -149,7 +149,7 @@ semanage_bool_t *get_bool_new(void)
 	return boolean;
 }
 
-semanage_bool_key_t *get_bool_key_nth(int idx)
+static semanage_bool_key_t *get_bool_key_nth(int idx)
 {
 	semanage_bool_key_t *key;
 	semanage_bool_t *boolean;
@@ -170,7 +170,7 @@ semanage_bool_key_t *get_bool_key_nth(int idx)
 	return key;
 }
 
-semanage_bool_key_t *get_bool_key_from_str(const char *str)
+static semanage_bool_key_t *get_bool_key_from_str(const char *str)
 {
 	semanage_bool_key_t *key;
 	int res;
@@ -186,7 +186,7 @@ semanage_bool_key_t *get_bool_key_from_str(const char *str)
 	return key;
 }
 
-void add_local_bool(const char *name)
+static void add_local_bool(const char *name)
 {
 	semanage_bool_t *boolean;
 	semanage_bool_key_t *key = NULL;
@@ -205,7 +205,7 @@ void add_local_bool(const char *name)
 	semanage_bool_free(boolean);
 }
 
-void delete_local_bool(const char *name)
+static void delete_local_bool(const char *name)
 {
 	semanage_bool_key_t *key = NULL;
 
@@ -221,7 +221,7 @@ void delete_local_bool(const char *name)
 
 /* Function bool_key_create */
 
-void helper_bool_key_create(level_t level)
+static void helper_bool_key_create(level_t level)
 {
 	semanage_bool_key_t *key = NULL;
 
@@ -253,7 +253,7 @@ void test_bool_key_create(void)
 #define SK_NEW 2
 #define SK_INDEX 3
 #define SK_KEY_NULL 4
-void helper_bool_key_extract(level_t level, int mode)
+static void helper_bool_key_extract(level_t level, int mode)
 {
 	semanage_bool_t *boolean = NULL;
 	semanage_bool_key_t *key = NULL;
@@ -306,7 +306,7 @@ void test_bool_key_extract(void)
 #undef SK_KEY_NULL
 
 /* Function bool_compare */
-void helper_bool_compare(level_t level, int bool_idx1, int bool_idx2)
+static void helper_bool_compare(level_t level, int bool_idx1, int bool_idx2)
 {
 	semanage_bool_t *boolean;
 	semanage_bool_key_t *key;
@@ -330,7 +330,7 @@ void helper_bool_compare(level_t level, int bool_idx1, int bool_idx2)
 	cleanup_handle(level);
 }
 
-void test_bool_compare(void)
+static void test_bool_compare(void)
 {
 	helper_bool_compare(SH_CONNECT, I_FIRST,  I_FIRST);
 	helper_bool_compare(SH_CONNECT, I_FIRST,  I_SECOND);
@@ -344,7 +344,7 @@ void test_bool_compare(void)
 }
 
 /* Function bool_compare2 */
-void helper_bool_compare2(level_t level, int bool_idx1, int bool_idx2)
+static void helper_bool_compare2(level_t level, int bool_idx1, int bool_idx2)
 {
 	semanage_bool_t *bool1;
 	semanage_bool_t *bool2;
@@ -368,7 +368,7 @@ void helper_bool_compare2(level_t level, int bool_idx1, int bool_idx2)
 	cleanup_handle(level);
 }
 
-void test_bool_compare2(void)
+static void test_bool_compare2(void)
 {
 	helper_bool_compare2(SH_CONNECT, I_FIRST,  I_FIRST);
 	helper_bool_compare2(SH_CONNECT, I_FIRST,  I_SECOND);
@@ -382,7 +382,7 @@ void test_bool_compare2(void)
 }
 
 /* Function bool_get_name, bool_set_name */
-void helper_bool_get_set_name(level_t level, int bool_idx, const char *name)
+static void helper_bool_get_set_name(level_t level, int bool_idx, const char *name)
 {
 	semanage_bool_t *boolean;
 	const char *new_name = NULL;
@@ -404,7 +404,7 @@ void helper_bool_get_set_name(level_t level, int bool_idx, const char *name)
 	cleanup_handle(level);
 }
 
-void test_bool_get_set_name(void)
+static void test_bool_get_set_name(void)
 {
 	helper_bool_get_set_name(SH_CONNECT, I_FIRST, "testbool");
 	helper_bool_get_set_name(SH_CONNECT, I_FIRST, "");
@@ -418,7 +418,7 @@ void test_bool_get_set_name(void)
 }
 
 /* Function bool_get_value, bool_set_value */
-void helper_bool_get_set_value(int bool_idx, int val)
+static void helper_bool_get_set_value(int bool_idx, int val)
 {
 	semanage_bool_t *boolean;
 	int new_val = 0;
@@ -436,7 +436,7 @@ void helper_bool_get_set_value(int bool_idx, int val)
 	semanage_bool_free(boolean);
 }
 
-void test_bool_get_set_value(void)
+static void test_bool_get_set_value(void)
 {
 	helper_bool_get_set_value(I_FIRST, 1);
 	helper_bool_get_set_value(I_FIRST, 0);
@@ -445,7 +445,7 @@ void test_bool_get_set_value(void)
 }
 
 /* Function bool_create */
-void helper_bool_create(level_t level)
+static void helper_bool_create(level_t level)
 {
 	semanage_bool_t *boolean;
 
@@ -461,7 +461,7 @@ void helper_bool_create(level_t level)
 	cleanup_handle(level);
 }
 
-void test_bool_create(void)
+static void test_bool_create(void)
 {
 	helper_bool_create(SH_HANDLE);
 	helper_bool_create(SH_CONNECT);
@@ -469,7 +469,7 @@ void test_bool_create(void)
 }
 
 /* Function bool_clone */
-void helper_bool_clone(level_t level, int bool_idx)
+static void helper_bool_clone(level_t level, int bool_idx)
 {
 	semanage_bool_t *boolean;
 	semanage_bool_t *boolean_clone;
@@ -500,7 +500,7 @@ void helper_bool_clone(level_t level, int bool_idx)
 	cleanup_handle(level);
 }
 
-void test_bool_clone(void)
+static void test_bool_clone(void)
 {
 	helper_bool_clone(SH_CONNECT, I_FIRST);
 	helper_bool_clone(SH_CONNECT, I_SECOND);
@@ -510,7 +510,7 @@ void test_bool_clone(void)
 }
 
 /* Function bool_query */
-void helper_bool_query(level_t level, const char *bool_str, int exp_res)
+static void helper_bool_query(level_t level, const char *bool_str, int exp_res)
 {
 	semanage_bool_key_t *key;
 	semanage_bool_t *resp = (void *) 42;
@@ -534,7 +534,7 @@ void helper_bool_query(level_t level, const char *bool_str, int exp_res)
 	cleanup_handle(level);
 }
 
-void test_bool_query(void)
+static void test_bool_query(void)
 {
 	helper_bool_query(SH_CONNECT, BOOL1_NAME,  1);
 	helper_bool_query(SH_CONNECT, BOOL2_NAME, 1);
@@ -546,7 +546,7 @@ void test_bool_query(void)
 }
 
 /* Function bool_exists */
-void helper_bool_exists(level_t level, const char *bool_str, int exp_resp)
+static void helper_bool_exists(level_t level, const char *bool_str, int exp_resp)
 {
 	semanage_bool_key_t *key;
 	int resp;
@@ -563,7 +563,7 @@ void helper_bool_exists(level_t level, const char *bool_str, int exp_resp)
 	cleanup_handle(level);
 }
 
-void test_bool_exists(void)
+static void test_bool_exists(void)
 {
 	helper_bool_exists(SH_CONNECT, BOOL1_NAME,  1);
 	helper_bool_exists(SH_CONNECT, BOOL2_NAME, 1);
@@ -575,7 +575,7 @@ void test_bool_exists(void)
 }
 
 /* Function bool_count */
-void test_bool_count(void)
+static void test_bool_count(void)
 {
 	unsigned int resp;
 
@@ -603,13 +603,13 @@ void test_bool_count(void)
 /* Function bool_iterate */
 unsigned int counter_bool_iterate = 0;
 
-int handler_bool_iterate(const semanage_bool_t *record, void *varg)
+static int handler_bool_iterate(const semanage_bool_t *record, void *varg)
 {
 	counter_bool_iterate++;
 	return 0;
 }
 
-void helper_bool_iterate_invalid(void)
+static void helper_bool_iterate_invalid(void)
 {
 	setup_handle(SH_HANDLE);
 	CU_ASSERT(semanage_bool_iterate(sh, &handler_bool_iterate, NULL) < 0);
@@ -617,7 +617,7 @@ void helper_bool_iterate_invalid(void)
 	cleanup_handle(SH_HANDLE);
 }
 
-void helper_bool_iterate(level_t level)
+static void helper_bool_iterate(level_t level)
 {
 	setup_handle(level);
 	counter_bool_iterate = 0;
@@ -626,7 +626,7 @@ void helper_bool_iterate(level_t level)
 	cleanup_handle(level);
 }
 
-void test_bool_iterate(void)
+static void test_bool_iterate(void)
 {
 	helper_bool_iterate_invalid();
 	helper_bool_iterate(SH_CONNECT);
@@ -634,7 +634,7 @@ void test_bool_iterate(void)
 }
 
 /* Function bool_list */
-void helper_bool_list_invalid(void)
+static void helper_bool_list_invalid(void)
 {
 	semanage_bool_t **records;
 	unsigned int count;
@@ -648,7 +648,7 @@ void helper_bool_list_invalid(void)
 	cleanup_handle(SH_HANDLE);
 }
 
-void helper_bool_list(level_t level)
+static void helper_bool_list(level_t level)
 {
 	semanage_bool_t **records;
 	unsigned int count;
@@ -669,7 +669,7 @@ void helper_bool_list(level_t level)
 	cleanup_handle(level);
 }
 
-void test_bool_list(void)
+static void test_bool_list(void)
 {
 	helper_bool_list_invalid();
 	helper_bool_list(SH_CONNECT);
@@ -677,7 +677,7 @@ void test_bool_list(void)
 }
 
 /* Function bool_modify_local, bool_del_local */
-void helper_bool_modify_del_local(level_t level, const char *name,
+static void helper_bool_modify_del_local(level_t level, const char *name,
 				  int old_val, int exp_res)
 {
 	semanage_bool_t *boolean;
@@ -729,7 +729,7 @@ void helper_bool_modify_del_local(level_t level, const char *name,
 	cleanup_handle(level);
 }
 
-void test_bool_modify_del_local(void)
+static void test_bool_modify_del_local(void)
 {
 	helper_bool_modify_del_local(SH_CONNECT, BOOL1_NAME, BOOL1_VALUE, -1);
 	helper_bool_modify_del_local(SH_CONNECT, BOOL2_NAME, BOOL2_VALUE, -1);
@@ -738,7 +738,7 @@ void test_bool_modify_del_local(void)
 }
 
 /* Function bool_query_local */
-void test_bool_query_local(void)
+static void test_bool_query_local(void)
 {
 	semanage_bool_key_t *key = NULL;
 	semanage_bool_t *resp = NULL;
@@ -785,7 +785,7 @@ void test_bool_query_local(void)
 }
 
 /* Function bool_exists_local */
-void test_bool_exists_local(void)
+static void test_bool_exists_local(void)
 {
 	int resp = -1;
 	semanage_bool_key_t *key;
@@ -815,7 +815,7 @@ void test_bool_exists_local(void)
 }
 
 /* Function bool_count_local */
-void test_bool_count_local(void)
+static void test_bool_count_local(void)
 {
 	unsigned int resp;
 	unsigned int init_count;
@@ -859,13 +859,13 @@ void test_bool_count_local(void)
 /* Function bool_iterate_local */
 unsigned int counter_bool_iterate_local = 0;
 
-int handler_bool_iterate_local(const semanage_bool_t *record, void *varg)
+static int handler_bool_iterate_local(const semanage_bool_t *record, void *varg)
 {
 	counter_bool_iterate_local++;
 	return 0;
 }
 
-void test_bool_iterate_local(void)
+static void test_bool_iterate_local(void)
 {
 	unsigned int init_count;
 
@@ -912,7 +912,7 @@ void test_bool_iterate_local(void)
 }
 
 /* Function bool_list_local */
-void test_bool_list_local(void)
+static void test_bool_list_local(void)
 {
 	semanage_bool_t **records;
 	unsigned int count;
diff --git a/libsemanage/tests/test_fcontext.c b/libsemanage/tests/test_fcontext.c
index a5fcf849..5104989e 100644
--- a/libsemanage/tests/test_fcontext.c
+++ b/libsemanage/tests/test_fcontext.c
@@ -45,35 +45,35 @@ unsigned int FCONTEXTS_LEN = sizeof(FCONTEXTS);
 #define FCONTEXT_NONEXISTENT_TYPE SEMANAGE_FCONTEXT_ALL
 
 /* fcontext_record.h */
-void test_fcontext_compare(void);
-void test_fcontext_compare2(void);
-void test_fcontext_key_create(void);
-void test_fcontext_key_extract(void);
-void test_fcontext_get_set_expr(void);
-void test_fcontext_get_set_type(void);
-void test_fcontext_get_type_str(void);
-void test_fcontext_get_set_con(void);
-void test_fcontext_create(void);
-void test_fcontext_clone(void);
+static void test_fcontext_compare(void);
+static void test_fcontext_compare2(void);
+static void test_fcontext_key_create(void);
+static void test_fcontext_key_extract(void);
+static void test_fcontext_get_set_expr(void);
+static void test_fcontext_get_set_type(void);
+static void test_fcontext_get_type_str(void);
+static void test_fcontext_get_set_con(void);
+static void test_fcontext_create(void);
+static void test_fcontext_clone(void);
 
 /* fcontext_policy.h */
-void test_fcontext_query(void);
-void test_fcontext_exists(void);
-void test_fcontext_count(void);
-void test_fcontext_iterate(void);
-void test_fcontext_list(void);
+static void test_fcontext_query(void);
+static void test_fcontext_exists(void);
+static void test_fcontext_count(void);
+static void test_fcontext_iterate(void);
+static void test_fcontext_list(void);
 
 /* fcontext_local.h */
-void test_fcontext_modify_del_local(void);
-void test_fcontext_query_local(void);
-void test_fcontext_exists_local(void);
-void test_fcontext_count_local(void);
-void test_fcontext_iterate_local(void);
-void test_fcontext_list_local(void);
+static void test_fcontext_modify_del_local(void);
+static void test_fcontext_query_local(void);
+static void test_fcontext_exists_local(void);
+static void test_fcontext_count_local(void);
+static void test_fcontext_iterate_local(void);
+static void test_fcontext_list_local(void);
 
 extern semanage_handle_t *sh;
 
-int get_type(char *t)
+static int get_type(char *t)
 {
 	if (strcmp(t, "--") == 0)
 		return SEMANAGE_FCONTEXT_ALL;
@@ -95,7 +95,7 @@ int get_type(char *t)
 		return -1;
 }
 
-int write_file_contexts(const char *data, unsigned int data_len)
+static int write_file_contexts(const char *data, unsigned int data_len)
 {
 	FILE *fptr = fopen("test-policy/store/active/file_contexts", "w+");
 
@@ -187,7 +187,7 @@ int fcontext_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-semanage_fcontext_t *get_fcontext_new(void)
+static semanage_fcontext_t *get_fcontext_new(void)
 {
 	semanage_fcontext_t *fcontext;
 
@@ -196,7 +196,7 @@ semanage_fcontext_t *get_fcontext_new(void)
 	return fcontext;
 }
 
-semanage_fcontext_t *get_fcontext_nth(int idx)
+static semanage_fcontext_t *get_fcontext_nth(int idx)
 {
 	semanage_fcontext_t **records;
 	semanage_fcontext_t *fcontext;
@@ -219,7 +219,7 @@ semanage_fcontext_t *get_fcontext_nth(int idx)
 	return fcontext;
 }
 
-semanage_fcontext_key_t *get_fcontext_key_nth(int idx)
+static semanage_fcontext_key_t *get_fcontext_key_nth(int idx)
 {
 	semanage_fcontext_key_t *key;
 	semanage_fcontext_t *fcontext;
@@ -237,7 +237,7 @@ semanage_fcontext_key_t *get_fcontext_key_nth(int idx)
 	return key;
 }
 
-void add_local_fcontext(int fcontext_idx)
+static void add_local_fcontext(int fcontext_idx)
 {
 	semanage_fcontext_t *fcontext;
 	semanage_fcontext_key_t *key = NULL;
@@ -256,7 +256,7 @@ void add_local_fcontext(int fcontext_idx)
 	semanage_fcontext_free(fcontext);
 }
 
-void delete_local_fcontext(int fcontext_idx)
+static void delete_local_fcontext(int fcontext_idx)
 {
 	semanage_fcontext_key_t *key = NULL;
 
@@ -269,7 +269,7 @@ void delete_local_fcontext(int fcontext_idx)
 	semanage_fcontext_key_free(key);
 }
 
-semanage_fcontext_key_t *get_fcontext_key_from_str(const char *str, int type)
+static semanage_fcontext_key_t *get_fcontext_key_from_str(const char *str, int type)
 {
 	semanage_fcontext_key_t *key;
 	int res;
@@ -286,7 +286,7 @@ semanage_fcontext_key_t *get_fcontext_key_from_str(const char *str, int type)
 }
 
 /* Function semanage_fcontext_compare */
-void test_fcontext_compare(void)
+static void test_fcontext_compare(void)
 {
 	semanage_fcontext_t *fcontext;
 	semanage_fcontext_key_t *key1;
@@ -316,7 +316,7 @@ void test_fcontext_compare(void)
 }
 
 /* Function semanage_fcontext_compare2 */
-void test_fcontext_compare2(void)
+static void test_fcontext_compare2(void)
 {
 	semanage_fcontext_t *fcontext;
 	semanage_fcontext_t *fcontext1;
@@ -345,7 +345,7 @@ void test_fcontext_compare2(void)
 }
 
 /* Function semanage_fcontext_key_create */
-void test_fcontext_key_create(void)
+static void test_fcontext_key_create(void)
 {
 	semanage_fcontext_key_t *key = NULL;
 
@@ -372,7 +372,7 @@ void test_fcontext_key_create(void)
 }
 
 /* Function semanage_fcontext_key_extract */
-void test_fcontext_key_extract(void)
+static void test_fcontext_key_extract(void)
 {
 	semanage_fcontext_t *fcontext;
 	semanage_fcontext_key_t *key;
@@ -392,7 +392,7 @@ void test_fcontext_key_extract(void)
 }
 
 /* Function semanage_fcontext_get_expr, semanage_fcontext_set_expr */
-void test_fcontext_get_set_expr(void)
+static void test_fcontext_get_set_expr(void)
 {
 	semanage_fcontext_t *fcontext;
 	const char *expr = NULL;
@@ -415,7 +415,7 @@ void test_fcontext_get_set_expr(void)
 }
 
 /* Function semanage_fcontext_get_type, semanage_fcontext_set_type */
-void test_fcontext_get_set_type(void)
+static void test_fcontext_get_set_type(void)
 {
 	semanage_fcontext_t *fcontext;
 	int type_exp = SEMANAGE_FCONTEXT_SOCK;
@@ -436,12 +436,12 @@ void test_fcontext_get_set_type(void)
 }
 
 /* Function semanage_fcontext_get_type_str */
-void helper_fcontext_get_type_str(int type, const char *exp_str)
+static void helper_fcontext_get_type_str(int type, const char *exp_str)
 {
 	CU_ASSERT_STRING_EQUAL(semanage_fcontext_get_type_str(type), exp_str);
 }
 
-void test_fcontext_get_type_str(void)
+static void test_fcontext_get_type_str(void)
 {
 	helper_fcontext_get_type_str(SEMANAGE_FCONTEXT_ALL, "all files");
 	helper_fcontext_get_type_str(SEMANAGE_FCONTEXT_REG, "regular file");
@@ -458,7 +458,7 @@ void test_fcontext_get_type_str(void)
 }
 
 /* Function semanage_fcontext_get_con, semanage_fcontext_set_con */
-void helper_fcontext_get_set_con(level_t level, int fcontext_idx,
+static void helper_fcontext_get_set_con(level_t level, int fcontext_idx,
 				 const char *con_str)
 {
 	semanage_fcontext_t *fcontext;
@@ -492,7 +492,7 @@ void helper_fcontext_get_set_con(level_t level, int fcontext_idx,
 	cleanup_handle(level);
 }
 
-void test_fcontext_get_set_con(void)
+static void test_fcontext_get_set_con(void)
 {
 	helper_fcontext_get_set_con(SH_CONNECT, I_FIRST, NULL);
 	helper_fcontext_get_set_con(SH_CONNECT, I_FIRST,
@@ -507,7 +507,7 @@ void test_fcontext_get_set_con(void)
 }
 
 /* Function semanage_fcontext_create */
-void helper_fcontext_create(level_t level)
+static void helper_fcontext_create(level_t level)
 {
 	semanage_fcontext_t *fcontext;
 
@@ -526,7 +526,7 @@ void helper_fcontext_create(level_t level)
 	cleanup_handle(level);
 }
 
-void test_fcontext_create(void)
+static void test_fcontext_create(void)
 {
 	helper_fcontext_create(SH_NULL);
 	helper_fcontext_create(SH_HANDLE);
@@ -535,7 +535,7 @@ void test_fcontext_create(void)
 }
 
 /* Function semanage_fcontext_clone */
-void helper_fcontext_clone(level_t level, int fcontext_idx)
+static void helper_fcontext_clone(level_t level, int fcontext_idx)
 {
 	semanage_fcontext_t *fcontext;
 	semanage_fcontext_t *fcontext_clone;
@@ -571,7 +571,7 @@ void helper_fcontext_clone(level_t level, int fcontext_idx)
 	cleanup_handle(level);
 }
 
-void test_fcontext_clone(void)
+static void test_fcontext_clone(void)
 {
 	helper_fcontext_clone(SH_CONNECT, I_FIRST);
 	helper_fcontext_clone(SH_CONNECT, I_SECOND);
@@ -580,7 +580,7 @@ void test_fcontext_clone(void)
 }
 
 /* Function semanage_fcontext_query */
-void helper_fcontext_query(level_t level, const char *fcontext_expr,
+static void helper_fcontext_query(level_t level, const char *fcontext_expr,
 			   int fcontext_type, int exp_res)
 {
 	semanage_fcontext_key_t *key;
@@ -609,7 +609,7 @@ void helper_fcontext_query(level_t level, const char *fcontext_expr,
 	cleanup_handle(level);
 }
 
-void test_fcontext_query(void)
+static void test_fcontext_query(void)
 {
 	helper_fcontext_query(SH_CONNECT, FCONTEXT_NONEXISTENT_EXPR,
 			      FCONTEXT_NONEXISTENT_TYPE, -1);
@@ -624,7 +624,7 @@ void test_fcontext_query(void)
 }
 
 /* Function semanage_fcontext_exists */
-void helper_fcontext_exists(level_t level, const char *fcontext_expr,
+static void helper_fcontext_exists(level_t level, const char *fcontext_expr,
 			    int fcontext_type, int exp_resp)
 {
 	semanage_fcontext_key_t *key;
@@ -643,7 +643,7 @@ void helper_fcontext_exists(level_t level, const char *fcontext_expr,
 	cleanup_handle(level);
 }
 
-void test_fcontext_exists(void)
+static void test_fcontext_exists(void)
 {
 	helper_fcontext_exists(SH_CONNECT, FCONTEXT_NONEXISTENT_EXPR,
 			       FCONTEXT_NONEXISTENT_TYPE, 0);
@@ -658,7 +658,7 @@ void test_fcontext_exists(void)
 }
 
 /* Function semanage_fcontext_count */
-void test_fcontext_count(void)
+static void test_fcontext_count(void)
 {
 	unsigned int resp;
 
@@ -686,14 +686,14 @@ void test_fcontext_count(void)
 /* Function semanage_fcontext_iterate */
 unsigned int counter_fcontext_iterate = 0;
 
-int handler_fcontext_iterate(const semanage_fcontext_t *record, void *varg)
+static int handler_fcontext_iterate(const semanage_fcontext_t *record, void *varg)
 {
 	CU_ASSERT_PTR_NOT_NULL(record);
 	counter_fcontext_iterate++;
 	return 0;
 }
 
-void helper_fcontext_iterate_invalid(void)
+static void helper_fcontext_iterate_invalid(void)
 {
 	/* setup */
 	setup_handle(SH_HANDLE);
@@ -707,7 +707,7 @@ void helper_fcontext_iterate_invalid(void)
 	cleanup_handle(SH_HANDLE);
 }
 
-void helper_fcontext_iterate(level_t level)
+static void helper_fcontext_iterate(level_t level)
 {
 	/* setup */
 	setup_handle(level);
@@ -722,7 +722,7 @@ void helper_fcontext_iterate(level_t level)
 	cleanup_handle(level);
 }
 
-void test_fcontext_iterate(void)
+static void test_fcontext_iterate(void)
 {
 	helper_fcontext_iterate_invalid();
 	helper_fcontext_iterate(SH_CONNECT);
@@ -730,7 +730,7 @@ void test_fcontext_iterate(void)
 }
 
 /* Function semanage_fcontext_list */
-void helper_fcontext_list_invalid(void)
+static void helper_fcontext_list_invalid(void)
 {
 	semanage_fcontext_t **records;
 	unsigned int count;
@@ -747,7 +747,7 @@ void helper_fcontext_list_invalid(void)
 	cleanup_handle(SH_HANDLE);
 }
 
-void helper_fcontext_list(level_t level)
+static void helper_fcontext_list(level_t level)
 {
 	semanage_fcontext_t **records;
 	unsigned int count;
@@ -771,7 +771,7 @@ void helper_fcontext_list(level_t level)
 	cleanup_handle(level);
 }
 
-void test_fcontext_list(void)
+static void test_fcontext_list(void)
 {
 	helper_fcontext_list_invalid();
 	helper_fcontext_list(SH_CONNECT);
@@ -779,7 +779,7 @@ void test_fcontext_list(void)
 }
 
 /* Function semanage_fcontext_modify_local, semanage_fcontext_del_local */
-void helper_fcontext_modify_del_local(level_t level, int fcontext_idx,
+static void helper_fcontext_modify_del_local(level_t level, int fcontext_idx,
 				      const char *con_str, int exp_res)
 {
 	semanage_fcontext_t *fcontext;
@@ -834,7 +834,7 @@ void helper_fcontext_modify_del_local(level_t level, int fcontext_idx,
 	cleanup_handle(level);
 }
 
-void test_fcontext_modify_del_local(void)
+static void test_fcontext_modify_del_local(void)
 {
 	helper_fcontext_modify_del_local(SH_CONNECT, I_FIRST,
 					 "system_u:object_r:tmp_t:s0", -1);
@@ -847,7 +847,7 @@ void test_fcontext_modify_del_local(void)
 }
 
 /* Function semanage_fcontext_query_local */
-void test_fcontext_query_local(void)
+static void test_fcontext_query_local(void)
 {
 	semanage_fcontext_key_t *key = NULL;
 	semanage_fcontext_t *resp = NULL;
@@ -891,7 +891,7 @@ void test_fcontext_query_local(void)
 }
 
 /* Function semanage_fcontext_exists_local */
-void test_fcontext_exists_local(void)
+static void test_fcontext_exists_local(void)
 {
 	int resp = -1;
 	semanage_fcontext_key_t *key;
@@ -927,7 +927,7 @@ void test_fcontext_exists_local(void)
 }
 
 /* Function semanage_fcontext_count_local */
-void test_fcontext_count_local(void)
+static void test_fcontext_count_local(void)
 {
 	unsigned int resp;
 
@@ -967,7 +967,7 @@ void test_fcontext_count_local(void)
 /* Function semanage_fcontext_iterate_local */
 unsigned int counter_fcontext_iterate_local = 0;
 
-int handler_fcontext_iterate_local(const semanage_fcontext_t *record,
+static int handler_fcontext_iterate_local(const semanage_fcontext_t *record,
 				   void *varg)
 {
 	CU_ASSERT_PTR_NOT_NULL(record);
@@ -975,7 +975,7 @@ int handler_fcontext_iterate_local(const semanage_fcontext_t *record,
 	return 0;
 }
 
-void test_fcontext_iterate_local(void)
+static void test_fcontext_iterate_local(void)
 {
 	/* handle */
 	setup_handle(SH_HANDLE);
@@ -1024,7 +1024,7 @@ void test_fcontext_iterate_local(void)
 }
 
 /* Function semanage_fcontext_list_local */
-void test_fcontext_list_local(void)
+static void test_fcontext_list_local(void)
 {
 	semanage_fcontext_t **records;
 	unsigned int count;
diff --git a/libsemanage/tests/test_handle.c b/libsemanage/tests/test_handle.c
index 2fab29be..00a6cb92 100644
--- a/libsemanage/tests/test_handle.c
+++ b/libsemanage/tests/test_handle.c
@@ -21,18 +21,18 @@
 #include "utilities.h"
 #include "test_handle.h"
 
-void test_handle_create(void);
-void test_connect(void);
-void test_disconnect(void);
-void test_transaction(void);
-void test_commit(void);
-void test_is_connected(void);
-void test_access_check(void);
-void test_is_managed(void);
-void test_mls_enabled(void);
-void test_msg_set_callback(void);
-void test_root(void);
-void test_select_store(void);
+static void test_handle_create(void);
+static void test_connect(void);
+static void test_disconnect(void);
+static void test_transaction(void);
+static void test_commit(void);
+static void test_is_connected(void);
+static void test_access_check(void);
+static void test_is_managed(void);
+static void test_mls_enabled(void);
+static void test_msg_set_callback(void);
+static void test_root(void);
+static void test_select_store(void);
 
 extern semanage_handle_t *sh;
 
@@ -80,7 +80,7 @@ int handle_add_tests(CU_pSuite suite)
 }
 
 /* Function semanage_handle_create */
-void test_handle_create(void)
+static void test_handle_create(void)
 {
 	sh = semanage_handle_create();
 	CU_ASSERT_PTR_NOT_NULL(sh);
@@ -88,7 +88,7 @@ void test_handle_create(void)
 }
 
 /* Function semanage_connect */
-void test_connect(void)
+static void test_connect(void)
 {
 	/* test handle created */
 	setup_handle(SH_HANDLE);
@@ -109,7 +109,7 @@ void test_connect(void)
 }
 
 /* Function semanage_disconnect */
-void test_disconnect(void)
+static void test_disconnect(void)
 {
 	setup_handle(SH_CONNECT);
 	CU_ASSERT(semanage_disconnect(sh) >= 0);
@@ -117,7 +117,7 @@ void test_disconnect(void)
 }
 
 /* Function semanage_begin_transaction */
-void test_transaction(void)
+static void test_transaction(void)
 {
 	/* test disconnected */
 	setup_handle(SH_CONNECT);
@@ -135,7 +135,7 @@ void test_transaction(void)
 }
 
 /* Function semanage_commit */
-void test_commit(void)
+static void test_commit(void)
 {
 	/* test without transaction */
 	setup_handle(SH_CONNECT);
@@ -149,7 +149,7 @@ void test_commit(void)
 }
 
 /* Function semanage_is_connected */
-void test_is_connected(void)
+static void test_is_connected(void)
 {
 	/* test disconnected */
 	setup_handle(SH_HANDLE);
@@ -167,7 +167,7 @@ void test_is_connected(void)
 }
 
 /* Function semanage_access_check */
-void test_access_check(void)
+static void test_access_check(void)
 {
 	int res = 0;
 
@@ -192,7 +192,7 @@ void test_access_check(void)
 }
 
 /* Function semanage_is_managed */
-void test_is_managed(void)
+static void test_is_managed(void)
 {
 	int res = 0;
 
@@ -210,7 +210,7 @@ void test_is_managed(void)
 }
 
 /* Function semanage_mls_enabled */
-void test_mls_enabled(void)
+static void test_mls_enabled(void)
 {
 	int res = 0;
 
@@ -236,13 +236,13 @@ void test_mls_enabled(void)
 /* Function semanage_set_callback */
 int msg_set_callback_count = 0;
 
-void helper_msg_set_callback(void *varg, semanage_handle_t *handle,
+static void helper_msg_set_callback(void *varg, semanage_handle_t *handle,
 			     const char *fmt, ...)
 {
 	msg_set_callback_count++;
 }
 
-void test_msg_set_callback(void)
+static void test_msg_set_callback(void)
 {
 	setup_handle(SH_CONNECT);
 
@@ -261,7 +261,7 @@ void test_msg_set_callback(void)
 }
 
 /* Function semanage_root, semanage_set_root */
-void helper_root(void)
+static void helper_root(void)
 {
 	const char *root = NULL;
 
@@ -274,7 +274,7 @@ void helper_root(void)
 	CU_ASSERT_STRING_EQUAL(root, "");
 }
 
-void test_root(void)
+static void test_root(void)
 {
 	/* test without handle */
 	setup_handle(SH_NULL);
@@ -292,7 +292,7 @@ void test_root(void)
 }
 
 /* Function semanage_select_store */
-void helper_select_store(const char *name, enum semanage_connect_type type,
+static void helper_select_store(const char *name, enum semanage_connect_type type,
 			 int exp_res)
 {
 	setup_handle(SH_HANDLE);
@@ -316,7 +316,7 @@ void helper_select_store(const char *name, enum semanage_connect_type type,
 		cleanup_handle(SH_HANDLE);
 }
 
-void test_select_store(void)
+static void test_select_store(void)
 {
 	helper_select_store("asdf", SEMANAGE_CON_INVALID - 1, -1);
 	helper_select_store("asdf", SEMANAGE_CON_POLSERV_REMOTE + 1, -1);
diff --git a/libsemanage/tests/test_ibendport.c b/libsemanage/tests/test_ibendport.c
index 8addc908..a6ce7a34 100644
--- a/libsemanage/tests/test_ibendport.c
+++ b/libsemanage/tests/test_ibendport.c
@@ -33,18 +33,18 @@
 #define IBENDPORT_3_CON "system_u:object_r:third_ibendport_second_t:s0"
 
 /* ibendports_policy.h */
-void test_ibendport_query(void);
-void test_ibendport_exists(void);
-void test_ibendport_count(void);
-void test_ibendport_iterate(void);
-void test_ibendport_list(void);
+static void test_ibendport_query(void);
+static void test_ibendport_exists(void);
+static void test_ibendport_count(void);
+static void test_ibendport_iterate(void);
+static void test_ibendport_list(void);
 
 /* ibendports_local.h */
-void test_ibendport_modify_del_query_local(void);
-void test_ibendport_exists_local(void);
-void test_ibendport_count_local(void);
-void test_ibendport_iterate_local(void);
-void test_ibendport_list_local(void);
+static void test_ibendport_modify_del_query_local(void);
+static void test_ibendport_exists_local(void);
+static void test_ibendport_count_local(void);
+static void test_ibendport_iterate_local(void);
+static void test_ibendport_list_local(void);
 
 extern semanage_handle_t *sh;
 
@@ -95,7 +95,7 @@ int ibendport_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-semanage_ibendport_t *get_ibendport_nth(int idx)
+static semanage_ibendport_t *get_ibendport_nth(int idx)
 {
 	semanage_ibendport_t **records;
 	semanage_ibendport_t *ibendport;
@@ -118,7 +118,7 @@ semanage_ibendport_t *get_ibendport_nth(int idx)
 	return ibendport;
 }
 
-semanage_ibendport_key_t *get_ibendport_key_nth(int idx)
+static semanage_ibendport_key_t *get_ibendport_key_nth(int idx)
 {
 	semanage_ibendport_key_t *key;
 	semanage_ibendport_t *ibendport;
@@ -139,7 +139,7 @@ semanage_ibendport_key_t *get_ibendport_key_nth(int idx)
 	return key;
 }
 
-void add_local_ibendport(int idx)
+static void add_local_ibendport(int idx)
 {
 	semanage_ibendport_t *ibendport;
 	semanage_ibendport_key_t *key = NULL;
@@ -157,7 +157,7 @@ void add_local_ibendport(int idx)
 	semanage_ibendport_free(ibendport);
 }
 
-void delete_local_ibendport(int idx)
+static void delete_local_ibendport(int idx)
 {
 	semanage_ibendport_key_t *key = NULL;
 	key = get_ibendport_key_nth(idx);
@@ -167,7 +167,7 @@ void delete_local_ibendport(int idx)
 }
 
 /* Function semanage_ibendport_query */
-void test_ibendport_query(void)
+static void test_ibendport_query(void)
 {
 	semanage_ibendport_t *ibendport = NULL;
 	semanage_ibendport_t *ibendport_exp = NULL;
@@ -213,7 +213,7 @@ void test_ibendport_query(void)
 }
 
 /* Function semanage_ibendport_exists */
-void test_ibendport_exists(void)
+static void test_ibendport_exists(void)
 {
 	semanage_ibendport_key_t *key1 = NULL;
 	semanage_ibendport_key_t *key2 = NULL;
@@ -238,7 +238,7 @@ void test_ibendport_exists(void)
 }
 
 /* Function semanage_ibendport_count */
-void test_ibendport_count(void)
+static void test_ibendport_count(void)
 {
 	unsigned int count = 42;
 
@@ -256,7 +256,7 @@ void test_ibendport_count(void)
 /* Function semanage_ibendport_iterate */
 unsigned int helper_ibendport_iterate_counter = 0;
 
-int helper_ibendport_iterate(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate(const semanage_ibendport_t *ibendport,
 			     void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -264,7 +264,7 @@ int helper_ibendport_iterate(const semanage_ibendport_t *ibendport,
 	return 0;
 }
 
-int helper_ibendport_iterate_error(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_error(const semanage_ibendport_t *ibendport,
 				   void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -272,7 +272,7 @@ int helper_ibendport_iterate_error(const semanage_ibendport_t *ibendport,
 	return -1;
 }
 
-int helper_ibendport_iterate_break(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_break(const semanage_ibendport_t *ibendport,
 				   void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -280,7 +280,7 @@ int helper_ibendport_iterate_break(const semanage_ibendport_t *ibendport,
 	return 1;
 }
 
-void test_ibendport_iterate(void)
+static void test_ibendport_iterate(void)
 {
 	/* setup */
 	setup_handle(SH_CONNECT);
@@ -308,7 +308,7 @@ void test_ibendport_iterate(void)
 }
 
 /* Function semanage_ibendport_list */
-void test_ibendport_list(void)
+static void test_ibendport_list(void)
 {
 	semanage_ibendport_t **records = NULL;
 	unsigned int count = 42;
@@ -345,7 +345,7 @@ void test_ibendport_list(void)
 /* Function semanage_ibendport_modify_local, semanage_ibendport_del_local,
  * semanage_ibendport_query_local
  */
-void test_ibendport_modify_del_query_local(void)
+static void test_ibendport_modify_del_query_local(void)
 {
 	semanage_ibendport_t *ibendport;
 	semanage_ibendport_t *ibendport_local;
@@ -380,7 +380,7 @@ void test_ibendport_modify_del_query_local(void)
 }
 
 /* Function semanage_ibendport_exists_local */
-void test_ibendport_exists_local(void)
+static void test_ibendport_exists_local(void)
 {
 	semanage_ibendport_key_t *key1 = NULL;
 	semanage_ibendport_key_t *key2 = NULL;
@@ -407,7 +407,7 @@ void test_ibendport_exists_local(void)
 }
 
 /* Function semanage_ibendport_count_local */
-void test_ibendport_count_local(void)
+static void test_ibendport_count_local(void)
 {
 	unsigned int count = 42;
 
@@ -441,7 +441,7 @@ void test_ibendport_count_local(void)
 /* Function semanage_ibendport_iterate_local */
 unsigned int helper_ibendport_iterate_local_counter = 0;
 
-int helper_ibendport_iterate_local(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_local(const semanage_ibendport_t *ibendport,
 				   void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -449,7 +449,7 @@ int helper_ibendport_iterate_local(const semanage_ibendport_t *ibendport,
 	return 0;
 }
 
-int helper_ibendport_iterate_local_error(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_local_error(const semanage_ibendport_t *ibendport,
 					 void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -457,7 +457,7 @@ int helper_ibendport_iterate_local_error(const semanage_ibendport_t *ibendport,
 	return -1;
 }
 
-int helper_ibendport_iterate_local_break(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_local_break(const semanage_ibendport_t *ibendport,
 					 void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -465,7 +465,7 @@ int helper_ibendport_iterate_local_break(const semanage_ibendport_t *ibendport,
 	return 1;
 }
 
-void test_ibendport_iterate_local(void)
+static void test_ibendport_iterate_local(void)
 {
 	/* setup */
 	setup_handle(SH_TRANS);
@@ -498,7 +498,7 @@ void test_ibendport_iterate_local(void)
 }
 
 /* Function semanage_ibendport_list_local */
-void test_ibendport_list_local(void)
+static void test_ibendport_list_local(void)
 {
 	semanage_ibendport_t **records = NULL;
 	unsigned int count = 42;
diff --git a/libsemanage/tests/test_iface.c b/libsemanage/tests/test_iface.c
index 46937e10..2b84cb8e 100644
--- a/libsemanage/tests/test_iface.c
+++ b/libsemanage/tests/test_iface.c
@@ -37,29 +37,29 @@
 
 
 /* iface_record.h */
-void test_iface_compare(void);
-void test_iface_compare2(void);
-void test_iface_key_create(void);
-void test_iface_key_extract(void);
-void test_iface_get_set_name(void);
-void test_iface_get_set_ifcon(void);
-void test_iface_get_set_msgcon(void);
-void test_iface_create(void);
-void test_iface_clone(void);
+static void test_iface_compare(void);
+static void test_iface_compare2(void);
+static void test_iface_key_create(void);
+static void test_iface_key_extract(void);
+static void test_iface_get_set_name(void);
+static void test_iface_get_set_ifcon(void);
+static void test_iface_get_set_msgcon(void);
+static void test_iface_create(void);
+static void test_iface_clone(void);
 
 /* interfaces_policy.h */
-void test_iface_query(void);
-void test_iface_exists(void);
-void test_iface_count(void);
-void test_iface_iterate(void);
-void test_iface_list(void);
+static void test_iface_query(void);
+static void test_iface_exists(void);
+static void test_iface_count(void);
+static void test_iface_iterate(void);
+static void test_iface_list(void);
 
 /* interfaces_local.h */
-void test_iface_modify_del_query_local(void);
-void test_iface_exists_local(void);
-void test_iface_count_local(void);
-void test_iface_iterate_local(void);
-void test_iface_list_local(void);
+static void test_iface_modify_del_query_local(void);
+static void test_iface_exists_local(void);
+static void test_iface_count_local(void);
+static void test_iface_iterate_local(void);
+static void test_iface_list_local(void);
 
 extern semanage_handle_t *sh;
 
@@ -118,7 +118,7 @@ int iface_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-semanage_iface_t *get_iface_nth(int idx)
+static semanage_iface_t *get_iface_nth(int idx)
 {
 	int res;
 	semanage_iface_t **records;
@@ -144,7 +144,7 @@ semanage_iface_t *get_iface_nth(int idx)
 	return iface;
 }
 
-semanage_iface_key_t *get_iface_key_nth(int idx)
+static semanage_iface_key_t *get_iface_key_nth(int idx)
 {
 	semanage_iface_key_t *key;
 	semanage_iface_t *iface;
@@ -165,7 +165,7 @@ semanage_iface_key_t *get_iface_key_nth(int idx)
 	return key;
 }
 
-void add_local_iface(int idx)
+static void add_local_iface(int idx)
 {
 	semanage_iface_t *iface;
 	semanage_iface_key_t *key = NULL;
@@ -182,7 +182,7 @@ void add_local_iface(int idx)
 	semanage_iface_free(iface);
 }
 
-void delete_local_iface(int idx)
+static void delete_local_iface(int idx)
 {
 	semanage_iface_key_t *key = NULL;
 	key = get_iface_key_nth(idx);
@@ -193,7 +193,7 @@ void delete_local_iface(int idx)
 }
 
 /* Function semanage_iface_compare */
-void test_iface_compare(void)
+static void test_iface_compare(void)
 {
 	semanage_iface_t *iface = NULL;
 	semanage_iface_key_t *key1 = NULL;
@@ -221,7 +221,7 @@ void test_iface_compare(void)
 }
 
 /* Function semanage_iface_compare2 */
-void test_iface_compare2(void)
+static void test_iface_compare2(void)
 {
 	semanage_iface_t *iface1 = NULL;
 	semanage_iface_t *iface2 = NULL;
@@ -248,7 +248,7 @@ void test_iface_compare2(void)
 }
 
 /* Function semanage_iface_create */
-void test_iface_key_create(void)
+static void test_iface_key_create(void)
 {
 	semanage_iface_key_t *key = NULL;
 
@@ -265,7 +265,7 @@ void test_iface_key_create(void)
 }
 
 /* Function semanage_iface_extract */
-void test_iface_key_extract(void)
+static void test_iface_key_extract(void)
 {
 	semanage_iface_t *iface = NULL;
 	semanage_iface_key_t *key = NULL;
@@ -285,7 +285,7 @@ void test_iface_key_extract(void)
 }
 
 /* Function semanage_iface_get_name, semanage_iface_set_name */
-void test_iface_get_set_name(void)
+static void test_iface_get_set_name(void)
 {
 	semanage_iface_t *iface = NULL;
 
@@ -303,7 +303,7 @@ void test_iface_get_set_name(void)
 }
 
 /* Function semanage_iface_get_ifcon, semanage_iface_set_ifcon */
-void test_iface_get_set_ifcon(void)
+static void test_iface_get_set_ifcon(void)
 {
 	semanage_iface_t *iface = NULL;
 	semanage_context_t *con1 = NULL;
@@ -327,7 +327,7 @@ void test_iface_get_set_ifcon(void)
 }
 
 /* Function semanage_iface_get_msgcon, semanage_iface_set_msgcon */
-void test_iface_get_set_msgcon(void)
+static void test_iface_get_set_msgcon(void)
 {
 	semanage_iface_t *iface = NULL;
 	semanage_context_t *con1 = NULL;
@@ -351,7 +351,7 @@ void test_iface_get_set_msgcon(void)
 }
 
 /* Function semanage_iface_create */
-void test_iface_create(void)
+static void test_iface_create(void)
 {
 	semanage_iface_t *iface = NULL;
 	semanage_context_t *ifcon = NULL;
@@ -378,7 +378,7 @@ void test_iface_create(void)
 }
 
 /* Function semanage_iface_clone */
-void test_iface_clone(void)
+static void test_iface_clone(void)
 {
 	semanage_iface_t *iface = NULL;
 	semanage_iface_t *iface_clone = NULL;
@@ -417,7 +417,7 @@ void test_iface_clone(void)
 }
 
 /* Function semanage_iface_query */
-void test_iface_query(void)
+static void test_iface_query(void)
 {
 	semanage_iface_t *iface = NULL;
 	semanage_iface_t *iface_exp = NULL;
@@ -451,7 +451,7 @@ void test_iface_query(void)
 }
 
 /* Function semanage_iface_exists */
-void test_iface_exists(void)
+static void test_iface_exists(void)
 {
 	semanage_iface_key_t *key1 = NULL;
 	semanage_iface_key_t *key2 = NULL;
@@ -475,7 +475,7 @@ void test_iface_exists(void)
 }
 
 /* Function semanage_iface_count */
-void test_iface_count(void)
+static void test_iface_count(void)
 {
 	unsigned int count = 42;
 
@@ -494,13 +494,13 @@ void test_iface_count(void)
 
 unsigned int counter_iface_iterate = 0;
 
-int handler_iface_iterate(const semanage_iface_t *record, void *varg)
+static int handler_iface_iterate(const semanage_iface_t *record, void *varg)
 {
 	counter_iface_iterate++;
 	return 0;
 }
 
-void test_iface_iterate(void)
+static void test_iface_iterate(void)
 {
 	/* setup */
 	setup_handle(SH_CONNECT);
@@ -514,7 +514,7 @@ void test_iface_iterate(void)
 }
 
 /* Function semanage_iface_list */
-void test_iface_list(void)
+static void test_iface_list(void)
 {
 	semanage_iface_t **records = NULL;
 	unsigned int count = 42;
@@ -541,7 +541,7 @@ void test_iface_list(void)
 /* Function semanage_iface_modify_local, semanage_iface_del_local,
  * semanage_iface_query_local
  */
-void test_iface_modify_del_query_local(void)
+static void test_iface_modify_del_query_local(void)
 {
 	semanage_iface_t *iface;
 	semanage_iface_t *iface_local;
@@ -574,7 +574,7 @@ void test_iface_modify_del_query_local(void)
 }
 
 /* Function semanage_iface_exists_local */
-void test_iface_exists_local(void)
+static void test_iface_exists_local(void)
 {
 	semanage_iface_key_t *key1 = NULL;
 	semanage_iface_key_t *key2 = NULL;
@@ -600,7 +600,7 @@ void test_iface_exists_local(void)
 }
 
 /* Function semanage_iface_count_local */
-void test_iface_count_local(void)
+static void test_iface_count_local(void)
 {
 	unsigned int count = 42;
 
@@ -634,13 +634,13 @@ void test_iface_count_local(void)
 /* Function semanage_iface_iterate_local */
 unsigned int counter_iface_iterate_local = 0;
 
-int handler_iface_iterate_local(const semanage_iface_t *record, void *varg)
+static int handler_iface_iterate_local(const semanage_iface_t *record, void *varg)
 {
 	counter_iface_iterate_local++;
 	return 0;
 }
 
-void test_iface_iterate_local(void)
+static void test_iface_iterate_local(void)
 {
 	/* setup */
 	setup_handle(SH_TRANS);
@@ -660,7 +660,7 @@ void test_iface_iterate_local(void)
 }
 
 /* Function semanage_iface_list_local */
-void test_iface_list_local(void)
+static void test_iface_list_local(void)
 {
 	semanage_iface_t **records = NULL;
 	unsigned int count = 42;
diff --git a/libsemanage/tests/test_node.c b/libsemanage/tests/test_node.c
index e49e8c3b..0db38d97 100644
--- a/libsemanage/tests/test_node.c
+++ b/libsemanage/tests/test_node.c
@@ -39,33 +39,33 @@
 #define NODE3_CONTEXT "system_u:object_r:third_node_t:s0"
 
 /* node_record.h */
-void test_node_compare(void);
-void test_node_compare2(void);
-void test_node_key_create(void);
-void test_node_key_extract(void);
-void test_node_get_set_addr(void);
-void test_node_get_set_addr_bytes(void);
-void test_node_get_set_mask(void);
-void test_node_get_set_mask_bytes(void);
-void test_node_get_set_proto(void);
-void test_node_get_proto_str(void);
-void test_node_get_set_con(void);
-void test_node_create(void);
-void test_node_clone(void);
+static void test_node_compare(void);
+static void test_node_compare2(void);
+static void test_node_key_create(void);
+static void test_node_key_extract(void);
+static void test_node_get_set_addr(void);
+static void test_node_get_set_addr_bytes(void);
+static void test_node_get_set_mask(void);
+static void test_node_get_set_mask_bytes(void);
+static void test_node_get_set_proto(void);
+static void test_node_get_proto_str(void);
+static void test_node_get_set_con(void);
+static void test_node_create(void);
+static void test_node_clone(void);
 
 /* nodes_policy.h */
-void test_node_query(void);
-void test_node_exists(void);
-void test_node_count(void);
-void test_node_iterate(void);
-void test_node_list(void);
+static void test_node_query(void);
+static void test_node_exists(void);
+static void test_node_count(void);
+static void test_node_iterate(void);
+static void test_node_list(void);
 
 /* nodes_local.h */
-void test_node_modify_del_query_local(void);
-void test_node_exists_local(void);
-void test_node_count_local(void);
-void test_node_iterate_local(void);
-void test_node_list_local(void);
+static void test_node_modify_del_query_local(void);
+static void test_node_exists_local(void);
+static void test_node_count_local(void);
+static void test_node_iterate_local(void);
+static void test_node_list_local(void);
 
 extern semanage_handle_t *sh;
 
@@ -130,7 +130,7 @@ int node_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-semanage_node_t *get_node_nth(int idx)
+static semanage_node_t *get_node_nth(int idx)
 {
 	semanage_node_t **records;
 	semanage_node_t *node;
@@ -153,7 +153,7 @@ semanage_node_t *get_node_nth(int idx)
 	return node;
 }
 
-semanage_node_key_t *get_node_key_nth(int idx)
+static semanage_node_key_t *get_node_key_nth(int idx)
 {
 	semanage_node_key_t *key;
 	semanage_node_t *node;
@@ -174,7 +174,7 @@ semanage_node_key_t *get_node_key_nth(int idx)
 	return key;
 }
 
-void add_local_node(int idx)
+static void add_local_node(int idx)
 {
 	semanage_node_t *node;
 	semanage_node_key_t *key = NULL;
@@ -191,7 +191,7 @@ void add_local_node(int idx)
 	semanage_node_free(node);
 }
 
-void delete_local_node(int idx)
+static void delete_local_node(int idx)
 {
 	semanage_node_key_t *key = NULL;
 
@@ -204,7 +204,7 @@ void delete_local_node(int idx)
 }
 
 /* Function semanage_node_compare */
-void test_node_compare(void)
+static void test_node_compare(void)
 {
 	semanage_node_t *node = NULL;
 	semanage_node_key_t *key1 = NULL;
@@ -233,7 +233,7 @@ void test_node_compare(void)
 }
 
 /* Function semanage_node_compare2 */
-void test_node_compare2(void)
+static void test_node_compare2(void)
 {
 	semanage_node_t *node1 = NULL;
 	semanage_node_t *node2 = NULL;
@@ -260,7 +260,7 @@ void test_node_compare2(void)
 }
 
 /* Function semanage_node_key_create */
-void test_node_key_create(void)
+static void test_node_key_create(void)
 {
 	semanage_node_key_t *key = NULL;
 
@@ -278,7 +278,7 @@ void test_node_key_create(void)
 }
 
 /* Function semanage_node_key_extract */
-void test_node_key_extract(void)
+static void test_node_key_extract(void)
 {
 	semanage_node_t *node = NULL;
 	semanage_node_key_t *key = NULL;
@@ -298,7 +298,7 @@ void test_node_key_extract(void)
 }
 
 /* Function semanage_node_get_addr, semanage_node_set_addr */
-void test_node_get_set_addr(void)
+static void test_node_get_set_addr(void)
 {
 	semanage_node_t *node = NULL;
 	char *addr = NULL;
@@ -322,7 +322,7 @@ void test_node_get_set_addr(void)
 }
 
 /* Function semanage_node_get_addr_bytes, semanage_node_set_addr_bytes */
-void test_node_get_set_addr_bytes(void)
+static void test_node_get_set_addr_bytes(void)
 {
 	semanage_node_t *node = NULL;
 	char addr1[] = { 192, 168, 0, 1 };
@@ -352,7 +352,7 @@ void test_node_get_set_addr_bytes(void)
 }
 
 /* Function semanage_node_get_mask, semanage_node_set_mask */
-void test_node_get_set_mask(void)
+static void test_node_get_set_mask(void)
 {
 	semanage_node_t *node = NULL;
 	char *mask = NULL;
@@ -376,7 +376,7 @@ void test_node_get_set_mask(void)
 }
 
 /* Function semanage_node_get_mask_bytes, semanage_node_set_mask_bytes */
-void test_node_get_set_mask_bytes(void)
+static void test_node_get_set_mask_bytes(void)
 {
 	semanage_node_t *node = NULL;
 	char mask1[] = { 255, 255, 255, 0 };
@@ -406,7 +406,7 @@ void test_node_get_set_mask_bytes(void)
 }
 
 /* Function semanage_node_get_proto, semanage_node_set_proto */
-void test_node_get_set_proto(void)
+static void test_node_get_set_proto(void)
 {
 	semanage_node_t *node = NULL;
 
@@ -424,7 +424,7 @@ void test_node_get_set_proto(void)
 }
 
 /* Function semanage_node_get_proto_str */
-void test_node_get_proto_str(void)
+static void test_node_get_proto_str(void)
 {
 	CU_ASSERT_STRING_EQUAL(semanage_node_get_proto_str(SEMANAGE_PROTO_IP4),
 							   "ipv4");
@@ -433,7 +433,7 @@ void test_node_get_proto_str(void)
 }
 
 /* Function semanage_node_get_con, semanage_node_set_con */
-void test_node_get_set_con(void)
+static void test_node_get_set_con(void)
 {
 	semanage_node_t *node = NULL;
 	semanage_context_t *con1 = NULL;
@@ -457,7 +457,7 @@ void test_node_get_set_con(void)
 }
 
 /* Function semanage_node_create */
-void test_node_create(void)
+static void test_node_create(void)
 {
 	semanage_node_t *node = NULL;
 	semanage_context_t *con = NULL;
@@ -483,7 +483,7 @@ void test_node_create(void)
 }
 
 /* Function semanage_node_clone */
-void test_node_clone(void)
+static void test_node_clone(void)
 {
 	semanage_node_t *node = NULL;
 	semanage_node_t *node_clone = NULL;
@@ -534,7 +534,7 @@ void test_node_clone(void)
 }
 
 /* Function semanage_node_query */
-void test_node_query(void)
+static void test_node_query(void)
 {
 	semanage_node_t *node = NULL;
 	semanage_node_t *node_exp = NULL;
@@ -579,7 +579,7 @@ void test_node_query(void)
 }
 
 /* Function semanage_node_exists */
-void test_node_exists(void)
+static void test_node_exists(void)
 {
 	semanage_node_key_t *key1 = NULL;
 	semanage_node_key_t *key2 = NULL;
@@ -604,7 +604,7 @@ void test_node_exists(void)
 }
 
 /* Function semanage_node_count */
-void test_node_count(void)
+static void test_node_count(void)
 {
 	unsigned int count = 42;
 
@@ -622,13 +622,13 @@ void test_node_count(void)
 /* Function semanage_node_iterate */
 unsigned int counter_node_iterate = 0;
 
-int handler_node_iterate(const semanage_node_t *record, void *varg)
+static int handler_node_iterate(const semanage_node_t *record, void *varg)
 {
 	counter_node_iterate++;
 	return 0;
 }
 
-void test_node_iterate(void)
+static void test_node_iterate(void)
 {
 	/* setup */
 	setup_handle(SH_CONNECT);
@@ -642,7 +642,7 @@ void test_node_iterate(void)
 }
 
 /* Function semanage_node_list */
-void test_node_list(void)
+static void test_node_list(void)
 {
 	semanage_node_t **records = NULL;
 	unsigned int count = 42;
@@ -669,7 +669,7 @@ void test_node_list(void)
 /* Function semanage_node_modify_local, semanage_node_del_local,
  * semanage_node_query_local
  */
-void test_node_modify_del_query_local(void)
+static void test_node_modify_del_query_local(void)
 {
 	semanage_node_t *node;
 	semanage_node_t *node_local;
@@ -719,7 +719,7 @@ void test_node_modify_del_query_local(void)
 }
 
 /* Function semanage_node_exists_local */
-void test_node_exists_local(void)
+static void test_node_exists_local(void)
 {
 	semanage_node_key_t *key1 = NULL;
 	semanage_node_key_t *key2 = NULL;
@@ -745,7 +745,7 @@ void test_node_exists_local(void)
 }
 
 /* Function semanage_node_count_local */
-void test_node_count_local(void)
+static void test_node_count_local(void)
 {
 	unsigned int count = 42;
 
@@ -779,13 +779,13 @@ void test_node_count_local(void)
 /* Function semanage_node_iterate_local */
 unsigned int counter_node_iterate_local = 0;
 
-int handler_node_iterate_local(const semanage_node_t *record, void *varg)
+static int handler_node_iterate_local(const semanage_node_t *record, void *varg)
 {
 	counter_node_iterate_local++;
 	return 0;
 }
 
-void test_node_iterate_local(void)
+static void test_node_iterate_local(void)
 {
 	/* setup */
 	setup_handle(SH_TRANS);
@@ -805,7 +805,7 @@ void test_node_iterate_local(void)
 }
 
 /* Function semanage_node_list_local */
-void test_node_list_local(void)
+static void test_node_list_local(void)
 {
 	semanage_node_t **records = NULL;
 	unsigned int count = 42;
diff --git a/libsemanage/tests/test_port.c b/libsemanage/tests/test_port.c
index f4c6ec21..19213f6d 100644
--- a/libsemanage/tests/test_port.c
+++ b/libsemanage/tests/test_port.c
@@ -36,34 +36,34 @@
 #define PORT3_PROTO SEPOL_PROTO_TCP
 
 /* port_record.h */
-void test_port_compare(void);
-void test_port_compare2(void);
-void test_port_key_create(void);
-void test_port_key_extract(void);
-void test_port_get_set_proto(void);
-void test_port_get_proto_str(void);
-void test_port_get_set_port(void);
-void test_port_get_set_con(void);
-void test_port_create(void);
-void test_port_clone(void);
+static void test_port_compare(void);
+static void test_port_compare2(void);
+static void test_port_key_create(void);
+static void test_port_key_extract(void);
+static void test_port_get_set_proto(void);
+static void test_port_get_proto_str(void);
+static void test_port_get_set_port(void);
+static void test_port_get_set_con(void);
+static void test_port_create(void);
+static void test_port_clone(void);
 
 /* ports_policy.h */
-void test_port_query(void);
-void test_port_exists(void);
-void test_port_count(void);
-void test_port_iterate(void);
-void test_port_list(void);
+static void test_port_query(void);
+static void test_port_exists(void);
+static void test_port_count(void);
+static void test_port_iterate(void);
+static void test_port_list(void);
 
 /* ports_local.h */
-void test_port_modify_del_local(void);
-void test_port_query_local(void);
-void test_port_exists_local(void);
-void test_port_count_local(void);
-void test_port_iterate_local(void);
-void test_port_list_local(void);
+static void test_port_modify_del_local(void);
+static void test_port_query_local(void);
+static void test_port_exists_local(void);
+static void test_port_count_local(void);
+static void test_port_iterate_local(void);
+static void test_port_list_local(void);
 
 /* internal */
-void test_port_validate_local(void);
+static void test_port_validate_local(void);
 
 extern semanage_handle_t *sh;
 
@@ -125,7 +125,7 @@ int port_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-semanage_port_t *get_port_nth(int idx)
+static semanage_port_t *get_port_nth(int idx)
 {
 	int res;
 	semanage_port_t **records;
@@ -151,7 +151,7 @@ semanage_port_t *get_port_nth(int idx)
 	return port;
 }
 
-semanage_port_key_t *get_port_key_nth(int idx)
+static semanage_port_key_t *get_port_key_nth(int idx)
 {
 	semanage_port_key_t *key;
 	semanage_port_t *port;
@@ -173,7 +173,7 @@ semanage_port_key_t *get_port_key_nth(int idx)
 	return key;
 }
 
-void add_local_port(int port_idx)
+static void add_local_port(int port_idx)
 {
 	semanage_port_t *port;
 	semanage_port_key_t *key = NULL;
@@ -192,7 +192,7 @@ void add_local_port(int port_idx)
 	semanage_port_free(port);
 }
 
-void delete_local_port(int port_idx)
+static void delete_local_port(int port_idx)
 {
 	semanage_port_key_t *key = NULL;
 
@@ -206,7 +206,7 @@ void delete_local_port(int port_idx)
 }
 
 /* Function semanage_port_compare */
-void helper_port_compare(int idx1, int idx2)
+static void helper_port_compare(int idx1, int idx2)
 {
 	semanage_port_t *port = NULL;
 	semanage_port_key_t *key = NULL;
@@ -232,7 +232,7 @@ void helper_port_compare(int idx1, int idx2)
 	cleanup_handle(SH_CONNECT);
 }
 
-void test_port_compare(void)
+static void test_port_compare(void)
 {
 	helper_port_compare(I_FIRST,  I_FIRST);
 	helper_port_compare(I_FIRST,  I_SECOND);
@@ -241,7 +241,7 @@ void test_port_compare(void)
 }
 
 /* Function semanage_port_compare2 */
-void helper_port_compare2(int idx1, int idx2)
+static void helper_port_compare2(int idx1, int idx2)
 {
 	semanage_port_t *port1 = NULL;
 	semanage_port_t *port2 = NULL;
@@ -268,7 +268,7 @@ void helper_port_compare2(int idx1, int idx2)
 	cleanup_handle(SH_CONNECT);
 }
 
-void test_port_compare2(void)
+static void test_port_compare2(void)
 {
 	helper_port_compare2(I_FIRST,  I_FIRST);
 	helper_port_compare2(I_FIRST,  I_SECOND);
@@ -277,7 +277,7 @@ void test_port_compare2(void)
 }
 
 /* Function semanage_port_create */
-void test_port_key_create(void)
+static void test_port_key_create(void)
 {
 	semanage_port_key_t *key = NULL;
 
@@ -294,7 +294,7 @@ void test_port_key_create(void)
 }
 
 /* Function semanage_port_extract */
-void test_port_key_extract(void)
+static void test_port_key_extract(void)
 {
 	semanage_port_t *port = NULL;
 	semanage_port_key_t *key = NULL;
@@ -314,7 +314,7 @@ void test_port_key_extract(void)
 }
 
 /* Function semanage_port_get_proto, semanage_port_set_proto */
-void helper_port_get_set_proto(int idx)
+static void helper_port_get_set_proto(int idx)
 {
 	semanage_port_t *port = NULL;
 
@@ -333,14 +333,14 @@ void helper_port_get_set_proto(int idx)
 	cleanup_handle(SH_CONNECT);
 }
 
-void test_port_get_set_proto(void)
+static void test_port_get_set_proto(void)
 {
 	helper_port_get_set_proto(I_FIRST);
 	helper_port_get_set_proto(I_SECOND);
 }
 
 /* Function semanage_port_get_proto_str */
-void test_port_get_proto_str(void)
+static void test_port_get_proto_str(void)
 {
 	const char *str = NULL;
 
@@ -365,7 +365,7 @@ void test_port_get_proto_str(void)
 
 /* Function semanage_port_get_low, semanage_port_get_high, */
 /* semanage_port_set_port, semanage_port_set_range */
-void test_port_get_set_port(void)
+static void test_port_get_set_port(void)
 {
 	semanage_port_t *port = NULL;
 
@@ -388,7 +388,7 @@ void test_port_get_set_port(void)
 }
 
 /* Function semanage_port_get_con, semanage_port_set_con */
-void test_port_get_set_con(void)
+static void test_port_get_set_con(void)
 {
 	semanage_port_t *port = NULL;
 	semanage_port_t *port_tmp = NULL;
@@ -413,7 +413,7 @@ void test_port_get_set_con(void)
 }
 
 /* Function semanage_port_create */
-void test_port_create(void)
+static void test_port_create(void)
 {
 	semanage_port_t *port = NULL;
 
@@ -433,7 +433,7 @@ void test_port_create(void)
 }
 
 /* Function semanage_port_clone */
-void test_port_clone(void)
+static void test_port_clone(void)
 {
 	semanage_port_t *port = NULL;
 	semanage_port_t *port_clone = NULL;
@@ -465,7 +465,7 @@ void test_port_clone(void)
 }
 
 /* Function semanage_port_query */
-void test_port_query(void)
+static void test_port_query(void)
 {
 	semanage_port_t *port = NULL;
 	semanage_port_t *port_exp = NULL;
@@ -499,7 +499,7 @@ void test_port_query(void)
 }
 
 /* Function semanage_port_exists */
-void test_port_exists(void)
+static void test_port_exists(void)
 {
 	semanage_port_key_t *key1 = NULL;
 	semanage_port_key_t *key2 = NULL;
@@ -523,7 +523,7 @@ void test_port_exists(void)
 }
 
 /* Function semanage_port_count */
-void test_port_count(void)
+static void test_port_count(void)
 {
 	unsigned int count = 42;
 
@@ -541,13 +541,13 @@ void test_port_count(void)
 /* Function semanage_port_iterate */
 unsigned int counter_port_iterate = 0;
 
-int handler_port_iterate(const semanage_port_t *record, void *varg)
+static int handler_port_iterate(const semanage_port_t *record, void *varg)
 {
 	counter_port_iterate++;
 	return 0;
 }
 
-void test_port_iterate(void)
+static void test_port_iterate(void)
 {
 	/* setup */
 	setup_handle(SH_CONNECT);
@@ -561,7 +561,7 @@ void test_port_iterate(void)
 }
 
 /* Function semanage_port_list */
-void test_port_list(void)
+static void test_port_list(void)
 {
 	semanage_port_t **records = NULL;
 	unsigned int count = 42;
@@ -586,7 +586,7 @@ void test_port_list(void)
 }
 
 /* Function semanage_port_modify_local, semanage_port_del_local */
-void test_port_modify_del_local(void)
+static void test_port_modify_del_local(void)
 {
 	semanage_port_t *port;
 	semanage_port_t *port_local;
@@ -622,7 +622,7 @@ void test_port_modify_del_local(void)
 }
 
 /* Function semanage_port_query_local */
-void test_port_query_local(void)
+static void test_port_query_local(void)
 {
 	semanage_port_t *port = NULL;
 	semanage_port_t *port_exp = NULL;
@@ -658,7 +658,7 @@ void test_port_query_local(void)
 }
 
 /* Function semanage_port_exists_local */
-void test_port_exists_local(void)
+static void test_port_exists_local(void)
 {
 	semanage_port_key_t *key1 = NULL;
 	semanage_port_key_t *key2 = NULL;
@@ -684,7 +684,7 @@ void test_port_exists_local(void)
 }
 
 /* Function semanage_port_count_local */
-void test_port_count_local(void)
+static void test_port_count_local(void)
 {
 	unsigned int count = 42;
 
@@ -718,13 +718,13 @@ void test_port_count_local(void)
 /* Function semanage_port_iterate_local */
 unsigned int counter_port_iterate_local = 0;
 
-int handler_port_iterate_local(const semanage_port_t *record, void *varg)
+static int handler_port_iterate_local(const semanage_port_t *record, void *varg)
 {
 	counter_port_iterate_local++;
 	return 0;
 }
 
-void test_port_iterate_local(void)
+static void test_port_iterate_local(void)
 {
 	/* setup */
 	setup_handle(SH_TRANS);
@@ -744,7 +744,7 @@ void test_port_iterate_local(void)
 }
 
 /* Function semanage_port_list_local */
-void test_port_list_local(void)
+static void test_port_list_local(void)
 {
 	semanage_port_t **records = NULL;
 	unsigned int count = 42;
@@ -775,7 +775,7 @@ void test_port_list_local(void)
 }
 
 /* Internal function semanage_port_validate_local */
-void helper_port_validate_local_noport(void)
+static void helper_port_validate_local_noport(void)
 {
 	semanage_port_key_t *key = NULL;
 	int resp = 42;
@@ -800,7 +800,7 @@ void helper_port_validate_local_noport(void)
 	cleanup_handle(SH_TRANS);
 }
 
-void helper_port_validate_local_oneport(void)
+static void helper_port_validate_local_oneport(void)
 {
 	/* setup */
 	setup_handle(SH_TRANS);
@@ -815,7 +815,7 @@ void helper_port_validate_local_oneport(void)
 	cleanup_handle(SH_TRANS);
 }
 
-void helper_port_validate_local_twoports(void)
+static void helper_port_validate_local_twoports(void)
 {
 	semanage_port_key_t *key1 = NULL;
 	semanage_port_key_t *key2 = NULL;
@@ -863,7 +863,7 @@ void helper_port_validate_local_twoports(void)
 	cleanup_handle(SH_TRANS);
 }
 
-void helper_port_validate_local_proto(void)
+static void helper_port_validate_local_proto(void)
 {
 	semanage_port_key_t *key1 = NULL;
 	semanage_port_key_t *key2 = NULL;
@@ -925,7 +925,7 @@ void helper_port_validate_local_proto(void)
 	cleanup_handle(SH_TRANS);
 }
 
-void test_port_validate_local(void)
+static void test_port_validate_local(void)
 {
 	helper_port_validate_local_noport();
 	helper_port_validate_local_oneport();
diff --git a/libsemanage/tests/test_user.c b/libsemanage/tests/test_user.c
index c3835c8d..b6fda51a 100644
--- a/libsemanage/tests/test_user.c
+++ b/libsemanage/tests/test_user.c
@@ -24,31 +24,31 @@
 #define USER_COUNT 3
 
 /* user_record.h */
-void test_user_compare(void);
-void test_user_compare2(void);
-void test_user_key_create(void);
-void test_user_key_extract(void);
-void test_user_get_set_name(void);
-void test_user_get_set_prefix(void);
-void test_user_get_set_mlslevel(void);
-void test_user_get_set_mlsrange(void);
-void test_user_roles(void);
-void test_user_create(void);
-void test_user_clone(void);
+static void test_user_compare(void);
+static void test_user_compare2(void);
+static void test_user_key_create(void);
+static void test_user_key_extract(void);
+static void test_user_get_set_name(void);
+static void test_user_get_set_prefix(void);
+static void test_user_get_set_mlslevel(void);
+static void test_user_get_set_mlsrange(void);
+static void test_user_roles(void);
+static void test_user_create(void);
+static void test_user_clone(void);
 
 /* users_policy.h */
-void test_user_query(void);
-void test_user_exists(void);
-void test_user_count(void);
-void test_user_iterate(void);
-void test_user_list(void);
+static void test_user_query(void);
+static void test_user_exists(void);
+static void test_user_count(void);
+static void test_user_iterate(void);
+static void test_user_list(void);
 
 /* users_local.h */
-void test_user_modify_del_query_local(void);
-void test_user_exists_local(void);
-void test_user_count_local(void);
-void test_user_iterate_local(void);
-void test_user_list_local(void);
+static void test_user_modify_del_query_local(void);
+static void test_user_exists_local(void);
+static void test_user_count_local(void);
+static void test_user_iterate_local(void);
+static void test_user_list_local(void);
 
 extern semanage_handle_t *sh;
 
@@ -109,7 +109,7 @@ int user_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-semanage_user_t *get_user_nth(int idx)
+static semanage_user_t *get_user_nth(int idx)
 {
 	int res;
 	semanage_user_t **records;
@@ -135,7 +135,7 @@ semanage_user_t *get_user_nth(int idx)
 	return user;
 }
 
-semanage_user_key_t *get_user_key_nth(int idx)
+static semanage_user_key_t *get_user_key_nth(int idx)
 {
 	semanage_user_key_t *key;
 	semanage_user_t *user;
@@ -156,7 +156,7 @@ semanage_user_key_t *get_user_key_nth(int idx)
 	return key;
 }
 
-void add_local_user(int user_idx)
+static void add_local_user(int user_idx)
 {
 	semanage_user_t *user;
 	semanage_user_key_t *key = NULL;
@@ -174,7 +174,7 @@ void add_local_user(int user_idx)
 	semanage_user_free(user);
 }
 
-void delete_local_user(int user_idx)
+static void delete_local_user(int user_idx)
 {
 	semanage_user_key_t *key = NULL;
 
@@ -188,7 +188,7 @@ void delete_local_user(int user_idx)
 }
 
 /* Function semanage_user_compare */
-void test_user_compare(void)
+static void test_user_compare(void)
 {
 	semanage_user_t *user = NULL;
 	semanage_user_key_t *key1 = NULL;
@@ -215,7 +215,7 @@ void test_user_compare(void)
 }
 
 /* Function semanage_user_compare2 */
-void test_user_compare2(void)
+static void test_user_compare2(void)
 {
 	semanage_user_t *user1 = NULL;
 	semanage_user_t *user2 = NULL;
@@ -242,7 +242,7 @@ void test_user_compare2(void)
 }
 
 /* Function semanage_user_key_create */
-void test_user_key_create(void)
+static void test_user_key_create(void)
 {
 	semanage_user_key_t *key = NULL;
 
@@ -259,7 +259,7 @@ void test_user_key_create(void)
 }
 
 /* Function semanage_user_key_extract */
-void test_user_key_extract(void)
+static void test_user_key_extract(void)
 {
 	semanage_user_t *user = NULL;
 	semanage_user_key_t *key = NULL;
@@ -279,7 +279,7 @@ void test_user_key_extract(void)
 }
 
 /* Function semanage_user_get_name, semanage_user_set_name */
-void test_user_get_set_name(void)
+static void test_user_get_set_name(void)
 {
 	semanage_user_t *user = NULL;
 
@@ -297,7 +297,7 @@ void test_user_get_set_name(void)
 }
 
 /* Function semanage_user_get_prefix, semanage_user_set_prefix */
-void test_user_get_set_prefix(void)
+static void test_user_get_set_prefix(void)
 {
 	semanage_user_t *user = NULL;
 
@@ -315,7 +315,7 @@ void test_user_get_set_prefix(void)
 }
 
 /* Function semanage_user_get_mlslevel, semanage_user_set_mlslevel */
-void test_user_get_set_mlslevel(void)
+static void test_user_get_set_mlslevel(void)
 {
 	semanage_user_t *user = NULL;
 
@@ -333,7 +333,7 @@ void test_user_get_set_mlslevel(void)
 }
 
 /* Function semanage_user_get_mlsrange, semanage_user_set_mlsrange */
-void test_user_get_set_mlsrange(void)
+static void test_user_get_set_mlsrange(void)
 {
 	semanage_user_t *user = NULL;
 
@@ -354,7 +354,7 @@ void test_user_get_set_mlsrange(void)
  * semanage_user_del_role, semanage_user_has_role, semanage_user_get_roles
  * semanage_user_set_roles
  */
-void test_user_roles(void)
+static void test_user_roles(void)
 {
 	semanage_user_t *user = NULL;
 	const char **roles_arr = NULL;
@@ -406,7 +406,7 @@ void test_user_roles(void)
 }
 
 /* Function semanage_user_create */
-void test_user_create(void)
+static void test_user_create(void)
 {
 	semanage_user_t *user = NULL;
 
@@ -426,7 +426,7 @@ void test_user_create(void)
 }
 
 /* Function semanage_user_clone */
-void test_user_clone(void)
+static void test_user_clone(void)
 {
 	semanage_user_t *user = NULL;
 	semanage_user_t *user_clone = NULL;
@@ -453,7 +453,7 @@ void test_user_clone(void)
 }
 
 /* Function semanage_user_query */
-void test_user_query(void)
+static void test_user_query(void)
 {
 	semanage_user_t *user = NULL;
 	semanage_user_key_t *key = NULL;
@@ -475,7 +475,7 @@ void test_user_query(void)
 }
 
 /* Function semanage_user_exists */
-void test_user_exists(void)
+static void test_user_exists(void)
 {
 	semanage_user_key_t *key1 = NULL;
 	semanage_user_key_t *key2 = NULL;
@@ -499,7 +499,7 @@ void test_user_exists(void)
 }
 
 /* Function semanage_user_count */
-void test_user_count(void)
+static void test_user_count(void)
 {
 	unsigned int count = 42;
 
@@ -517,13 +517,13 @@ void test_user_count(void)
 /* Function semanage_user_iterate */
 unsigned int counter_user_iterate = 0;
 
-int handler_user_iterate(const semanage_user_t *record, void *varg)
+static int handler_user_iterate(const semanage_user_t *record, void *varg)
 {
 	counter_user_iterate++;
 	return 0;
 }
 
-void test_user_iterate(void)
+static void test_user_iterate(void)
 {
 	/* setup */
 	setup_handle(SH_CONNECT);
@@ -537,7 +537,7 @@ void test_user_iterate(void)
 }
 
 /* Function semanage_user_list */
-void test_user_list(void)
+static void test_user_list(void)
 {
 	semanage_user_t **records = NULL;
 	unsigned int count = 42;
@@ -565,7 +565,7 @@ void test_user_list(void)
 /* Function semanage_user_modify_local, semanage_user_del_local,
  * semanage_user_query_local
  */
-void test_user_modify_del_query_local(void)
+static void test_user_modify_del_query_local(void)
 {
 	semanage_user_t *user;
 	semanage_user_t *user_local;
@@ -597,7 +597,7 @@ void test_user_modify_del_query_local(void)
 }
 
 /* Function semanage_user_exists_local */
-void test_user_exists_local(void)
+static void test_user_exists_local(void)
 {
 	semanage_user_t *user = NULL;
 	semanage_user_key_t *key1 = NULL;
@@ -626,7 +626,7 @@ void test_user_exists_local(void)
 }
 
 /* Function semanage_user_count_local */
-void test_user_count_local(void)
+static void test_user_count_local(void)
 {
 	unsigned int count = 42;
 
@@ -650,13 +650,13 @@ void test_user_count_local(void)
 /* Function semanage_user_iterate_local */
 unsigned int counter_user_iterate_local = 0;
 
-int handler_user_iterate_local(const semanage_user_t *record, void *varg)
+static int handler_user_iterate_local(const semanage_user_t *record, void *varg)
 {
 	counter_user_iterate_local++;
 	return 0;
 }
 
-void test_user_iterate_local(void)
+static void test_user_iterate_local(void)
 {
 	/* setup */
 	setup_handle(SH_TRANS);
@@ -676,7 +676,7 @@ void test_user_iterate_local(void)
 }
 
 /* Function semanage_user_list_local */
-void test_user_list_local(void)
+static void test_user_list_local(void)
 {
 	semanage_user_t **records = NULL;
 	unsigned int count = 42;
diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index 33609401..e1ff4e7d 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -35,16 +35,17 @@
 #include <unistd.h>
 
 #include "utilities.h"
-
-void test_semanage_is_prefix(void);
-void test_semanage_split_on_space(void);
-void test_semanage_split(void);
-void test_semanage_list(void);
-void test_semanage_str_count(void);
-void test_semanage_rtrim(void);
-void test_semanage_str_replace(void);
-void test_semanage_findval(void);
-void test_slurp_file_filter(void);
+#include "test_utilities.h"
+
+static void test_semanage_is_prefix(void);
+static void test_semanage_split_on_space(void);
+static void test_semanage_split(void);
+static void test_semanage_list(void);
+static void test_semanage_str_count(void);
+static void test_semanage_rtrim(void);
+static void test_semanage_str_replace(void);
+static void test_semanage_findval(void);
+static void test_slurp_file_filter(void);
 
 char fname[] = {
 	'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X', 'X',
@@ -122,7 +123,7 @@ int semanage_utilities_add_tests(CU_pSuite suite)
 	return CU_get_error();
 }
 
-void test_semanage_is_prefix(void)
+static void test_semanage_is_prefix(void)
 {
 	const char *str = "some string";
 	const char *pre = "some";
@@ -134,7 +135,7 @@ void test_semanage_is_prefix(void)
 	CU_ASSERT_FALSE(semanage_is_prefix(str, not_pre));
 }
 
-void test_semanage_split_on_space(void)
+static void test_semanage_split_on_space(void)
 {
 	char *str = strdup("   foo   bar    baz");
 	char *temp;
@@ -163,7 +164,7 @@ void test_semanage_split_on_space(void)
 	free(temp);
 }
 
-void test_semanage_split(void)
+static void test_semanage_split(void)
 {
 	char *str = strdup("foo1 foo2   foo:bar:");
 	char *temp;
@@ -198,7 +199,7 @@ void test_semanage_split(void)
 	free(temp);
 }
 
-void test_semanage_list(void)
+static void test_semanage_list(void)
 {
 	semanage_list_t *list = NULL;
 	semanage_list_t *ptr = NULL;
@@ -247,7 +248,7 @@ void test_semanage_list(void)
 	CU_ASSERT_PTR_NULL(list);
 }
 
-void test_semanage_str_count(void)
+static void test_semanage_str_count(void)
 {
 	const char *test_string = "abaababbaaaba";
 
@@ -256,7 +257,7 @@ void test_semanage_str_count(void)
 	CU_ASSERT_EQUAL(semanage_str_count(test_string, 'b'), 5);
 }
 
-void test_semanage_rtrim(void)
+static void test_semanage_rtrim(void)
 {
 	char *str = strdup("/blah/foo/bar/baz/");
 
@@ -272,7 +273,7 @@ void test_semanage_rtrim(void)
 	free(str);
 }
 
-void test_semanage_str_replace(void)
+static void test_semanage_str_replace(void)
 {
 	const char *test_str = "Hello, I am %{USERNAME} and my id is %{USERID}";
 	char *str1, *str2;
@@ -301,7 +302,7 @@ void test_semanage_str_replace(void)
 	free(str1);
 }
 
-void test_semanage_findval(void)
+static void test_semanage_findval(void)
 {
 	char *tok;
 	if (!fptr) {
@@ -323,12 +324,12 @@ void test_semanage_findval(void)
 	free(tok);
 }
 
-int PREDICATE(const char *str)
+static int PREDICATE(const char *str)
 {
 	return semanage_is_prefix(str, "#");
 }
 
-void test_slurp_file_filter(void)
+static void test_slurp_file_filter(void)
 {
 	semanage_list_t *data, *tmp;
 	int cnt = 0;
diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilities.c
index b28ae155..71d7af1e 100644
--- a/libsemanage/tests/utilities.c
+++ b/libsemanage/tests/utilities.c
@@ -76,7 +76,7 @@ void enable_test_store(void) {
 	test_store_enabled = 1;
 }
 
-int write_test_policy(char *data, size_t data_len) {
+static int write_test_policy(char *data, size_t data_len) {
 	FILE *fptr = fopen("test-policy/store/active/policy.kern", "wb+");
 
 	if (!fptr) {
-- 
2.34.1

