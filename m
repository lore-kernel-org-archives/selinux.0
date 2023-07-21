Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3039DEB64DD
	for <selinux@archiver.kernel.org>; Fri, 21 Jul 2023 03:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGUDcw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 23:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUDcv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 23:32:51 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7D1BF7;
        Thu, 20 Jul 2023 20:32:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VnsoRWg_1689910358;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VnsoRWg_1689910358)
          by smtp.aliyun-inc.com;
          Fri, 21 Jul 2023 11:32:45 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, bpf@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] selinux: Use NULL for pointers
Date:   Fri, 21 Jul 2023 11:32:36 +0800
Message-Id: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace integer constants with NULL.

security/selinux/hooks.c:251:41: warning: Using plain integer as NULL pointer.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5958
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62072b63b19b..d0818a338fa8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -248,7 +248,7 @@ static void ad_net_init_from_iif(struct common_audit_data *ad,
 				 struct lsm_network_audit *net,
 				 int ifindex, u16 family)
 {
-	__ad_net_init(ad, net, ifindex, 0, family);
+	__ad_net_init(ad, net, ifindex, NULL, family);
 }
 
 /*
-- 
2.20.1.7.g153144c

