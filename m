Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56048C433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 11:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376264AbiFPLxK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376955AbiFPLxI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 07:53:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B01B7BD;
        Thu, 16 Jun 2022 04:53:05 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LP0sc4hxJzDrFH;
        Thu, 16 Jun 2022 19:52:36 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 19:53:03 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] selinux: Let the caller free the momory in *mnt_opts on error
Date:   Thu, 16 Jun 2022 19:50:52 +0800
Message-ID: <20220616115052.221803-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It may allocate memory for @mnt_opts if NULL in selinux_add_opt(), and
now some error paths goto @err label while others don't, as suggested
by Paul, don't free memory in case of error and let the caller to cleanup
on error.

And also this patch change the @s NULL check to return -EINVAL instead.

Link: https://lore.kernel.org/lkml/20220611090550.135674-1-xiujianfeng@huawei.com/T/
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/hooks.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4d20a139a86d..0ec03126ac8e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -944,10 +944,12 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	return rc;
 }
 
+/**
+ * NOTE: the caller is resposible for freeing the memory even if on error.
+ */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct selinux_mnt_opts *opts = *mnt_opts;
-	bool is_alloc_opts = false;
 	u32 *dst_sid;
 	int rc;
 
@@ -955,7 +957,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		/* eaten and completely ignored */
 		return 0;
 	if (!s)
-		return -ENOMEM;
+		return -EINVAL;
 
 	if (!selinux_initialized(&selinux_state)) {
 		pr_warn("SELinux: Unable to set superblock options before the security server is initialized\n");
@@ -967,7 +969,6 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		if (!opts)
 			return -ENOMEM;
 		*mnt_opts = opts;
-		is_alloc_opts = true;
 	}
 
 	switch (token) {
@@ -1002,10 +1003,6 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	return rc;
 
 err:
-	if (is_alloc_opts) {
-		kfree(opts);
-		*mnt_opts = NULL;
-	}
 	pr_warn(SEL_MOUNT_FAIL_MSG);
 	return -EINVAL;
 }
-- 
2.17.1

