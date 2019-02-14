Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5C9C4360F
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60231222A4
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406218AbfBNJug (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:50:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44505 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406213AbfBNJua (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 04:50:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so5690753wrn.11
        for <selinux@vger.kernel.org>; Thu, 14 Feb 2019 01:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QMYjOe+pf/wWcR8iZ9VPRtgN1hVQge8pFTdDf7ePKo=;
        b=HpGcoMPwu2il7kqJ8Nx3oSaVn4NxCAztrErcfafUXXkUrlYdOdUhnrc5yw+lCWF0mZ
         l5x5OcXFKq8hXIout2YYmOyiq5qogztL5p2PwxInAxyHJuYJ8Mi9yzkYEtTeXxkia1E0
         Nrk+bKsO7tx5MVHMQamWXhi43mnGT9Khb20sIVFSq2cR60RkaiTeb2v9NcVMCad/Mjf+
         G7lzQR/QtoeSymLitcoj48nYvw/4EnER8A3/ue03Is35O0s0p/uDIniqCpjCxLcsfOaY
         NcHYKFbayI6m3QvUid/a+rN8nNVnybrXAjvDqdyN3HkhlGCuBVK+5XvuBV6asGOX7FoN
         CY0g==
X-Gm-Message-State: AHQUAub9ajFAyZwxcUiMOzUKflny9sBfwgKNyLx7UilOnpDMYW+0EsdV
        lZUsL0AmdZ74kcZ+31auJu8kvoELM9w=
X-Google-Smtp-Source: AHgI3IYJ5QYWMgXya0INPv5OoCWnpQ7omXQ25Wh4gTLx0SXSI8zKfi6UawYmvOhGrA+MZd2f0lsDSQ==
X-Received: by 2002:adf:f103:: with SMTP id r3mr2264430wro.50.1550137828080;
        Thu, 14 Feb 2019 01:50:28 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g11sm969439wmk.26.2019.02.14.01.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:50:27 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v6 2/5] kernfs: use simple_xattrs for security attributes
Date:   Thu, 14 Feb 2019 10:50:12 +0100
Message-Id: <20190214095015.16032-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214095015.16032-1-omosnace@redhat.com>
References: <20190214095015.16032-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the special handling of security xattrs with simple_xattrs, as
is already done for the trusted xattrs. This simplifies the code and
allows LSMs to use more than just a single xattr to do their business.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/dir.c             |   7 ++-
 fs/kernfs/inode.c           | 100 +++++++++++++++---------------------
 fs/kernfs/kernfs-internal.h |   5 +-
 3 files changed, 46 insertions(+), 66 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4ca0b5c18192..ad7e3356bcc5 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -532,11 +532,10 @@ void kernfs_put(struct kernfs_node *kn)
 	kfree_const(kn->name);
 
 	if (kn->iattr) {
-		if (kn->iattr->ia_secdata)
-			security_release_secctx(kn->iattr->ia_secdata,
-						kn->iattr->ia_secdata_len);
-		simple_xattrs_free(&kn->iattr->xattrs);
+		simple_xattrs_free(&kn->iattr->xattrs_trusted);
+		simple_xattrs_free(&kn->iattr->xattrs_security);
 	}
+
 	kfree(kn->iattr);
 	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, kn->id.ino);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 80cebcd94c90..f0e2cb4379c0 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -56,7 +56,8 @@ static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 	iattrs->ia_mtime = iattrs->ia_atime;
 	iattrs->ia_ctime = iattrs->ia_atime;
 
-	simple_xattrs_init(&kn->iattr->xattrs);
+	simple_xattrs_init(&kn->iattr->xattrs_trusted);
+	simple_xattrs_init(&kn->iattr->xattrs_security);
 out_unlock:
 	ret = kn->iattr;
 	mutex_unlock(&iattr_mutex);
@@ -135,33 +136,31 @@ out:
 	return error;
 }
 
-static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
-				  u32 *secdata_len)
-{
-	void *old_secdata;
-	size_t old_secdata_len;
-
-	old_secdata = attrs->ia_secdata;
-	old_secdata_len = attrs->ia_secdata_len;
-
-	attrs->ia_secdata = *secdata;
-	attrs->ia_secdata_len = *secdata_len;
-
-	*secdata = old_secdata;
-	*secdata_len = old_secdata_len;
-	return 0;
-}
-
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct kernfs_iattrs *attrs;
+	ssize_t ret, length = 0;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
+	ret = simple_xattr_list(inode, &attrs->xattrs_trusted, buf, size);
+	if (ret < 0)
+		return ret;
+	length += ret;
+
+	buf += ret;
+	size -= ret;
+
+	ret = simple_xattr_list(inode, &attrs->xattrs_security, buf, size);
+	if (ret < 0)
+		return ret;
+	length += ret;
+
+	return length;
 }
 
 static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
