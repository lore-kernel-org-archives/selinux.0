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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACE4C433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238BD611CE
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbhDSPQu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhDSPQt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:49 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A40C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y12so26329037qtx.11
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKK6va0e2ppEidijJ2JejfttkTrL2zLHSQMqRJT6mMo=;
        b=JkT4OjSHa+F0UWps0YtOGOjELiLVPEyA6bd9jnkG63MOv8Iq7wNvi7XjCt6vbn56SF
         wN6/FnhaBfYS79ST8ooJGOhuKNWnLQOI5V/nxSMgvp17khRBuJcmC+AOOKMxQn+Hf7vX
         uDIoaHKwAxkNpAALXO0bFnx/4q+pnW+N7VCZF1/JAZl5UE82vkoaGmTqH52kC29GjVCs
         aNM6G6fPXigbgMvSeq14dwvPvJihqnPTZ87b6MkkNSVmFCQQl0XiYGoUOqiFAPb/kLBT
         /N6bPydWtN7LBIfmHwNg+uu7+TfMfno8TLIwEa3JDlgHZX+rWY2SLyJ93Gvyde7to7sJ
         Nl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKK6va0e2ppEidijJ2JejfttkTrL2zLHSQMqRJT6mMo=;
        b=B3Swdw2uYToFGYcrTs6oamdk1JcPdHFLheCiP0fE7ap2IZG20qLJlbfuPf3jCVYMR+
         24e4LnCa5xPfPu+Fm8h9pE+ocIfjh1Rli+tnjhlI8uFJBqrfppjrdj1TZCYQOz8ESkdU
         hZzbei2pn7MiEIhcDHs1DqYw8H13ydk2VpbrDsNN7N3uUmbviyeMHqhN5Cu7vxaXC2fg
         6ldAK8pxcotgK3kPJxDv3GuX1sEag6c0zn9us7xKoqYeo10KiGhC/W0baO7upP5J0nQw
         X6ddNuf48EbXGYbEG281dq3PAZmpKoZldZstrsif3xwwmuqHi60QBTXmvjbhIZP2nLuQ
         wd5Q==
X-Gm-Message-State: AOAM532Rn82SAmUUt5beXkqEkPr7DNTLs+UGApx+qyuEYRkU5FnBRMqu
        Hln8Q3oLM7+WiUWCxKjRJWhuOI+dOebGLw==
X-Google-Smtp-Source: ABdhPJyAUf1zhYBKTQ9AsPn0S+h7C/lJMoNzxoQIV2WUdoQi3Qo8Oudzt2IxJ5KyhtSdvrTPQq4QBA==
X-Received: by 2002:a05:622a:183:: with SMTP id s3mr5702181qtw.13.1618845377096;
        Mon, 19 Apr 2021 08:16:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:16 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 05/11 v2] libsepol/cil: Set class field to NULL when resetting struct cil_classperms
Date:   Mon, 19 Apr 2021 11:15:51 -0400
Message-Id: <20210419151557.87561-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
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

