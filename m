Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4661AC433DF
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F2207FB
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K07mGI58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgEVOzy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731376AbgEVOzx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 10:55:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15435C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:55:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n11so5473024qkn.8
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IK7yvVYrYBCnqwQZV3pANWDC3Repl+X0w5xkoElFxNw=;
        b=K07mGI58OsqsAQ2T1MOVS3Cq78fEfrure1aNp2TzCDKlbUKSAmVlnPAoU+0W1yjDfn
         aO3lKUQPVdgBWq224DSECX3HrF+3wFc9xct4BEg7Sky7ZH0bwCVK81C1s3N2zgPoLKgn
         0v1YFR7vzJyJPvsvzu6KD1xllOjWIGq+wWDk3Bs+uLg6bV6WAr6PMtf0vWESRUYBqGnU
         skWyrly7uCdUgoyd1mc8PSpyRbR4aGaobwDtO6PmXWrfCruCfRf9Gw9mCuywkp4zdbOg
         Fwykr7Ikp87N33oKJ3r6PpCaeHWb0P9Gpx1ZWPy+/TJhfh9HFj3/XqCQ3DvKJ/bqqliB
         +84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IK7yvVYrYBCnqwQZV3pANWDC3Repl+X0w5xkoElFxNw=;
        b=WeGHCJVYqBOi95bH1kk4cZFDe+STiKoZpA25SW3Boj2YjDBa4BnEwWjC3nhJ45bZo7
         uYB29AeFtI65uLgyKJCIibgs7boz1von+vgr46ahB9u6te1JCnm6cribfVxO65tE7qHr
         mcBiH6zUlD0DSe3J4X+smvFiEiJ8HPbLXCZxVc5d6BIPT6Ienw17NCCYM2U/Krr2GYJy
         NLu+2nTKi+S0vZit7hTFR03Rq2XLCTlEcXLAXVecsDQ8o7RjW1aS1Hz0wSCo9ZIMGA1L
         RVhdfAvhPQYt7U6OiwWeWToAVn2XGae+T4bfnny6oqr0ulxVZChqtzH8adgLmqTzoV7j
         DaNg==
X-Gm-Message-State: AOAM531E8JU7qMnFK4p4AvipRonviqGOZLaTdQ/PF0OeyTHv4L38N7+C
        GSy/TlaX75ks/5CKjD9wj9Ic4iCjiqI=
X-Google-Smtp-Source: ABdhPJyUaGopA+dF+00b2h76oN+emKARB8PxVvMUEEEDoWX3GFY0F/QrL8Cow/YcfHSelS+68myuJA==
X-Received: by 2002:a37:2711:: with SMTP id n17mr15402699qkn.430.1590159352105;
        Fri, 22 May 2020 07:55:52 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id 9sm7776479qko.29.2020.05.22.07.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:55:51 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 3/3] libsepol: Improve writing CIL category rules
Date:   Fri, 22 May 2020 10:55:13 -0400
Message-Id: <20200522145513.194440-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522145513.194440-1-jwcart2@gmail.com>
References: <20200522145513.194440-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Improves writing of CIL category rules when converting MLS kernel
policy to CIL. No changes to functionality, but eliminate useless
checks for category aliases when using the p_cat_val_to_name array,
find the actual number of aliases before allocating memory, and
skip the category alias rules if there are no aliases.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Add "__attribute__((unused))" to unused parameters as suggested by
    Nicolas Iooss

 libsepol/src/kernel_to_cil.c | 59 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index b84da3e5..36c6c682 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -886,6 +886,17 @@ exit:
 	return rc;
 }
 
+static int map_count_category_aliases(__attribute__((unused)) char *key, void *data, void *args)
+{
+	cat_datum_t *cat = data;
+	unsigned *count = args;
+
+	if (cat->isalias)
+		(*count)++;
+
+	return SEPOL_OK;
+}
+
 static int map_category_aliases_to_strs(char *key, void *data, void *args)
 {
 	cat_datum_t *cat = data;
@@ -903,26 +914,13 @@ static int write_category_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	cat_datum_t *cat;
 	char *prev, *name, *actual;
-	struct strs *strs;
-	unsigned i, num;
+	struct strs *strs = NULL;
+	unsigned i, num = 0;
 	int rc = 0;
 
-	rc = strs_init(&strs, pdb->p_levels.nprim);
-	if (rc != 0) {
-		goto exit;
-	}
-
 	/* categories */
 	for (i=0; i < pdb->p_cats.nprim; i++) {
 		name = pdb->p_cat_val_to_name[i];
-		if (!name) continue;
-		cat = hashtab_search(pdb->p_cats.table, name);
-		if (!cat) {
-			rc = -1;
-			goto exit;
-		}
-		if (cat->isalias) continue;
-
 		sepol_printf(out, "(category %s)\n", name);
 	}
 
@@ -931,14 +929,6 @@ static int write_category_rules_to_cil(FILE *out, struct policydb *pdb)
 	prev = NULL;
 	for (i=0; i < pdb->p_cats.nprim; i++) {
 		name = pdb->p_cat_val_to_name[i];
-		if (!name) continue;
-		cat = hashtab_search(pdb->p_cats.table, name);
-		if (!cat) {
-			rc = -1;
-			goto exit;
-		}
-		if (cat->isalias) continue;
-
 		if (prev) {
 			sepol_printf(out, "%s ", prev);
 		}
@@ -949,6 +939,22 @@ static int write_category_rules_to_cil(FILE *out, struct policydb *pdb)
 	}
 	sepol_printf(out, "))\n");
 
+	rc = hashtab_map(pdb->p_cats.table, map_count_category_aliases, &num);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	if (num == 0) {
+		/* No aliases, so skip category alias rules */
+		rc = 0;
+		goto exit;
+	}
+
+	rc = strs_init(&strs, num);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = hashtab_map(pdb->p_cats.table, map_category_aliases_to_strs, strs);
 	if (rc != 0) {
 		goto exit;
@@ -956,16 +962,9 @@ static int write_category_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	strs_sort(strs);
 
-	num = strs_num_items(strs);
-
 	/* category aliases */
 	for (i=0; i < num; i++) {
 		name = strs_read_at_index(strs, i);
-		cat = hashtab_search(pdb->p_cats.table, name);
-		if (!cat) {
-			rc = -1;
-			goto exit;
-		}
 		sepol_printf(out, "(categoryalias %s)\n", name);
 	}
 
-- 
2.25.4

