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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC70FC433E2
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB52B205CB
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZbaUC3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgEVOz4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbgEVOzr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 10:55:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583FFC061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:55:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i5so10882040qkl.12
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNLW+SpC8F1AjfW9/5EzZDT0ejjsZJs1zdPAZDXuqJQ=;
        b=sZbaUC3YjBufafwG1kQot7ChBcr3wdVSTc5khKBNbtMkFt3DE3qPG9u2Xj9ekik+ne
         4N9EpQSWTnzIbNJI9xrX1F91WkWJUY4NyIl3i0LeYdI9C9jBK1IsF+q+8DolLPpt6aIC
         VUEnQkHVECoNyuS/7Gmx+cgSUiACxhgB4XoJAVhtYjp0TT4K9kMmbKMOBpYd9aHetPht
         qD6BSWt06CLimURI4f3s+NsA9BZFr8uxkuvszEmal1R5hd/y4USzNE5GotwkBAiUbs08
         i/5rtpp/ghYdt4/qjP927yOwaJk3PtQbRgX/eqXli+ezAzrpAFtRd5bhhTisROjvaBrO
         wv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNLW+SpC8F1AjfW9/5EzZDT0ejjsZJs1zdPAZDXuqJQ=;
        b=P0daWokBXo3+6AR8+N0nBxF0SdRzAnH+mc3n3JOhbY53g2yqA3CSZf4vnlP9pkVQkp
         WXJoG6GR5eJZlHyKTzJookHRSMu5GZXbNt3AvQaPUlsBZQILFnI+YJnRpMHMluQp2+/p
         5ICFGde7j1PzmHRBeeVzQtUYQF/JRboyFiKlCRPYcJIXyO34szhZMBWLRznM578oz3+w
         NYzYZ3Pqjctsmfd5xCQtYaAa4hNgOgsnMKTU7jw1Cv1C1A1ehMqIKta817zP+uAh0NhY
         XWJTfJOUKpTaVFTnvC7B1fQo59pjdT1n6htszQ9KoRKKqUktVn/CLLEldItx6T9jiZ+3
         IxFw==
X-Gm-Message-State: AOAM53320/Hz8q2AaUyo0T53Q2NcacLo0myED74MFHABGkDRB4dQz9YO
        Xwa4MtXjsP4mjWHJwKJ/UbMsSOCFYUU=
X-Google-Smtp-Source: ABdhPJwltWhrIqqguB4+Xi3Ya+9YpNiBHROis6iJnc/0YCKRe+ETL4v5J/vBXvYaCSctnubDzSXG1g==
X-Received: by 2002:a05:620a:a93:: with SMTP id v19mr15297318qkg.416.1590159346330;
        Fri, 22 May 2020 07:55:46 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id 9sm7776479qko.29.2020.05.22.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:55:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 2/3] libsepol: Improve writing CIL sensitivity rules
Date:   Fri, 22 May 2020 10:55:12 -0400
Message-Id: <20200522145513.194440-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522145513.194440-1-jwcart2@gmail.com>
References: <20200522145513.194440-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Improves writing of CIL sensitivity rules when converting MLS kernel
policy to CIL. No changes to functionality, but eliminate useless
checks for sensitivity aliases when using the p_sens_val_to_name
array, find the actual number of aliases before allocating memory,
and skip the sensitivity alias rules if there are no aliases.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Add "__attribute__((unused))" to unused parameters as suggested by
    Nicolas Iooss

 libsepol/src/kernel_to_cil.c | 59 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index cca77251..b84da3e5 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -782,6 +782,17 @@ static void write_default_mls_level(FILE *out)
 	sepol_printf(out, "(level %s (s0))\n", DEFAULT_LEVEL);
 }
 
+static int map_count_sensitivity_aliases(__attribute__((unused)) char *key, void *data, void *args)
+{
+	level_datum_t *sens = data;
+	unsigned *count = args;
+
+	if (sens->isalias)
+		(*count)++;
+
+	return SEPOL_OK;
+}
+
 static int map_sensitivity_aliases_to_strs(char *key, void *data, void *args)
 {
 	level_datum_t *sens = data;
@@ -799,26 +810,13 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	level_datum_t *level;
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
 	/* sensitivities */
 	for (i=0; i < pdb->p_levels.nprim; i++) {
 		name = pdb->p_sens_val_to_name[i];
-		if (!name) continue;
-		level = hashtab_search(pdb->p_levels.table, name);
-		if (!level) {
-			rc = -1;
-			goto exit;
-		}
-		if (level->isalias) continue;
-
 		sepol_printf(out, "(sensitivity %s)\n", name);
 	}
 
@@ -827,14 +825,6 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
 	prev = NULL;
 	for (i=0; i < pdb->p_levels.nprim; i++) {
 		name = pdb->p_sens_val_to_name[i];
-		if (!name) continue;
-		level = hashtab_search(pdb->p_levels.table, name);
-		if (!level) {
-			rc = -1;
-			goto exit;
-		}
-		if (level->isalias) continue;
-
 		if (prev) {
 			sepol_printf(out, "%s ", prev);
 		}
@@ -845,6 +835,22 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
 	}
 	sepol_printf(out, "))\n");
 
+	rc = hashtab_map(pdb->p_levels.table, map_count_sensitivity_aliases, &num);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	if (num == 0) {
+		/* No aliases, so skip sensitivity alias rules */
+		rc = 0;
+		goto exit;
+	}
+
+	rc = strs_init(&strs, num);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = hashtab_map(pdb->p_levels.table, map_sensitivity_aliases_to_strs, strs);
 	if (rc != 0) {
 		goto exit;
@@ -852,16 +858,9 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	strs_sort(strs);
 
-	num = strs_num_items(strs);
-
 	/* sensitivity aliases */
 	for (i=0; i < num; i++) {
 		name = strs_read_at_index(strs, i);
-		level = hashtab_search(pdb->p_levels.table, name);
-		if (!level) {
-			rc = -1;
-			goto exit;
-		}
 		sepol_printf(out, "(sensitivityalias %s)\n", name);
 	}
 
-- 
2.25.4

