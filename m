Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88784C4338F
	for <selinux@archiver.kernel.org>; Thu, 29 Jul 2021 03:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2D260F59
	for <selinux@archiver.kernel.org>; Thu, 29 Jul 2021 03:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhG2DPi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:15:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7765 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DPh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 23:15:37 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZwVm4ggHzYh8R;
        Thu, 29 Jul 2021 11:09:36 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 11:15:33 +0800
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 11:15:29 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next, v2] selinux: correct the return value when loads initial sids
Date:   Thu, 29 Jul 2021 11:16:44 +0800
Message-ID: <20210729031644.47679-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It should not return 0 when SID 0 is assigned to isids.
This patch fixes it.

v2: remove the "out" label and return directly.

Fixes: e3e0b582c321a ("selinux: remove unused initial SIDs and improve handling")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/ss/policydb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index defc5ef35c66..0ae1b718194a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -874,7 +874,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	rc = sidtab_init(s);
 	if (rc) {
 		pr_err("SELinux:  out of memory on SID table init\n");
-		goto out;
+		return rc;
 	}
 
 	head = p->ocontexts[OCON_ISID];
@@ -885,7 +885,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		if (sid == SECSID_NULL) {
 			pr_err("SELinux:  SID 0 was assigned a context.\n");
 			sidtab_destroy(s);
-			goto out;
+			return -EINVAL;
 		}
 
 		/* Ignore initial SIDs unused by this kernel. */
@@ -897,12 +897,10 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 			pr_err("SELinux:  unable to load initial SID %s.\n",
 			       name);
 			sidtab_destroy(s);
-			goto out;
+			return rc;
 		}
 	}
-	rc = 0;
-out:
-	return rc;
+	return 0;
 }
 
 int policydb_class_isvalid(struct policydb *p, unsigned int class)
-- 
2.17.1

