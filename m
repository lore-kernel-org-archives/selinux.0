Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC866C282D7
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A842083B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfBEI7m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:59:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbfBEI7j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 03:59:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so648296wrn.1
        for <selinux@vger.kernel.org>; Tue, 05 Feb 2019 00:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7b1bc6+meFmPqgAqo0J5mXXNpERkis1nOajyuz7TJZM=;
        b=Bx5LKn9dDhDqC81D/H7rjrlBY94417gg+bBE/d+3SwMtjK4ml4m/sCMhMyvhUe/6HH
         0KA2VgTuKXCIMfRgNMGApOlh8vnJD4cceWbULZpA0+MosHUNpeXzvmVrLXnSDICtUVz0
         nOkhTmTqL4Urv3aSoKEFG/eB5v5tTyH8cfWbH28tHvKQqRcJipjf8ZrZtLe94y3jSR6J
         kryVFjHSTYgkhSSlexj5JRUU+Tk5eRHLYkOjY2S2tRpycptu8mWYsFr/wuh/cSbTjGlY
         VOrPTYBc/dAOGChl7UZwKBXGXYw7whI9qxHYZneNekjqfnqsFjyO00/Pf48NVeIAGZvw
         1rfQ==
X-Gm-Message-State: AHQUAuZk79MYHEoAp3/21RbL9jlvYXNk6d5r0ZZSS0YgMy9xw7tLoy/Q
        Kx9z6VDgxZ9Ge5nKzW47EBL4m0Jls+E=
X-Google-Smtp-Source: AHgI3IYIlgvmYuf6FLMF8ysO2kH8XciSTKd+0GOdOdDNv6d6aaOnJuIN6vw1PUAktYPIab3HYoAl4w==
X-Received: by 2002:adf:b201:: with SMTP id u1mr2640918wra.165.1549357176054;
        Tue, 05 Feb 2019 00:59:36 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n82sm12973613wma.42.2019.02.05.00.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 00:59:35 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v4 5/5] kernfs: initialize security of newly created nodes
Date:   Tue,  5 Feb 2019 09:59:15 +0100
Message-Id: <20190205085915.5183-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205085915.5183-1-omosnace@redhat.com>
References: <20190205085915.5183-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the new security_kernfs_init_security() hook to allow LSMs to
possibly assign a non-default security context to a newly created kernfs
node based on the attributes of the new node and also its parent node.

This fixes an issue with cgroupfs under SELinux, where newly created
cgroup subdirectories/files would not inherit its parent's context if
it had been set explicitly to a non-default value (other than the genfs
context specified by the policy). This can be reproduced as follows (on
Fedora/RHEL):

    # mkdir /sys/fs/cgroup/unified/test
    # # Need permissive to change the label under Fedora policy:
    # setenforce 0
    # chcon -t container_file_t /sys/fs/cgroup/unified/test
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 cgroup.controllers
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 cgroup.max.depth
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 cgroup.max.descendants
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 cgroup.procs
    -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 cgroup.stat
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 cgroup.subtree_control
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 cgroup.threads
    drwxr-xr-x.  2 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 init.scope
    drwxr-xr-x. 26 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:21 system.slice
    drwxr-xr-x.  3 root root system_u:object_r:container_file_t:s0 0 Jan 29 03:15 test
    drwxr-xr-x.  3 root root system_u:object_r:cgroup_t:s0         0 Jan 29 03:06 user.slice
    # mkdir /sys/fs/cgroup/unified/test/subdir

Actual result:

    # ls -ldZ /sys/fs/cgroup/unified/test/subdir
    drwxr-xr-x. 2 root root system_u:object_r:cgroup_t:s0 0 Jan 29 03:15 /sys/fs/cgroup/unified/test/subdir

Expected result:

    # ls -ldZ /sys/fs/cgroup/unified/test/subdir
    drwxr-xr-x. 2 root root unconfined_u:object_r:container_file_t:s0 0 Jan 29 03:15 /sys/fs/cgroup/unified/test/subdir

Link: https://github.com/SELinuxProject/selinux-kernel/issues/39
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/dir.c             | 57 +++++++++++++++++++++++++++++++++++--
 fs/kernfs/inode.c           | 25 +++++++++-------
 fs/kernfs/kernfs-internal.h |  2 ++
 include/linux/xattr.h       | 15 ++++++++++
 4 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ad7e3356bcc5..735a6d382d9d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/hash.h>
+#include <linux/stringhash.h>
 
 #include "kernfs-internal.h"
 
@@ -616,7 +617,53 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 	return NULL;
 }
 
