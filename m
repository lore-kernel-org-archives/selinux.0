Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D31DC43334
	for <selinux@archiver.kernel.org>; Sat, 11 Jun 2022 09:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiFKJHx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Jun 2022 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiFKJHw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Jun 2022 05:07:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B982CE097;
        Sat, 11 Jun 2022 02:07:49 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LKsPb2Cqwz1K9Bg;
        Sat, 11 Jun 2022 17:05:55 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 17:07:47 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <omosnace@redhat.com>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] selinux: Fix potential memory leak in selinux_add_opt
Date:   Sat, 11 Jun 2022 17:05:50 +0800
Message-ID: <20220611090550.135674-1-xiujianfeng@huawei.com>
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

In the entry of selinux_add_opt, *mnt_opts may be assigned to new
allocated memory, and also may be freed and reset at the end of the
function. however, if security_context_str_to_sid failed, it returns
directly and skips the procedure for free and reset, even if it may be
handled at the caller of this function, It is better to handle it
inside.

Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/hooks.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4af4986d3893..3d67c1dab2c6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -949,7 +949,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	struct selinux_mnt_opts *opts = *mnt_opts;
 	bool is_alloc_opts = false;
 	u32 *dst_sid;
-	int rc;
+	int rc = -EINVAL;
 
 	if (token == Opt_seclabel)
 		/* eaten and completely ignored */
@@ -993,13 +993,15 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		break;
 	default:
 		WARN_ON(1);
-		return -EINVAL;
+		goto err;
 	}
 	rc = security_context_str_to_sid(&selinux_state, s, dst_sid, GFP_KERNEL);
-	if (rc)
+	if (rc) {
 		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
 			s, rc);
-	return rc;
+		goto err;
+	}
+	return 0;
 
 err:
 	if (is_alloc_opts) {
@@ -1007,7 +1009,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		*mnt_opts = NULL;
 	}
 	pr_warn(SEL_MOUNT_FAIL_MSG);
-	return -EINVAL;
+	return rc;
 }
 
 static int show_sid(struct seq_file *m, u32 sid)
-- 
2.17.1

