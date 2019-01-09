Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3996C43444
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FAD206BB
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfAIJLP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbfAIJLM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 04:11:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so6828170wra.6
        for <selinux@vger.kernel.org>; Wed, 09 Jan 2019 01:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQ9+vAEQgXLrTJxApgP0j/Zmb2cMc+3wzdpOFUtuIXI=;
        b=N+rXXG/pq6DDZ549bGcxAIg/FXoHZn6j4fhSDWdsLZFFre8pNxzWO63QiltKtrqJwJ
         Fhxq8wFdO40I7qGvYOFZ89y1drXGsBqd5kxDjT6Kwxd3yVTfblcm0tQdFJbXscJvmlsg
         gAhdnKqSax5fNXpD1mYPJQQWisffX1TF8JcPEOW1uZ4rMI1G3POdfgfR09h/78YdtYBA
         mRRi6vi1nXFVYZ7957wahVtGqpo/vumGTz9Y9SrPn3GwPImIGkIT58N+Us0SNcM5C4rT
         894PxDoHJd29MGH9HYGAuT6EZzH65aPP1FbPU8eiaxQtFkjhgWRLjZB94ItKgNhsrhGt
         VvBg==
X-Gm-Message-State: AJcUukfv5Cg45790In9t1A9kwzQN93VSabbfqhmm24c/pHPLblMsPhX0
        lv43jqv3Qs/KCFlrfeKf5siuf7FCPCg=
X-Google-Smtp-Source: ALg8bN7z/3Nrj9nXWbegnf9n3opvTnjeaFutopKBZPQixqDztrjdDfq0qXKvc3BaM5ENMqUalJd52A==
X-Received: by 2002:adf:81b6:: with SMTP id 51mr4519424wra.240.1547025070415;
        Wed, 09 Jan 2019 01:11:10 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f137sm11186044wmg.29.2019.01.09.01.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 01:11:09 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 3/3] kernfs: Initialize security of newly created nodes
Date:   Wed,  9 Jan 2019 10:10:28 +0100
Message-Id: <20190109091028.24485-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109091028.24485-1-omosnace@redhat.com>
References: <20190109091028.24485-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the new security_object_init_security() hook to allow LSMs to
possibly assign a non-default security context to newly created nodes
based on the context of their parent node.

This fixes an issue with cgroupfs under SELinux, where newly created
cgroup subdirectories would not inherit its parent's context if it had
been set explicitly to a non-default value (other than the genfs context
specified by the policy). This can be reproduced as follows:

    # mkdir /sys/fs/cgroup/unified/test
    # chcon -R system_u:object_r:cgroup_t:s0:c123 /sys/fs/cgroup/unified/test
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.controllers
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.max.depth
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.max.descendants
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.procs
    -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.stat
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.subtree_control
    -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.threads
    drwxr-xr-x.  2 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:54 init.scope
    drwxr-xr-x. 25 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:54 system.slice
    drwxr-xr-x.  2 root root system_u:object_r:cgroup_t:s0:c123 0 Jan  8 04:59 test
    drwxr-xr-x.  3 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:55 user.slice
    # mkdir /sys/fs/cgroup/unified/test/subdir

Actual result:

    # ls -ldZ /sys/fs/cgroup/unified/test/subdir
    drwxr-xr-x. 2 root root system_u:object_r:cgroup_t:s0 0 Jan  8 05:10 /sys/fs/cgroup/unified/test/subdir

Expected result:

    # ls -ldZ /sys/fs/cgroup/unified/test/subdir
    drwxr-xr-x. 2 root root unconfined_u:object_r:cgroup_t:s0:c123 0 Jan  8 05:10 /sys/fs/cgroup/unified/test/subdir

Link: https://github.com/SELinuxProject/selinux-kernel/issues/39
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
 fs/kernfs/inode.c           |  9 +++----
 fs/kernfs/kernfs-internal.h |  4 +++
 3 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4ca0b5c18192..8a678a934f65 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/hash.h>
+#include <linux/stringhash.h>
 
 #include "kernfs-internal.h"
 
@@ -617,7 +618,43 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 	return NULL;
 }
 
-static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
+static int kernfs_node_init_security(struct kernfs_node *parent,
+				     struct kernfs_node *kn, umode_t mode)
+{
+	struct kernfs_iattrs *attrs;
+	struct qstr q;
+	void *ctx;
+	u32 ctxlen;
+	int ret;
+
+	/* If parent has no explicit context set, leave child unset as well */
+	if (!parent->iattr)
+		return 0;
+	if (!parent->iattr->ia_secdata || !parent->iattr->ia_secdata_len)
+		return 0;
+
+	q.name = kn->name;
+	q.hash_len = hashlen_string(parent, kn->name);
+
+	ret = security_object_init_security(parent->iattr->ia_secdata,
+					    parent->iattr->ia_secdata_len,
+					    &q, (u16)mode, &ctx, &ctxlen);
+	if (ret)
+		return ret;
+
+	attrs = kernfs_iattrs(kn);
+	if (!attrs) {
+		security_release_secctx(ctx, ctxlen);
+		return -ENOMEM;
+	}
+
+	kernfs_node_setsecdata(attrs, &ctx, &ctxlen);
+	/* The inode is fresh, so the returned ctx is always NULL. */
+	return 0;
+}
+
+static struct kernfs_node *__kernfs_new_node(struct kernfs_node *parent,
+					     struct kernfs_root *root,
 					     const char *name, umode_t mode,
 					     kuid_t uid, kgid_t gid,
 					     unsigned flags)
@@ -674,6 +711,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 			goto err_out3;
 	}
 
+	if (parent) {
+		ret = kernfs_node_init_security(parent, kn, mode);
+		if (ret)
+			goto err_out3;
+	}
+
 	return kn;
 
  err_out3:
@@ -692,7 +735,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	kn = __kernfs_new_node(kernfs_root(parent),
+	kn = __kernfs_new_node(parent, kernfs_root(parent),
 			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
@@ -962,7 +1005,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	INIT_LIST_HEAD(&root->supers);
 	root->next_generation = 1;
 
-	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
+	kn = __kernfs_new_node(NULL, root, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 			       KERNFS_DIR);
 	if (!kn) {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 80cebcd94c90..e6db8d23437b 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -31,7 +31,7 @@ static const struct inode_operations kernfs_iops = {
 	.listxattr	= kernfs_iop_listxattr,
 };
 
-static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
+struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 {
 	static DEFINE_MUTEX(iattr_mutex);
 	struct kernfs_iattrs *ret;
@@ -135,8 +135,8 @@ out:
 	return error;
 }
 
-static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
-				  u32 *secdata_len)
+void kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
+			    u32 *secdata_len)
 {
 	void *old_secdata;
 	size_t old_secdata_len;
@@ -149,7 +149,6 @@ static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
 
 	*secdata = old_secdata;
 	*secdata_len = old_secdata_len;
-	return 0;
 }
 
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
@@ -365,7 +364,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
+	kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
 	mutex_unlock(&kernfs_mutex);
 
 	if (secdata)
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3d83b114bb08..f6fb2df24c30 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -92,6 +92,10 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 
+struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn);
+void kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
+			    u32 *secdata_len);
+
 /*
  * dir.c
  */
-- 
2.20.1

