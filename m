Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D8C433E0
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 18:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3B020823
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRyWvsZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbgEZSvK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgEZSvJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 14:51:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA05C03E96D
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 11:51:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c12so2849780qkk.13
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfybXLokL70Cp5JcnYrtIeThoFCOuRALUzEIfhnaEqY=;
        b=LRyWvsZnu2Cv4W3n6ieyLW0PkdHp4pArBRRJrM1gJf6OC8vfuTivkoME93Aev63O8v
         LCLRVpQxoJ4IrHLgSwwvWxwFCc+dsekyglG51KWSYX2aSDBLisOzp3qIarm40grTqgi/
         HyYl63Lb1fYUaRTf4f6rNEcvvIMpf7pa0/k3FzqutvEW7Tl1Gz7zZX5ocOz9aNEREt8a
         nnj5Oe+ik1cNz4ewrYT7+JKyN+P8iFfK0mb75rh4eB1LweQC4uiOTEvWlvTRd1v2Is5J
         4rIjqd2DGfe3kg0lWqOATe83+aOS+zTiDlUKZoEabOtzxFe/X50R1YTj+TYHTfjaZA1+
         Th8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfybXLokL70Cp5JcnYrtIeThoFCOuRALUzEIfhnaEqY=;
        b=LGjIVsq/Jw1ZOCegpn8W2qeb+AhA+N+EBT1KYD4L39kZHX0SJrhE7vAYwlfS3VeC+Y
         d0zNflOEweWEBhkRl8GBgbzfjV71gaSRgwy3cscXV9RkoAQm0QF+r6Th1wtKuKDiLsdS
         2IFmIBmV2puf3bHVQt0/0M4LOJf3dhx9yQSVuASyVjG29JkT/IZ3LrZCyQqe0FSRNKzd
         80mMeFO/wAG8t46sweZB3rSMSXXjpDy1VziFeoIh8Q5tfAjm0An/4Mz+ctH+7+CDGhRq
         RVhDfMeO0nlqJDUiizp1T+DrRw7Ps5E30y33ZYdUb9Ck6sKkYTfszjR4qnvrz25WevAO
         c6qw==
X-Gm-Message-State: AOAM533QWpF3tldO+PGgOYge6/OZSnH2HWGUnhCHksUbwHjZIwWmEwBW
        w6RCmylOigYIUGMlxmDbSDTqeO1o
X-Google-Smtp-Source: ABdhPJwri3JwDiHW4VnVajtZ36Ear3FRHQjJLr7Z+WyBQY15eJW3DWdPv54X5BIRwup74izdUDgbeA==
X-Received: by 2002:a05:620a:b03:: with SMTP id t3mr210900qkg.317.1590519068782;
        Tue, 26 May 2020 11:51:08 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-97-86.bltmmd.east.verizon.net. [71.166.97.86])
        by smtp.gmail.com with ESMTPSA id n13sm488718qtb.20.2020.05.26.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:51:08 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/2] libsepol/cil: Initialize the multiple_decls field of the cil db
Date:   Tue, 26 May 2020 14:50:57 -0400
Message-Id: <20200526185058.42827-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Initialize the multiple_decls field when intializing the structure
cil_db.

Fixes: fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare types[attributes]")
Reported-by: Topi Miettinen <toiwoton@gmail.com
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 4a77aa9c..a3c6a293 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -459,6 +459,7 @@ void cil_db_init(struct cil_db **db)
 	(*db)->preserve_tunables = CIL_FALSE;
 	(*db)->handle_unknown = -1;
 	(*db)->mls = -1;
+	(*db)->multiple_decls = CIL_FALSE;
 	(*db)->target_platform = SEPOL_TARGET_SELINUX;
 	(*db)->policy_version = POLICYDB_VERSION_MAX;
 }
-- 
2.25.4

