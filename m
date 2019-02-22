Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10D5C10F0B
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2B420657
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfBVO6A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:58:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34889 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfBVO57 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 09:57:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so2255487wma.0
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 06:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIV1fCtG86s0m7c7WVIkMbP81jHJSbE5ZarjCCqDsws=;
        b=P+uSAHFalmxfwF7csj7mPG/7a7mtYOGvt9N80NR0UTaAw1VPeR5lmoGHDn/YaUbAo9
         ex87VCcS7xTir4CYyEfSBPloFhBMaRjdxiYadMJ+YWfLMYcrR7FEEtooO359n9gUkt1t
         RUJeU8Ha32jxOXtzoLQyM2Wsvglzhsz+1Ag3pBMMcFWpHyZC//TqVrOd7oCQ10gLqRnK
         zQ6gzB6qICuzeM97eIE047p69FN8RHNpo4HN9jDowfh1lgvQW0swj1eLgTW52NJwRxPH
         i3rjt3wg6fxPtTMtWCImfPCaVOmkRUilZiS/A+mK4MZDU3aS9YeakB8XvPjzE+kng18S
         Zgmg==
X-Gm-Message-State: AHQUAubJoKdASSlX1fGGSIBcJHI7FtTEB5umqYq8OZ2bPjYjVkLgW+H7
        8rk5n4pls8dPZb9tRCS8Sgki59M9If3moA==
X-Google-Smtp-Source: AHgI3IZGtmfvx6O88/ej785uZA2eS30KPDhLGylbngJTAqcI40/W4v3FYL1C1dejIT3+K57f22cKLg==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr2872288wmz.150.1550847477314;
        Fri, 22 Feb 2019 06:57:57 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 203sm1503912wme.30.2019.02.22.06.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:57:56 -0800 (PST)
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
Subject: [PATCH v7 7/7] kernfs: initialize security of newly created nodes
Date:   Fri, 22 Feb 2019 15:57:18 +0100
Message-Id: <20190222145718.5740-8-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222145718.5740-1-omosnace@redhat.com>
References: <20190222145718.5740-1-omosnace@redhat.com>
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
 fs/kernfs/dir.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6048f2ce85c4..c5f6e6c76982 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -615,6 +615,7 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 }
 
 static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
+					     struct kernfs_node *parent,
 					     const char *name, umode_t mode,
 					     kuid_t uid, kgid_t gid,
 					     unsigned flags)
@@ -671,6 +672,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 			goto err_out3;
 	}
 
+	if (parent) {
+		ret = security_kernfs_init_security(parent, kn);
+		if (ret)
+			goto err_out3;
+	}
+
 	return kn;
 
  err_out3:
@@ -689,7 +696,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	kn = __kernfs_new_node(kernfs_root(parent),
+	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
@@ -958,7 +965,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	INIT_LIST_HEAD(&root->supers);
 	root->next_generation = 1;
 
-	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
+	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 			       KERNFS_DIR);
 	if (!kn) {
-- 
2.20.1

