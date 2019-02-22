Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E52C10F00
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524122086A
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfBVO5v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:57:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52163 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBVO5v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 09:57:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so2230995wmi.1
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 06:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8YHv0/qIqj+KRVAYbor72UyNmxKrCXiH7RYPyw72kU=;
        b=IGEz6HycfNFVUmTqDyrmRXuyg+x/iXzA07KDSeH16D63JYDcD6b1NIyscZ9jV7vG78
         LrApc6b1IiT4JOCXXhJmh00SRZN/xByo/qzl//mU+ogUdv0ORNsQPZTdgfTU38oOz0nH
         daCk+4tN7v2pUnPG52hEBMj3i7AZqa5S6UAgVRALGVLKxUPipVH9VfAifCXQWsMFn0n2
         ef/LI5XqVf8KXaoVVs5QhX5mfBJkxhGcifig2/XhshHE47FNJz2tIsWxswnvZD74r+Ii
         GCC1G7mvwC3kF6H1DSYKoQ+q7KCzCiW6qzUOgcD9dLvDReE6skScW4ZO5uSU1e6mJAjg
         Ffjg==
X-Gm-Message-State: AHQUAuYrZ5CGa0KF+vNRX8QYmEk9wpbCf4ZJKIs3asdiJWgtopPCDTiL
        IHUqQdtNnQkrKiQKY0ITwTc3Aal+XL+e2A==
X-Google-Smtp-Source: AHgI3IbGcwdiZdgENhG4RF7d9RUODRKCbnSygvPNXZ+Qqgv2HwmGICokA+II73AJzD51MlMyRRP8oQ==
X-Received: by 2002:a1c:6c12:: with SMTP id h18mr2556656wmc.131.1550847468932;
        Fri, 22 Feb 2019 06:57:48 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 203sm1503912wme.30.2019.02.22.06.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:57:48 -0800 (PST)
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
Subject: [PATCH v7 1/7] kernfs: clean up struct kernfs_iattrs
Date:   Fri, 22 Feb 2019 15:57:12 +0100
Message-Id: <20190222145718.5740-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222145718.5740-1-omosnace@redhat.com>
References: <20190222145718.5740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Right now, kernfs_iattrs embeds the whole struct iattr, even though it
doesn't really use half of its fields... This both leads to wasting
space and makes the code look awkward. Let's just list the few fields
we need directly in struct kernfs_iattrs.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/dir.c             | 10 ++++----
 fs/kernfs/inode.c           | 47 ++++++++++++++++---------------------
 fs/kernfs/kernfs-internal.h |  6 ++++-
 fs/kernfs/symlink.c         |  4 ++--
 4 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4ca0b5c18192..e3e00d9be70d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -795,9 +795,8 @@ int kernfs_add_one(struct kernfs_node *kn)
 	/* Update timestamps on the parent */
 	ps_iattr = parent->iattr;
 	if (ps_iattr) {
-		struct iattr *ps_iattrs = &ps_iattr->ia_iattr;
-		ktime_get_real_ts64(&ps_iattrs->ia_ctime);
-		ps_iattrs->ia_mtime = ps_iattrs->ia_ctime;
+		ktime_get_real_ts64(&ps_iattr->ia_ctime);
+		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
 	mutex_unlock(&kernfs_mutex);
@@ -1329,9 +1328,8 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 			/* update timestamps on the parent */
 			if (ps_iattr) {
-				ktime_get_real_ts64(&ps_iattr->ia_iattr.ia_ctime);
-				ps_iattr->ia_iattr.ia_mtime =
-					ps_iattr->ia_iattr.ia_ctime;
+				ktime_get_real_ts64(&ps_iattr->ia_ctime);
+				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 			}
 
 			kernfs_put(pos);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 80cebcd94c90..ffd1ef962728 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -35,7 +35,6 @@ static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 {
 	static DEFINE_MUTEX(iattr_mutex);
 	struct kernfs_iattrs *ret;
-	struct iattr *iattrs;
 
 	mutex_lock(&iattr_mutex);
 
@@ -45,16 +44,14 @@ static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 	kn->iattr = kzalloc(sizeof(struct kernfs_iattrs), GFP_KERNEL);
 	if (!kn->iattr)
 		goto out_unlock;
-	iattrs = &kn->iattr->ia_iattr;
 
 	/* assign default attributes */
-	iattrs->ia_mode = kn->mode;
-	iattrs->ia_uid = GLOBAL_ROOT_UID;
-	iattrs->ia_gid = GLOBAL_ROOT_GID;
+	kn->iattr->ia_uid = GLOBAL_ROOT_UID;
+	kn->iattr->ia_gid = GLOBAL_ROOT_GID;
 
-	ktime_get_real_ts64(&iattrs->ia_atime);
-	iattrs->ia_mtime = iattrs->ia_atime;
-	iattrs->ia_ctime = iattrs->ia_atime;
+	ktime_get_real_ts64(&kn->iattr->ia_atime);
+	kn->iattr->ia_mtime = kn->iattr->ia_atime;
+	kn->iattr->ia_ctime = kn->iattr->ia_atime;
 
 	simple_xattrs_init(&kn->iattr->xattrs);
 out_unlock:
@@ -66,29 +63,24 @@ out_unlock:
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	struct kernfs_iattrs *attrs;
-	struct iattr *iattrs;
 	unsigned int ia_valid = iattr->ia_valid;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	iattrs = &attrs->ia_iattr;
-
 	if (ia_valid & ATTR_UID)
-		iattrs->ia_uid = iattr->ia_uid;
+		attrs->ia_uid = iattr->ia_uid;
 	if (ia_valid & ATTR_GID)
-		iattrs->ia_gid = iattr->ia_gid;
+		attrs->ia_gid = iattr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
-		iattrs->ia_atime = iattr->ia_atime;
+		attrs->ia_atime = iattr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
-		iattrs->ia_mtime = iattr->ia_mtime;
+		attrs->ia_mtime = iattr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
-		iattrs->ia_ctime = iattr->ia_ctime;
-	if (ia_valid & ATTR_MODE) {
-		umode_t mode = iattr->ia_mode;
-		iattrs->ia_mode = kn->mode = mode;
-	}
+		attrs->ia_ctime = iattr->ia_ctime;
+	if (ia_valid & ATTR_MODE)
+		kn->mode = iattr->ia_mode;
 	return 0;
 }
 
@@ -171,14 +163,15 @@ static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
 		inode->i_ctime = current_time(inode);
 }
 
