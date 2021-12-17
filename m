Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F194BC433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhLQST2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhLQST2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:28 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEEC061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:28 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id p19so3463979qtw.12
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75EcyTw5P2z4vDUA60U0TG9nAgtXhZm50zN9nmG3df8=;
        b=JtIr2ZY8feYldNg1XLz4GpoUQ6eP/zVl0Jq90SQ+8Ry3B01WsZO+FkriJ/ccRHeteN
         Pyfbv2OuvdKFQ9TUfUqnjNZisTC2A49aRCEQas0rkgk8kOQrUWPweGggOTxqTYWFJE0o
         Ja4Erluk5WuaDc+csADPvyeikZt++B7M2UiwQfdsBV9d54gfPQLvB3kPTFp9Hs9Y8EGA
         4qaZzbt+giCHxb0yCoBDPNp9diCPb8qs5T8SCdHkkf1SP/EULwCLDn1xHD8xZC2TmUyx
         FGcHQgQNbG13xkkYidDIMx7UK+Erk8L9yXrzklHIqlE9gZg+zdmLn6dYE74WIUbRN13l
         o6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75EcyTw5P2z4vDUA60U0TG9nAgtXhZm50zN9nmG3df8=;
        b=S8Ipf+Cni9n3NI0f8KJnV0E+wIvhUD6dEJ6uI3+xJH8eUniZ59M3ZqqUukWV6Tnexn
         P5MccbUXVrrIs45yaW2T3dDMxDnFvE7ABGTmnoVq2W6GtmwD3zbilVHkG+8+rntIkbgU
         C3siQJI9LBh1K1amzfvNBXVsnwcWOZelYEa4PAK8VLGXD29+o9wss0GY/SNPtOzHWYJk
         cIdiDo31FKy1JeeGYYm1GwqJhD07X2kkQsat/sLIHHPWqfqVBQUll9Quj5uC//AVlSwF
         JJknFs8/3mPdASp/M79Q29pwk98slgvBX/CFTAYA6zJKluYCJW7otqBbbOG8jNqVL+X4
         MopA==
X-Gm-Message-State: AOAM533P5d6OkJmpgTPKpt2EYKHJcuQf+zcRa3Wlr0nOC3STnzBUM33F
        QIx4vcbPN8RnUmUiR6oM7j6oAteDB6g=
X-Google-Smtp-Source: ABdhPJxQHwyR/+JelpceOhIpylWCnFPmoG5tjq+aXQf+EuzSbLQNa4J2ym0xoMkgVDCZTaBRdA42lg==
X-Received: by 2002:ac8:4459:: with SMTP id m25mr3421806qtn.659.1639765167486;
        Fri, 17 Dec 2021 10:19:27 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:27 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 05/16] libsepol: Use consistent return checking style
Date:   Fri, 17 Dec 2021 13:19:02 -0500
Message-Id: <20211217181913.336360-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In check_assertion_avtab_match(), for the functions that do not return
an error, but only returns 0 or 1 depending on if a match is found,
call the function in an if statement.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index a2cbb74d..bd0dc4ed 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -454,8 +454,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
 		goto nomatch;
 
-	rc = ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
-	if (rc == 0)
+	if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]))
 		goto nomatch;
 
 	if (avrule->flags == RULE_SELF) {
@@ -475,9 +474,10 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	}
 
 	/* neverallow may have tgts even if it uses SELF */
-	rc = ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
-	if (rc == 0 && rc2 == 0)
-		goto nomatch;
+	if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
+		if (rc2 == 0)
+			goto nomatch;
+	}
 
 	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 		rc = check_assertion_extended_permissions(avrule, avtab, k, p);
-- 
2.31.1

