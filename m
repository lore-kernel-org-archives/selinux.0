Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C8C43444
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C143B2054F
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfAIQ27 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:28:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46564 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfAIQ2z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 11:28:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so8262755wrt.13
        for <selinux@vger.kernel.org>; Wed, 09 Jan 2019 08:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRDDqmr3Vwt5yZVlqcMbm6I6d7BK2hVZRky0qELkXvU=;
        b=Y63zFbQr9S6KotSVGbNY5pkXa7hsnvWh39gFgjm3xxElxDu+s1F53IjoI5TzSrH0sy
         FnBy9WN31YkZUPSDdEpYafzfTxLs8ugJnMT/Hd/GasS722V98gdY+AKs7HqaBiX/IzIR
         TPfu5GxHcOfdi8SjGHhXotruHE2G2ANafXfvVlPwkr6tDdRzVLTCqMSqglb0/14AP9rI
         w6gGNxnsN5PQ14NFYcFPpFYYBVLna5yLJy3cTgeSAKpbQsDhYLQvfvgLc8iYoFXZ1XSG
         h9PVOg88Fi6XBGLO2hvQ+M7BYOIxlGSB2IxjEIZ1Jl3qO1tX0BW4R+HXgygreOJuMRt7
         Un4A==
X-Gm-Message-State: AJcUukfgrQaohu8BAsf61aj5TMhfUSP4PzsIHGJSwso3oNqg+GInr/eE
        WFy93GIwQ7J3QTQhC4o3Rz3CQs2Zdfk=
X-Google-Smtp-Source: ALg8bN5socWIWRP3eTHOqxhvYBqZihCXAong9TjQcm79TqyuN8r/u/HPX4Pe0aCXwlxJxBQTR1tqhw==
X-Received: by 2002:adf:f009:: with SMTP id j9mr5565083wro.170.1547051333255;
        Wed, 09 Jan 2019 08:28:53 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a17sm13661438wma.15.2019.01.09.08.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 08:28:52 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 3/3] kernfs: Initialize security of newly created nodes
Date:   Wed,  9 Jan 2019 17:28:30 +0100
Message-Id: <20190109162830.8309-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109162830.8309-1-omosnace@redhat.com>
References: <20190109162830.8309-1-omosnace@redhat.com>
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
Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
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

