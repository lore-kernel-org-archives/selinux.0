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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E39C433DF
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F2F204EA
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQqvetQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgEUPZu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 11:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgEUPZq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 11:25:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E855DC061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 08:25:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w3so2048278qkb.6
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pueDequ/3r0EC91R2eIjkfDkG4GVBlAfywCl/EUx9ik=;
        b=FQqvetQBBarQ3QWGtHyreGREG5nBq2hyUoS4in2ie6XCaGAUx0ZMlvgQo1htmLbN0O
         s6H0o/i1qdHPr7Tdv2XqivwSecqu1THTbq7a/dr58cmF/+dBLZe2vMhJAVV3rDUC6sFN
         ULUdISusESmgpdyvSTHDx3HQCih4rERzVn1DmDcxCKB4jC3MzG2vPTFaNuHFMHpkdLkK
         0A4y+WNzTQFUigoLwkGVI1EAdUTicSfsptQfyO5wozqkxAugdiVX4HDvefjfDJuzvKlL
         ualvMTiL8sQ03CmGZJy9KR+qdVVjbTRMJWyjYPW5cM5iachoL0cnptvc8CvhG/j/+cnG
         H1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pueDequ/3r0EC91R2eIjkfDkG4GVBlAfywCl/EUx9ik=;
        b=fxe8YmQeYiEWC6NDNzjjyOKNYioZPo8b5sv6nruoKWaRqWrN/LWy9Ox5VJR4fxZg83
         oG4biG7PSQzVLcIVxlzt1sHoDUQVLkecBRcJAOSWnF5oWGeT1w/UmlIilRJfAXynICGw
         tWFRPmFqRV5Ik0cwqpHfHXRHbeWviDYQlsfbTIdYx49Jy1TWaK9MZJXaTAG+jCutYtME
         KEmh7J8i5crBZOj4hrkQle7ruPGkYdDXBOVNvdI/x8Vc5Klf/PBMhpYtH4oDKdlx6AIM
         WqdAc0NoyS8x7LbDJvOzWBcn1gBHNbvfcgigSH46BD+iV2vaXfIymW6723PnlNenUPLF
         EuCg==
X-Gm-Message-State: AOAM531w/MR5tulD5pKSHzxLmGSFoMQJ6elsCfm4y70gYY7xBsRTeUjk
        N0N0VI3/GtfmHHxp+wX+WvJwNHyqQQM=
X-Google-Smtp-Source: ABdhPJxvFpw3Y+Zcx0dUrAEtIWfWP3izA9faE7J6Dwv8o7e5cuwrgUXZW77MX3fsFiYLiLQPMdPwdw==
X-Received: by 2002:a37:b185:: with SMTP id a127mr10273847qkf.87.1590074745024;
        Thu, 21 May 2020 08:25:45 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id z19sm5840135qtz.81.2020.05.21.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:25:44 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol: Improve writing CIL sensitivity rules
Date:   Thu, 21 May 2020 11:24:47 -0400
Message-Id: <20200521152448.148333-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521152448.148333-1-jwcart2@gmail.com>
References: <20200521152448.148333-1-jwcart2@gmail.com>
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
 libsepol/src/kernel_to_cil.c | 59 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index cca77251..6103c1a6 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -782,6 +782,17 @@ static void write_default_mls_level(FILE *out)
 	sepol_printf(out, "(level %s (s0))\n", DEFAULT_LEVEL);
 }
 
+static int map_count_sensitivity_aliases(char *key, void *data, void *args)
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

