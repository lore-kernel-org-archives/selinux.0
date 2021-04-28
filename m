Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B85C433ED
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 10:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E7C6142A
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 10:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhD1KBJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 06:01:09 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43219 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238733AbhD1KBI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 06:01:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UX3eBtw_1619604016;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UX3eBtw_1619604016)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 18:00:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] selinux: Remove redundant assignment to rc
Date:   Wed, 28 Apr 2021 18:00:15 +0800
Message-Id: <1619604015-117734-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Variable rc is set to '-EINVAL' but this value is never read as
it is overwritten or not used later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

security/selinux/ss/services.c:2103:3: warning: Value stored to 'rc' is
never read [clang-analyzer-deadcode.DeadStores].

security/selinux/ss/services.c:2079:2: warning: Value stored to 'rc' is
never read [clang-analyzer-deadcode.DeadStores].

security/selinux/ss/services.c:2071:2: warning: Value stored to 'rc' is
never read [clang-analyzer-deadcode.DeadStores].

security/selinux/ss/services.c:2062:2: warning: Value stored to 'rc' is
never read [clang-analyzer-deadcode.DeadStores].

security/selinux/ss/policydb.c:2592:3: warning: Value stored to 'rc' is
never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/selinux/ss/policydb.c | 1 -
 security/selinux/ss/services.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9fccf41..defc5ef 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2589,7 +2589,6 @@ int policydb_read(struct policydb *p, void *fp)
 		if (rc)
 			goto bad;
 
-		rc = -EINVAL;
 		rtk->role = le32_to_cpu(buf[0]);
 		rtk->type = le32_to_cpu(buf[1]);
 		rtd->new_role = le32_to_cpu(buf[2]);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f0ba826..3331766 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2059,7 +2059,6 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	context_init(newc);
 
 	/* Convert the user. */
-	rc = -EINVAL;
 	usrdatum = symtab_search(&args->newp->p_users,
 				 sym_name(args->oldp,
 					  SYM_USERS, oldc->user - 1));
@@ -2068,7 +2067,6 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	newc->user = usrdatum->value;
 
 	/* Convert the role. */
-	rc = -EINVAL;
 	role = symtab_search(&args->newp->p_roles,
 			     sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
 	if (!role)
@@ -2076,7 +2074,6 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	newc->role = role->value;
 
 	/* Convert the type. */
-	rc = -EINVAL;
 	typdatum = symtab_search(&args->newp->p_types,
 				 sym_name(args->oldp,
 					  SYM_TYPES, oldc->type - 1));
@@ -2100,7 +2097,6 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 		oc = args->newp->ocontexts[OCON_ISID];
 		while (oc && oc->sid[0] != SECINITSID_UNLABELED)
 			oc = oc->next;
-		rc = -EINVAL;
 		if (!oc) {
 			pr_err("SELinux:  unable to look up"
 				" the initial SIDs list\n");
-- 
1.8.3.1