@@ -186,15 +185,12 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 	struct kernfs_iattrs *attrs = kn->iattr;
 
 	inode->i_mode = kn->mode;
-	if (attrs) {
+	if (attrs)
 		/*
 		 * kernfs_node has non-default attributes get them from
 		 * persistent copy in kernfs_node.
 		 */
 		set_inode_attr(inode, &attrs->ia_iattr);
-		security_inode_notifysecctx(inode, attrs->ia_secdata,
-					    attrs->ia_secdata_len);
-	}
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		set_nlink(inode, kn->dir.subdirs + 2);
@@ -305,19 +301,29 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 	return generic_permission(inode, mask);
 }
 
+static const struct xattr_handler kernfs_trusted_xattr_handler;
+static const struct xattr_handler kernfs_security_xattr_handler;
+
 static int kernfs_xattr_get(const struct xattr_handler *handler,
 			    struct dentry *unused, struct inode *inode,
 			    const char *suffix, void *value, size_t size)
 {
-	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
+	struct simple_xattrs *xattrs;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_get(&attrs->xattrs, name, value, size);
+	if (handler == &kernfs_trusted_xattr_handler)
+		xattrs = &attrs->xattrs_trusted;
+	else if (handler == &kernfs_security_xattr_handler)
+		xattrs = &attrs->xattrs_security;
+	else
+		return -EINVAL;
+
+	return simple_xattr_get(xattrs, suffix, value, size);
 }
 
 static int kernfs_xattr_set(const struct xattr_handler *handler,
@@ -325,15 +331,22 @@ static int kernfs_xattr_set(const struct xattr_handler *handler,
 			    const char *suffix, const void *value,
 			    size_t size, int flags)
 {
-	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
+	struct simple_xattrs *xattrs;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
+	if (handler == &kernfs_trusted_xattr_handler)
+		xattrs = &attrs->xattrs_trusted;
+	else if (handler == &kernfs_security_xattr_handler)
+		xattrs = &attrs->xattrs_security;
+	else
+		return -EINVAL;
+
+	return simple_xattr_set(xattrs, suffix, value, size, flags);
 }
 
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
@@ -342,41 +355,10 @@ static const struct xattr_handler kernfs_trusted_xattr_handler = {
 	.set = kernfs_xattr_set,
 };
 
-static int kernfs_security_xattr_set(const struct xattr_handler *handler,
-				     struct dentry *unused, struct inode *inode,
-				     const char *suffix, const void *value,
-				     size_t size, int flags)
-{
-	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_iattrs *attrs;
-	void *secdata;
-	u32 secdata_len = 0;
-	int error;
-
-	attrs = kernfs_iattrs(kn);
-	if (!attrs)
-		return -ENOMEM;
-
-	error = security_inode_setsecurity(inode, suffix, value, size, flags);
-	if (error)
-		return error;
-	error = security_inode_getsecctx(inode, &secdata, &secdata_len);
-	if (error)
-		return error;
-
-	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
-	mutex_unlock(&kernfs_mutex);
-
-	if (secdata)
-		security_release_secctx(secdata, secdata_len);
-	return error;
-}
-
 static const struct xattr_handler kernfs_security_xattr_handler = {
 	.prefix = XATTR_SECURITY_PREFIX,
 	.get = kernfs_xattr_get,
-	.set = kernfs_security_xattr_set,
+	.set = kernfs_xattr_set,
 };
 
 const struct xattr_handler *kernfs_xattr_handlers[] = {
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3d83b114bb08..93bf1dcd0306 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -20,10 +20,9 @@
 
 struct kernfs_iattrs {
 	struct iattr		ia_iattr;
-	void			*ia_secdata;
-	u32			ia_secdata_len;
 
-	struct simple_xattrs	xattrs;
+	struct simple_xattrs	xattrs_trusted;
+	struct simple_xattrs	xattrs_security;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
-- 
2.20.1

