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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5704EC43460
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FD661264
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhEMS4B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhEMS4B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 14:56:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B924C06174A
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id l129so26522106qke.8
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbDoe6xas0UFhwO4qpY/2lEzLmZw7R8VmcG0YIrhVxY=;
        b=RBafFan4zok9R6mZzTE9jjQ4/6aYx4lAi7ZAi2BNqGb2qISwhOO7NMmQ7+RqOtgH6c
         le6y7boffsTwa0hMZi7aB4CT6y5NH5InhWFoE1Rt+RtfYtbg4mPQBjcAwBz5NruMho3W
         3+tNgn0mQxWcqqh9zSn3J/OzLstZj2ReFeowUS6mEbwPunpPeDINNe7C0vT7fEovp+zp
         4q1kmeqFUoLU5LX4Oh17m1xx/ekUOa8sIkbNAibAtq5tIVq3FXaLev5A8JLdDWV8SFgI
         B0hZu4GKtV0rSd1HNIykdhale8A9n+Ze6wK7fFan48/t4SvjLfsUdkYjqELD0uzFibKW
         2AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbDoe6xas0UFhwO4qpY/2lEzLmZw7R8VmcG0YIrhVxY=;
        b=JrLXJ8p5hoD7AZe9UePcRbcbGm/sbyv/zUG3/6lWxrr/3ySSgMrmLz6oDcWPZsbC2r
         vfn9BRm85InXkj7oCQenzfavGgWYd28QPJS2HOJTroQbNkBse16peRgKJcV7p78dbUZ2
         TMcwlRj7C6KQz2QfrPPC16M8kd8PQSAo/JlGrLEQvrfqH/czglvFXp2kURgZUAtRym/f
         w9y21SzGwkRKhp628ihEGugn357fUTTPuTKR3VOp6VUS8TjbbzpSrrVelOCbCK/KmC1+
         fMCNlKPnMOEPvXNtS8Qdpe+Tfqe8QrP3im2db3cZTZbVWBOB97xYKVVLlKGSNljAsEUB
         Msdg==
X-Gm-Message-State: AOAM531umBbdfLHcNnMW+9dmSnpoG5v+ZF+7uzhKabzcW6vELZeBj0AR
        Ji/zhwWXTtxaDos11h2WSyXUYhiKOASTqQ==
X-Google-Smtp-Source: ABdhPJyBTioP4wqdgdXuXJ9yhMVZEKPE3kC9Sv6nFTsxm+8Zzi11K3N6qKZ3/wI3Up+K15D4dlF0GA==
X-Received: by 2002:a05:620a:1675:: with SMTP id d21mr21536314qko.390.1620932090465;
        Thu, 13 May 2021 11:54:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h188sm1713767qkf.133.2021.05.13.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:54:50 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6] libsepol/cil: Resolve anonymous levels only once
Date:   Thu, 13 May 2021 14:52:54 -0400
Message-Id: <20210513185254.559588-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513185254.559588-1-jwcart2@gmail.com>
References: <20210513185254.559588-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Anonymous levels can be passed as call arguments and they can
appear in anonymous levelranges as well.

Anonymous call arguments are resolved when they are used in a rule.
If more than one rule uses the anonymous level, then a memory leak
will occur when a new list for the category datum expression is
created without destroying the old one.

When resolving a level, check if the sensitivity datum has already
been resolved. If it has, then the categories have been as well.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 865297fb..9c95f2a0 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1700,6 +1700,10 @@ int cil_resolve_level(struct cil_tree_node *current, struct cil_level *level, vo
 	struct cil_symtab_datum *sens_datum = NULL;
 	int rc = SEPOL_ERR;
 
+	if (level->sens) {
+		return SEPOL_OK;
+	}
+
 	rc = cil_resolve_name(current, (char*)level->sens_str, CIL_SYM_SENS, extra_args, &sens_datum);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Failed to find sensitivity\n");
-- 
2.26.3

