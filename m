Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B50C10F0B
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135452086A
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfBVO56 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:57:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45469 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfBVO54 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 09:57:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so2661195wrn.12
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 06:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQqTehVwyEq+5RjrXTh4vr5ainm8upgUWoiVA/zT8OY=;
        b=PIErGT2KGr5dFuZqEWqCxiesvCdOa5EHR+gJ3o5yOMJ2pQGSBlGdadUZL0iR7LnMWL
         xv3Vu+n0RkmzMIdGNLhwRxNFB04BpLkglw4j00GTxUqgcbu8/P46e4NyNOAqJXq9a5us
         j7NPKGB9am5NUsUDa6Vgz/529EMHDkqt73AOS7iOk3FAKz+U1aLaiwb6Dt1gPRf+d9zZ
         pfWzV7HlIvIXgdFuDdMUR1MeZxMtXCmNxJTDgnLQv0YgLHdoq+dQolPrnf0EbeLXp7L1
         C812/ob8vySZnE2q5UUnzLsmqYY6Ol/kOnnIc6wiBMIxNSEb29eBig69APD3qL74ozyx
         2a2g==
X-Gm-Message-State: AHQUAub1kjnVsrYn3Y5/JQEMko6LIQnJX/JXWnOspUQdz3CNPy/+1tob
        iyXxZR+OghvamJquNFczkLDAcmyfbCF9gQ==
X-Google-Smtp-Source: AHgI3IbD9XBZzLkfcM82OGUQ3YUOi1ufH+//zGIwnvAYMcrFN4VP1/zwsfwqxudhQpdFpdpussPzig==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr3208021wrn.268.1550847474588;
        Fri, 22 Feb 2019 06:57:54 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 203sm1503912wme.30.2019.02.22.06.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:57:53 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v7 5/7] LSM: add new hook for kernfs node initialization
Date:   Fri, 22 Feb 2019 15:57:16 +0100
Message-Id: <20190222145718.5740-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222145718.5740-1-omosnace@redhat.com>
References: <20190222145718.5740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch introduces a new security hook that is intended for
initializing the security data for newly created kernfs nodes, which
provide a way of storing a non-default security context, but need to
operate independently from mounts (and therefore may not have an
associated inode at the moment of creation).

The main motivation is to allow kernfs nodes to inherit the context of
the parent under SELinux, similar to the behavior of
security_inode_init_security(). Other LSMs may implement their own logic
for handling the creation of new nodes.

This patch also adds helper functions to <linux/kernfs.h> for
getting/setting security xattrs of a kernfs node so that LSMs hooks are
able to do their job. Other important attributes should be accessible
direcly in the kernfs_node fields (in case there is need for more, then
new helpers should be added to kernfs.h along with the patch that needs
them).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/inode.c         | 48 +++++++++++++++++++++++++++++++--------
 include/linux/kernfs.h    | 15 ++++++++++++
 include/linux/lsm_hooks.h | 13 +++++++++++
 include/linux/security.h  |  9 ++++++++
 security/security.c       |  6 +++++
 5 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 1acdfbf4b86a..a831b2186a27 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -288,12 +288,11 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 	return generic_permission(inode, mask);
 }
 
