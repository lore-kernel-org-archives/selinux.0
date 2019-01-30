Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E12C282D9
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EAA20882
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfA3LnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:43:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfA3LnS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 06:43:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so25674302wrt.4
        for <selinux@vger.kernel.org>; Wed, 30 Jan 2019 03:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxpiwmlQDoDF6RAotexevMMoKGue2lbvHPVm/hqHKck=;
        b=uEgjg9ZCkMKSnpQw8gtoDJM6/VDp1P5wHLKBdm0JmSht8spaHVDg79PNR7QK1tJOUn
         QjeoHAjJJ6TxN97JGTSWKqbi+8s8XQ4wYSjtqj3fssnBKTFNGqDyjKETne4ctt7IBfYc
         w6DNYYNnx5sZMsGBWspQ50hcoEKgRfJUWhnbCUp/DYxal3C1lIHjHDZbZWYELbMpX8C2
         f1XVfExQl2pAi2VVLfI0z3Nlq45iilMj9SgmOBlrpYhGm2pFBrVc92htZtWwpC9H1Vny
         KwFKWI+Ph4P2wtHfaHCAI3oBg2jAgugGjlWcnaHCwgZlNrf0M66KynOBuxp5VL+fsw9T
         3zzQ==
X-Gm-Message-State: AJcUukd7qlluUvSp9KtLHIqCyzoFo/3tYATQSKC3YGmNvGi3oDz02TW0
        JJGZyIMBcUvKwPigC4KW+7u3WLy/v8Q=
X-Google-Smtp-Source: ALg8bN7OS5Z84Bbqwx8945VpH8Gg/zYbCouvYvoo7FmhlQY8fVVVTxXw02itYBjqdVqALsUEaG28/Q==
X-Received: by 2002:adf:9591:: with SMTP id p17mr31011892wrp.224.1548848595440;
        Wed, 30 Jan 2019 03:43:15 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n124sm2417691wmd.15.2019.01.30.03.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 03:43:14 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 3/5] LSM: add new hook for kernfs node initialization
Date:   Wed, 30 Jan 2019 12:41:48 +0100
Message-Id: <20190130114150.27807-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130114150.27807-1-omosnace@redhat.com>
References: <20190130114150.27807-1-omosnace@redhat.com>
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

The interface of the new hook provides the following to the LSM:
 * a qstr containing the name of the new node
 * initial inode attributes (struct iattr + simple_xattrs) of the new
   node
 * inode attributes of the parent node (directory)

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hooks.h | 20 ++++++++++++++++++++
 include/linux/security.h  | 13 +++++++++++++
 security/security.c       |  9 +++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9a0bdf91e646..7a7ea511cc61 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -429,6 +429,19 @@
  *	to abort the copy up. Note that the caller is responsible for reading
  *	and writing the xattrs as this hook is merely a filter.
  *
+ * Security hooks for kernfs node operations
+ *
+ * @kernfs_init_security
+ *	Initialize the security context of a newlycreated kernfs node based
+ *	on its own and its parent's attributes. The security context should
+ *	be stored in the simple_xattrs structure as an extended attribute.
+ *
+ *	@qstr contains the last path component of the new node.
+ *	@iattr contains the inode attributes of the new node.
+ *	@secattr is the list of security xattrs of the new node.
+ *	@dir_iattr contains the inode attributes of the parent node.
+ *	@dir_secattr is the list of security xattrs of the parent node.
+ *
  * Security hooks for file operations
  *
  * @file_permission:
@@ -1558,6 +1571,12 @@ union security_list_options {
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
+	int (*kernfs_init_security)(const struct qstr *qstr,
+				    struct iattr *iattr,
+				    struct simple_xattrs *secattr,
+				    struct iattr *dir_iattr,
+				    struct simple_xattrs *dir_secattr);
+
 	int (*file_permission)(struct file *file, int mask);
 	int (*file_alloc_security)(struct file *file);
 	void (*file_free_security)(struct file *file);
@@ -1858,6 +1877,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getsecid;
 	struct hlist_head inode_copy_up;
 	struct hlist_head inode_copy_up_xattr;
+	struct hlist_head kernfs_init_security;
 	struct hlist_head file_permission;
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index dbfb5a66babb..92234c19727f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -51,6 +51,7 @@ struct fown_struct;
 struct file_operations;
 struct msg_msg;
 struct xattr;
+struct simple_xattrs;
 struct xfrm_sec_ctx;
 struct mm_struct;
 
@@ -291,6 +292,10 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_kernfs_init_security(const struct qstr *qstr, struct iattr *iattr,
+				  struct simple_xattrs *secattr,
+				  struct iattr *dir_iattr,
+				  struct simple_xattrs *dir_secattr);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
@@ -783,6 +788,14 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
 	return 0;
 }
 
+static inline int security_kernfs_init_security(
+	const struct qstr *qstr, struct iattr *iattr,
+	struct simple_xattrs *secattr, struct iattr *dir_iattr,
+	struct simple_xattrs *dir_secattr)
+{
+	return 0;
+}
+
 static inline int security_inode_copy_up_xattr(const char *name)
 {
 	return -EOPNOTSUPP;
diff --git a/security/security.c b/security/security.c
index f1b8d2587639..3a79e0b53833 100644
--- a/security/security.c
+++ b/security/security.c
@@ -892,6 +892,15 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+int security_kernfs_init_security(const struct qstr *qstr, struct iattr *iattr,
+				  struct simple_xattrs *secattr,
+				  struct iattr *dir_iattr,
+				  struct simple_xattrs *dir_secattr)
+{
+	return call_int_hook(kernfs_init_security, 0, qstr, iattr, secattr,
+			     dir_iattr, dir_secattr);
+}
+
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
-- 
2.20.1

