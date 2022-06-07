Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D77C43334
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 15:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiFGPB5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiFGPB5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 11:01:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2C36B60
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 08:01:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v25so23394331eda.6
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fhdo6t0AgySV89c6Tu3foX4/jnq002/77ckkzUgCbg4=;
        b=BBDEq6AkPJ+0ONH0pReqCr45alx0Zb1kXRvXzD74oMAb9+flqMIXx0W05P+kON2hcz
         6yAxaEKsqnoXJB4qk31/JI8/JgRK2Mu/9jmw++yBUVuMA7bKd63mU2/FBCCL9b7DCku0
         Kvj6OGO0owdOasZ6BdLLpdKGWz7P3kywmC/vw+A5hQ/B1qKKmJ0YBDGZuwFBuzW1Fz2i
         r4//bwd6gM/ur/aF9KArS+CTNlZ9I60NmVJPye/GhivV0nX18PhPs8M4RQ32dwIyWYJR
         f+1ZaVZeOAaQ3+QI8+U/CMQc3NYjzYZ7lidwmmQIiTugZSOKhpOVZta0opc9PqWb1jZg
         6EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fhdo6t0AgySV89c6Tu3foX4/jnq002/77ckkzUgCbg4=;
        b=jEmxLwnFrwTmu9fpbCnbXD8JSuBgtRz6VjjGj5LumrYPXv/Zvg+/240TlkUGSkNYOR
         p5yXtT2uCQWDeTntZp9KQ79Fmi5rLWv94z0Mw+Hf5PaPO4C/EXDU4z3MX2HFBlBYO0ng
         UksFKBXvlx+OYA4tmsNv8Qwi9HOSuceR00j16r6jgGkAr8L3cLJMWynXymDeGMyHU+OH
         CpQFnuGZi8dTVkwBUXHdnd9yBT1JERyyiiFXmMQH0XJs7KRsE0BDJxU3WfojuUwNihml
         GIYf3EJV1dZnRW63/rJQGSFxxae90A219G6icOd3WvTuEt3b56SF49IMM4RxgMl1P0av
         WMjQ==
X-Gm-Message-State: AOAM530zqYe+J9QzpKgyBMeRP/pLvdAmOfA+uLlaFpworrKLICUfVypA
        KzriKlnByktIVB3DsIr2Zw454uTG4go=
X-Google-Smtp-Source: ABdhPJxrAU7vq7OqlrihoHaou685NDJr0P/ZBKggXu4LMN+PdUh0BUk5RV1t/RGeQyqEvSkPofCPDg==
X-Received: by 2002:a05:6402:1d48:b0:42d:d1a2:7c6d with SMTP id dz8-20020a0564021d4800b0042dd1a27c6dmr34288764edb.43.1654614113558;
        Tue, 07 Jun 2022 08:01:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id v7-20020aa7d647000000b0042bd2012196sm10456130edr.85.2022.06.07.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:01:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@gmail.com>
Subject: [PATCH] libsepol: fix validation of user declarations in modules
Date:   Tue,  7 Jun 2022 17:01:45 +0200
Message-Id: <20220607150145.29757-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Users are allowed to be declared in modules. Modules do not get expanded
leaving the `struct user_datum` members `exp_range` and `exp_dfltlevel`
empty.
Do no validate the expanded range and level for modular polices.

Reported-by: bauen1 <j2468h@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index da18282b..99d4eb7f 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -18,7 +18,7 @@ typedef struct validate {
 typedef struct map_arg {
 	validate_t *flavors;
 	sepol_handle_t *handle;
-	int mls;
+	policydb_t *policy;
 } map_arg_t;
 
 static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitmap_t *gaps)
@@ -571,7 +571,7 @@ static int validate_mls_range(mls_range_t *range, validate_t *sens, validate_t *
 	return -1;
 }
 
-static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], int mls)
+static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], policydb_t *p)
 {
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
@@ -581,9 +581,9 @@ static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, valid
 		goto bad;
 	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
-	if (mls && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
-	if (mls && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
 	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
@@ -599,7 +599,7 @@ static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 {
 	map_arg_t *margs = args;
 
-	return validate_user_datum(margs->handle, d, margs->flavors, margs->mls);
+	return validate_user_datum(margs->handle, d, margs->flavors, margs->policy);
 }
 
 static int validate_bool_datum(sepol_handle_t *handle, cond_bool_datum_t *boolean, validate_t flavors[])
@@ -689,7 +689,7 @@ static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum
 
 static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
-	map_arg_t margs = { flavors, handle, p->mls };
+	map_arg_t margs = { flavors, handle, p };
 
 	if (hashtab_map(p->p_commons.table, validate_common_datum_wrapper, &margs))
 		goto bad;
-- 
2.36.1

