Return-Path: <SRS0=YsfU=SF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8CC4360F
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 07:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8013C2084C
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 07:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfDCH3s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:29:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45521 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCH3r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Apr 2019 03:29:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so563144wra.12
        for <selinux@vger.kernel.org>; Wed, 03 Apr 2019 00:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aR3t1/MUWrYbx96QglriLtjH4RY1dIAD2vH86T9dqE=;
        b=Lv/6i1quLQYvGSnfb09WRpN+kqAdA1jkmsfhsrS5YmPF07uSTIbhShT9wWBreQQ45n
         WNI/WX06LDzoLFtfjgpOnI/KoEv5aFaW96oOEJuwW4gVrZGh186Br9gE5dp+XRh/3ttk
         UzNFjIfuk28v3mCrqDs/NFR671f/AkhPHN7LM8AqKqOF/nfJVPL5+AiWJud0tF0dlzUF
         TiTbpAaLdxpGFVi93/iCH0hVh2qo8n30abOlWurPjUICzKEfkyvYX1D00B7lFY/wignM
         5TJVTsg/n0pbYGHVqHBqqgSlRn+prVsoeTOVLKa4KTd91MP/G2uKnMl0CD+0R76KNNaL
         9C1g==
X-Gm-Message-State: APjAAAWDnWCHE3hRZas+V1lhojM1AvIPwMmJ/28j3sFCiaysW6OTMxhl
        rCVvMbKWnhM8y6LTCEXTPWSXBO65N+Q=
X-Google-Smtp-Source: APXvYqwuMxN6nEzHhLwtSyi3EoAQcmCQz7jp7j+8e4M8i+kbT+2H/6B3nw1drVXsXrcAoGq7sTpVxw==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr9833348wro.276.1554276585010;
        Wed, 03 Apr 2019 00:29:45 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j9sm21815375wrr.93.2019.04.03.00.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:29:44 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tejun Heo <tj@kernel.org>, lkp@01.org,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH v4] kernfs: fix xattr name handling in LSM helpers
Date:   Wed,  3 Apr 2019 09:29:41 +0200
Message-Id: <20190403072941.26520-1-omosnace@redhat.com>
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

v4: fix function names and types to make it build...
v3: simplify kernfs xattr helpers as per Paul's suggestion
v2: just rebase to update diff context

 fs/kernfs/inode.c        | 62 ++++++++++++++--------------------------
 include/linux/kernfs.h   | 18 ++++++------
 security/selinux/hooks.c |  9 +++---
 3 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 673ef598d97d..f89a0f13840e 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -288,63 +288,57 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 	return generic_permission(inode, mask);
 }
 
-static int kernfs_node_xattr_get(const struct xattr_handler *handler,
-				 struct kernfs_node *kn, const char *suffix,
-				 void *value, size_t size)
+int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
+		     void *value, size_t size)
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
+int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
+		     const void *value, size_t size, int flags)
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
+	return kernfs_xattr_get(kn, name, value, size);
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
+	return kernfs_xattr_set(kn, name, value, size, flags);
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
index 39eea07c2900..7987e0f89b69 100644
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
+		     const void *value, size_t size, int flags);
 
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
+				   const void *value, size_t size, int flags)
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