+static int kernfs_node_init_security(struct kernfs_node *parent,
+				     struct kernfs_node *kn)
+{
+	struct simple_xattrs xattr_child, xattr_parent, *pxattr_parent;
+	struct iattr iattr_child, iattr_parent, *piattr_parent;
+	struct qstr q;
+	int ret;
+
+	if (!parent->iattr) {
+		kernfs_iattr_init(&iattr_parent, parent);
+		simple_xattrs_init(&xattr_parent);
+		piattr_parent = &iattr_parent;
+		pxattr_parent = &xattr_parent;
+	} else {
+		piattr_parent = &parent->iattr->ia_iattr;
+		pxattr_parent = &parent->iattr->xattrs_security;
+	}
+
+	kernfs_iattr_init(&iattr_child, kn);
+	simple_xattrs_init(&xattr_child);
+
+	q.name = kn->name;
+	q.hash_len = hashlen_string(parent, kn->name);
+
+	ret = security_kernfs_init_security(&q, piattr_parent, pxattr_parent,
+					    &iattr_child, &xattr_child);
+	if (pxattr_parent == &xattr_parent)
+		simple_xattrs_free(&xattr_parent);
+	if (!ret && !simple_xattrs_empty(&xattr_child)) {
+		/*
+		 * Child has new security xattrs, allocate its kernfs_iattrs
+		 * and put our local xattrs in there.
+		 */
+		struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
+
+		if (!attrs) {
+			simple_xattrs_free(&xattr_child);
+			return -ENOMEM;
+		}
+		simple_xattrs_move(&attrs->xattrs_security, &xattr_child);
+	}
+	simple_xattrs_free(&xattr_child);
+	return ret;
+}
+
 static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
+					     struct kernfs_node *parent,
 					     const char *name, umode_t mode,
 					     kuid_t uid, kgid_t gid,
 					     unsigned flags)
@@ -673,6 +720,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 			goto err_out3;
 	}
 
+	if (parent) {
+		ret = kernfs_node_init_security(parent, kn);
+		if (ret)
+			goto err_out3;
+	}
+
 	return kn;
 
  err_out3:
@@ -691,7 +744,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	kn = __kernfs_new_node(kernfs_root(parent),
+	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
@@ -961,7 +1014,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	INIT_LIST_HEAD(&root->supers);
 	root->next_generation = 1;
 
-	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
+	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 			       KERNFS_DIR);
 	if (!kn) {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index f0e2cb4379c0..6a9084aecbe5 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -31,11 +31,22 @@ static const struct inode_operations kernfs_iops = {
 	.listxattr	= kernfs_iop_listxattr,
 };
 
-static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
+void kernfs_iattr_init(struct iattr *iattrs, struct kernfs_node *kn)
+{
+	/* assign default attributes */
+	iattrs->ia_mode = kn->mode;
+	iattrs->ia_uid = GLOBAL_ROOT_UID;
+	iattrs->ia_gid = GLOBAL_ROOT_GID;
+
+	ktime_get_real_ts64(&iattrs->ia_atime);
+	iattrs->ia_mtime = iattrs->ia_atime;
+	iattrs->ia_ctime = iattrs->ia_atime;
+}
+
+struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 {
 	static DEFINE_MUTEX(iattr_mutex);
 	struct kernfs_iattrs *ret;
-	struct iattr *iattrs;
 
 	mutex_lock(&iattr_mutex);
 
@@ -45,16 +56,8 @@ static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 	kn->iattr = kzalloc(sizeof(struct kernfs_iattrs), GFP_KERNEL);
 	if (!kn->iattr)
 		goto out_unlock;
-	iattrs = &kn->iattr->ia_iattr;
-
-	/* assign default attributes */
-	iattrs->ia_mode = kn->mode;
-	iattrs->ia_uid = GLOBAL_ROOT_UID;
-	iattrs->ia_gid = GLOBAL_ROOT_GID;
 
-	ktime_get_real_ts64(&iattrs->ia_atime);
-	iattrs->ia_mtime = iattrs->ia_atime;
-	iattrs->ia_ctime = iattrs->ia_atime;
+	kernfs_iattr_init(&kn->iattr->ia_iattr, kn);
 
 	simple_xattrs_init(&kn->iattr->xattrs_trusted);
 	simple_xattrs_init(&kn->iattr->xattrs_security);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 93bf1dcd0306..ad80f438d8d4 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -90,6 +90,8 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
+void kernfs_iattr_init(struct iattr *iattrs, struct kernfs_node *kn);
+struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn);
 
 /*
  * dir.c
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 6dad031be3c2..05fc6812d554 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -108,4 +108,19 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs, cha
 void simple_xattr_list_add(struct simple_xattrs *xattrs,
 			   struct simple_xattr *new_xattr);
 
+static inline int simple_xattrs_empty(struct simple_xattrs *xattrs)
+{
+	return list_empty(&xattrs->head);
+}
+
+/**
+ * Move the xattr list from @src to @dst, leaving @src empty.
+ */
+static inline void simple_xattrs_move(struct simple_xattrs *dst,
+				      struct simple_xattrs *src)
+{
+	simple_xattrs_free(dst);
+	list_replace_init(&src->head, &dst->head);
+}
+
 #endif	/* _LINUX_XATTR_H */
-- 
2.20.1

