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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10029C4320A
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 16:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EAE6101A
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 16:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhHSQyU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhHSQyO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Aug 2021 12:54:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D49C061575
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 09:53:37 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d25so2048813qtq.9
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfd6/XVm4ZGbjCxulQi7eQN6VXYus53zvvBVac8ySr8=;
        b=lGamhlKU0nhgzi9KT8J2P6BKfKzY13afHRFjjiD4dGeWQHPu7yO9W4jh/WaYgJSOb0
         oF3GamWK3QQWa7YtE2Xn3chk1rhwRmq1Ccdn1W6ZV8lDbPGUNAtK8ZKiSsT/xiBRJ5K9
         nA7CbTOW5mypXVTvBISU8RrMOKoTYBWjAbqLyIgvZIvbbllOjdjMURSyM5WsEcLsfn+M
         +qHfWXuY2H9Q2+Aps0itjoFIEDAiZqTt+KQssiQBruvNKHH1CnMnZZcsCiPcLQiI5yK/
         jJQEqybw0dTNWE5AxfS2Na0a9SH44SUAjCZEmFMF/vSgdqLVdNCU3NO4ZpUzl8urTVCL
         lZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfd6/XVm4ZGbjCxulQi7eQN6VXYus53zvvBVac8ySr8=;
        b=M3rvYRcZlZtVwSPLkJ5/12BHiZ3Kr3OZS8SOaI6Y36cAA0Fc15t8d+HhUi5Xu+G7wU
         SBaAY+74DwBEMSb3kzDveAltE9UQhYKXZdSU2QlPfqkOapeH4MgkTydUSIBZKRVyhCHk
         FQFjAartVMSRtOkUvpx97rFhbLUOZi9JJSasxQE+fLQD7r68jDgRgierVS1p8KxR7Pg8
         GCc5iZdD0BAxRuABuslKTJZ2uhhwb9tDEhfeVetdvJSnzfkX37p3zPgQjoi6b5ld84iT
         zvDqCfBXhl1XbWyAWoxp3AXep1sMaYul6jyOI0lmUqO7g385Sw6AcougOa6p/KqvZehV
         VtXg==
X-Gm-Message-State: AOAM53163eqbjEcexB+rz3YD2w+MTGsmGCBEqN40EN0T5CQxmgw7xwlV
        UOHFsqQ/2+IsDIExGiG3RhzMXmmfkgCeRw==
X-Google-Smtp-Source: ABdhPJxdzyjkCRm1T3zZm2cEgb9X4h8YoGrUDDg+xWQhbiTEZF1dZJXjdR1MOnJbSWBXXjRyZdmajQ==
X-Received: by 2002:a05:622a:106:: with SMTP id u6mr13470372qtw.288.1629392016961;
        Thu, 19 Aug 2021 09:53:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h140sm1895411qke.112.2021.08.19.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:53:36 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/cil: Remove redundant syntax checking
Date:   Thu, 19 Aug 2021 12:53:31 -0400
Message-Id: <20210819165332.58896-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For every call to cil_fill_classperms_list(), the syntax of the
whole rule, including the class permissions, has already been
checked. There is no reason to check it again. Also, because the
class permissions appear in the middle of some rules, like
constraints, the syntax array does not end with CIL_SYN_END. This
is the only case where the syntax array does not end with CIL_SYN_END.
This prevents __cil_verify_syntax() from requiring that the syntax
array ends with CIL_SYN_END.

Remove the redundant syntax checking in cil_fill_classperms_list().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 9da90883..514cac8d 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -736,20 +736,11 @@ int cil_fill_classperms_list(struct cil_tree_node *parse_current, struct cil_lis
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *curr;
-	enum cil_syntax syntax[] = {
-		CIL_SYN_STRING | CIL_SYN_LIST,
-	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	if (parse_current == NULL || cp_list == NULL) {
 		goto exit;
 	}
 
-	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	cil_list_init(cp_list, CIL_CLASSPERMS);
 
 	curr = parse_current->cl_head;
-- 
2.31.1

