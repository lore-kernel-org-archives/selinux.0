Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6555EB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGFOCl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGFOCk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:02:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BE1BD2
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:02:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so1080155e87.0
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688652158; x=1691244158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWL68vJ58sQTNpMR0md2KCO7W2kGqfI61ckHKiHWwYw=;
        b=JpHhbH7RK+jMgFxi1yVzMPG0pSDz2Qhf0g64LIHKuK8aZS5ggufvTX49ynlxZi0QYT
         7CMjvkPtTj4iw0jR3YWE/kcknVNnUVKx3N8M1BgO4eHTTA3NGexYI8/2HxI0pxAhH+/N
         D6G8/CLjFqhpUr1hk6KLLeX9qjhUDsiW+EdJMsCDNjKY3UsXOJlE66IerH5mweuSsLfj
         +EjBkrrEpj7X8yrY7ze8/XT/IbGKYm9SKNutcig2hc4U4mbxMq23/j6U65ZSc4PJB24c
         fVSTSoDrKbRoUFS2N0FHTBWsRaiD2pNe0xJezejit73oQN0eoDtHRYWAcStHQsOls2Cp
         6L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688652158; x=1691244158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWL68vJ58sQTNpMR0md2KCO7W2kGqfI61ckHKiHWwYw=;
        b=J8Xnno6h1oKHJA42PuX4fmtJwzrGkmEiFHkHhgWlqrb5bVMGrdfd7TAi8clO9qrKks
         sfIOYF3bAYgE1SQ8ff50XA8HHL9FSawNFzVVUbeHduQVQqeoAtk2L5ojeCoZyZmaJjil
         HafPbz5H4bY/BohQOs71LWVAakRuL7xTDMj27ZjFcCFbLhH0napYy2a8voOi0i3HUYRB
         iI/1wRJpLfl9sgnn74t6dJFGsl654d+2CZjlGxpW0pAmVGHJRUCV5Mi2fsU2WesusD8z
         IFn0eifx9yD9in88MOqEcYwJZ7QbimpKWm8DJsdhPT3KfXvA+MfoGcw3SxDHGQXFL2Dl
         8iqA==
X-Gm-Message-State: ABy/qLYgaUPWAaDQUFHgA+QhV0FCWxMi8w3KretDbPXBH/mmClKKnSLX
        6cebiiirzzOewVeaMmMmq8VCY/PJQBrV/rOq
X-Google-Smtp-Source: APBJJlHObrE/GFtzR0S74GxpO8DDZ6yRAvVb+vEf0ap2lAdAMpFngph3xtu0B0LT7cXBg07P1IiVTg==
X-Received: by 2002:a2e:93d0:0:b0:2b6:ef10:f018 with SMTP id p16-20020a2e93d0000000b002b6ef10f018mr1456757ljh.42.1688652157913;
        Thu, 06 Jul 2023 07:02:37 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090624c200b00965a4350411sm874678ejb.9.2023.07.06.07.02.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:02:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/fuzz: more strict fuzzing of binary policies
Date:   Thu,  6 Jul 2023 16:02:33 +0200
Message-Id: <20230706140233.45990-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Validate policy after optimizing.

Run policy assertion check, ignoring any assertions.

Abort on failures writing the parsed policy, as writing should not fail on
validated policies.

Set close-on-exec flag in case of any sibling thread.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/fuzz/binpolicy-fuzzer.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index 85c59645..79d42b0e 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -3,6 +3,8 @@
 #include <sepol/kernel_to_conf.h>
 #include <sepol/policydb/policydb.h>
 
+extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
+
 extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
 static int write_binary_policy(policydb_t *p, FILE *outfp)
@@ -38,18 +40,27 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	if (policydb_load_isids(&policydb, &sidtab))
 		goto exit;
 
-	if (policydb.policy_type == POLICY_KERN)
+	if (policydb.policy_type == POLICY_KERN) {
 		(void) policydb_optimize(&policydb);
 
-	devnull = fopen("/dev/null", "w");
+		if (policydb_validate(NULL, &policydb) == -1)
+			abort();
+	}
+
+	(void) check_assertions(NULL, &policydb, policydb.global->branch_list->avrules);
+
+	devnull = fopen("/dev/null", "we");
 	if (!devnull)
 		goto exit;
 
-	(void) write_binary_policy(&policydb, devnull);
+	if (write_binary_policy(&policydb, devnull))
+		abort();
 
-	(void) sepol_kernel_policydb_to_conf(devnull, &policydb);
+	if (sepol_kernel_policydb_to_conf(devnull, &policydb))
+		abort();
 
-	(void) sepol_kernel_policydb_to_cil(devnull, &policydb);
+	if (sepol_kernel_policydb_to_cil(devnull, &policydb))
+		abort();
 
 exit:
 	if (devnull != NULL)
-- 
2.40.1

