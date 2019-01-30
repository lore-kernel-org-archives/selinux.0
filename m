Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E692C282D7
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2208820882
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfA3LnW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:43:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37952 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfA3LnV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 06:43:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so21374970wml.3
        for <selinux@vger.kernel.org>; Wed, 30 Jan 2019 03:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PwjwnLNTsMD005MExgPvqEqo3DYQCBut/K5wBI3Tz8=;
        b=G+hIuVhhcW/ND7724/bPfpyrlAyN8WPLbg2YgoLypgaNPi1AvE6dOEHsPhaSmdmPhz
         b4Eba+cS+YQfxwfUmUYn9B4safXLySRK30uK99Y6elnlRVGWakMuGl22i32htmdopDOh
         EESFGxsvhUW82MS2iR+p8NeuDejCzmp2vPxFusdr8S17oKyJg7L7t3jtGFx8QODZmTU2
         t/SDTrgL+kzR1YiezLn5LCuA8+sJKCvhcK3elZS2e4tKggIErqkSJM/ZuuzfpfVUam/+
         H7/68AVRiphwgepsr+N+hJyeNI6Ivzynm3q5ywN4UwNjsJtLTT8pgAXltkuodgwtSLfL
         4MfQ==
X-Gm-Message-State: AJcUuke90Wln94p9kJz0UWBwvh9EOreAkPKb5Tx6JDD8a2ddP78zgV1e
        NGPC0/NgBl0M/szePlU5zc9+d24yMhg=
X-Google-Smtp-Source: ALg8bN4ZPi6grMG89IFL02CrFMuQ3SqhpDmbRacbmnfLWoV8glMov7YCQ0T1J87BtJRffLdoAmmzMQ==
X-Received: by 2002:a1c:6442:: with SMTP id y63mr23812533wmb.143.1548848597859;
        Wed, 30 Jan 2019 03:43:17 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n124sm2417691wmd.15.2019.01.30.03.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 03:43:17 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 5/5] kernfs: initialize security of newly created nodes
Date:   Wed, 30 Jan 2019 12:41:50 +0100
Message-Id: <20190130114150.27807-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130114150.27807-1-omosnace@redhat.com>
References: <20190130114150.27807-1-omosnace@redhat.com>
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
 fs/kernfs/dir.c             | 35 +++++++++++++++++++++++++++++++++--
 fs/kernfs/inode.c           |  2 +-
 fs/kernfs/kernfs-internal.h |  1 +
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ad7e3356bcc5..797199a748d7 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/hash.h>
+#include <linux/stringhash.h>
 
 #include "kernfs-internal.h"
 
@@ -616,7 +617,31 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 	return NULL;
 }
 
+static int kernfs_node_init_security(struct kernfs_node *parent,
+				     struct kernfs_node *kn)
+{
+	struct kernfs_iattrs *attrs, *pattrs;
+	struct qstr q;
+
+	attrs = kernfs_iattrs(kn);
+	if (!attrs)
+		return -ENOMEM;
+
+	pattrs = kernfs_iattrs(parent);
+	if (!pattrs)
+		return -ENOMEM;
+
+	q.name = kn->name;
+	q.hash_len = hashlen_string(parent, kn->name);
+
+	return security_kernfs_init_security(&q, &attrs->ia_iattr,
+					     &attrs->xattrs_security,
+					     &pattrs->ia_iattr,
+					     &pattrs->xattrs_security);
+}
+
 static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
+					     struct kernfs_node *parent,
 					     const char *name, umode_t mode,
 					     kuid_t uid, kgid_t gid,
 					     unsigned flags)
@@ -673,6 +698,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
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
@@ -691,7 +722,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	kn = __kernfs_new_node(kernfs_root(parent),
+	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
@@ -961,7 +992,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	INIT_LIST_HEAD(&root->supers);
 	root->next_generation = 1;
 
-	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
+	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 			       KERNFS_DIR);
 	if (!kn) {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index f0e2cb4379c0..645c404b8644 100644
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
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 93bf1dcd0306..90215f8e503a 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -90,6 +90,7 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
+struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn);
 
 /*
  * dir.c
-- 
2.20.1

