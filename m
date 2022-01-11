Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA7AC43217
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiAKVzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD7EC034001
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:03 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s19so848823qtc.5
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5T03bEnp5V21xYQMv2byghA2J4HbcGOzDNBumOeQk0=;
        b=DvKFujzD6bHSu/WfEXEpxibsCK2feVNz/GXmbhhKaZLJGUU5pZ4oqWPLDZONUD0fTD
         SECeUaP1g5UMWt0cjvvlMmEWuPNgEeZ2DQerX4qmt5aLBUQNOqQMNu6JC2uP8AySaaGw
         MoC9RUojUuEeQxl1ujlU2yKnGn37Ruf3Hu2DTWG6jP/quKMEwMnS0GmvqITfU3xEqs0A
         7MEOuSm/wlR4PLuY/Wc7fi562etOek2sWoyf8VZItfwS8e14dBcgi+3Vh/nmuhu7nWBD
         ar4XIIwHZT1O5nGTOODdJan3VKI0nrc/aVgKryRUGu49KTM5BsOMxvAz7v2viibcvYv1
         A+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5T03bEnp5V21xYQMv2byghA2J4HbcGOzDNBumOeQk0=;
        b=PDX38zL7hA9bM1OJwPHtdviyWpoE1v2B8nmDgdNLWjbcOAgePnFk8ei7nzq1uDzF8E
         wIOclMRUanWhUhBRxIB09pSNmlzAzb1GGC3ocCbkJmGWqFxVrV2S2+cNe+NmiAXvLly2
         YkuSOxuyChVCidago/eJ2kMoX0GhxszxDGrTC7WbNpAa6S1ViAsdCYARB14bxz5blDG8
         CupDEQL4LWhAor/Wf90oap+80AZxUlwbO/PHjY2QV9ULNY6TiV3CRjoeKWPW1wKu3JMl
         HDxFeOa8WW7j8AMX6oapobqg8NAro9n/mg57qWmjaCh3SQT8Luswflx+MmoNeglthyS5
         M51A==
X-Gm-Message-State: AOAM53020RQ04a/1Zv5p8PORGpq5emlwqLBzUKs8M0qL8YHSzK2KATB1
        z5o9KS0oBvnJzILP7urx1g3iIP3tNvs=
X-Google-Smtp-Source: ABdhPJxhXaspz/RWnA+6kT6Utfff1jlXEBrYcHbVlcwhqJoWH6QL39p9yCyqrJx/PPHPJBSshrIIpg==
X-Received: by 2002:a05:622a:1b86:: with SMTP id bp6mr5529584qtb.157.1641938102676;
        Tue, 11 Jan 2022 13:55:02 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:02 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 11/16 v2] libsepol: Make use of previously created ebitmap when checking self
Date:   Tue, 11 Jan 2022 16:54:41 -0500
Message-Id: <20220111215446.595516-12-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In both check_assertion_extended_permissions() and
report_assertion_avtab_matches(), when checking for a match involving
a rule using self, the matches between the source and target of the
rule being checked are found using ebitmap_and() and then the matches
between that result and the source of the neverallow are found using
another ebitmap_and() call.

Since the matches between the sources of the rule being checked and
the neverallow have already been found, just find the matches between
that result and the target of the rule being checked. This only
requires one call to ebitmap_and() instead of two.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 9c09eef3..71ee7815 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -214,7 +214,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	avrule_t *avrule = a->avrule;
 	class_perm_node_t *cp;
 	uint32_t perms;
-	ebitmap_t src_matches, tgt_matches, self_matches, matches;
+	ebitmap_t src_matches, tgt_matches, self_matches;
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 
@@ -227,7 +227,6 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
 	ebitmap_init(&self_matches);
-	ebitmap_init(&matches);
 
 	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
 			 &p->attr_type_map[k->source_type - 1]);
@@ -242,10 +241,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 		goto oom;
 
 	if (avrule->flags == RULE_SELF) {
-		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
-		if (rc < 0)
-			goto oom;
-		rc = ebitmap_and(&self_matches, &avrule->stypes.types, &matches);
+		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 		if (rc < 0)
 			goto oom;
 
@@ -284,7 +280,6 @@ exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
 	ebitmap_destroy(&self_matches);
-	ebitmap_destroy(&matches);
 	return rc;
 }
 
@@ -374,7 +369,7 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab,
 						avtab_key_t *k, policydb_t *p)
 {
-	ebitmap_t src_matches, tgt_matches, self_matches, matches;
+	ebitmap_t src_matches, tgt_matches, self_matches;
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
 	int rc;
@@ -382,7 +377,6 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
 	ebitmap_init(&self_matches);
-	ebitmap_init(&matches);
 
 	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
 			 &p->attr_type_map[k->source_type - 1]);
@@ -400,11 +394,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		goto oom;
 
 	if (avrule->flags == RULE_SELF) {
-		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1],
-				&p->attr_type_map[k->target_type - 1]);
-		if (rc < 0)
-			goto oom;
-		rc = ebitmap_and(&self_matches, &avrule->stypes.types, &matches);
+		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 		if (rc < 0)
 			goto oom;
 
@@ -435,7 +425,7 @@ oom:
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
-	ebitmap_destroy(&matches);
+	ebitmap_destroy(&self_matches);
 	return rc;
 }
 
-- 
2.31.1