-static inline void set_inode_attr(struct inode *inode, struct iattr *iattr)
+static inline void set_inode_attr(struct inode *inode,
+				  struct kernfs_iattrs *attrs)
 {
 	struct super_block *sb = inode->i_sb;
-	inode->i_uid = iattr->ia_uid;
-	inode->i_gid = iattr->ia_gid;
-	inode->i_atime = timespec64_trunc(iattr->ia_atime, sb->s_time_gran);
-	inode->i_mtime = timespec64_trunc(iattr->ia_mtime, sb->s_time_gran);
-	inode->i_ctime = timespec64_trunc(iattr->ia_ctime, sb->s_time_gran);
+	inode->i_uid = attrs->ia_uid;
+	inode->i_gid = attrs->ia_gid;
+	inode->i_atime = timespec64_trunc(attrs->ia_atime, sb->s_time_gran);
+	inode->i_mtime = timespec64_trunc(attrs->ia_mtime, sb->s_time_gran);
+	inode->i_ctime = timespec64_trunc(attrs->ia_ctime, sb->s_time_gran);
 }
 
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
@@ -191,7 +184,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 * kernfs_node has non-default attributes get them from
 		 * persistent copy in kernfs_node.
 		 */
-		set_inode_attr(inode, &attrs->ia_iattr);
+		set_inode_attr(inode, attrs);
 		security_inode_notifysecctx(inode, attrs->ia_secdata,
 					    attrs->ia_secdata_len);
 	}
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3d83b114bb08..388c1193c4fa 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -19,7 +19,11 @@
 #include <linux/kernfs.h>
 
 struct kernfs_iattrs {
-	struct iattr		ia_iattr;
+	kuid_t			ia_uid;
+	kgid_t			ia_gid;
+	struct timespec64	ia_atime;
+	struct timespec64	ia_mtime;
+	struct timespec64	ia_ctime;
 	void			*ia_secdata;
 	u32			ia_secdata_len;
 
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 162f43b80c84..eb46c3a16e2f 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -33,8 +33,8 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 	kgid_t gid = GLOBAL_ROOT_GID;
 
 	if (target->iattr) {
-		uid = target->iattr->ia_iattr.ia_uid;
-		gid = target->iattr->ia_iattr.ia_gid;
+		uid = target->iattr->ia_uid;
+		gid = target->iattr->ia_gid;
 	}
 
 	kn = kernfs_new_node(parent, name, S_IFLNK|S_IRWXUGO, uid, gid,
-- 
2.20.1

