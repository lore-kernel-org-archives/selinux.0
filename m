Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D7C433E0
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 14:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AEA20838
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 14:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W55IbATh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHLOJU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:09:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40640 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHLOJS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 10:09:18 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17BA620B490F;
        Wed, 12 Aug 2020 07:09:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17BA620B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597241358;
        bh=TWaa5J7FL27uITC423BFjVEEdl8/5m1i6QAGc4Mk748=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W55IbAThdG+xFOiMjtUl3qwZAOzw6oS2KDlxDutC9KcnehwUSTsrbpUJFK/9yPtpr
         J2kPuu1d3UTRgIxgNrv8zw2uiUKbUCh/+iz2xiB/ObbxQdt9+WrajRRXsJEtqQDE2d
         2bhT9KVNVaec+fYg6Nqd1YyYxFMpSw8+Vv7fCCSs=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com
Subject: [PATCH 3/4] selinux: Standardize string literal usage for selinuxfs directory names
Date:   Wed, 12 Aug 2020 10:09:06 -0400
Message-Id: <20200812140907.1102299-4-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812140907.1102299-1-dburgener@linux.microsoft.com>
References: <20200812140907.1102299-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Switch class and policy_capabilities directory names to be referred to with
global constants, consistent with booleans directory name.  This will allow
for easy consistency of naming in future development.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9657c3acfc8f..f09afdb90ddd 100644
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
@@ -1363,8 +1367,6 @@ static void sel_remove_entries(struct dentry *de)
 	shrink_dcache_parent(de);
 }
 
-#define BOOL_DIR_NAME "booleans"
-
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
 			  unsigned int **bool_pending_values)
@@ -2080,14 +2082,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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

