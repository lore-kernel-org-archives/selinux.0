Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F403BC4743D
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE3B610A2
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFHQB3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhFHQB2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE6C061574
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ce15so33436923ejb.4
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uYZQDgKuK3aWpLYQs8mqqUL/L969oc9TyAiq+YPfHF4=;
        b=Utp1bVygDJqSOaUF6eKd+4euE5e3syeydX2nUNCm6sEbcss/jUBd7Ahk2vXHumEuDG
         7Q3HDsKYmJxRN8SUDiCBrGf5HcSEMmfu1mtPfJc5xkz0/7GUpTbOqbaFkBmj7rHXG317
         mAhSjAo4HkyGPaPm6e2cXbefqMFq213gVZVRjuwFQV4Xi2jcjrgLC/nOufILWGCj2jre
         0qGZ8Yu64Sckq+qH3cDHEsuOsbftk55Rk1ekaxgikUR8U0Uzxn25qgCnQDcx/S5iTz+C
         zfuser0M+erur739uglIAXXZPTpkwry5fWSvSsTBs5r4R3+wGtXHoCF+le4U7zpOZlSG
         UhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYZQDgKuK3aWpLYQs8mqqUL/L969oc9TyAiq+YPfHF4=;
        b=peHH1ftfiwJicrA2h23uPMLSSsWyAod8jI5TOA10uBpxnY3vvM/lwY4GYTLMPCernJ
         UAKKSw4pVDb+iH7zHYt1ncA7XC44YXxgQC+DjiDmRrJLw8154iYYgCdsoOgL/3b9Stvk
         1TtlFRGCpb/Yjmv1pA+IP8/TWWqFw59C3QOZZfBxpdfPeuskkVZSEKK+CqK/yVhAucoW
         Rno5BF/wY6UGdusQu5mCtdyvPqeEcCiNqA9RC11S5Ryny3a1ElVj0mX7Cfxln6pAiGEe
         FIN9bRvPtqg/yctwmOzfMLz4/N0y1kAL4BewCnOFsMh4MNboyTw2tZybL80GAfQfxqfF
         kfeA==
X-Gm-Message-State: AOAM531PH3ppNkRjUDU+UBtdJvgrGUT0vr2l2WT4BUE0ol3MatEWvWQv
        3ItrwGJXiGS27OHRkq1oxyo6pN0+3zg=
X-Google-Smtp-Source: ABdhPJy6r2WwBL/dqd6TuwMk4Jbe9y+YrS017JCRAa8EBGWq8rA3mtZB6dTDN9uHwpFKQRPRNEu+EQ==
X-Received: by 2002:a17:906:3057:: with SMTP id d23mr24196100ejd.131.1623167962019;
        Tue, 08 Jun 2021 08:59:22 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 05/23] libsepol: avoid implicit conversions
Date:   Tue,  8 Jun 2021 17:58:54 +0200
Message-Id: <20210608155912.32047-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid implicit conversions from signed to unsigned values, found by
UB sanitizers, by using unsigned values in the first place.

expand.c:1644:18: runtime error: implicit conversion from type 'int' of value -1 (32-bit, signed) to type 'uint32_t' (aka 'unsigned int') changed the value to 4294967295 (32-bit, unsigned)

expand.c:2892:24: runtime error: implicit conversion from type 'int' of value -2 (32-bit, signed) to type 'unsigned int' changed the value to 4294967294 (32-bit, unsigned)

policy_define.c:2344:4: runtime error: implicit conversion from type 'int' of value -1048577 (32-bit, signed) to type 'unsigned int' changed the value to 4293918719 (32-bit, unsigned)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/conditional.h | 2 +-
 libsepol/include/sepol/policydb/policydb.h    | 2 +-
 libsepol/src/expand.c                         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
index 9c3df3ef..db3ef98d 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -90,7 +90,7 @@ typedef struct cond_node {
 	uint32_t expr_pre_comp;
 	struct cond_node *next;
 	/* a tunable conditional, calculated and used at expansion */
-#define	COND_NODE_FLAGS_TUNABLE	0x01
+#define	COND_NODE_FLAGS_TUNABLE	0x01U
 	uint32_t flags;
 } cond_node_t;
 
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 9ef43abc..c29339dc 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -253,7 +253,7 @@ typedef struct class_perm_node {
 
 #define xperm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
 #define xperm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
-#define xperm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
+#define xperm_clear(x, p) (p[x >> 5] &= ~(1U << (x & 0x1f)))
 #define EXTENDED_PERMS_LEN 8
 
 typedef struct av_extended_perms {
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 84bfcfa3..35e45780 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1641,7 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 		 * AUDITDENY, aka DONTAUDIT, are &= assigned, versus |= for
 		 * others. Initialize the data accordingly.
 		 */
-		avdatum.data = key->specified == AVTAB_AUDITDENY ? ~0 : 0;
+		avdatum.data = key->specified == AVTAB_AUDITDENY ? ~0U : 0U;
 		/* this is used to get the node - insertion is actually unique */
 		node = avtab_insert_nonunique(avtab, key, &avdatum);
 		if (!node) {
-- 
2.32.0

