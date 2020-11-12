Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2144BC2D0A3
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D219C20825
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 08:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKLIu4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 03:50:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7492 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKLIu4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 03:50:56 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CWwKw2FCpzhh7x;
        Thu, 12 Nov 2020 16:50:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 16:50:41 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <danielj@mellanox.com>,
        <dledford@redhat.com>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] selinux: Fix error return code in sel_ib_pkey_sid_slow()
Date:   Thu, 12 Nov 2020 16:55:42 +0800
Message-ID: <20201112085542.182692-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix to return a negative error code from the error handling case
instead of 0 in function sel_ib_pkey_sid_slow(), as done elsewhere
in this function.

Fixes: 409dcf31538a ("selinux: Add a cache for quicker retreival of PKey SIDs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 security/selinux/ibpkey.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index f68a7617cfb9..680b2dd1520f 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -151,8 +151,10 @@ static int sel_ib_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
 	 * is valid, it just won't be added to the cache.
 	 */
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (!new)
+	if (IS_ERR(new)) {
+		ret = PTR_ERR(new);
 		goto out;
+	}
 
 	new->psec.subnet_prefix = subnet_prefix;
 	new->psec.pkey = pkey_num;
-- 
2.20.1

