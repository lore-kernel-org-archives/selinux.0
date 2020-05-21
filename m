Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D48C433E3
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408AB20826
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 15:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic9wPvAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgEUPZ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbgEUPZz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 11:25:55 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA6EC061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 08:25:55 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d7so5723830qtn.11
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtfdXbFn2o3ZbJ67xT/SXkoVhP8jAGbq6xyqPrJ1CrU=;
        b=Ic9wPvAw5LejdFfTGiCfPHQjVIQaJ2t7ypdZRRtL8pDa7geiQkxzRH7/+HSx/XAqup
         y8PNjdHMxVHUSFSQF5rtzi1Z4z0RcGR3zDYhc47dkH/G111Nx8X+2DQtN6Xw+dZqxE2V
         pAJEYo7jgh8hkVRCzZ2Qia5hVXWthwe/5NT7cWPVUGz2NpAmY/05qu2i+aKzuyh7NoK6
         J+ka97pRjXUeQj/rSBx3hxRSSSOXCKjM+5qtnqAgCnn4ZVTE82ilB1BaM5MOzNvdpDHp
         g9gs0m4PxtiGgnatPscsCrPLUfZ+0/KjQd01bEBH3vG7J2rBRFY9kwO0vfTMmahHUCYE
         R1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtfdXbFn2o3ZbJ67xT/SXkoVhP8jAGbq6xyqPrJ1CrU=;
        b=dq4spKlF53JpxRhmVqkwYA229SaOPA0Q8dRkY/LH54P7DndcC22r+UmNj6P8uxo/iO
         2BRVVpJHI5ocPcUXR9OljEsxM7Fzk6n+xR+UzLHgHrxQaLyMvitQdesbq9Zw2NIxYRBF
         8n9NGm+i3vgrZnqQuBelgY1qnpLaj/uaNFSXZwHJRV3/SXDpETrrH/3Gtu3/vLD0UcsZ
         xYctJ7ar3a2K4RUtPJKwmoGCDgrEq1ckmc8Ma28oCkAqF1op0U38W5BAMMQmQGWLo3tp
         wc0+sTK6Ag0jdSrC98LEESGV9R7JSwnpplvMjDvrcWbkgdYwU/7AbYDTYsO7ERLEhq6V
         CteA==
X-Gm-Message-State: AOAM5318bDyhFniksIOVgvQiboAAY2WKOzK+Yy2JP2VL+NHRtZlQodxO
        e2yr+2tKBuzw+WPsj7XhDbNae9VSu5s=
X-Google-Smtp-Source: ABdhPJy4jmiTp2QZM4s0ywPDiIp3wbC5VGuHjqqrm12gbW3PMKMpZ70rcb5dHRe7wa46EQ9MnrBlcA==
X-Received: by 2002:ac8:60d4:: with SMTP id i20mr11113515qtm.324.1590074754409;
        Thu, 21 May 2020 08:25:54 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id z19sm5840135qtz.81.2020.05.21.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:25:54 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol: Improve writing CIL category rules
Date:   Thu, 21 May 2020 11:24:48 -0400
Message-Id: <20200521152448.148333-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521152448.148333-1-jwcart2@gmail.com>
References: <20200521152448.148333-1-jwcart2@gmail.com>
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
 libsepol/src/kernel_to_cil.c | 59 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 6103c1a6..319f3641 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -886,6 +886,17 @@ exit:
 	return rc;
 }
 
+static int map_count_category_aliases(char *key, void *data, void *args)
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

