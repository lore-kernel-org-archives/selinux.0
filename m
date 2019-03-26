Return-Path: <SRS0=N/SO=R5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC76C43381
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C1F20830
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCZIRg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:17:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40871 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZIRg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Mar 2019 04:17:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so8541824wmi.5
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2019 01:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEdeOkA8NKRTivfDbRyXl/WpVSx26hNaFfT21NQoBfI=;
        b=sT6FPepWpeT6fH/IQ9BkCTqhSTa181Im7rmgT+ku0mzEVK+Mr919eesE0GvOwBiweI
         2vzZgMD/5ionsyhl3dvZZ+qcjt4GrEnqEVoqd8cHCbuDsHTXkjaGoEweWHoDY5PtmGDJ
         zqGEVo4z21zd8rU71x2Vq2WqVuEnBlIOD8SPpe/b48zkwJts4IiSV1EZzwLzD0OZhvUq
         IKOsVfzaDcWpGAz1Q3DFMj8ERkKhhjANrm0KuXfleW/cy1uGed0sQFKGWc4E+S4sxGE/
         ROAlUcfCthkBa0xwGJXcKKOPNUUj114FPXudeOtaDZEXtTnJVZvu89k5gNPOjQG9ATec
         S/0Q==
X-Gm-Message-State: APjAAAW7DxEpD995QHoqtyDDItQ0Hq4qX7J6ho9iFw1GbdIcBeiZURWq
        wS1Bw++fTulpHWtgoHlYMh3LKN/9IeY=
X-Google-Smtp-Source: APXvYqyl5+RYQ8mwB1vNWMaJkRWCcVoCjZqZCtqs7F09hKdXIv9WFIG11La2wFkWvC4p9VoavIuNBg==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr15084119wmc.30.1553588252926;
        Tue, 26 Mar 2019 01:17:32 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r6sm1290754wrt.38.2019.03.26.01.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 01:17:32 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tejun Heo <tj@kernel.org>, lkp@01.org,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH] kernfs: fix xattr name handling in LSM helpers
Date:   Tue, 26 Mar 2019 09:17:29 +0100
Message-Id: <20190326081729.21406-1-omosnace@redhat.com>
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

Fix this by converting the helpers to take the full xattr name instead
of just the suffix and moving the reconstruction to the xattr handlers.
We now need to check if the prefix is correct in the helpers, but it
saves us the difficulty of reconstructing the full name from just the
plain suffix.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/inode.c        | 38 ++++++++++++++++++--------------------
 include/linux/kernfs.h   |  8 ++++----
 security/selinux/hooks.c |  6 +++---
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 673ef598d97d..1daa8aa9ec96 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -288,28 +288,20 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 	return generic_permission(inode, mask);
 }
 
