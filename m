Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95231C4167D
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiDNOnO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347719AbiDNN7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 09:59:30 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC0BC874
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:52:05 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id b17so4024137qvp.6
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TX4YZ8zOwWjMt4q23dnW3jEy+KYdMB8U5wMRUw2ohU=;
        b=jUz91eyUDT8psp2aF4iICnEJWTtLYIeSuqhBcH/nIvL6VcEILfYmgDdpbry+zPXwh7
         RxdOxl6NzvuwYE+y4UKFJAWxvMxx/v2mQmyo4Jr+/soDwKPGoaCoZsacuDFvo3s+0EZP
         /fVl8yXJEfcjW9hnYRDZWI9XBOpNF5najabg+ZAduegWRuY7humAgES8F7tpjy5s5QHF
         sFuB3/jJixpTPkw25BiPOMefK0DoL0tmEdZdubron8qiziXVErC/rmWdnCAPqf1J/Z63
         qqUT4Oj67Qo3LEG/NFapMt9Gxtxa8jFBOZyTUMXynW3OR9Uzs8eLrBIeL9jelvNms0KB
         Zcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TX4YZ8zOwWjMt4q23dnW3jEy+KYdMB8U5wMRUw2ohU=;
        b=jSfp4xckOabZwvM+C416ofWxbZhLmlgDwx5YY5Opk0389WhJhATUBUidtcIk3Vju5f
         ZZyiKPqMQCghutaubOjk3kK89E5DmZ93fpcmyzWNHb/yq+P8c9XgVafOaR6P7OwkxYT5
         9ZJshuWErRrQKBeit/yTtRaavX/4T69ajdQYcty8Yrff8qFsZ1Aa9WQGgjBiPMHGlsWa
         hRrDBj4ZoET4WY7iN9qtnfeU+jDBw/iw3v/ddqHtaFhXnDXOtCzcYBPRg5AvOm/1bVZA
         ptCLpYHm1/h5UXM5tr/Te0wGGt9u5qGvCUz1LB9HFnMN4PWS3lS1oN2/QafbknpXnr8X
         Es2A==
X-Gm-Message-State: AOAM531kuGF1sLy9YbYUqlmB5eLDR2nuGq5PWakGrGJ2uN3jw2/a+549
        o8Lr+Kat66PYokeHx/iP5lck+biBnK8=
X-Google-Smtp-Source: ABdhPJz4M4O4nIKSDSXT+dDilU9APZjKKmmQyleoESi4fe8qML4bqW++Evu49EXGAZc9B/IKOvj9bQ==
X-Received: by 2002:a05:6214:4017:b0:443:e335:efd3 with SMTP id kd23-20020a056214401700b00443e335efd3mr3494688qvb.131.1649944324694;
        Thu, 14 Apr 2022 06:52:04 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id 14-20020a37090e000000b0069bfe98662csm999748qkj.17.2022.04.14.06.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:52:04 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/5] libsemanage/tests: Remove unused functions
Date:   Thu, 14 Apr 2022 09:51:41 -0400
Message-Id: <20220414135141.1723610-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414135141.1723610-1-jwcart2@gmail.com>
References: <20220414135141.1723610-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The functions helper_port_validate_local_proto(), get_type(), and
get_fcontext_new() are not used, so remove them.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsemanage/tests/test_fcontext.c | 31 ----------------
 libsemanage/tests/test_port.c     | 62 -------------------------------
 2 files changed, 93 deletions(-)

diff --git a/libsemanage/tests/test_fcontext.c b/libsemanage/tests/test_fcontext.c
index 5104989e..8943d741 100644
--- a/libsemanage/tests/test_fcontext.c
+++ b/libsemanage/tests/test_fcontext.c
@@ -73,28 +73,6 @@ static void test_fcontext_list_local(void);
 
 extern semanage_handle_t *sh;
 
