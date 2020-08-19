Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB7C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E780207DA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qPMqVcws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHST7p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:59:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39346 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgHST7o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 15:59:44 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id E84AE20B490D;
        Wed, 19 Aug 2020 12:59:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E84AE20B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597867183;
        bh=ELLloZXLGWIgA1j7VgBLVTYrCn6ySImPgI+px1pcv9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPMqVcwsVsStGRBb1mGNdhVZmhXDzYTSCUHT8AGC/8YhfFSJip6c/12mAHg4RdiQ6
         4CPqcJtsuYjW76xrZIGfXAjL2UhJ/F5r4TSMU1ARCBANADLA2a1kmanqFG9TMsqHlZ
         ssvhwYnBZARcGjjqnpJoAnhOUNNFyAqrmG0ImxWo=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v3 2/4] selinux: Refactor selinuxfs directory populating functions
Date:   Wed, 19 Aug 2020 15:59:33 -0400
Message-Id: <20200819195935.1720168-3-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make sel_make_bools and sel_make_classes take the specific elements of
selinux_fs_info that they need rather than the entire struct.

This will allow a future patch to pass temporary elements that are not in
the selinux_fs_info struct to these functions so that the original elements
can be preserved until we are ready to perform the switch over.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 45 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 19670e9bcd72..cac585ce576b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -346,10 +346,12 @@ static const struct file_operations sel_policyvers_ops = {
 };
 
 /* declaration for sel_write_load */
-static int sel_make_bools(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy);
-static int sel_make_classes(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy);
+static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
+			  unsigned int *bool_num, char ***bool_pending_names,
+			  unsigned int **bool_pending_values);
+static int sel_make_classes(struct selinux_policy *newpolicy,
+			    struct dentry *class_dir,
+			    unsigned long *last_class_ino);
 
 /* declaration for sel_make_class_dirs */
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
@@ -539,13 +541,15 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 
 	sel_remove_old_policy_nodes(fsi);
 
-	ret = sel_make_bools(fsi, newpolicy);
+	ret = sel_make_bools(newpolicy, fsi->bool_dir, &fsi->bool_num,
+			     &fsi->bool_pending_names, &fsi->bool_pending_values);
 	if (ret) {
 		pr_err("SELinux: failed to load policy booleans\n");
 		return ret;
 	}
 
-	ret = sel_make_classes(fsi, newpolicy);
+	ret = sel_make_classes(newpolicy, fsi->class_dir,
+			       &fsi->last_class_ino);
 	if (ret) {
 		pr_err("SELinux: failed to load policy classes\n");
 		return ret;
@@ -1359,13 +1363,13 @@ static void sel_remove_entries(struct dentry *de)
 
 #define BOOL_DIR_NAME "booleans"
 
-static int sel_make_bools(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy)
+static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
+			  unsigned int *bool_num, char ***bool_pending_names,
+			  unsigned int **bool_pending_values)
 {
 	int ret;
 	ssize_t len;
 	struct dentry *dentry = NULL;
-	struct dentry *dir = fsi->bool_dir;
 	struct inode *inode = NULL;
 	struct inode_security_struct *isec;
 	char **names = NULL, *page;
@@ -1384,12 +1388,12 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 
 	for (i = 0; i < num; i++) {
 		ret = -ENOMEM;
-		dentry = d_alloc_name(dir, names[i]);
+		dentry = d_alloc_name(bool_dir, names[i]);
 		if (!dentry)
 			goto out;
 
 		ret = -ENOMEM;
-		inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
+		inode = sel_make_inode(bool_dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
 		if (!inode) {
 			dput(dentry);
 			goto out;
@@ -1418,9 +1422,9 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 		inode->i_ino = i|SEL_BOOL_INO_OFFSET;
 		d_add(dentry, inode);
 	}
-	fsi->bool_num = num;
-	fsi->bool_pending_names = names;
-	fsi->bool_pending_values = values;
+	*bool_num = num;
+	*bool_pending_names = names;
+	*bool_pending_values = values;
 
 	free_page((unsigned long)page);
 	return 0;
@@ -1433,7 +1437,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 		kfree(names);
 	}
 	kfree(values);
-	sel_remove_entries(dir);
+	sel_remove_entries(bool_dir);
 
 	return ret;
 }
@@ -1880,8 +1884,9 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 	return rc;
 }
 
-static int sel_make_classes(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy)
+static int sel_make_classes(struct selinux_policy *newpolicy,
+			    struct dentry *class_dir,
+			    unsigned long *last_class_ino)
 {
 
 	int rc, nclasses, i;
@@ -1892,13 +1897,13 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
 		return rc;
 
 	/* +2 since classes are 1-indexed */
-	fsi->last_class_ino = sel_class_to_ino(nclasses + 2);
+	*last_class_ino = sel_class_to_ino(nclasses + 2);
 
 	for (i = 0; i < nclasses; i++) {
 		struct dentry *class_name_dir;
 
-		class_name_dir = sel_make_dir(fsi->class_dir, classes[i],
-					      &fsi->last_class_ino);
+		class_name_dir = sel_make_dir(class_dir, classes[i],
+					      last_class_ino);
 		if (IS_ERR(class_name_dir)) {
 			rc = PTR_ERR(class_name_dir);
 			goto out;
-- 
2.25.4

