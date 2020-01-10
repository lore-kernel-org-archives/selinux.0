Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104EC282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1231E20838
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 21:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uNNAYywh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgAJVcN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:32:13 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39543 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAJVcN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 16:32:13 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so1458962qvk.6
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 13:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Chmj9OkeFxatK/Exl+tgjUhpo62A3QT8B8QlkG219cY=;
        b=uNNAYywhyTTHAD4FT8+swKGCy65YL2IVn3e1NXj1NVV/Bo+c0ulIfLNpmrk3/4pDUQ
         7B6nL9JU4NjXhj8KWRad2+Sg9yH2bZIrVKzQTC4VW0V8m+dtr9PkA8SguNBaY85ksYoI
         YmyixcqX0aRBRQE8GQVxv50PMkW+kOdoqQQvv+Y9MheLLKmn9UQU9jNSG5+nE+bKwC1o
         Is1tijuchrp/XNERu/WqMV4RTijTQ8pNM5ADwlcpP/zoj0XjRA2WtZfZYuEk3GEx2rpK
         ZHd1H4yddlzPWbzUNawKMCawuO96ZNo4SkdvyBUPIUtMWMv577vV6p/qsDteiSvDmT8R
         AW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=Chmj9OkeFxatK/Exl+tgjUhpo62A3QT8B8QlkG219cY=;
        b=kTMVKz1xAjrb+BxbOCQ1HdD+GztzPPdP5A2glr+SmqJW19HCkXAbzsjRIc40vDckqc
         gFRQtjS4agbyg42EGiWCHUmI8TpSI+kBqjdvwOm0oCqegCU1WtEdofINN3K+/U0ex30B
         1SKi6OumrBMD/trwvZgTcSjgyvrclLxLdqjnp62rKHGhA6yt0o8BP3kvhDiYpwEcKbuQ
         dz7bXHtLE0zMK7OWshCHEJgmW0/f5amrohE6dJK5Y/R1jHnA2pCHyMl+U1qbWCH8MNzg
         aLqBCVzof296uiF+5wdaI4Z9YuPaxtcNKO93rks6j6iLbqP3MGoaNsJCgzdGSnVqU2mr
         MBkw==
X-Gm-Message-State: APjAAAX/ZBn1lstEjXZKjxHUM+UDgUpXWIx2BzRwV64WfA/XsQUywNql
        /nWfHLveQ36+xnjjgSAgcsmItZ1X7Q==
X-Google-Smtp-Source: APXvYqxMByQbI+UGEil0eVVZMhMsImTXmH1KM3FJ27qa/1AGAVnPwCOuP9woDLq9iEkFaZ7fOE09Bg==
X-Received: by 2002:ad4:5525:: with SMTP id ba5mr710778qvb.117.1578691931590;
        Fri, 10 Jan 2020 13:32:11 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id f4sm1426027qka.89.2020.01.10.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:32:10 -0800 (PST)
Subject: [RFC PATCH] selinux: remove redundant allocation and helper functions
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Fri, 10 Jan 2020 16:32:10 -0500
Message-ID: <157869192997.484726.14884768578207909170.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch removes the inode, file, and superblock security blob
allocation functions and moves the associated code into the
respective LSM hooks.  This patch also removes the inode_doinit()
function as it was a trivial wrapper around
inode_doinit_with_dentry() and called from one location in the code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   94 ++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 58 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2c84b12d50bc..1305fc51bfae 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -238,24 +238,6 @@ static inline u32 task_sid(const struct task_struct *task)
 	return sid;
 }
 
-/* Allocate and free functions for each kind of security blob. */
-
-static int inode_alloc_security(struct inode *inode)
-{
-	struct inode_security_struct *isec = selinux_inode(inode);
-	u32 sid = current_sid();
-
-	spin_lock_init(&isec->lock);
-	INIT_LIST_HEAD(&isec->list);
-	isec->inode = inode;
-	isec->sid = SECINITSID_UNLABELED;
-	isec->sclass = SECCLASS_FILE;
-	isec->task_sid = sid;
-	isec->initialized = LABEL_INVALID;
-
-	return 0;
-}
-
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
 
 /*
@@ -354,37 +336,6 @@ static void inode_free_security(struct inode *inode)
 	}
 }
 
-static int file_alloc_security(struct file *file)
-{
-	struct file_security_struct *fsec = selinux_file(file);
-	u32 sid = current_sid();
-
-	fsec->sid = sid;
-	fsec->fown_sid = sid;
-
-	return 0;
-}
-
-static int superblock_alloc_security(struct super_block *sb)
-{
-	struct superblock_security_struct *sbsec;
-
-	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
-	if (!sbsec)
-		return -ENOMEM;
-
-	mutex_init(&sbsec->lock);
-	INIT_LIST_HEAD(&sbsec->isec_head);
-	spin_lock_init(&sbsec->isec_lock);
-	sbsec->sb = sb;
-	sbsec->sid = SECINITSID_UNLABELED;
-	sbsec->def_sid = SECINITSID_FILE;
-	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
-	sb->s_security = sbsec;
-
-	return 0;
-}
-
 static void superblock_free_security(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
@@ -406,11 +357,6 @@ static void selinux_free_mnt_opts(void *mnt_opts)
 	kfree(opts);
 }
 
-static inline int inode_doinit(struct inode *inode)
-{
-	return inode_doinit_with_dentry(inode, NULL);
-}
-
 enum {
 	Opt_error = -1,
 	Opt_context = 0,
@@ -598,7 +544,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 		inode = igrab(inode);
 		if (inode) {
 			if (!IS_PRIVATE(inode))
-				inode_doinit(inode);
+				inode_doinit_with_dentry(inode, NULL);
 			iput(inode);
 		}
 		spin_lock(&sbsec->isec_lock);
@@ -2593,7 +2539,22 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 
 static int selinux_sb_alloc_security(struct super_block *sb)
 {
-	return superblock_alloc_security(sb);
+	struct superblock_security_struct *sbsec;
+
+	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
+	if (!sbsec)
+		return -ENOMEM;
+
+	mutex_init(&sbsec->lock);
+	INIT_LIST_HEAD(&sbsec->isec_head);
+	spin_lock_init(&sbsec->isec_lock);
+	sbsec->sb = sb;
+	sbsec->sid = SECINITSID_UNLABELED;
+	sbsec->def_sid = SECINITSID_FILE;
+	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
+	sb->s_security = sbsec;
+
+	return 0;
 }
 
 static void selinux_sb_free_security(struct super_block *sb)
@@ -2845,7 +2806,18 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
 
 static int selinux_inode_alloc_security(struct inode *inode)
 {
-	return inode_alloc_security(inode);
+	struct inode_security_struct *isec = selinux_inode(inode);
+	u32 sid = current_sid();
+
+	spin_lock_init(&isec->lock);
+	INIT_LIST_HEAD(&isec->list);
+	isec->inode = inode;
+	isec->sid = SECINITSID_UNLABELED;
+	isec->sclass = SECCLASS_FILE;
+	isec->task_sid = sid;
+	isec->initialized = LABEL_INVALID;
+
+	return 0;
 }
 
 static void selinux_inode_free_security(struct inode *inode)
@@ -3555,7 +3527,13 @@ static int selinux_file_permission(struct file *file, int mask)
 
 static int selinux_file_alloc_security(struct file *file)
 {
-	return file_alloc_security(file);
+	struct file_security_struct *fsec = selinux_file(file);
+	u32 sid = current_sid();
+
+	fsec->sid = sid;
+	fsec->fown_sid = sid;
+
+	return 0;
 }
 
 /*