-static int get_type(char *t)
-{
-	if (strcmp(t, "--") == 0)
-		return SEMANAGE_FCONTEXT_ALL;
-	else if (strcmp(t, "-f") == 0)
-		return SEMANAGE_FCONTEXT_REG;
-	else if (strcmp(t, "-d") == 0)
-		return SEMANAGE_FCONTEXT_DIR;
-	else if (strcmp(t, "-c") == 0)
-		return SEMANAGE_FCONTEXT_CHAR;
-	else if (strcmp(t, "-b") == 0)
-		return SEMANAGE_FCONTEXT_BLOCK;
-	else if (strcmp(t, "-s") == 0)
-		return SEMANAGE_FCONTEXT_SOCK;
-	else if (strcmp(t, "-l") == 0)
-		return SEMANAGE_FCONTEXT_LINK;
-	else if (strcmp(t, "-p") == 0)
-		return SEMANAGE_FCONTEXT_PIPE;
-	else
-		return -1;
-}
-
 static int write_file_contexts(const char *data, unsigned int data_len)
 {
 	FILE *fptr = fopen("test-policy/store/active/file_contexts", "w+");
@@ -187,15 +165,6 @@ int fcontext_add_tests(CU_pSuite suite)
 
 /* Helpers */
 
-static semanage_fcontext_t *get_fcontext_new(void)
-{
-	semanage_fcontext_t *fcontext;
-
-	CU_ASSERT_FATAL(semanage_fcontext_create(sh, &fcontext) >= 0);
-
-	return fcontext;
-}
-
 static semanage_fcontext_t *get_fcontext_nth(int idx)
 {
 	semanage_fcontext_t **records;
diff --git a/libsemanage/tests/test_port.c b/libsemanage/tests/test_port.c
index 19213f6d..e6393d78 100644
--- a/libsemanage/tests/test_port.c
+++ b/libsemanage/tests/test_port.c
@@ -863,68 +863,6 @@ static void helper_port_validate_local_twoports(void)
 	cleanup_handle(SH_TRANS);
 }
 
-static void helper_port_validate_local_proto(void)
-{
-	semanage_port_key_t *key1 = NULL;
-	semanage_port_key_t *key2 = NULL;
-	semanage_port_key_t *key3 = NULL;
-	semanage_port_t *port1 = NULL;
-	semanage_port_t *port2 = NULL;
-	semanage_port_t *port3 = NULL;
-	semanage_context_t *con1 = NULL;
-	semanage_context_t *con2 = NULL;
-	semanage_context_t *con3 = NULL;
-
-	/* setup */
-	setup_handle(SH_TRANS);
-
-	CU_ASSERT(semanage_port_key_create(sh, 101, 200, 0, &key1) >= 0);
-	CU_ASSERT(semanage_port_key_create(sh,  51, 250, 1, &key2) >= 0);
-	CU_ASSERT(semanage_port_key_create(sh, 201, 300, 0, &key3) >= 0);
-
-	CU_ASSERT(semanage_port_create(sh, &port1) >= 0);
-	CU_ASSERT(semanage_port_create(sh, &port2) >= 0);
-	CU_ASSERT(semanage_port_create(sh, &port3) >= 0);
-
-	semanage_port_set_range(port1, 101, 200);
-	semanage_port_set_range(port2,  51, 250);
-	semanage_port_set_range(port3, 201, 300);
-
-	semanage_port_set_proto(port1, 0);
-	semanage_port_set_proto(port2, 0);
-	semanage_port_set_proto(port3, 0);
-
-	CU_ASSERT(semanage_context_from_string(sh,
-			       "system_u:object_r:user_home_t:s0", &con1) >= 0);
-	CU_ASSERT(semanage_context_from_string(sh,
-			       "system_u:object_r:user_home_t:s0", &con2) >= 0);
-	CU_ASSERT(semanage_context_from_string(sh,
-				"system_u:object_r:user_tmp_t:s0", &con3) >= 0);
-
-	semanage_port_set_con(sh, port1, con1);
-	semanage_port_set_con(sh, port2, con2);
-	semanage_port_set_con(sh, port3, con3);
-
-	CU_ASSERT(semanage_port_modify_local(sh, key1, port1) >= 0);
-	CU_ASSERT(semanage_port_modify_local(sh, key2, port2) >= 0);
-	CU_ASSERT(semanage_port_modify_local(sh, key3, port3) >= 0);
-
-	/* test */
-	helper_commit();
-
-	/* cleanup */
-	CU_ASSERT(semanage_port_del_local(sh, key1) >= 0);
-	CU_ASSERT(semanage_port_del_local(sh, key2) >= 0);
-	CU_ASSERT(semanage_port_del_local(sh, key3) >= 0);
-	semanage_port_key_free(key1);
-	semanage_port_key_free(key2);
-	semanage_port_key_free(key3);
-	semanage_port_free(port1);
-	semanage_port_free(port2);
-	semanage_port_free(port3);
-	cleanup_handle(SH_TRANS);
-}
-
 static void test_port_validate_local(void)
 {
 	helper_port_validate_local_noport();
-- 
2.34.1

