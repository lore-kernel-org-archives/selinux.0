Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA0C282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860372083B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfBEI7i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:59:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34127 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfBEI7g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 03:59:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so648162wrn.1
        for <selinux@vger.kernel.org>; Tue, 05 Feb 2019 00:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2+lSKbNDEdLOWYnChv35IpvQLg947oZJ5GZx6ThNH8=;
        b=dJmyRAQeGpbFN9/tJEycrHJnUVvWHC8DbnBA+Qr7e9xOjmyoQgr/iLnItt8kS2eST/
         ya0NOh3S6Xpyj4BJiFdDYrqNtvL2CB+HJGe4Z6wW0WOVkRAP5EFTQU2hePxv444NTNRX
         SmZi9UcIGQIOSKCtzBGeOI4jUCMUncpB3obf3vKwClAfeUDgx9FBzTVkKpNAIrHqeEWD
         /LMwZKV5V4483aSxDF0ULegRehtU592z2/ZY72EaS96fV/09CV3SFeMKHNBhzFIlOcGw
         JisExdGLn6SLTqP8O262fEo9IwunAspr+u2UNqd+CK4gAMgShenXzNOmgUCw7GKlRrBU
         E+VA==
X-Gm-Message-State: AHQUAuadPwxm01CJUdcxOeu9pHc75v6F+bcdB3XHr5/OWFS5stEzmk0E
        pJKYvI4nfg23Q1MgNLxjMvaE4W8bsPo=
X-Google-Smtp-Source: AHgI3IbgXWw/kI8vVThRWDH4CaU8Gs0tSArIshNxDZuYL6Q41CTR3g8nL3NF0Y73BT0WF7U1Pf8zDQ==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr677232wro.126.1549357173415;
        Tue, 05 Feb 2019 00:59:33 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n82sm12973613wma.42.2019.02.05.00.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 00:59:32 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v4 3/5] LSM: add new hook for kernfs node initialization
Date:   Tue,  5 Feb 2019 09:59:13 +0100
Message-Id: <20190205085915.5183-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205085915.5183-1-omosnace@redhat.com>
References: <20190205085915.5183-1-omosnace@redhat.com>
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
 * inode attributes of the parent node (directory)
 * initial inode attributes (struct iattr + simple_xattrs) of the new
   node

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hooks.h | 22 ++++++++++++++++++++++
 include/linux/security.h  | 14 ++++++++++++++
 security/security.c       | 10 ++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9a0bdf91e646..558bbc0ff125 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -429,6 +429,21 @@
  *	to abort the copy up. Note that the caller is responsible for reading
  *	and writing the xattrs as this hook is merely a filter.
  *
+ * Security hooks for kernfs node operations
+ *
+ * @kernfs_init_security
+ *	Initialize the security context of a newlycreated kernfs node based
+ *	on its own and its parent's attributes. The security context (or other
+ *	LSM metadata) should be stored in @secattr as extended attributes.
+ *	The hook MAY NOT add/modify attributes in @dir_secattr; it should be
+ *	treated as a read-only list of attributes.
+ *
+ *	@qstr contains the last path component of the new node.
+ *	@dir_iattr contains the inode attributes of the parent node.
+ *	@dir_secattr is the list of security xattrs of the parent node.
+ *	@iattr contains the inode attributes of the new node.
+ *	@secattr is the list of security xattrs of the new node.
+ *
  * Security hooks for file operations
  *
  * @file_permission:
@@ -1558,6 +1573,12 @@ union security_list_options {
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
+	int (*kernfs_init_security)(const struct qstr *qstr,
+				    const struct iattr *dir_iattr,
+				    struct simple_xattrs *dir_secattr,
+				    const struct iattr *iattr,
+				    struct simple_xattrs *secattr);
+
 	int (*file_permission)(struct file *file, int mask);
 	int (*file_alloc_security)(struct file *file);
 	void (*file_free_security)(struct file *file);
@@ -1858,6 +1879,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getsecid;
 	struct hlist_head inode_copy_up;
 	struct hlist_head inode_copy_up_xattr;
+	struct hlist_head kernfs_init_security;
 	struct hlist_head file_permission;
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index dbfb5a66babb..5b2aeb2457ab 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -51,6 +51,7 @@ struct fown_struct;
 struct file_operations;
 struct msg_msg;
 struct xattr;
+struct simple_xattrs;
 struct xfrm_sec_ctx;
 struct mm_struct;
 
@@ -291,6 +292,11 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_kernfs_init_security(const struct qstr *qstr,
+				  const struct iattr *dir_iattr,
+				  struct simple_xattrs *dir_secattr,
+				  const struct iattr *iattr,
+				  struct simple_xattrs *secattr);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
@@ -783,6 +789,14 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
 	return 0;
 }
 
+static inline int security_kernfs_init_security(
+		const struct qstr *qstr, const struct iattr *dir_iattr,
+		struct simple_xattrs *dir_secattr, const struct iattr *iattr,
+		struct simple_xattrs *secattr);
+{
+	return 0;
+}
+
 static inline int security_inode_copy_up_xattr(const char *name)
 {
 	return -EOPNOTSUPP;
diff --git a/security/security.c b/security/security.c
index f1b8d2587639..836e0822874a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -892,6 +892,16 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+int security_kernfs_init_security(const struct qstr *qstr,
+				  const struct iattr *dir_iattr,
+				  struct simple_xattrs *dir_secattr,
+				  const struct iattr *iattr,
+				  struct simple_xattrs *secattr)
+{
+	return call_int_hook(kernfs_init_security, 0, qstr, dir_iattr,
+			     dir_secattr, iattr, secattr);
+}
+
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
-- 
2.20.1

