Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613AAC433EF
	for <selinux@archiver.kernel.org>; Tue, 21 Jun 2022 06:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbiFUGkg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jun 2022 02:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUGkg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jun 2022 02:40:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E491900A;
        Mon, 20 Jun 2022 23:40:34 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRxgs3ChgzkWcr;
        Tue, 21 Jun 2022 14:39:21 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 14:40:32 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] selinux: Cleanup the enum SEL_COMPAT_NET
Date:   Tue, 21 Jun 2022 14:38:24 +0800
Message-ID: <20220621063824.241527-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The "compat_net" compatibility code has been removed since commit
58bfbb51ff2b ("selinux: Remove the "compat_net" compatibility code"),
so SEL_COMPAT_NET need to be removed as well.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/selinuxfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8fcdd494af27..7115ca91ec05 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -58,7 +58,6 @@ enum sel_inos {
 	SEL_DISABLE,	/* disable SELinux until next reboot */
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
-	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
 	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
 	SEL_STATUS,	/* export current status using mmap() */
-- 
2.17.1

