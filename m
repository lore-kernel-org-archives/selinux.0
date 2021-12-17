Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13C9C433FE
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhLQST1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhLQST1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:27 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94DCC061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:26 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v22so3485932qtx.8
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=106LcaQV+09ecmysXH/0CQoQX/LNoX+Zp7PgkkWnBf0=;
        b=ZXCeRDAbTGvnFI3MPXhDNrCT2nRbNRppzxlxb0fQ6YFhbydDHw101Vvzzf3IveKyZ6
         aAnnX6ob2m5Ms37xuijr0RLxQbl5UVEu9ZsnFvuv6qkgmJmnwQC5US+QGqKGPRHTdidk
         cgoqDDbI2kCyOKhRY7eQN4u9prgaqCBHjokC2s18PobKyIUfuJ56fdweUfLt6zsS6Y8o
         3PPnLibm3gv5+yVZeqyY1aouU5EQky9jyMAIrKpzP/j8iXsSQSmBB16PkN1yYL5uBgkv
         SGn5lA6/cZ8iAQ9P8HrosaRlK0PV6vyUxjw8Z3FxKi83exehs9d1rJumoVipKIdBKHcE
         B7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=106LcaQV+09ecmysXH/0CQoQX/LNoX+Zp7PgkkWnBf0=;
        b=ogu8R9orcrTeeYS8sVc+XQ8w583/vum6MIcMlbHl/7Mrj4Urx80lfgGjexbQarI7hI
         KvOGEd1ykzyTDFVRxH4ZYn6Frvu3fAsZOuHxumTwwALNwWNyw1YDdwGJkZMJKWvJmTko
         ivNynEWflIZ3dy4PfxBiOMgiLeQk4pZrelS47pLbZfIk3x3aVXw5FBaTVOXvTVREbBGA
         2Nk/o513+u635oXLFe6jM6L/0OE5knzU1t0bg8PEMw36QG+up90XyhFm2SNvAW/S2WYs
         la8jGXtTzW3s58EmKgoP9Ug5b9zI5bahzn84BYbZ2sW7o6rWw1TULuSlw/CNud41YdZC
         C11A==
X-Gm-Message-State: AOAM532LuOw0tgAa9+gBanroEH7xHVzge8qVLsTijrNc6HqJxgu9Uktt
        fJWyfLo0pvIpZLMpEyGR8VdF+p64Sl4=
X-Google-Smtp-Source: ABdhPJwLhpYpDTzgmyoQFkkUVCeBMOUYYRmrv44L1IhQo5+96/pL5IgqjHWnxrxb05jpU52vdv8haw==
X-Received: by 2002:a05:622a:30b:: with SMTP id q11mr3618943qtw.235.1639765165937;
        Fri, 17 Dec 2021 10:19:25 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:25 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 02/16] libsepol: Change label in check_assertion_avtab_match()
Date:   Fri, 17 Dec 2021 13:18:59 -0500
Message-Id: <20211217181913.336360-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the label name from "exit" to "nomatch' to make it clearer
what is happening.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index ba4a204f..d716450f 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -454,14 +454,14 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	avtab_t *avtab = a->avtab;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
-		goto exit;
+		goto nomatch;
 
 	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
-		goto exit;
+		goto nomatch;
 
 	rc = ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
 	if (rc == 0)
-		goto exit;
+		goto nomatch;
 
 	if (avrule->flags == RULE_SELF) {
 		/* If the neverallow uses SELF, then it is not enough that the
@@ -482,16 +482,16 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	/* neverallow may have tgts even if it uses SELF */
 	rc = ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
 	if (rc == 0 && rc2 == 0)
-		goto exit;
+		goto nomatch;
 
 	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 		rc = check_assertion_extended_permissions(avrule, avtab, k, p);
 		if (rc == 0)
-			goto exit;
+			goto nomatch;
 	}
 	return 1;
 
-exit:
+nomatch:
 	return 0;
 
 oom:
-- 
2.31.1

