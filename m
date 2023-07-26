Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061CCC41513
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjGZO0C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjGZO0A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:26:00 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B451B8
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:58 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-486487be6aeso481915e0c.1
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381557; x=1690986357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8XYB2wTHqEeTQIYLWcK3hZnQZBUmPmtBSTX1IvNBZY=;
        b=HjruF3Km6drLQBHohF9bMGENxxkvCTR/Pnyo63CSuPXpA9kFj+vGG1MlBYvWJhDkt4
         4o/ejsy1svGUVb7IkaWfss+Yi8lD8ySfVoCiGkT6FCG77xv07J8vT8ZzC9HIGScaRAP4
         1hZSfvEuAM20qOzxIrvwKZxYdvr4X8n8GaFAVnCWyz/NdINfvuAJSz7rNRhQIV3cUSwd
         HcnGNw1htX7HhormWToko1rm4iN2qDKLJGrtM3lrhuFaLczjg+eaMptk/p8JJTg2n5Mb
         7AtUKarCo94s754W9IK1p4Qyf+URQMAJgB9Xvqpb0EI9d+NTZP/LwtIxR5iJqcEB4ATQ
         9tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381557; x=1690986357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8XYB2wTHqEeTQIYLWcK3hZnQZBUmPmtBSTX1IvNBZY=;
        b=ioC7OeJhbbA8CvUkSy7UcZvYO9o8ha1sLrUUzvPFCaojHYSlY0AQCF6uat7Y6QdezX
         O/GK0qs2Be9oYgAEnf+3P9Nh6QyoskVt+y85BJ8WvUuUva6GSeAQqj8U6bBLUHebdSVL
         gungdUCly0Tq86FNlLuIbVwGZEJS0kWYnyY0FbOOAkTmpO/SHffBJ8CW1BET0y5wofbV
         f2ZZhkYHoex9nTLL+LBpi9o1UgCI8ZzO7kvhycEbyhHwWmsKu3QPr/qRyYz1S0aWqyBZ
         DznT/c07ZeHA3iPDLSh8JXTaYVY3Y80OO4rR/cWjkYxk1jkweenhaGHIscAqMPxY0KcE
         te8g==
X-Gm-Message-State: ABy/qLYtsh+KxSuiIZDbbx4ug0UgeDoX6YTAEN4WAID6hYZxJ3MDzXNS
        A2yd3LVaWveTy1oO4GHeuuCT2817wRvFmg==
X-Google-Smtp-Source: APBJJlEGWGOIJaTy6wy53sCBzQUCIPrsLRKG+601tfxDlNOFuCi+ZE0mS4vuM9Xh6g06ti+34JuD+g==
X-Received: by 2002:a1f:bfd7:0:b0:486:4a16:63c6 with SMTP id p206-20020a1fbfd7000000b004864a1663c6mr868877vkf.15.1690381557309;
        Wed, 26 Jul 2023 07:25:57 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:56 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/8] Revert "libsepol: implement new module binary format of avrule"
Date:   Wed, 26 Jul 2023 10:25:45 -0400
Message-ID: <20230726142549.94685-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit 11013986ac484586e50ce318f4f10c1edf39e746.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/include/sepol/policydb/policydb.h |  3 +--
 libsepol/src/policydb.c                    | 28 ----------------------
 libsepol/src/write.c                       | 24 +++----------------
 3 files changed, 4 insertions(+), 51 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 5efd0a47..528c1cad 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -749,10 +749,9 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_INFINIBAND		19
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
-#define MOD_POLICYDB_VERSION_AVRULE_FTRANS	22
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_AVRULE_FTRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 37bb97a1..b15d4163 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -341,13 +341,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-	 .type = POLICY_BASE,
-	 .version = MOD_POLICYDB_VERSION_AVRULE_FTRANS,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_IBENDPORT + 1,
-	 .target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -474,13 +467,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-	 .type = POLICY_MOD,
-	 .version = MOD_POLICYDB_VERSION_AVRULE_FTRANS,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = 0,
-	 .target_platform = SEPOL_TARGET_SELINUX,
-	},
 };
 
 #if 0
@@ -3216,19 +3202,6 @@ static avrule_t *avrule_read(policydb_t * p, struct policy_file *fp)
 		tail = cur;
 	}
 
-	if (p->policyvers >= MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
-	    avrule->specified & AVRULE_TRANSITION) {
-		rc = next_entry(buf, fp, sizeof(uint32_t));
-		if (rc < 0)
-			goto bad;
-		len = le32_to_cpu(*buf);
-		if (len) {
-			rc = str_read(&avrule->object_name, fp, len);
-			if (rc < 0)
-				goto bad;
-		}
-	}
-
 	if (avrule->specified & AVRULE_XPERMS) {
 		uint8_t buf8;
 		size_t nel = ARRAY_SIZE(avrule->xperms->perms);
@@ -3660,7 +3633,6 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 	}
 
 	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
 	    filename_trans_rule_read(p, &decl->avrules, fp))
 		return -1;
 
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index d7f47c8d..68495198 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2025,9 +2025,8 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
 
-	/* skip filename transitions if writing older version without name */
-	if (p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
-	    avrule->specified & AVRULE_TRANSITION && avrule->object_name)
+	/* skip filename transitions for now */
+	if (avrule->specified & AVRULE_TRANSITION && avrule->object_name)
 		return POLICYDB_SUCCESS;
 
 	if (p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
@@ -2074,21 +2073,6 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 		cur = cur->next;
 	}
 
-	if (p->policyvers >= MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
-	    avrule->specified & AVRULE_TRANSITION) {
-		len = avrule->object_name ? strlen(avrule->object_name) : 0;
-		*buf = cpu_to_le32(len);
-		items = put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return POLICYDB_ERROR;
-		if (avrule->object_name) {
-			items = put_entry(avrule->object_name, sizeof(char),
-					  len, fp);
-			if (items != len)
-				return POLICYDB_ERROR;
-		}
-	}
-
 	if (avrule->specified & AVRULE_XPERMS) {
 		size_t nel = ARRAY_SIZE(avrule->xperms->perms);
 		uint32_t buf32[nel];
@@ -2138,8 +2122,7 @@ static int avrule_write_list(policydb_t *p, avrule_t * avrules,
 	avrule = avrules;
 	len = 0;
 	while (avrule) {
-		if (p->policyvers >= MOD_POLICYDB_VERSION_AVRULE_FTRANS ||
-		    !(avrule->specified & AVRULE_TRANSITION &&
+		if (!(avrule->specified & AVRULE_TRANSITION &&
 		      avrule->object_name))
 			len++;
 		avrule = avrule->next;
@@ -2374,7 +2357,6 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
 	}
 
 	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
 	    filename_trans_rule_write(p, decl->avrules, fp))
 		return POLICYDB_ERROR;
 
-- 
2.41.0

