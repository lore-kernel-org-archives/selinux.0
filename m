Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D5C433FE
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345590AbiAKVzN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345279AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CC6C0611FD
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:01 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id y17so825313qtx.9
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUkVWMGFzR0RIyDH4k4H7XT087kiExp2zHkWnR8Emyo=;
        b=F+bkbdda4XF6otL0AXiCzXJJvMaabwNq9xRFschovhlmQbwRrkISKWyBiT6qu5navq
         4qtkgbiftBijxaYwA4NEMhfmScO138Hfss11MKSQQ1OTaseiuXinx+t+LGkbih7FqX+n
         rx+tryK+1Hn88N3Sdp6YPI3hgTeXOZfyJywQZsyNAxxsYbR7+KsTZFVZCBt9D6+zH0s0
         Ag+d3iOrPnizT06NDlqzuhhOH89LDh2MTcrjHG7kNmuzl3dznRiyCN4SlFn5lHQdH+tA
         7eavxPGjDiqFMrCVX2AEWVR/weUgZ8avhPz4a9KIHi/CpIzsiyvB2unpoWP5NA3lMDDx
         N7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUkVWMGFzR0RIyDH4k4H7XT087kiExp2zHkWnR8Emyo=;
        b=dnUUJYLOkr2UOaRoDRdWHXbQP44M8+7BO/xjXBfQvAGcxOczphXU3O0PaeZjWkZ7K9
         Oyd9jIuiLvTKNOnZmjLOkkLkOulbomQgAVINSlBIIQOr3+QzcjcHZgq4wpNDgGoeX4cU
         ftaUDnG46h0hV0eB4ZRoRCZGx7ShCxuO9fpGhOxQZ1x/SkpRqYXsvWQZExOOVwn4CJbG
         VQ3MJBSLU12mD39Ftc+30ay44RkLjsk8zrrGz2oSvhng3ZjQ/AlMA56vJNV6Shm1UIK6
         /Zlu+vi3XDHtsx5LJqnmlLuT9p8yf6fcxg1sfz8VJsKMZGz4DzNEB1S04nLpS6I4oCli
         Pi7A==
X-Gm-Message-State: AOAM533euTUIqemOWwN8BzuK94ifoGvJt8qQ+DPiqBX9H2LwtenWkjDJ
        Rj3SpnFANSZbzChTL8Y6Sz5feClQa1A=
X-Google-Smtp-Source: ABdhPJydr56wG1OKzRYwrUJ4lzoNsdAijWvFXhAPzJZuY+bFcAGzEwSms1kNWyn/Hr7hpeL01pjkdA==
X-Received: by 2002:a05:622a:44a:: with SMTP id o10mr5552260qtx.251.1641938100632;
        Tue, 11 Jan 2022 13:55:00 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:00 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 07/16 v2] libsepol: Create function check_assertion_self_match() and use it
Date:   Tue, 11 Jan 2022 16:54:37 -0500
Message-Id: <20220111215446.595516-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create the function called check_assertion_self_match() and put the
self checking code into it.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Use k->target_type instead of k->source_type in call to ebitmap_match_any()

 libsepol/src/assertion.c | 45 ++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 7a1c4a5e..6881c5f6 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -440,9 +440,35 @@ exit:
 	return ret;
 }
 
+static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule, policydb_t *p)
+{
+	ebitmap_t src_matches;
+	int rc;
+
+	/* The key's target must match something in the matches of the avrule's source
+	 * and the key's source.
+	 */
+
+	rc = ebitmap_and(&src_matches, &avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
+	if (rc < 0)
+		goto oom;
+
+	if (!ebitmap_match_any(&src_matches, &p->attr_type_map[k->target_type - 1])) {
+		rc = 0;
+		goto nomatch;
+	}
+
+	rc = 1;
+
+oom:
+nomatch:
+	ebitmap_destroy(&src_matches);
+	return rc;
+}
+
 static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *args)
 {
-	int rc, rc2 = 0;
+	int rc;
 	struct avtab_match_args *a = (struct avtab_match_args *)args;
 	policydb_t *p = a->p;
 	avrule_t *avrule = a->avrule;
@@ -460,22 +486,11 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	/* neverallow may have tgts even if it uses SELF */
 	if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
 		if (avrule->flags == RULE_SELF) {
-			/* If the neverallow uses SELF, then it is not enough that the
-			 * neverallow's source matches the src and tgt of the rule being checked.
-			 * It must match the same thing in the src and tgt, so AND the source
-			 * and target together and check for a match on the result.
-			 */
-			ebitmap_t match;
-			rc = ebitmap_and(&match, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1] );
-			if (rc) {
-				ebitmap_destroy(&match);
+			rc = check_assertion_self_match(k, avrule, p);
+			if (rc < 0)
 				goto oom;
-			}
-			if (!ebitmap_match_any(&avrule->stypes.types, &match)) {
-				ebitmap_destroy(&match);
+			if (rc == 0)
 				goto nomatch;
-			}
-			ebitmap_destroy(&match);
 		} else {
 			goto nomatch;
 		}
-- 
2.31.1

