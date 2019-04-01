Return-Path: <SRS0=DZBp=SD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7943FC43381
	for <selinux@archiver.kernel.org>; Mon,  1 Apr 2019 10:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8020693
	for <selinux@archiver.kernel.org>; Mon,  1 Apr 2019 10:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfDAKeK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:34:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50801 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfDAKeK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Apr 2019 06:34:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so9892588wmi.0
        for <selinux@vger.kernel.org>; Mon, 01 Apr 2019 03:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcEj3DiSy10fdBgaXTSpyVmDak0vBNrIg8nNoEijANM=;
        b=cDV75pypEnBc5qyN6UNfG+RVMCp1MHbCHzkPFcKRiNW2Kix9eOR5yvjrDR66QfEUdN
         xs/i5Ymfn6R8zlMUDXnwsBgyb8gvxOSBn6G3RD3Fmet75NnXuCyRJVx0n6nX0ZgKQa/K
         MUps+1XfLzmRQy/8oeMwxFJdZmT+UK10FP0vk9dRhJq6IJ1COKwDhRQpGEMSN3zGufZJ
         lULqPzmDXEUglWh/xN3uLILyjXw1WnLw3QN2ufFfKJ3gJz5vvkVsSie/pNJPeZe/+XSq
         uSt66ItJ9yY78nPkNo/20Pnx2N2xa0O+yD7AziswvEk2Q9cP5XKLPDzwhoTfs2n2J5FO
         IFlg==
X-Gm-Message-State: APjAAAW4wtFgZeDsJnrgCYBN0rIKgBSYxgHO2orTDsCURXdGJyv/q9TP
        /cVXRcuQgUtLKO9d9KKR57kMaZWQJVrznA==
X-Google-Smtp-Source: APXvYqxRlcVroalojUf0Va28ZpTK71DC59Mt5V3GhdCU/7JzCZYtgw+Mp40R0ckV+r/59gocK5ZpWA==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr4019048wmb.127.1554114847320;
        Mon, 01 Apr 2019 03:34:07 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c18sm8134288wmk.47.2019.04.01.03.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:34:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tejun Heo <tj@kernel.org>, lkp@01.org,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH v3] kernfs: fix xattr name handling in LSM helpers
Date:   Mon,  1 Apr 2019 12:34:03 +0200
Message-Id: <20190401103403.14130-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325145032.GB21359@shao2-debian>
References: <20190325145032.GB21359@shao2-debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The implementation of kernfs_security_xattr_*() helpers reuses the
kernfs_node_xattr_*() functions, which take the suffix of the xattr name
and extract full xattr name from it using xattr_full_name(). However,
this function relies on the fact that the suffix passed to xattr
handlers from VFS is always constructed from the full name by just
incerementing the pointer. This doesn't necessarily hold for the callers
of kernfs_security_xattr_*(), so their usage will easily lead to
out-of-bounds access.

Fix this by moving the xattr name reconstruction to the VFS xattr
handlers and replacing the kernfs_security_xattr_*() helpers with more
general kernfs_xattr_*() helpers that take full xattr name and allow
accessing all kernfs node's xattrs.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v3: simplify kernfs xattr helpers as per Paul's suggestion
v2: just rebase to update diff context

 fs/kernfs/inode.c        | 62 ++++++++++++++--------------------------
 include/linux/kernfs.h   | 18 ++++++------
 security/selinux/hooks.c |  9 +++---
 3 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 673ef598d97d..1e93fe8c67f4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -288,63 +288,57 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 	return generic_permission(inode, mask);
 }
 
-static int kernfs_node_xattr_get(const struct xattr_handler *handler,
-				 struct kernfs_node *kn, const char *suffix,
-				 void *value, size_t size)
+int kernfs_node_xattr_get(struct kernfs_node *kn, const char *name,
+			  void *value, size_t size)
 {
-	const char *name = xattr_full_name(handler, suffix);
-	struct kernfs_iattrs *attrs;
-
-	attrs = kernfs_iattrs_noalloc(kn);
+	struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
 	if (!attrs)
 		return -ENODATA;
 
 	return simple_xattr_get(&attrs->xattrs, name, value, size);
 }
 
-static int kernfs_node_xattr_set(const struct xattr_handler *handler,
-				 struct kernfs_node *kn, const char *suffix,
-				 const void *value, size_t size, int flags)
+int kernfs_node_xattr_set(struct kernfs_node *kn, const char *name,
+			  const void *value, size_t size, int flags)
 {
-	const char *name = xattr_full_name(handler, suffix);
-	struct kernfs_iattrs *attrs;
-
-	attrs = kernfs_iattrs(kn);
+	struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
 	return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
 }
 
