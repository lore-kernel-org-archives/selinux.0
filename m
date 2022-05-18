Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9489C433F5
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 01:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiERBV5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 21:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiERBV4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 21:21:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469651BEB4;
        Tue, 17 May 2022 18:21:55 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2wDJ5ZrZzhZFD;
        Wed, 18 May 2022 09:21:04 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 09:21:53 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 09:21:53 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "Kees Cook" <keescook@chromium.org>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH] selinux: add __randomize_layout to selinux_audit_data
Date:   Wed, 18 May 2022 09:21:37 +0000
Message-ID: <20220518092137.141626-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Randomize the layout of struct selinux_audit_data as suggested in [1],
since it contains a pointer to struct selinux_state, an already
randomized strucure.

[1]: https://github.com/KSPP/linux/issues/188

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 security/selinux/include/avc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 2b372f98f2d7..5525b94fd266 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -53,7 +53,7 @@ struct selinux_audit_data {
 	u32 denied;
 	int result;
 	struct selinux_state *state;
-};
+} __randomize_layout;
 
 /*
  * AVC operations
-- 
2.17.1

