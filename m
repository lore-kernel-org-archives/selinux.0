Return-Path: <SRS0=790g=XQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BF9C3A5A2
	for <selinux@archiver.kernel.org>; Sat, 21 Sep 2019 01:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4252B2086A
	for <selinux@archiver.kernel.org>; Sat, 21 Sep 2019 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437210AbfIUBzw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:55:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38614 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437018AbfIUBzw (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 20 Sep 2019 21:55:52 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 3C6878FF3F0438D8E6E6;
        Sat, 21 Sep 2019 09:55:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x8L1ta04061200;
        Sat, 21 Sep 2019 09:55:36 +0800 (GMT-8)
        (envelope-from zhang.lin16@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019092109561847-3748946 ;
          Sat, 21 Sep 2019 09:56:18 +0800 
From:   zhanglin <zhang.lin16@zte.com.cn>
To:     paul@paul-moore.com
Cc:     sds@tycho.nsa.gov, eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH] selinux: Remove load size limit
Date:   Sat, 21 Sep 2019 09:57:15 +0800
Message-Id: <1569031035-12354-1-git-send-email-zhang.lin16@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-09-21 09:56:18,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-09-21 09:55:42,
        Serialize complete at 2019-09-21 09:55:42
X-MAIL: mse-fl1.zte.com.cn x8L1ta04061200
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Load size was limited to 64MB, this was legacy limitation due to vmalloc()
which was removed a while ago.

Limiting load size to 64MB is both pointless and affects real world use
cases.

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
---
 security/selinux/selinuxfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f3a5a138a096..4249400e9712 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -549,10 +549,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (*ppos != 0)
 		goto out;
 
-	length = -EFBIG;
-	if (count > 64 * 1024 * 1024)
-		goto out;
-
 	length = -ENOMEM;
 	data = vmalloc(count);
 	if (!data)
-- 
2.17.1

