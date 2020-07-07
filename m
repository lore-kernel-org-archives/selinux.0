Return-Path: <SRS0=l4yV=AS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F80C433DF
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 04:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9742053B
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 04:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGEA2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:00:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbgGGEA2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 7 Jul 2020 00:00:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EBF267B42C9A29E7A6AE;
        Tue,  7 Jul 2020 12:00:17 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.217) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 12:00:07 +0800
From:   lihao <fly.lihao@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <selinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <fly.lihao@huawei.com>, <young.liuyang@huawei.com>
Subject: [PATCH] security/selinux: Fix spelling mistakes in the comments
Date:   Tue, 7 Jul 2020 12:00:04 +0800
Message-ID: <1594094404-69691-1-git-send-email-fly.lihao@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.217]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix spelling mistakes in the comments
    quering==>querying

Signed-off-by: lihao <fly.lihao@huawei.com>
---
 security/selinux/netif.c   | 2 +-
 security/selinux/netnode.c | 2 +-
 security/selinux/netport.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 15b8c1b..86813b4 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -124,7 +124,7 @@ static void sel_netif_destroy(struct sel_netif *netif)
  * @sid: interface SID
  *
  * Description:
- * This function determines the SID of a network interface by quering the
+ * This function determines the SID of a network interface by querying the
  * security policy.  The result is added to the network interface table to
  * speedup future queries.  Returns zero on success, negative values on
  * failure.
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index dff587d..461fb54 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -181,7 +181,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
  * @sid: node SID
  *
  * Description:
- * This function determines the SID of a network address by quering the
+ * This function determines the SID of a network address by querying the
  * security policy.  The result is added to the network address table to
  * speedup future queries.  Returns zero on success, negative values on
  * failure.
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index de727f7..d340f4d 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -130,7 +130,7 @@ static void sel_netport_insert(struct sel_netport *port)
  * @sid: port SID
  *
  * Description:
- * This function determines the SID of a network port by quering the security
+ * This function determines the SID of a network port by querying the security
  * policy.  The result is added to the network port table to speedup future
  * queries.  Returns zero on success, negative values on failure.
  *
-- 
1.8.5.6

