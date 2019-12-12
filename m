Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0617C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 02:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6748214D8
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 02:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLLCCT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:02:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbfLLCCT (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 11 Dec 2019 21:02:19 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E30229945177F42B14C3;
        Thu, 12 Dec 2019 10:02:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 12 Dec 2019 10:02:08 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <selinux@vger.kernel.org>
CC:     Yang Guo <guoyang2@huawei.com>, Paul Moore <paul@paul-moore.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Shaokun Zhang" <zhangshaokun@hisilicon.com>
Subject: [PATCH] selinux: remove unnecessary selinux cred request
Date:   Thu, 12 Dec 2019 10:02:24 +0800
Message-ID: <1576116144-55503-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Yang Guo <guoyang2@huawei.com>

task_security_struct was obtained at the beginning of may_create
and selinux_inode_init_security, no need to obtain again.
may_create will be called very frequently when create dir and file.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Signed-off-by: Yang Guo <guoyang2@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 security/selinux/hooks.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 116b4d644f68..64bc69426369 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1833,8 +1833,8 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = selinux_determine_inode_label(selinux_cred(current_cred()), dir,
-					   &dentry->d_name, tclass, &newsid);
+	rc = selinux_determine_inode_label(tsec, dir, &dentry->d_name, tclass,
+					   &newsid);
 	if (rc)
 		return rc;
 
@@ -2906,8 +2906,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	newsid = tsec->create_sid;
 
-	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
-		dir, qstr,
+	rc = selinux_determine_inode_label(tsec, dir, qstr,
 		inode_mode_to_security_class(inode->i_mode),
 		&newsid);
 	if (rc)
-- 
2.7.4

