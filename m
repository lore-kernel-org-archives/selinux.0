Return-Path: <SRS0=kXWH=DX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1150C2BD0C
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A060820874
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="khczLff8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408423AbgJPNsx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:48:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53652 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408420AbgJPNsw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Oct 2020 09:48:52 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id B94852090E4E;
        Fri, 16 Oct 2020 06:48:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B94852090E4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1602856132;
        bh=ovyUeHRUrJVB/2XX0dlO2H9mKISmJ1qs+lMXRGhA8nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khczLff8+r+jlEKUfwYVWVzOwqVwX9FQhag7BkX9diA9WAWQ895aNOaDHc46BnPPa
         k4aa6GK8CkRiWRyEvbf830fxWk41+lJlUY2kjHUVjK8fStDdTT8tKefrGKp+8IlLBW
         phTECAoSXa2aWGHbDBnzFIhVeJb6241HzHhW1Atw=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, paul@paul-moore.com,
        selinux@vger.kernel.org, jmorris@namei.org, sashal@kernel.org
Subject: [PATCH v5.4 v2 3/4] selinux: Standardize string literal usage for selinuxfs directory names
Date:   Fri, 16 Oct 2020 09:48:34 -0400
Message-Id: <20201016134835.1886478-4-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201016134835.1886478-1-dburgener@linux.microsoft.com>
References: <20201016134835.1886478-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

upstream commit 613ba18798ac3cf257ecff65d490e8f1aa323588

Switch class and policy_capabilities directory names to be referred to with
global constants, consistent with booleans directory name.  This will allow
for easy consistency of naming in future development.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ea21f3ef4a6f..ae018aaa4391 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -117,6 +117,10 @@ static void selinux_fs_info_free(struct super_block *sb)
 #define SEL_POLICYCAP_INO_OFFSET	0x08000000
 #define SEL_INO_MASK			0x00ffffff
 
+#define BOOL_DIR_NAME "booleans"
+#define CLASS_DIR_NAME "class"
+#define POLICYCAP_DIR_NAME "policy_capabilities"
+
 #define TMPBUFLEN	12
 static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
@@ -2000,14 +2004,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	fsi->class_dir = sel_make_dir(sb->s_root, "class", &fsi->last_ino);
+	fsi->class_dir = sel_make_dir(sb->s_root, CLASS_DIR_NAME, &fsi->last_ino);
 	if (IS_ERR(fsi->class_dir)) {
 		ret = PTR_ERR(fsi->class_dir);
 		fsi->class_dir = NULL;
 		goto err;
 	}
 
-	fsi->policycap_dir = sel_make_dir(sb->s_root, "policy_capabilities",
+	fsi->policycap_dir = sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
 					  &fsi->last_ino);
 	if (IS_ERR(fsi->policycap_dir)) {
 		ret = PTR_ERR(fsi->policycap_dir);
-- 
2.25.4