-static int kernfs_node_xattr_get(const struct xattr_handler *handler,
-				 struct kernfs_node *kn, const char *suffix,
+static int kernfs_node_xattr_get(struct kernfs_node *kn, const char *name,
 				 void *value, size_t size)
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
+static int kernfs_node_xattr_set(struct kernfs_node *kn, const char *name,
 				 const void *value, size_t size, int flags)
 {
-	const char *name = xattr_full_name(handler, suffix);
-	struct kernfs_iattrs *attrs;
-
-	attrs = kernfs_iattrs(kn);
+	struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
@@ -320,9 +312,10 @@ static int kernfs_xattr_get(const struct xattr_handler *handler,
 			    struct dentry *unused, struct inode *inode,
 			    const char *suffix, void *value, size_t size)
 {
+	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 
-	return kernfs_node_xattr_get(handler, kn, suffix, value, size);
+	return kernfs_node_xattr_get(kn, name, value, size);
 }
 
 static int kernfs_xattr_set(const struct xattr_handler *handler,
@@ -330,9 +323,10 @@ static int kernfs_xattr_set(const struct xattr_handler *handler,
 			    const char *suffix, const void *value,
 			    size_t size, int flags)
 {
+	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 
-	return kernfs_node_xattr_set(handler, kn, suffix, value, size, flags);
+	return kernfs_node_xattr_set(kn, name, value, size, flags);
 }
 
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
@@ -353,16 +347,20 @@ const struct xattr_handler *kernfs_xattr_handlers[] = {
 	NULL
 };
 
-int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
+int kernfs_security_xattr_get(struct kernfs_node *kn, const char *name,
 			      void *value, size_t size)
 {
-	return kernfs_node_xattr_get(&kernfs_security_xattr_handler,
-				     kn, suffix, value, size);
+	if (WARN_ON_ONCE(!strstarts(name, XATTR_SECURITY_PREFIX)))
+		return -EINVAL;
+
+	return kernfs_node_xattr_get(kn, name, value, size);
 }
 
-int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
+int kernfs_security_xattr_set(struct kernfs_node *kn, const char *name,
 			      void *value, size_t size, int flags)
 {
-	return kernfs_node_xattr_set(&kernfs_security_xattr_handler,
-				     kn, suffix, value, size, flags);
+	if (WARN_ON_ONCE(!strstarts(name, XATTR_SECURITY_PREFIX)))
+		return -EINVAL;
+
+	return kernfs_node_xattr_set(kn, name, value, size, flags);
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 39eea07c2900..196a98cf39ed 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -371,9 +371,9 @@ __poll_t kernfs_generic_poll(struct kernfs_open_file *of,
 			     struct poll_table_struct *pt);
 void kernfs_notify(struct kernfs_node *kn);
 
-int kernfs_security_xattr_get(struct kernfs_node *kn, const char *suffix,
+int kernfs_security_xattr_get(struct kernfs_node *kn, const char *name,
 			      void *value, size_t size);
-int kernfs_security_xattr_set(struct kernfs_node *kn, const char *suffix,
+int kernfs_security_xattr_set(struct kernfs_node *kn, const char *name,
 			      void *value, size_t size, int flags);
 
 const void *kernfs_super_ns(struct super_block *sb);
@@ -479,12 +479,12 @@ static inline int kernfs_setattr(struct kernfs_node *kn,
 static inline void kernfs_notify(struct kernfs_node *kn) { }
 
 static inline int kernfs_security_xattr_get(struct kernfs_node *kn,
-					    const char *suffix, void *value,
+					    const char *name, void *value,
 					    size_t size)
 { return -ENOSYS; }
 
 static inline int kernfs_security_xattr_set(struct kernfs_node *kn,
-					    const char *suffix, void *value,
+					    const char *name, void *value,
 					    size_t size, int flags)
 { return -ENOSYS; }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ab4b049daf17..716ae37d4834 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3394,7 +3394,7 @@ int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	int rc;
 	char *context;
 
-	rc = kernfs_security_xattr_get(kn_dir, XATTR_SELINUX_SUFFIX, NULL, 0);
+	rc = kernfs_security_xattr_get(kn_dir, XATTR_NAME_SELINUX, NULL, 0);
 	if (rc == -ENODATA)
 		return 0;
 	else if (rc < 0)
@@ -3405,7 +3405,7 @@ int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	if (!context)
 		return -ENOMEM;
 
-	rc = kernfs_security_xattr_get(kn_dir, XATTR_SELINUX_SUFFIX, context,
+	rc = kernfs_security_xattr_get(kn_dir, XATTR_NAME_SELINUX, context,
 				       clen);
 	if (rc < 0) {
 		kfree(context);
@@ -3439,7 +3439,7 @@ int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	if (rc)
 		return rc;
 
-	rc = kernfs_security_xattr_set(kn, XATTR_SELINUX_SUFFIX, context, clen,
+	rc = kernfs_security_xattr_set(kn, XATTR_NAME_SELINUX, context, clen,
 				       XATTR_CREATE);
 	kfree(context);
 	return rc;
-- 
2.20.1

