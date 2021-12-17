Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCAC433F5
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhLQSTa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhLQST3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:29 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3429CC061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:29 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o17so3536898qtk.1
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJSIYiK1iYgbVswXsUOfqMg9hjOoN19kqBrH9ke4030=;
        b=oOWEEiFZM8hPHf73tT62FNMVfSTF2ynyLRvlmMiqIaw8ObaZBgeRu2VA9633CUMn5C
         NsXPfzIRmtf5J6bCHsaZCOy94V3sLxHFlraXhlv9mK4nyleGitoyV0wVJR807D1Vuedj
         DEq/vVxeb3fMyncJaBRVvragji5BT960mdverUdfNLkAFP8CavHgKYuGr8b7QLmf0BVZ
         v6/0bC6M5eWU0JcKXje50xR9HSsIin/eIvGVbrubCpeRTqjTYM5OvQZqcb70z9dw2D8x
         Vxw3JH41j3rtPnYoCaYbGvzx4wJnsT+5ZVSjGcQSSO97SeG9/j+CM05nFAfKIPxXEs6L
         LEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJSIYiK1iYgbVswXsUOfqMg9hjOoN19kqBrH9ke4030=;
        b=G3Sa7gLpPnUxGyoiJgvrJ8LOkAsoAwyhwfhw6OErr2tPZFdO+PhehUtJSklB+xkGIC
         hY/MJ1QHD1U1Rty8eoC9zz839GDsx22N1YzsAwg7EOOtWgpm/fnGjvQWqfazoV04tagz
         V/oTUxEn8dcYQlt0dxU5/Lr3cwxwzhIkl6e7ePMeN7h/EDL5bpyNb3Iqx3Q68e9BTQph
         GOTpc4mpXLFswb/ATdN2DFXA4pvCjSEG5v6L7cLUTIFjgt7d6p0bQAu3lIPiHHzS7JW5
         A/LfWommuJ7hDRv1MC+gtZK5gJuAHFXrHjKVBAggo86TEJAn3tdJVpqJ+vfsb+PopWLw
         7jJQ==
X-Gm-Message-State: AOAM532eiKIhEhma+ftXvkLOsDepVlON1ItgOsU9mPEv6fOKGHZmf5MX
        lD8bKv21IE8v7Tdw9aco1bbXlOFcqnQ=
X-Google-Smtp-Source: ABdhPJzkfAiP5+72QdWH3kw5rX3FwXDswc6ZKX5+KqoDn81BVUZu522oDZYUj7bbDWnkmxfUskxO7Q==
X-Received: by 2002:ac8:4e8a:: with SMTP id 10mr3555644qtp.578.1639765168282;
        Fri, 17 Dec 2021 10:19:28 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:27 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 06/16] libsepol: Move check of target types to before check for self
Date:   Fri, 17 Dec 2021 13:19:03 -0500
Message-Id: <20211217181913.336360-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If a neverallow has target types as well as using self and a match
is found with the target types, then self does not even need to
be checked, since the rule is already in violation of the assertion.

So move the check for a match of the target types before dealing with
self.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index bd0dc4ed..7a1c4a5e 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -457,26 +457,28 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]))
 		goto nomatch;
 
-	if (avrule->flags == RULE_SELF) {
-		/* If the neverallow uses SELF, then it is not enough that the
-		 * neverallow's source matches the src and tgt of the rule being checked.
-		 * It must match the same thing in the src and tgt, so AND the source
-		 * and target together and check for a match on the result.
-		 */
-		ebitmap_t match;
-		rc = ebitmap_and(&match, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1] );
-		if (rc) {
-			ebitmap_destroy(&match);
-			goto oom;
-		}
-		rc2 = ebitmap_match_any(&avrule->stypes.types, &match);
-		ebitmap_destroy(&match);
-	}
-
 	/* neverallow may have tgts even if it uses SELF */
 	if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
-		if (rc2 == 0)
+		if (avrule->flags == RULE_SELF) {
+			/* If the neverallow uses SELF, then it is not enough that the
+			 * neverallow's source matches the src and tgt of the rule being checked.
+			 * It must match the same thing in the src and tgt, so AND the source
+			 * and target together and check for a match on the result.
+			 */
+			ebitmap_t match;
+			rc = ebitmap_and(&match, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1] );
+			if (rc) {
+				ebitmap_destroy(&match);
+				goto oom;
+			}
+			if (!ebitmap_match_any(&avrule->stypes.types, &match)) {
+				ebitmap_destroy(&match);
+				goto nomatch;
+			}
+			ebitmap_destroy(&match);
+		} else {
 			goto nomatch;
+		}
 	}
 
 	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
-- 
2.31.1

