Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B3AC43217
	for <selinux@archiver.kernel.org>; Mon, 18 Apr 2022 09:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiDRJtO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiDRJtH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Apr 2022 05:49:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A56F165AF;
        Mon, 18 Apr 2022 02:46:28 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KhhsB2W5YzdZQt;
        Mon, 18 Apr 2022 17:46:22 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:26 +0800
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:24 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <alexander.kozhevnikov@huawei.com>, <artem.kuzin@huawei.com>,
        <hw.likun@huawei.com>, <igor.baranov@huawei.com>,
        <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <yusongping@huawei.com>, <anton.sirazetdinov@huawei.com>
Subject: [RFC PATCH 5/7] SELINUXNS: Migrate all open files and all vma to new namespace
Date:   Mon, 18 Apr 2022 17:45:50 +0800
Message-ID: <20220418094552.128898-6-alexander.kozhevnikov@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220418094552.128898-1-alexander.kozhevnikov@huawei.com>
References: <CAHC9VhTDu1GDxJwFg5gAMWhuMKUWEU5eXuTr_6eG=tGwiGsMTw@mail.gmail.com>
 <20220418094552.128898-1-alexander.kozhevnikov@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.219.174.70]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Igor Baranov <igor.baranov@huawei.com>

When process switched to another namespace and loads a new policy, the
following problem occurs: the current open files in their
file_security_struct contain the sid's relevant to the loaded policy
in the old namespace. Under the new policy, they have completely
random (incorrect) values, and, as a rule, accessing such descriptors
leads to failure. For example, a process gets EACCES when writing to its
own stdout.

Our solution: reinitialize sid's and isid's to actual values in new policy
of all opened files, as well as of files referenced by process's VMA.

Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
Signed-off-by: Igor Baranov <igor.baranov@huawei.com>
---
 security/selinux/hooks.c     | 94 +++++++++++++++++++++++++++++++++++-
 security/selinux/selinuxfs.c |  2 +-
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b618c4e0ef36..74d32b6a4855 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -91,6 +91,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
+#include <linux/sched/mm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -4159,8 +4160,7 @@ static int selinux_file_open(struct file *file)
 	 * Task label is already saved in the file security
 	 * struct as its SID.
 	 */
-	//TODO: namespace?
-	fsec->isid = isec->sid;
+	fsec->isid = update_sid(isec);
 	fsec->pseqno = avc_policy_seqno(current_selinux_state);
 	/*
 	 * Since the inode label or policy seqno may have changed
@@ -7659,6 +7659,8 @@ static void delayed_superblock_init(struct super_block *sb, void *unused)
 	selinux_set_mnt_opts(sb, NULL, 0, NULL);
 }
 
+static void migrate_files(void);
+
 void selinux_complete_init(void)
 {
 	pr_debug("SELinux:  Completing initialization.\n");
@@ -7666,6 +7668,9 @@ void selinux_complete_init(void)
 	/* Set up any superblocks initialized prior to the policy load. */
 	pr_debug("SELinux:  Setting up existing superblocks.\n");
 	iterate_supers(delayed_superblock_init, NULL);
+
+	if (current_selinux_state->id != 0)
+		migrate_files();
 }
 
 /* SELinux requires early initialization in order to label
@@ -7816,3 +7821,88 @@ int selinux_disable(struct selinux_state *state)
 	return 0;
 }
 #endif
+
+
+/* TODO: check&return errors? */
+static void migrate_fds(void)
+{
+	unsigned int fd;
+	struct files_struct *files = current->files;
+	u32 tsid = current_sid();
+
+	rcu_read_lock();
+	for (fd = 0; fd < files_fdtable(files)->max_fds; fd++) {
+		struct inode *inode;
+		struct file_security_struct *fsec;
+		struct file *file = fcheck_files(files, fd);
+
+		if (!file)
+			continue;
+
+		fsec = selinux_file(file);
+
+		fsec->sid = fsec->fown_sid = tsid;
+		inode = file_inode(file);
+		if (inode) {
+			get_file(file);
+			rcu_read_unlock();
+			fsec->isid = update_sid(inode_security(inode));
+			rcu_read_lock();
+			fput(file);
+		}
+	}
+	rcu_read_unlock();
+}
+
+static int migrate_vmas(void)
+{
+	int ret;
+	struct mempolicy *task_mempolicy;
+	struct vm_area_struct *vma;
+	u32 tsid = current_sid();
+	struct mm_struct *mm =  mm_access(current, PTRACE_MODE_READ | PTRACE_MODE_FSCREDS);
+
+	if (IS_ERR_OR_NULL(mm))
+		return PTR_ERR(mm);
+
+	ret = mmap_read_lock_killable(mm);
+	if (ret)
+		goto out_put_mm;
+
+	task_mempolicy = get_task_policy(current);
+	mpol_get(task_mempolicy);
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		struct file *file = vma->vm_file;
+		struct file_security_struct *fsec;
+		struct inode *inode;
+
+		if (!file)
+			continue;
+
+		fsec = selinux_file(file);
+
+		inode = file_inode(file);
+		if (inode)
+			fsec->isid = update_sid(inode_security(inode));
+
+		fsec->sid = fsec->fown_sid = tsid;
+	}
+
+	mpol_put(task_mempolicy);
+	mmap_read_unlock(mm);
+
+out_put_mm:
+	mmput(mm);
+
+	return ret;
+}
+
+/* TODO return error? */
+void migrate_files(void)
+{
+	migrate_fds();
+
+/* TODO: return error */
+	migrate_vmas();
+}
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 2da27f2fc2e3..18c5383b87a9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2306,7 +2306,7 @@ static int selinuxfs_compare(struct super_block *sb, struct fs_context *fc)
 {
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 
-	return (current_selinux_state == fsi->state);
+	return (current_selinux_state->id == fsi->state->id);
 }
 
 static int sel_get_tree(struct fs_context *fc)
-- 
2.34.1

