Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F44C433EF
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiAKVzK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFBBC0611FF
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:01 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id h16so398544qkp.3
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kSJJxbqAqd96eKdMqq1E9ZVWmim7jioRfBH3JX0prX0=;
        b=Alu/yVvZppm7spUfTbT+tNQp2NcGGL8yJN4isnsVnNzZaFyzfcQVdWbfpBOCTfow0v
         eMJ47KkbB48WfgTlTffzddEIXFCgFV68EWDh8OStIKsqZEUJOqnjDTn02e7kq51eVrEi
         Ssrr7dJ3yW5sg0HGyUTScCTJ1ik0VhxglBsfcMlsbpXtE7F2XTKu2tGpds4pCtP6dbUZ
         Y4F4G5VB3QOWIB42nZhuh/h9Iu6p9fAffbvC2ghi9OIHy/4CwVahpA4QiT9onaPaY7aK
         VmoexBNG+LEqQpxWtDf3wJMUC3RHdp5bH7ad0S6X9g9CBlx/r2tzlylomXBOZvmS+MG5
         Tecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSJJxbqAqd96eKdMqq1E9ZVWmim7jioRfBH3JX0prX0=;
        b=BUwpH8H46fh4pSjt8cbHumPwtRSArFtk0WgVog4mUQWCFqXyPprP2WUi4n0w4JUZm/
         iN+lWbV02bitb5a2T3Jq9IQ93We/Xf+3rJEbo73U1Mk74flBYpm6ivEZ9DvI538WKR+3
         nAIUjqg2n1vtA48ASLJKcJi4CXO4ar/o7HLE/ci/HezcCfGevAAaMMcanvgx4nZY6lOS
         onF7sUjCeMKZhwjw70WaIXe2Xz2LDAtWLBGJxytQ3CZNnmtvd0we6xTzDBZDC1YYMu9d
         UKzGUOYJbJseNlUKl/TL2mkYt9oLWcxYqyEtcw7ZpnZyoaoUrEsohPLKoiw+7HXOFJw4
         4LvQ==
X-Gm-Message-State: AOAM530stFsNxx2XzgaXMFEBG/OdmHsvpRMnkbT8SDVq4VsEPTbD8FDS
        k7sinDrKB1g0L8juVBCkx8rTgO1yfVg=
X-Google-Smtp-Source: ABdhPJyY8StStJ1f4dqGCzb26HQDz8iQlw2tZChbUrFurJy5a+mkxLLvzeLRW7xN4MURmbaAiweOLQ==
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr4662440qke.480.1641938101063;
        Tue, 11 Jan 2022 13:55:01 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:00 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 08/16 v2] libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
Date:   Tue, 11 Jan 2022 16:54:38 -0500
Message-Id: <20220111215446.595516-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Inorder to differentiate errors from matches, use "(rc < 0)" when
calling ebitmap_* functions while checking neverallow rules.

Also, just use rc instead of having a separate variable (ret) in
check_assertion_extended_permissions().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 44 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 6881c5f6..b48169ef 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -231,27 +231,27 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 
 	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
 			 &p->attr_type_map[k->source_type - 1]);
-	if (rc)
+	if (rc < 0)
 		goto oom;
 
 	if (ebitmap_is_empty(&src_matches))
 		goto exit;
 
 	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
-	if (rc)
+	if (rc < 0)
 		goto oom;
 
 	if (avrule->flags == RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
-		if (rc)
+		if (rc < 0)
 			goto oom;
 		rc = ebitmap_and(&self_matches, &avrule->stypes.types, &matches);
-		if (rc)
+		if (rc < 0)
 			goto oom;
 
 		if (!ebitmap_is_empty(&self_matches)) {
 			rc = ebitmap_union(&tgt_matches, &self_matches);
-			if (rc)
+			if (rc < 0)
 				goto oom;
 		}
 	}
@@ -299,11 +299,11 @@ static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avru
 	args.errors = 0;
 
 	rc = avtab_map(&p->te_avtab, report_assertion_avtab_matches, &args);
-	if (rc)
+	if (rc < 0)
 		goto oom;
 
 	rc = avtab_map(&p->te_cond_avtab, report_assertion_avtab_matches, &args);
-	if (rc)
+	if (rc < 0)
 		goto oom;
 
 	return args.errors;
@@ -379,7 +379,6 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	ebitmap_node_t *snode, *tnode;
 	class_perm_node_t *cp;
 	int rc;
-	int ret = 1;
 
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
@@ -388,56 +387,61 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 
 	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
 			 &p->attr_type_map[k->source_type - 1]);
-	if (rc)
+	if (rc < 0)
 		goto oom;
 
-	if (ebitmap_is_empty(&src_matches))
+	if (ebitmap_is_empty(&src_matches)) {
+		rc = 0;
 		goto exit;
+	}
 
 	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types,
 			 &p->attr_type_map[k->target_type -1]);
-	if (rc)
+	if (rc < 0)
 		goto oom;
 
 	if (avrule->flags == RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1],
 				&p->attr_type_map[k->target_type - 1]);
-		if (rc)
+		if (rc < 0)
 			goto oom;
 		rc = ebitmap_and(&self_matches, &avrule->stypes.types, &matches);
-		if (rc)
+		if (rc < 0)
 			goto oom;
 
 		if (!ebitmap_is_empty(&self_matches)) {
 			rc = ebitmap_union(&tgt_matches, &self_matches);
-			if (rc)
+			if (rc < 0)
 				goto oom;
 		}
 	}
 
-	if (ebitmap_is_empty(&tgt_matches))
+	if (ebitmap_is_empty(&tgt_matches)) {
+		rc = 0;
 		goto exit;
+	}
 
 	for (cp = avrule->perms; cp; cp = cp->next) {
 		if (cp->tclass != k->target_class)
 			continue;
 		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
-				ret = check_assertion_extended_permissions_avtab(
-						avrule, avtab, i, j, k, p);
-				if (ret)
+				if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
+					rc = 1;
 					goto exit;
+				}
 			}
 		}
 	}
-	goto exit;
+
+	rc = 0;
 
 oom:
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
 	ebitmap_destroy(&matches);
-	return ret;
+	return rc;
 }
 
 static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule, policydb_t *p)
-- 
2.31.1

