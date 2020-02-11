Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8525C35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8368C2086A
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfyYSNDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBKW4i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:56:38 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:60182 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgBKW4Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 17:56:16 -0500
Received: by mail-pj1-f74.google.com with SMTP id e4so30324pjj.9
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 14:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=SfqbTtIZ891t7TDE9ou6HfiwogoYL0L+vInmvzqifsw=;
        b=WfyYSNDPN67RlUiW7x9XkianhYsJOBw/+w3G/mDYOLSvddwfe6D+t/ixXuvoc+wr/l
         Bz5hewdVukRwZ+dkHapInvhSRuw4keyjs8m2id82QO+o58jzCFe8LAw1b6CztNsELJWZ
         fualBZEutVuaJyL6SViqeDpn6v+eP545tu4qZ1H1kmVlhiJqpaOUEnxEOWDv3jQyc8y6
         40XY0SpJ8MlJgm0IkmJIcgbnhTAn1GdPNt6o+wXWaNF0+krC2gYLUngwMdRnjly24uis
         Ps09LZegEIx5tkwacAba3KtVqx9AYa/bKa+bslSYOAq58Q9NSnziLbYRP2FjqM6hHAbB
         voTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=SfqbTtIZ891t7TDE9ou6HfiwogoYL0L+vInmvzqifsw=;
        b=TV2Gc6Lk1ZoZs/qYGs0NWTORfbr3tZLeL7CBzWpBLISMjXTWnFVieclBa24eoV75ed
         H13NthCrJjXWUfqZL435WNrWo4HOPTr6ztdqD1T8hZVdRT6+mnZKEEIuA6EGw3ke7VcQ
         s5p+hhTmgRu50dBP4+kZ1hte1STO1L/CC36JiR38Gys13Iylhry1JzCcjQTJ66NSi1aL
         PJQK8VjdbN7GqmdubCzOGQl3ixpHuz7TfzS0+FqQiTQrq+R1yVSubNlzJ6D0Qvn5vgN6
         HudoJ4+IFCwzhS/S8AEiD2B8y7vB0bdVTSNM9zEMQgIaS+qCpDyI2ofxEdXM7YLC6iJi
         mEmQ==
X-Gm-Message-State: APjAAAVEUeaHjK9KxVool6tuM0pVmiMLbredxGBHNn4qCabYS/saZGTr
        yE24GRNdto2+3mAvOfWJ51HE4g7/hIk=
X-Google-Smtp-Source: APXvYqxcOZR72yGyDyJvUedgz3YRRybV+KpcT1SSXjtHbgMmPun7x8fbFMkY5AOwdjKTmF9bxkn/7qXoxf0=
X-Received: by 2002:a63:502:: with SMTP id 2mr9605820pgf.364.1581461774275;
 Tue, 11 Feb 2020 14:56:14 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:43 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-3-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 2/6] Add a concept of a "secure" anonymous file
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A secure anonymous file is one we hooked up to its own inode (as
opposed to the shared inode we use for non-secure anonymous files). A
new selinux hook gives security modules a chance to initialize, label,
and veto the creation of these secure anonymous files. Security
modules had limit ability to interact with non-secure anonymous files
due to all of these files sharing a single inode.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/anon_inodes.c          | 45 ++++++++++++++++++++++++++++++---------
 include/linux/lsm_hooks.h |  8 +++++++
 include/linux/security.h  |  2 ++
 security/security.c       |  8 +++++++
 4 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index caa36019afca..d68d76523ad3 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,6 +55,23 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
+struct inode *anon_inode_make_secure_inode(const char *name,
+					   const struct file_operations *fops)
+{
+	struct inode *inode;
+	int error;
+	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return ERR_PTR(PTR_ERR(inode));
+	inode->i_flags &= ~S_PRIVATE;
+	error =	security_inode_init_security_anon(inode, name, fops);
+	if (error) {
+		iput(inode);
+		return ERR_PTR(error);
+	}
+	return inode;
+}
+
 /**
  * anon_inode_getfile2 - creates a new file instance by hooking it up to
  *                       an anonymous inode, and a dentry that describe
@@ -72,7 +89,9 @@ static struct file_system_type anon_inode_fs_type = {
  * hence saving memory and avoiding code duplication for the file/inode/dentry
  * setup.  Returns the newly created file* or an error pointer.
  *
- * anon_inode_flags must be zero.
+ * If anon_inode_flags contains ANON_INODE_SECURE, create a new inode
+ * and enable security checks for it. Otherwise, attach a new file to
+ * a singleton placeholder inode with security checks disabled.
  */
 struct file *anon_inode_getfile2(const char *name,
 				 const struct file_operations *fops,
@@ -81,17 +100,23 @@ struct file *anon_inode_getfile2(const char *name,
 	struct inode *inode;
 	struct file *file;
 
-	if (anon_inode_flags)
+	if (anon_inode_flags & ~ANON_INODE_SECURE)
 		return ERR_PTR(-EINVAL);
 
-	inode =	anon_inode_inode;
-	if (IS_ERR(inode))
-		return ERR_PTR(-ENODEV);
-	/*
-	 * We know the anon_inode inode count is always
-	 * greater than zero, so ihold() is safe.
-	 */
-	ihold(inode);
+	if (anon_inode_flags & ANON_INODE_SECURE) {
+		inode =	anon_inode_make_secure_inode(name, fops);
+		if (IS_ERR(inode))
+			return ERR_PTR(PTR_ERR(inode));
+	} else {
+		inode =	anon_inode_inode;
+		if (IS_ERR(inode))
+			return ERR_PTR(-ENODEV);
+		/*
+		 * We know the anon_inode inode count is always
+		 * greater than zero, so ihold() is safe.
+		 */
+		ihold(inode);
+	}
 
 	if (fops->owner && !try_module_get(fops->owner)) {
 		file = ERR_PTR(-ENOENT);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20d8cf194fb7..ba208ce5711d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -215,6 +215,10 @@
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
+ * @inode_init_security_anon:
+ *      Set up a secure anonymous inode.
+ *	Returns 0 on success. Returns -EPERM if	the security module denies
+ *	the creation of this inode.
  * @inode_create:
  *	Check permission to create a regular file.
  *	@dir contains inode structure of the parent of the new file.
@@ -1552,6 +1556,9 @@ union security_list_options {
 					const struct qstr *qstr,
 					const char **name, void **value,
 					size_t *len);
+	int (*inode_init_security_anon)(struct inode *inode,
+					const char *name,
+					const struct file_operations *fops);
 	int (*inode_create)(struct inode *dir, struct dentry *dentry,
 				umode_t mode);
 	int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
@@ -1884,6 +1891,7 @@ struct security_hook_heads {
 	struct hlist_head inode_alloc_security;
 	struct hlist_head inode_free_security;
 	struct hlist_head inode_init_security;
+	struct hlist_head inode_init_security_anon;
 	struct hlist_head inode_create;
 	struct hlist_head inode_link;
 	struct hlist_head inode_unlink;
diff --git a/include/linux/security.h b/include/linux/security.h
index 64b19f050343..8625b647dd0b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -320,6 +320,8 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_inode_init_security_anon(struct inode *inode, const char *name,
+				      const struct file_operations *fops);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len);
diff --git a/security/security.c b/security/security.c
index 565bc9b67276..78dc6096b30f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1033,6 +1033,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+int
+security_inode_init_security_anon(struct inode *inode,
+				  const char *name,
+				  const struct file_operations *fops)
+{
+	return call_int_hook(inode_init_security_anon, 0, inode, name, fops);
+}
+
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
-- 
2.25.0.225.g125e21ebc7-goog