-static int kernfs_xattr_get(const struct xattr_handler *handler,
-			    struct dentry *unused, struct inode *inode,
-			    const char *suffix, void *value, size_t size)
+static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
+				struct dentry *unused, struct inode *inode,
+				const char *suffix, void *value, size_t size)
 {
+	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 
-	return kernfs_node_xattr_get(handler, kn, suffix, value, size);
+	return kernfs_node_xattr_get(kn, name, value, size);
 }
 
-static int kernfs_xattr_set(const struct xattr_handler *handler,
-			    struct dentry *unused, struct inode *inode,
-			    const char *suffix, const void *value,
-			    size_t size, int flags)
+static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
+				struct dentry *unused, struct inode *inode,
+				const char *suffix, const void *value,
+				size_t size, int flags)
 {
+	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 
-	return kernfs_node_xattr_set(handler, kn, suffix, value, size, flags);
+	return kernfs_node_xattr_set(kn, name, value, size, flags);
 }
 
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
 	.prefix = XATTR_TRUSTED_PREFIX,
-	.get = kernfs_xattr_get,
-	.set = kernfs_xattr_set,
+	.get = kernfs_vfs_xattr_get,
+	.set = kernfs_vfs_xattr_set,
 };
 
 static const struct xattr_handler kernfs_security_xattr_handler = {
 	.prefix = XATTR_SECURITY_PREFIX,
-	.get = kernfs_xattr_get,
-	.set = kernfs_xattr_set,
+	.get = kernfs_vfs_xattr_get,
+	.set = kernfs_vfs_xattr_set,
 };
 
 const struct xattr_handler *kernfs_xattr_handlers[] = {
@@ -352,17 +346,3 @@ const struct xattr_handler *kernfs_xattr_handlers[] = {
 	&kernfs_security_xattr_handler,
 	NULL
 };
-
-int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
-			      void *value, size_t size)
-{
-	return kernfs_node_xattr_get(&kernfs_security_xattr_handler,
-				     kn, suffix, value, size);
-}
-
-int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
-			      void *value, size_t size, int flags)
-{
-	return kernfs_node_xattr_set(&kernfs_security_xattr_handler,
-				     kn, suffix, value, size, flags);
-}
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 39eea07c2900..b3f62e7bb996 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -371,10 +371,10 @@ __poll_t kernfs_generic_poll(struct kernfs_open_file *of,
 			     struct poll_table_struct *pt);
 void kernfs_notify(struct kernfs_node *kn);
 
-int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
-			      void *value, size_t size);
-int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
-			      void *value, size_t size, int flags);
+int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
+		     void *value, size_t size);
+int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
+		     void *value, size_t size, int flags);
 
 const void *kernfs_super_ns(struct super_block *sb);
 int kernfs_get_tree(struct fs_context *fc);
@@ -478,14 +478,12 @@ static inline int kernfs_setattr(struct kernfs_node *kn,
 
 static inline void kernfs_notify(struct kernfs_node *kn) { }
 
-static inline int kernfs_security_xattr_get(struct kernfs_node *kn,
-					    const char *suffix, void *value,
-					    size_t size)
+static inline int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
+				   void *value, size_t size)
 { return -ENOSYS; }
 
-static inline int kernfs_security_xattr_set(struct kernfs_node *kn,
-					    const char *suffix, void *value,
-					    size_t size, int flags)
+static inline int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
+				   void *value, size_t size, int flags)
 { return -ENOSYS; }
 
 static inline const void *kernfs_super_ns(struct super_block *sb)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b6e61524d68d..d5fdcb0d26fe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3394,7 +3394,7 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	int rc;
 	char *context;
 
-	rc = kernfs_security_xattr_get(kn_dir, XATTR_SELINUX_SUFFIX, NULL, 0);
+	rc = kernfs_xattr_get(kn_dir, XATTR_NAME_SELINUX, NULL, 0);
 	if (rc == -ENODATA)
 		return 0;
 	else if (rc < 0)
@@ -3405,8 +3405,7 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	if (!context)
 		return -ENOMEM;
 
-	rc = kernfs_security_xattr_get(kn_dir, XATTR_SELINUX_SUFFIX, context,
-				       clen);
+	rc = kernfs_xattr_get(kn_dir, XATTR_NAME_SELINUX, context, clen);
 	if (rc < 0) {
 		kfree(context);
 		return rc;
@@ -3439,8 +3438,8 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	if (rc)
 		return rc;
 
-	rc = kernfs_security_xattr_set(kn, XATTR_SELINUX_SUFFIX, context, clen,
-				       XATTR_CREATE);
+	rc = kernfs_xattr_set(kn, XATTR_NAME_SELINUX, context, clen,
+			      XATTR_CREATE);
 	kfree(context);
 	return rc;
 }
-- 
2.20.1

