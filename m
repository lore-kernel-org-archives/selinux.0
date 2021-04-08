Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E1BC433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1985661103
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhDHTQn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDHTQm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D532C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q3so3368519qkq.12
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKK6va0e2ppEidijJ2JejfttkTrL2zLHSQMqRJT6mMo=;
        b=SyNgpq9g1AuGWt22IcLyY6s5ZZH7lsGnngZ9Gvyh27CSd2a9nvre7I5s2Pe+i5koIC
         Ycd9o1B0feiAmncRcy3XiC9fjG9v3o2aUvQXhcA2lCFnBAV/NJD6jb6BGcvDK6eKcYFi
         X2lsCXxN//AWCe1bNsOTq13aWJjOnbX6xuzOor0b0YXF0XuHnjN1YTuwVh/h+HyfVqYB
         090cZFcdkNC35M1S1QZFH7nWhIZ25p5lWLd2z3PkpICY0ZaN6DfVdSeeLTb2nOpyMDxd
         O4QnsrkRd9RSlUUBdzbbRVpx83XYwmdhAwckz9P5B/rF/4K+qB/6WDuMxUhFM3Vv/DmG
         DpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKK6va0e2ppEidijJ2JejfttkTrL2zLHSQMqRJT6mMo=;
        b=U2s1pndIK+Xha1JkZEPwZuBWi8DanPD+g+UlXqDw5QHM/KMUQZ35widWOf2yrrePlM
         LvLRTjxaqVhGdnVQJwYZkKSMuc/b28TRF5JXCwCmvqCSk3Sajfjg1Al95uaI1UZu1Q16
         NqMK/EKrFp+C9cfGWYdhrCA6a2nfKZxgrBnMLZctG3uqT3TVRzeGlO3W4MBZx57d2TQ7
         ylAcQ52NWZl4Csf+wY0rJsL96DHGxXLN2BSAjKGUqu5iOO1/xRGLBZfZHddEeB9kxejY
         /KSvnJjsiNqna6NFWGmSPH3CwcRT3rvfStLVLE7/UIKNvyxudHjSMbrGRo2W0EE9HvET
         0OlQ==
X-Gm-Message-State: AOAM532mgANCpqmRT903QmRLjjSs+6AODD8+7hoQUFipY/Rus5s2q3F6
        S3lQLHLLifnZ7rC5Roj5XrkFcR14FsEwAQ==
X-Google-Smtp-Source: ABdhPJxIIMy4dpZyVf4BdiDxvd5szys9a3x9n1lSLiC0HLoDFbbsk0Mivzbe52ELCSfsdDFuX/dMAA==
X-Received: by 2002:ae9:f818:: with SMTP id x24mr10169905qkh.101.1617909390444;
        Thu, 08 Apr 2021 12:16:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:30 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 05/11] libsepol/cil: Set class field to NULL when resetting struct cil_classperms
Date:   Thu,  8 Apr 2021 15:16:08 -0400
Message-Id: <20210408191614.262173-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The class field of a struct cil_classperms points to the class looked
up in the symbol table, so that field should be set to NULL when
the cil_classperms is reset.

Set the class field to NULL when resetting the struct cil_classperms.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 1d9ca704..76405aba 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -45,6 +45,7 @@ static inline void cil_reset_classperms(struct cil_classperms *cp)
 		return;
 	}
 
+	cp->class = NULL;
 	cil_list_destroy(&cp->perms, CIL_FALSE);
 }
 
-- 
2.26.3

