Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2286C4332F
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhLQSTd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhLQSTc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:32 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F35C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id kd9so3148901qvb.11
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LozCoQKUQpmqPMifyhEH/ul1tsFqWRTxqDJtnc3XY5M=;
        b=JvnobrOXrCIZQPYAsGsEvy11pKyn8+RNgrR5Jsr5hJmjJD7H5HvqA0DFMaaeTPqq3p
         ikX6jFBjq11s9ZsQJaR1ogt25biz524dKuv0JZ8HlTNXEabnftI7JRKxCDw4rqEXs5mI
         5cGJ+X5ritUYPo6zvahgGHJjo0wjDQPt/ZAQr+DhYToQ3UlQ+euTj89FxwNcV4qBFOze
         /Hdbw2ceDPjRcgaeJzewXrinoVluVM3URdBgTLhTKUQlLmLrjO3roZqAfTpzOkOBzgpW
         DM09mDKMO5QZu7lmda0ECcjSIGfDEcfnM61sc74t6LW6nZSaRv2+DF+YJP9Cvy380TR3
         Pe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LozCoQKUQpmqPMifyhEH/ul1tsFqWRTxqDJtnc3XY5M=;
        b=AbVHaeCCeAqCp79KzDizVQ8eKFhv5g1ppScrJXNvJNZHmUHjlc06eejOox6MFKIArg
         tmQnlGlscSWFFXHTFYWK6AO9UbJG33G/c9YH5EMv7C2Vh62Qv3oAW6hGtJBb5fzEXd0x
         cJLNU6TwL28vLCMW6icTougEKZmsD7f9L3klzmAYSI3S6T9cRnVUpR8o0mgFyyMfndRY
         /P5lbXtl1eQbCA4FwL6Am0GR2sauxJGfdH3cR1Ya/qqjUW8gY1zJb0YpVt9z/qrlcoaZ
         CSDd2saoNdn6tocjbaRbixeOHzEg5l6yLcfrG/sWb3+phNDRC+gmPTYHx4E5+ckV9Tfz
         iMnw==
X-Gm-Message-State: AOAM53170RQcInssvZ/o9faCzQ7wYOhl9gKmO5l/xxTqUdc2dqxISueH
        LFk9HudkY35g+bz5MeExj2Yw7SoB+to=
X-Google-Smtp-Source: ABdhPJy+KChSDAtPpoPfdGWwBYAYaY5SMT+oClnNy0veu8nz2ElbLvk+0L7vim6Q0IW37WVnIlguHg==
X-Received: by 2002:a05:6214:4f0:: with SMTP id cl16mr3431214qvb.72.1639765170943;
        Fri, 17 Dec 2021 10:19:30 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:30 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 11/16] libsepol: Make use of previously created ebitmap when checking self
Date:   Fri, 17 Dec 2021 13:19:08 -0500
Message-Id: <20211217181913.336360-12-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
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
index d3711b01..4c9b9557 100644
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

