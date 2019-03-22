Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B6FC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC08A218A5
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 14:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfCVOEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:04:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbfCVOEX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 22 Mar 2019 10:04:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93AB923E581FDAC0502D;
        Fri, 22 Mar 2019 22:04:18 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:04:09 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <paul@paul-moore.com>, <sds@tycho.nsa.gov>, <eparis@parisplace.org>
CC:     <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] selinux: Make selinux_kernfs_init_security static
Date:   Fri, 22 Mar 2019 22:04:00 +0800
Message-ID: <20190322140400.18892-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

security/selinux/hooks.c:3389:5: warning:
 symbol 'selinux_kernfs_init_security' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ab4b049..b6e6152 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3386,8 +3386,8 @@ static int selinux_inode_copy_up_xattr(const char *name)
 
 /* kernfs node operations */
 
-int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
-				 struct kernfs_node *kn)
+static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
+					struct kernfs_node *kn)
 {
 	const struct task_security_struct *tsec = current_security();
 	u32 parent_sid, newsid, clen;
-- 
2.7.0


