Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D3DC433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbiAKVzH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbiAKVzC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:02 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C87DC061201
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:00 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id r139so363846qke.9
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75EcyTw5P2z4vDUA60U0TG9nAgtXhZm50zN9nmG3df8=;
        b=OqgxQRPHjUO62T8IviIXG+zyGizV1Mq7rFEB6WqgVXJ8g5aRwYVWh5lEr+jqt8e6M7
         aPPfZAM2U7S5C5C2stSfghYZnv3FkNmftNdTmPXINDybox485cX01hJHVS2X5RtiKCiX
         opk/oRTg4+u2GXqzEBSyWLFybID7h1qD/+kIRIhWHnpGpfGCiezCqSBr9BmS76wtLbie
         AgUV8KKyy+l5ATiKkuieIvFEM34i5xrlTeD3n/SLFxh7BbWky5QDSJ/T+KyjdxZ3iZSw
         Or6UoIpdIA/PKvYa71Zkes9FRv2BuwuXh6gOmNZjU+PHgxPHiRWJ4c4Iss2OcDy2Bn9J
         LPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75EcyTw5P2z4vDUA60U0TG9nAgtXhZm50zN9nmG3df8=;
        b=fpEv7075T+rWkKQPHe/2zxuloVea+qInvYBw/hXhQ7M1AzNNPdfL6ICJ2iazbtpmF9
         aNloA/Jw3zMz2c3iNMSeCmgUNQfp48KQRv9aSpPQie2/9XH4JxACO3GLiDs9wBGQAxPE
         BPR1WXUypSB+NJwBJsfGREnCA+2137y1zKG6CGN43soxLqNqE9OKcOvDWqEiXE4DhZXU
         4KmriZ4DqZ5+0o8sNO6QRlbXDhnuSwi8MCK5p0JCtX74bF46YVgggVC6TQgg5ZMZl6SV
         5U7pdA9qPol+rr0qpUlAhYxSkvSphcsXlXLsvqIZ0DaEpGtdIJY0/XjYrsWl6uzK6ssk
         j1NQ==
X-Gm-Message-State: AOAM531+Jk9D7RJft1gOdMULPWi2rPUlm2gIi4moLmown+R2U8vs8Iyq
        i5CBTD38gJhDK6OGhD5BvdEIkckDs1Y=
X-Google-Smtp-Source: ABdhPJxV06F9hVsLat5sn2EWAlt1WMvNE0j47FkcaLs8f8xQc0kkDY6fraRphRtPHfCjpO6TXwQEew==
X-Received: by 2002:a37:5f04:: with SMTP id t4mr4686707qkb.190.1641938099573;
        Tue, 11 Jan 2022 13:54:59 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:59 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 05/16 v2] libsepol: Use consistent return checking style
Date:   Tue, 11 Jan 2022 16:54:35 -0500
Message-Id: <20220111215446.595516-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
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