-static int kernfs_xattr_get(const struct xattr_handler *handler,
-			    struct dentry *unused, struct inode *inode,
-			    const char *suffix, void *value, size_t size)
+static int kernfs_node_xattr_get(const struct xattr_handler *handler,
+				 struct kernfs_node *kn, const char *suffix,
+				 void *value, size_t size)
 {
 	const char *name = xattr_full_name(handler, suffix);
-	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
 
 	attrs = kernfs_iattrs_noalloc(kn);
@@ -303,13 +302,11 @@ static int kernfs_xattr_get(const struct xattr_handler *handler,
 	return simple_xattr_get(&attrs->xattrs, name, value, size);
 }
 
-static int kernfs_xattr_set(const struct xattr_handler *handler,
-			    struct dentry *unused, struct inode *inode,
-			    const char *suffix, const void *value,
-			    size_t size, int flags)
+static int kernfs_node_xattr_set(const struct xattr_handler *handler,
+				 struct kernfs_node *kn, const char *suffix,
+				 const void *value, size_t size, int flags)
 {
 	const char *name = xattr_full_name(handler, suffix);
-	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
 
 	attrs = kernfs_iattrs(kn);
@@ -319,6 +316,25 @@ static int kernfs_xattr_set(const struct xattr_handler *handler,
 	return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
 }
 
+static int kernfs_xattr_get(const struct xattr_handler *handler,
+			    struct dentry *unused, struct inode *inode,
+			    const char *suffix, void *value, size_t size)
+{
+	struct kernfs_node *kn = inode->i_private;
+
+	return kernfs_node_xattr_get(handler, kn, suffix, value, size);
+}
+
+static int kernfs_xattr_set(const struct xattr_handler *handler,
+			    struct dentry *unused, struct inode *inode,
+			    const char *suffix, const void *value,
+			    size_t size, int flags)
+{
+	struct kernfs_node *kn = inode->i_private;
+
+	return kernfs_node_xattr_set(handler, kn, suffix, value, size, flags);
+}
+
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
 	.prefix = XATTR_TRUSTED_PREFIX,
 	.get = kernfs_xattr_get,
@@ -336,3 +352,17 @@ const struct xattr_handler *kernfs_xattr_handlers[] = {
 	&kernfs_security_xattr_handler,
 	NULL
 };
+
+int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
+			      void *value, size_t size)
+{
+	return kernfs_node_xattr_get(&kernfs_security_xattr_handler,
+				     kn, suffix, value, size);
+}
+
+int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
+			      void *value, size_t size, int flags)
+{
+	return kernfs_node_xattr_set(&kernfs_security_xattr_handler,
+				     kn, suffix, value, size, flags);
+}
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5b36b1287a5a..db8d1aa57e95 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -352,6 +352,11 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 void kernfs_notify(struct kernfs_node *kn);
 
+int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
+			      void *value, size_t size);
+int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
+			      void *value, size_t size, int flags);
+
 const void *kernfs_super_ns(struct super_block *sb);
 struct dentry *kernfs_mount_ns(struct file_system_type *fs_type, int flags,
 			       struct kernfs_root *root, unsigned long magic,
@@ -456,6 +461,16 @@ static inline int kernfs_setattr(struct kernfs_node *kn,
 
 static inline void kernfs_notify(struct kernfs_node *kn) { }
 
+static inline int kernfs_security_xattr_get(struct kernfs_node *kn,
+					    const char *suffix, void *value,
+					    size_t size)
+{ return -ENOSYS; }
+
+static inline int kernfs_security_xattr_set(struct kernfs_node *kn,
+					    const char *suffix, void *value,
+					    size_t size, int flags)
+{ return -ENOSYS; }
+
 static inline const void *kernfs_super_ns(struct super_block *sb)
 { return NULL; }
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9a0bdf91e646..71af02629c63 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -429,6 +429,15 @@
  *	to abort the copy up. Note that the caller is responsible for reading
  *	and writing the xattrs as this hook is merely a filter.
  *
+ * Security hooks for kernfs node operations
+ *
+ * @kernfs_init_security
+ *	Initialize the security context of a newly created kernfs node based
+ *	on its own and its parent's attributes.
+ *
+ *	@kn_dir the parent kernfs node
+ *	@kn the new child kernfs node
+ *
  * Security hooks for file operations
  *
  * @file_permission:
@@ -1558,6 +1567,9 @@ union security_list_options {
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
+	int (*kernfs_init_security)(struct kernfs_node *kn_dir,
+				    struct kernfs_node *kn);
+
 	int (*file_permission)(struct file *file, int mask);
 	int (*file_alloc_security)(struct file *file);
 	void (*file_free_security)(struct file *file);
@@ -1858,6 +1870,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getsecid;
 	struct hlist_head inode_copy_up;
 	struct hlist_head inode_copy_up_xattr;
+	struct hlist_head kernfs_init_security;
 	struct hlist_head file_permission;
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index dbfb5a66babb..f63765af1816 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -51,6 +51,7 @@ struct fown_struct;
 struct file_operations;
 struct msg_msg;
 struct xattr;
+struct kernfs_node;
 struct xfrm_sec_ctx;
 struct mm_struct;
 
@@ -291,6 +292,8 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_kernfs_init_security(struct kernfs_node *kn_dir,
+				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
@@ -783,6 +786,12 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
 	return 0;
 }
 
+static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
+						struct kernfs_node *kn)
+{
+	return 0;
+}
+
 static inline int security_inode_copy_up_xattr(const char *name)
 {
 	return -EOPNOTSUPP;
diff --git a/security/security.c b/security/security.c
index f1b8d2587639..2864fb99feb2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -892,6 +892,12 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+int security_kernfs_init_security(struct kernfs_node *kn_dir,
+				  struct kernfs_node *kn)
+{
+	return call_int_hook(kernfs_init_security, 0, kn_dir, kn);
+}
+
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
-- 
2.20.1

