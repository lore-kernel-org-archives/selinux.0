Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA8C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB62E21927
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbeLUUT3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:19:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54100 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeLUUT3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:19:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so6381451wmb.3
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 12:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOZzE1SxmsUzMRMIvQJ4lLza8XAJyNO3SDAESoMt/dI=;
        b=qA7W76iMHMezVgYlzharjhI+DRx2mxUT4AWipxrUX9UnqLmqwPoMhoQFPUzLbRY0Qn
         q3vyeSUkalPBPmh2dVzohufx7l3ac8PaES+TXj+isRqzjNMu3J/DFpl3wDS2B/X1xbhP
         bZWpO3FNJEa7ysgg3Hrs9Sj6g/i/6h7G1c4HMUFIvgETEzWoy6wnYMXqSj2IYpusePgL
         7K/wKrdn6raG3lL4w9gSVRGxpUyUJ6S3cnHWwqvv5K/jlpw7UyZUbxj+j77oliqrgM1M
         C8ghLu1AxFI+sP3wlvS0nqwdIlYE0MdQ9J6IxSgyKAuMbC/8RKd6erxS8mOrKxA9gl9T
         9BJg==
X-Gm-Message-State: AA+aEWbMKgLVAJYa9LGZSUVFIoXefy/5BXFtBH0IMD+1xtoWlesWfuty
        IcgK1WsRdYoDGTDko6mo7Ty/1Vpvhwg=
X-Google-Smtp-Source: ALg8bN63fKSXxMzaxkyoeIysVlLRgjCECJyGXSjxkz/6WifSwmvsGKuFKClseNJkzne0szltdstlFQ==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr4220263wme.41.1545423566744;
        Fri, 21 Dec 2018 12:19:26 -0800 (PST)
Received: from localhost.localdomain.com (adsl-dyn216.78-99-85.t-com.sk. [78.99.85.216])
        by smtp.gmail.com with ESMTPSA id r12sm17378087wrq.3.2018.12.21.12.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 12:19:25 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 1/2] selinux: never allow relabeling on context mounts
Date:   Fri, 21 Dec 2018 21:18:52 +0100
Message-Id: <20181221201853.24015-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221201853.24015-1-omosnace@redhat.com>
References: <20181221201853.24015-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the SECURITY_FS_USE_MNTPOINT case we never want to allow relabeling
files/directories, so we should never set the SBLABEL_MNT flag. The
'special handling' in selinux_is_sblabel_mnt() is only intended for when
the behavior is set to SECURITY_FS_USE_GENFS.

While there, make the logic in selinux_is_sblabel_mnt() more explicit
and add a BUILD_BUG_ON() to make sure that introducing a new
SECURITY_FS_USE_* forces a review of the logic.

Fixes: d5f3a5f6e7e7 ("selinux: add security in-core xattr support for pstore and debugfs")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce012d9ec51..b4759bebeddc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -497,16 +497,10 @@ static int may_context_mount_inode_relabel(u32 sid,
 	return rc;
 }
 
-static int selinux_is_sblabel_mnt(struct super_block *sb)
+static int selinux_is_genfs_special_handling(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
-
-	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
-		sbsec->behavior == SECURITY_FS_USE_TRANS ||
-		sbsec->behavior == SECURITY_FS_USE_TASK ||
-		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
-		/* Special handling. Genfs but also in-core setxattr handler */
-		!strcmp(sb->s_type->name, "sysfs") ||
+	/* Special handling. Genfs but also in-core setxattr handler */
+	return	!strcmp(sb->s_type->name, "sysfs") ||
 		!strcmp(sb->s_type->name, "pstore") ||
 		!strcmp(sb->s_type->name, "debugfs") ||
 		!strcmp(sb->s_type->name, "tracefs") ||
@@ -516,6 +510,34 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 		  !strcmp(sb->s_type->name, "cgroup2")));
 }
 
+static int selinux_is_sblabel_mnt(struct super_block *sb)
+{
+	struct superblock_security_struct *sbsec = sb->s_security;
+
+	/*
+	 * IMPORTANT: Double-check logic in this function when adding a new
+	 * SECURITY_FS_USE_* definition!
+	 */
+	BUILD_BUG_ON(SECURITY_FS_USE_MAX != 7);
+
+	switch (sbsec->behavior) {
+	case SECURITY_FS_USE_XATTR:
+	case SECURITY_FS_USE_TRANS:
+	case SECURITY_FS_USE_TASK:
+	case SECURITY_FS_USE_NATIVE:
+		return 1;
+
+	case SECURITY_FS_USE_GENFS:
+		return selinux_is_genfs_special_handling(sb);
+
+	/* Never allow relabeling on context mounts */
+	case SECURITY_FS_USE_MNTPOINT:
+	case SECURITY_FS_USE_NONE:
+	default:
+		return 0;
+	}
+}
+
 static int sb_finish_set_opts(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
-- 
2.19.2

