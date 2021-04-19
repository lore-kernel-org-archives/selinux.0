Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369CAC43462
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0AA6113C
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbhDSPQr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhDSPQq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E720C061761
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v7so8027953qkj.13
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zv1JoDzTu6AkTMma31wcs0OtpJUwcmFUO1jIKrCGjUs=;
        b=BkSSXogM0ltFJG85Oqxkuv231xCB7rUip2cDue1I97KaCaLpcx8iFJWtHcsiD2rTn2
         6WKIOa+iglPl6QfH4UNjpozVvBHxYgv/v/S1QZk6avg+G5kZ3Y0t82f+Ii2ztFroFz7/
         NQkjhb+WaWQ2GGut21nCey89mj6Ae/TX9/8Yu3ITWvHCWUHWbPIZmlXzcFu96/EjXM8l
         Q+CMEDVHsIkWOtnO3vg5Zu0KYfYz6aScsc8L1JhLvNM1VhYAxMm0b1YKl0rDf6HsCtw2
         kj9xFU9GFyTJq+jN+he9Gx6rCzrgcyQzf2y+bEklZyU8bBKCdQY/rw8yvZykgjc4Qh80
         zRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zv1JoDzTu6AkTMma31wcs0OtpJUwcmFUO1jIKrCGjUs=;
        b=nGVTFSklTAQzOR2Y+NJh8XjwVhqYV8UhDiC+eRC1v3ylysu67SuQJh5s8K9rsDb4Ol
         Acdtxq+77gZZ8kfI9yUb1i0GejiD6nuavDQWXbLhuMjxr81zpT2iXqwmpTqHPUmxka6m
         MR9fgZKWiUpiDn2+wRsT0Xas1Xk9En+0MAuJH88Vpay3AIEyE+9SrF///Q8vBTvQuFSr
         3xKwt8Uw0GN/77IiID2mhew6tbeEOnZ3Ansp+1NCRfuBQjjgglzGMHN7oCr/9jep2+wu
         IumkotRuehaUW4oDHgpQolquriuPDuKC1diVZ+zGnbyuJNLiojQb0+BCfqTIr6zlRzxD
         3iyg==
X-Gm-Message-State: AOAM533lOp2I78/4hmfKP3sejDAd7xG0RF0SvdrBkIQxT/Dbve7H+UGh
        H79ITv9GU6bCaPoFaLZbM5TQu8MAtJyg8A==
X-Google-Smtp-Source: ABdhPJyRF0scK9fyO71yiW3uBDzMtntWGHgaFdjNs1AKLEWtKiJjZvj1FsJx94JISOW2imCbTGcBmA==
X-Received: by 2002:ae9:ed14:: with SMTP id c20mr5662767qkg.312.1618845375518;
        Mon, 19 Apr 2021 08:16:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:14 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 04/11 v2] libsepol/cil: cil_reset_classperms_set() should not reset classpermission
Date:   Mon, 19 Apr 2021 11:15:50 -0400
Message-Id: <20210419151557.87561-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In struct cil_classperms_set, the set field is a pointer to a
struct cil_classpermission which is looked up in the symbol table.
Since the cil_classperms_set does not create the cil_classpermission,
it should not reset it.

Set the set field to NULL instead of resetting the classpermission
that it points to.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 89f91e56..1d9ca704 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -59,7 +59,11 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
 
 static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
 {
-	cil_reset_classpermission(cp_set->set);
+	if (cp_set == NULL) {
+		return;
+	}
+
+	cp_set->set = NULL;
 }
 
 static inline void cil_reset_classperms_list(struct cil_list *cp_list)
-- 
2.26.3

