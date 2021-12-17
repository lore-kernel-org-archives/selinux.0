Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594FFC433FE
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhLQSTa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhLQST3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998EC06173E
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:29 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t34so3504256qtc.7
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xhupr/TCQsKOcfDPSB2ZK4KZ1yUWAoE4llznwi/sTCo=;
        b=XMnVe4zULPd3A+ziptWuk5Hz+CJpW/H9NLRT3Zm9rKVUaym76r66PD14R4aMc9vObK
         KGkb6/2trNMQoA61Ncb6jzqRmP2tPhiVU88tghRFe23pOjoDn9cPRsy4ZoJnn4s7UvO/
         TOqfF9AB5aG5APEFbI5Ljr+O/9OqwtMXH1wwgGgj+jUWv/CQy2iTEwpVYNGmJFAsG71V
         nN9pYpfZNyf//zPJ1hPFlg/pB52zQhU9VXkTe2glgQvCHUwtG9nXhhbAlULzVvi9IGhE
         EGq1zSzc7UeAd+sk+1SzEYXjKqwozWjO4L8hSwZVlx+qPn7b8uV99155ame3B/H8xyGe
         ViBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xhupr/TCQsKOcfDPSB2ZK4KZ1yUWAoE4llznwi/sTCo=;
        b=1Q+Z/e8Z9io5g2qvp0BFbhpPsK4yau/dGHtrTx19xjOd7dpPpnMS8oQZz7twz+epSe
         vJ35fNteiZ0LuzM9Z5QsetUS0HQ4NnhlwStD+QvSkY9oKXmA7Mq1nkPXm7DdzFDF1tCG
         PEFVnxwQO3doW/+xnjqJ+cxHBNfpDhAJRY4Kf7pI+AEheC85mj0sTFUwYcdBT85xPN52
         K8IybBgpocMOoWCNALbz8Gohtfs/50ne7YrY7XAlo/xNo7UEOP994QgKJPPp+y3HOkY0
         d/tNcWdTy51oi2HCH/oEeqWpwbJsUIVBtWB1blyqF0pqS970X+5r/EB51P3lnTxribrL
         snWA==
X-Gm-Message-State: AOAM532uuMxE/0baiEVgtA/BwLlk2vSuPREtJWUxZwQFGexlCbp+xlKN
        ypGcghLZFy6H/YaFgGK/C0QDkRUHYJQ=
X-Google-Smtp-Source: ABdhPJzj+ECLIuZcCDIAQOpGDQ9fL+YTDrncX0sPsjtgRhxCuVO73cFKvlXiiDjk0VvQbS7HzsBohQ==
X-Received: by 2002:a05:622a:120e:: with SMTP id y14mr3513847qtx.671.1639765168775;
        Fri, 17 Dec 2021 10:19:28 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:28 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 07/16] libsepol: Create function check_assertion_self_match() and use it
Date:   Fri, 17 Dec 2021 13:19:04 -0500
Message-Id: <20211217181913.336360-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create the function called check_assertion_self_match() and put the
self checking code into it.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 45 ++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 7a1c4a5e..1b13b232 100644
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
+	if (!ebitmap_match_any(&src_matches, &p->attr_type_map[k->source_type - 1])) {
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

