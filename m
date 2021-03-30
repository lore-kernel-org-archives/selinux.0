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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C330C433E4
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E61561953
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhC3RkI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhC3Rjp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09458C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:45 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 1so11859545qtb.0
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0KbmHCiBoyaD5qRh9OPGvlIT2r7grJT/Aetoyk0myI=;
        b=hKuJPrCyc4iN4tWgKgSx2w/kHPb6nu0VIcvAF+bNBm7z+leEBEXJzC7jsIR40i4d82
         AOSSu7V/dTDS2ME+Kd0IdvQU3Tj2PdOPBkD5jxctTdwesrOnzlrKqo2hMGdEGOnJqLVj
         8frh5gCO9uQGOo36i8EAutfkRdNGumWhTbvMbO3vzcxd+26yIJcefH/xBSxfsx4BANjJ
         IffQchyqFIeIw9ZYwboUoyliXNW57BNhfuSFMu/DbNKOYAaPvS/FJZpDPDDO4+GMJbFS
         /9ErkiGjVXf8gQvzujds4Nly7otjjmV7uO//jkNpCM79eNrm71rqsO71MQEwTAMGArO0
         UmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0KbmHCiBoyaD5qRh9OPGvlIT2r7grJT/Aetoyk0myI=;
        b=H7qz4So01G6DhNVZXjPbsygZc2jFuunddj/Y29h3CiJ1kncX3Yy036ydrs8sTE86VK
         r1TvLs+CRU6Klfafydj+50lGa5IH94UELQUwywK1r9B1/5Hv0vOlCV47ufu6zttKofN9
         0bAku8ZlVtcoTDDlpcLbwDKzJyLtWQBXa9FMhFRBV5I5bobwEdqXTQtpDe0F66Yr3R7Z
         oP5k+4dCBtuArGvIFeR6R+4//7cG012ZgzMfwM7p2IMptN+9TEocfXYUE5t6qQFHNhsG
         XhQVokmCmc8IgPqyf/ZmPE1tAwsbWlyi0hzlgs11p10IOmmySlgOtrp3YbFkF+f5x9SP
         Xoog==
X-Gm-Message-State: AOAM530926hkZtSJRFCQpVd0DvanWWDA8m+L22ctftmBBg5XYMkdnl+K
        BWEsNGp7lDt9CuXQgr6QqM9lWbvQDI5vcw==
X-Google-Smtp-Source: ABdhPJwLIYkOiZJQBQ1Y4DwaoLknnIAT5lW/6n9tu+3GLyUXSVHwBDS0GXMc/XiSjf3v/tUtKVoLHQ==
X-Received: by 2002:ac8:5f87:: with SMTP id j7mr3647170qta.135.1617125984205;
        Tue, 30 Mar 2021 10:39:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 09/12] libsepol/cil: Do not allow tunable declarations in in-statements
Date:   Tue, 30 Mar 2021 13:39:20 -0400
Message-Id: <20210330173920.281531-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since tunableifs are resolved before in-statements, do not allow
tuanble declarations in in-statements.

Since in-statements are the first flavor of statement that causes
part of the AST to be copied to another part, there is no need to
check the in-statements when resolving the AST.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 1fef25d4..df7bb950 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6130,7 +6130,8 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	}
 
 	if (in != NULL) {
-		if (parse_current->data == CIL_KEY_IN) {
+		if (parse_current->data == CIL_KEY_TUNABLE ||
+			parse_current->data == CIL_KEY_IN) {
 			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "Found in-statement");
 			cil_log(CIL_ERR, "in-statements cannot be defined within in-statements\n");
-- 
2.26.3

