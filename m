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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FEC43460
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C941D61007
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbhDSPQq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbhDSPQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:45 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8564DC06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h7so26331113qtx.3
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGp8CG8ZwKsh42+s8xC53KdJNxA3ZmtfgGM2bRaeXOI=;
        b=hhyM7UPfhd56emy9GmnbbU44XRc5Xw8HdNKFkOdMnxpikCj/0aCN1CkwX+tS6DIlxo
         Ph64EjexfSLbpBkLLHYIc9f92kuMymzIVaTEVXNyvVrI9ceqNPN8UU7YcfE/13HOTu+v
         ddFZZ2QpGQX7BiFG3ZnwbjUTeW1pRNtyTt/PU2We672cvwRrZh2f2639R8f2fNiiWBIt
         g6BTWIdUz/YYSjKixziDxGKJ3wZM+x0oXhU2omnXXMgtUv3s2Q0t8zf0p5bhFWIiPD0t
         va2Ka8w0yZLNmGlT78ooFf1NvIwZiovAZrJeA4hJeNgL+VdDGz4hq1cP9RhlQsGyJahC
         Xg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGp8CG8ZwKsh42+s8xC53KdJNxA3ZmtfgGM2bRaeXOI=;
        b=J80i7XkqcVRK8iau9KPTZFnexLopZ2kF3fhQeirjv3fBbPh4l1C+3LnoBT0vsVd1iC
         rr8Aun7M1a/fI28l2T6QXEvLX+Y0SBL0Hk/MyskMfxVoxRhH43cxtmOjHgDDHKl1UilU
         WNih4zS90UTUtL8vTtX0qvgSLBOfFKsrZ2MXRBIFg5LQLBMsoxPTO8xqwrJ4VO7Yeita
         Znmn8Jh2/peqNB3gSb4sYIFBo4kSDIHx06Di+j2nLspoy4fNHb5pjfdBqvaO+MhiyFa5
         XanmH9PhUUaNDmzBGHIhK+dHd9pf78mWkw2L69EZF+XU4ue3HOSb1g/k1hIYPvvf78gF
         OaaA==
X-Gm-Message-State: AOAM530mMGFq/MCYJmUdMCUeW/LvToKJPFEAi1PGqhF17NgvnYE4PgC9
        xrO9q2YcYLeaqC0ZThC3ao0RnuYs2B2evw==
X-Google-Smtp-Source: ABdhPJy7pRw8tLble4FOCvVR4PcO1Xcmx1o9Ro3jqUhKBAHFZWAo3c0+Zzw7Aq7dGLKmy3gCWYWjEQ==
X-Received: by 2002:ac8:1304:: with SMTP id e4mr4965254qtj.277.1618845373717;
        Mon, 19 Apr 2021 08:16:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:13 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 03/11 v2] libsepol/cil: Destroy classperm list when resetting map perms
Date:   Mon, 19 Apr 2021 11:15:49 -0400
Message-Id: <20210419151557.87561-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Map perms share the same struct as regular perms, but only the
map perms use the classperms field. This field is a pointer to a
list of classperms that is created and added to when resolving
classmapping rules, so the map permission doesn't own any of the
data in the list and this list should be destroyed when the AST is
reset.

When resetting a perm, destroy the classperms list without destroying
the data in the list.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index db70a535..89f91e56 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -36,7 +36,7 @@ static void cil_reset_class(struct cil_class *class)
 
 static void cil_reset_perm(struct cil_perm *perm)
 {
-	cil_reset_classperms_list(perm->classperms);
+	cil_list_destroy(&perm->classperms, CIL_FALSE);
 }
 
 static inline void cil_reset_classperms(struct cil_classperms *cp)
-- 
2.26.3

