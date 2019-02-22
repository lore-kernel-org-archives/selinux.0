Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D35C10F18
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE89F2086D
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfBVO5z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:57:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37090 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfBVO5z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 09:57:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so2703973wrs.4
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 06:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtC53CwnIpZppJiGjM2dPMSUQdkOPhnvKUZTLjV/uWw=;
        b=ryvDb5Nvu1+zQbNfkyM1K7sNXvDAozUnr1v+9c4Cb9p6xsYw8Pq2iiezrH+PsjCNoZ
         Wod6zB/8jSgzOYd/biRS7yW2O3L1fz3wtXm6FSa4eCcgQrUugugg2MhmX+flEzRF7Aeh
         amS2+xRRelT0Z9if6nkBXa83vu4O/GUGIbebT4e6JR+TdChTr1jJkYq8zkRIanE1/zJr
         gPum6UVJPOTr5jBjBZN80l+WgtM59oUSBxrsVJCJPJ7q/n2XS16JnzFGMuTZ7PaXi5FB
         /wBkAmR4Aiza0xpf2uWHqbWEFu+Ly+75psFTY10BeXpMW+r8nS+4MqZ21forwP6Z3z23
         ZEdA==
X-Gm-Message-State: AHQUAuZL31uoAtB4TFAt+h1qnFmdfn1wsME0df785+8q1mOQIW/EC3oi
        9zmWV6Nbex79o9nRpwt1DK/sGPovicycMg==
X-Google-Smtp-Source: AHgI3IafQQvCpXtC0mmzQdj04YWnd6hHIiJKlzp1ZbkFQwsaQpEaDW5EebOja8mQysZkx4fVojSulg==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr3096428wrn.315.1550847473411;
        Fri, 22 Feb 2019 06:57:53 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 203sm1503912wme.30.2019.02.22.06.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:57:52 -0800 (PST)
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
Subject: [PATCH v7 4/7] kernfs: use simple_xattrs for security attributes
Date:   Fri, 22 Feb 2019 15:57:15 +0100
Message-Id: <20190222145718.5740-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222145718.5740-1-omosnace@redhat.com>
References: <20190222145718.5740-1-omosnace@redhat.com>
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
 fs/kernfs/dir.c             |  7 ++---
 fs/kernfs/inode.c           | 55 ++-----------------------------------
 fs/kernfs/kernfs-internal.h |  2 --
 3 files changed, 4 insertions(+), 60 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e3e00d9be70d..6048f2ce85c4 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -531,12 +531,9 @@ void kernfs_put(struct kernfs_node *kn)
 
 	kfree_const(kn->name);
 
-	if (kn->iattr) {
-		if (kn->iattr->ia_secdata)
-			security_release_secctx(kn->iattr->ia_secdata,
-						kn->iattr->ia_secdata_len);
+	if (kn->iattr)
 		simple_xattrs_free(&kn->iattr->xattrs);
-	}
+
 	kfree(kn->iattr);
 	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, kn->id.ino);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 7a7985961bbf..1acdfbf4b86a 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -137,23 +137,6 @@ out:
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
@@ -189,15 +172,12 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 	struct kernfs_iattrs *attrs = kn->iattr;
 
 	inode->i_mode = kn->mode;
-	if (attrs) {
+	if (attrs)
 		/*
 		 * kernfs_node has non-default attributes get them from
 		 * persistent copy in kernfs_node.
 		 */
 		set_inode_attr(inode, attrs);
-		security_inode_notifysecctx(inode, attrs->ia_secdata,
-					    attrs->ia_secdata_len);
-	}
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		set_nlink(inode, kn->dir.subdirs + 2);
@@ -345,41 +325,10 @@ static const struct xattr_handler kernfs_trusted_xattr_handler = {
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
index 388c1193c4fa..0e1f1aa7df1e 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -24,8 +24,6 @@ struct kernfs_iattrs {
 	struct timespec64	ia_atime;
 	struct timespec64	ia_mtime;
 	struct timespec64	ia_ctime;
-	void			*ia_secdata;
-	u32			ia_secdata_len;
 
 	struct simple_xattrs	xattrs;
 };
-- 
2.20.1

