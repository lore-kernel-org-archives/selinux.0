Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C5C4CEC9
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B05222BD
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 07:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfIQHUp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:20:45 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:64644 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbfIQHUp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 17 Sep 2019 03:20:45 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 91CB34ED71A3E664AA02;
        Tue, 17 Sep 2019 15:20:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x8H7Ine1018416;
        Tue, 17 Sep 2019 15:18:49 +0800 (GMT-8)
        (envelope-from zhang.lin16@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019091715190161-3647147 ;
          Tue, 17 Sep 2019 15:19:01 +0800 
From:   zhanglin <zhang.lin16@zte.com.cn>
To:     paul@paul-moore.com
Cc:     sds@tycho.nsa.gov, eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH] selinux: improve performance of sel_write_load()
Date:   Tue, 17 Sep 2019 15:20:36 +0800
Message-Id: <1568704836-14357-1-git-send-email-zhang.lin16@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-09-17 15:19:01,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-09-17 15:18:51,
        Serialize complete at 2019-09-17 15:18:51
X-MAIL: mse-fl1.zte.com.cn x8H7Ine1018416
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

remove unecessary multiplications of sel_write_load().

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
---
 security/selinux/selinuxfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f3a5a138a096..4b2d87b6fcf9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -117,6 +117,7 @@ static void selinux_fs_info_free(struct super_block *sb)
 #define SEL_CLASS_INO_OFFSET		0x04000000
 #define SEL_POLICYCAP_INO_OFFSET	0x08000000
 #define SEL_INO_MASK			0x00ffffff
+#define SEL_LOAD_MAX			0x04000000
 
 #define TMPBUFLEN	12
 static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
@@ -550,7 +551,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		goto out;
 
 	length = -EFBIG;
-	if (count > 64 * 1024 * 1024)
+	if (count > SEL_LOAD_MAX)
 		goto out;
 
 	length = -ENOMEM;
-- 
2.17.1

