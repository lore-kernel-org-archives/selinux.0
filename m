Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B65C4332F
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhLQSTg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhLQSTf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:35 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A92C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:35 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id o10so3199590qvc.5
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUihKd1ZsQaAR0C1IGh3+vZfEx/FMUbtfZTO0dEhv44=;
        b=GJJc9gjukaYy2dkvTwhwab/gQI/dkWC/PPaPxN0iV688ItMQx7/LlwLorBDWAxSMB6
         eHa7kLu+RMlTKr4k0C+lqjsbAFh7KHd43cuTalKibFxPZk8DEnunt5RyCCGSVygMdgr8
         jua7VwKEMfPvjj2aB/8JYQZrXBntGWYCk/dmqOXGrpHYptl1GkOtTiZaPsOQ3ZPz89iI
         sUhxUeV7L+E5cEhaTlEHsH+nj0lkxzrxCGaYlCADDHWpDrw/UyPOA71i7u65q5VlqJS1
         D/0P/eZMGSqTSdSX3TkXhyzqlgs0rqvyxvAPH3+D795uzwZUfDaQywAU4IyDoSYUOr1p
         byQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUihKd1ZsQaAR0C1IGh3+vZfEx/FMUbtfZTO0dEhv44=;
        b=c4s/TmMOvKmV6AQkLTyg/YM1qQ+E+ZFy88FkG5pqziOyGiFTI9HBkhlpy19Pgwu3Ek
         d3rGNovQicBNo7wRKmjaBUJw152NfFg4B0D2ZdkhGhnLHy0szbSwtAoXI0DcNf+jXtgK
         tEzbu0WcNqb7ayHwKkYnoPprkLnKmGoF3YP8RdOna9Vm7m0IKhQgcjR0jPnPtuo7wXKP
         bvuIWTF9q4L13EOm1E8Uk97oBcwoPsoPkV14mQU3vL4NMkIHE4qHO8fDoDtGGWa7+RoQ
         sC2FWHiLWGuJ1fGanAzqwb4bzin+1GFCvbTV5dcyT0TBQBSODjAz83LCy/l3SAR/CFVe
         WwoQ==
X-Gm-Message-State: AOAM533sBKMjMwWvmK/e6N09Ke4CCuZZvZVfDT0ZrwZfqERo34OjsZHs
        8tqPGKZnW9YKtrE6i33nd587nxtBWos=
X-Google-Smtp-Source: ABdhPJxXnrjuVQNgwq2moVcL4Hgrn4Xw1+lsBd1+ZfheOlmy7J7DP9seDylt4BdIBI36Fy3gZqs9uA==
X-Received: by 2002:a05:6214:d08:: with SMTP id 8mr3525591qvh.46.1639765169398;
        Fri, 17 Dec 2021 10:19:29 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:29 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 08/16] libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
Date:   Fri, 17 Dec 2021 13:19:05 -0500
Message-Id: <20211217181913.336360-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
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
index 1b13b232..cf10e41d 100644
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

