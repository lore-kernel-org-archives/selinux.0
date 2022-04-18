Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02310C433FE
	for <selinux@archiver.kernel.org>; Mon, 18 Apr 2022 09:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiDRJtD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiDRJtD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Apr 2022 05:49:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2E11659D;
        Mon, 18 Apr 2022 02:46:23 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KhhrN08FXz1GCNq;
        Mon, 18 Apr 2022 17:45:40 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:22 +0800
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:20 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <alexander.kozhevnikov@huawei.com>, <artem.kuzin@huawei.com>,
        <hw.likun@huawei.com>, <igor.baranov@huawei.com>,
        <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <yusongping@huawei.com>, <anton.sirazetdinov@huawei.com>
Subject: [RFC PATCH 3/7] SELINUXNS: Fix initilization of the superblock security under spinlock
Date:   Mon, 18 Apr 2022 17:45:48 +0800
Message-ID: <20220418094552.128898-4-alexander.kozhevnikov@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220418094552.128898-1-alexander.kozhevnikov@huawei.com>
References: <CAHC9VhTDu1GDxJwFg5gAMWhuMKUWEU5eXuTr_6eG=tGwiGsMTw@mail.gmail.com>
 <20220418094552.128898-1-alexander.kozhevnikov@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.219.174.70]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Igor Baranov <igor.baranov@huawei.com>

After porting 3378718ef7d4a837f32c63bdfcc0b70342cdd55d,
selinux_superblock() started being called from under spinlock, along
with kzalloc(GFP_NOFS), which causes a scheduling while atomic error.
The solution is to take the call to selinux_superblock() out from under
the spinlock.

Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
Signed-off-by: Igor Baranov <igor.baranov@huawei.com>
---
 security/selinux/hooks.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a1716ce534dd..f02e31edae7c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1408,13 +1408,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->initialized == LABEL_INITIALIZED)
 		return 0;
 
-	spin_lock(&isec->lock);
-	if (isec->initialized == LABEL_INITIALIZED)
-		goto out_unlock;
-
-	if (isec->sclass == SECCLASS_FILE)
-		isec->sclass = inode_mode_to_security_class(inode->i_mode);
-
 	sbsec = selinux_superblock(inode->i_sb);
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
@@ -1424,9 +1417,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		if (list_empty(&isec->list))
 			list_add(&isec->list, &sbsec->isec_head);
 		spin_unlock(&sbsec->isec_lock);
-		goto out_unlock;
+		return 0;
 	}
 
+	spin_lock(&isec->lock);
+	if (isec->initialized == LABEL_INITIALIZED)
+		goto out_unlock;
+
+	if (isec->sclass == SECCLASS_FILE)
+		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	sclass = isec->sclass;
 	task_sid = isec->task_sid;
 	sid = isec->sid;
-- 
2.34.1

