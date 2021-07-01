Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EF4C11F69
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A396140D
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhGASJZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhGASJZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jul 2021 14:09:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C8C061762
        for <selinux@vger.kernel.org>; Thu,  1 Jul 2021 11:06:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hc16so11844876ejc.12
        for <selinux@vger.kernel.org>; Thu, 01 Jul 2021 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EDR7r8X+zg8tVYrF82O22BNiqzleBwAjlVKhdZLkyrY=;
        b=KUhKnXcLwd/t0MUOF9SF6uA9PbPSxpmyvkHtLabievyPlEqJqmg9pC8dGDxzwXMdWQ
         oX8T5qGaK+mwTPXUQTfgan6W4GW3FsZF31FFpet0hT4h0gDolOBtEd0OK9phxs1mw6tg
         FVcFmXQltdKt+w6v0LMAwAvcOsdxcNSXo84ulCYJrVVRGH02/I1BUKvhS57a87H59dER
         GF8OOM0etw5rJa3rzIK8X2aUDn3pfbu5hG6mFD8sAcEIKSkvP98JAczVgw6TURBMYV8u
         8WTvvsvdn4WFVry6oHTGdIyQ+WsnebximXi8KZlqmN3nl3eHRKkWk7ea6PmGT+HlMDDl
         XWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDR7r8X+zg8tVYrF82O22BNiqzleBwAjlVKhdZLkyrY=;
        b=jKj185Z1SMH0buRJWmizoKIFlTZ3PVfD8RK8PcFI7bj/0cLNUbv55Ls+0k/1o4g8x7
         oWS+bv/rXqgK7KofGsLWG9ZCzCcI671uS2wIoydNmIowAUmOWqUHYBKv/X4y3W48IYdR
         DEvsQje8vgTea0Ji7485elUEF7PB0XOPA+ty/aRw8p6xNRB1UI8q/x9ShtTitT0in8XK
         cgSXhxZEDcF/7HksragWp7ZIL0WI/lQ++uzeDralsUZ41ofkAbEq7wj0eU2D46RRSc07
         OTg04DsOfQkzD5hxMrHBqq7/Hfv9MRQaYWzOve6TZforLGFwJXUyylroAhP2Ikmy1+hk
         5RGg==
X-Gm-Message-State: AOAM530tIiE2TfXU2H4rnN27KmL+d6rXEZn6Z2ia64r3DHpPJWEWkEHO
        c2J3+ZSsiO9u4yyRKsIxlScSqEITZW8=
X-Google-Smtp-Source: ABdhPJxZQMPcCeyF/Yl7q2fYxUnYsBBDvq1zsMvDgAPiFresZFbj4nI6GZDT2TA8igye/aEMYZ6WLg==
X-Received: by 2002:a17:906:2b85:: with SMTP id m5mr1238414ejg.141.1625162812011;
        Thu, 01 Jul 2021 11:06:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-223-136.77.6.pool.telefonica.de. [77.6.223.136])
        by smtp.gmail.com with ESMTPSA id y6sm236118edr.65.2021.07.01.11.06.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:06:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/3] libsepol: avoid implicit conversions
Date:   Thu,  1 Jul 2021 20:06:45 +0200
Message-Id: <20210701180645.120082-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-6-cgzones@googlemail.com>
References: <20210608155912.32047-6-cgzones@googlemail.com>
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
v2:
  - use UINT32_C as suggested by Ondrej Mosnacek 

 libsepol/include/sepol/policydb/conditional.h | 2 +-
 libsepol/include/sepol/policydb/policydb.h    | 6 +++---
 libsepol/src/expand.c                         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
index 9c3df3ef..49c0d766 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -90,7 +90,7 @@ typedef struct cond_node {
 	uint32_t expr_pre_comp;
 	struct cond_node *next;
 	/* a tunable conditional, calculated and used at expansion */
-#define	COND_NODE_FLAGS_TUNABLE	0x01
+#define	COND_NODE_FLAGS_TUNABLE	UINT32_C(0x01)
 	uint32_t flags;
 } cond_node_t;
 
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 6976ef48..4bf9f05d 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -251,9 +251,9 @@ typedef struct class_perm_node {
 	struct class_perm_node *next;
 } class_perm_node_t;
 
-#define xperm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
-#define xperm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
-#define xperm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
+#define xperm_test(x, p) (UINT32_C(1) & (p[x >> 5] >> (x & 0x1f)))
+#define xperm_set(x, p) (p[x >> 5] |= (UINT32_C(1) << (x & 0x1f)))
+#define xperm_clear(x, p) (p[x >> 5] &= ~(UINT32_C(1) << (x & 0x1f)))
 #define EXTENDED_PERMS_LEN 8
 
 typedef struct av_extended_perms {
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 84bfcfa3..aac5b35f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1641,7 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 		 * AUDITDENY, aka DONTAUDIT, are &= assigned, versus |= for
 		 * others. Initialize the data accordingly.
 		 */
-		avdatum.data = key->specified == AVTAB_AUDITDENY ? ~0 : 0;
+		avdatum.data = key->specified == AVTAB_AUDITDENY ? ~UINT32_C(0) : UINT32_C(0);
 		/* this is used to get the node - insertion is actually unique */
 		node = avtab_insert_nonunique(avtab, key, &avdatum);
 		if (!node) {
-- 
2.32.0

