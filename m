Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A49C4332F
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245648AbiAKVzF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiAKVy7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:54:59 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7D9C06175D
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:58 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id b11so806119qtk.12
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=106LcaQV+09ecmysXH/0CQoQX/LNoX+Zp7PgkkWnBf0=;
        b=VJAAjt+GtQdhG1XwQ3QDkdBQZaztuHqjV6xaIHtB6xzPNBqLxX1GGWTvxpwc7fB/H9
         4ma9kXBr7ogNSgwQHcOTR4cLCxyJt77xeK5DMDPK7s17W8RKlGQAB4MOhQdbaVcTDO0L
         E0Ftk66RO5W3q9qIn1txy6GHNzQ1RHTQUQHnbOCGUWRYRPWdsGSV4PUnQxT/bur0+3cu
         snkdmGS0K3JmKW8dHtkMpZhidimLKi5NoCUsgTzRJU6E3HH6ccZNIUjHciQJNv0FPsvJ
         vhzppbdMkS8HK4IlZHNiOCgULh5iPxreHOIMYspyt6/HKWpf1NChOiHuVMyMNh9oBU87
         1GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=106LcaQV+09ecmysXH/0CQoQX/LNoX+Zp7PgkkWnBf0=;
        b=0Yn5SA6TmijFpV33pWzrR76+ZB6W2ywJ9MFxQnxHHCyM9vVtKS0OIrDT6gjXsN3Ih0
         qhEx5/PA7lLHXjCfmuUa/1DIIxLQ9tla50hHzMJSYyjPI9TWHitpz32WhURJzlpHiCqp
         Mwx7IW/4oNx+GyKSA0gtvUyrsQAIhNy9OxEnXJzaRT/eqEMdOtuc8RoZwcOpLDWBxpt8
         67SNDEsPlFEq1j5od6x0B7RJaHq/MyR293fIguqUKwUZXbKYFoESKDX8Wp2xh8sVY5zq
         JFEQNIcD4wlALHX3JksH1wyIc7+GhvfZpP2D4DoOLSWpsq9OBDegqmp4j3Kt4bHj5npZ
         mMqw==
X-Gm-Message-State: AOAM532+1PjNp7urRpJm7OZsCBqamNzg/scuQbXxeYplzj0/lt80R74D
        DA4pCkQtsV0yqcigojPgP2k/aw2Kb2o=
X-Google-Smtp-Source: ABdhPJwgH7Ul3OpAVZdixMQXTdEYF5EQSIHTxfla2zfYuILSfduhNuby46LW4XsPlviAWJcB4mFDdQ==
X-Received: by 2002:ac8:5b92:: with SMTP id a18mr5500783qta.262.1641938097995;
        Tue, 11 Jan 2022 13:54:57 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:57 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 02/16 v2] libsepol: Change label in check_assertion_avtab_match()
Date:   Tue, 11 Jan 2022 16:54:32 -0500
Message-Id: <20220111215446.595516-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
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

