Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61490C4338F
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 06:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3778460EB2
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 06:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhG1GaJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 02:30:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12322 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhG1GaJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 02:30:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GZNv63X11z801B;
        Wed, 28 Jul 2021 14:25:22 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 14:30:05 +0800
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 14:30:05 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next] selinux: correct the return value when loads initial sids
Date:   Wed, 28 Jul 2021 14:31:10 +0800
Message-ID: <20210728063110.3652-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It should not return 0 when SID 0 is assigned to isids.
This patch fixes it.

Fixes: e3e0b582c321a ("selinux: remove unused initial SIDs and improve handling")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/ss/policydb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index defc5ef35c66..ad1183e18ce0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -884,6 +884,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 
 		if (sid == SECSID_NULL) {
 			pr_err("SELinux:  SID 0 was assigned a context.\n");
+			rc = -EINVAL;
 			sidtab_destroy(s);
 			goto out;
 		}
-- 
2.17.1

