Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1CEC433F5
	for <selinux@archiver.kernel.org>; Wed, 16 Feb 2022 12:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiBPMxg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:53:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiBPMx2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Feb 2022 07:53:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4282D222DD6;
        Wed, 16 Feb 2022 04:52:31 -0800 (PST)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzHmx5zjPz6GCv6;
        Wed, 16 Feb 2022 20:48:01 +0800 (CST)
Received: from lhreml725-chm.china.huawei.com (10.201.108.76) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 13:52:29 +0100
Received: from centos7.huawei.com (10.122.133.3) by
 lhreml725-chm.china.huawei.com (10.201.108.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 12:52:28 +0000
From:   Igor Baranov <igor.baranov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <hw.likun@huawei.com>, <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <alexander.kozhevnikov@huawei.com>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>, Igor Baranov <igor.baranov@huawei.com>
Subject: [RFC PATCH 1/1] selinuxns: Replace state pointer with namespace id
Date:   Wed, 16 Feb 2022 15:52:06 +0300
Message-ID: <20220216125206.20975-2-igor.baranov@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216125206.20975-1-igor.baranov@huawei.com>
References: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
 <20220216125206.20975-1-igor.baranov@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.133.3]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhreml725-chm.china.huawei.com (10.201.108.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All the objects which in the original patchset kept a pointer to their
namespace now store its identifier. It's needed only to determine whether
an object belongs to our (in the current context) namespace or not.
The aim of this change is to reduce the height of the Babel tower of pointers.

Signed-off-by: Igor Baranov <igor.baranov@huawei.com>
---
 security/selinux/hooks.c            | 29 ++++++++++++++++++++++++-----
 security/selinux/include/objsec.h   |  4 +++-
 security/selinux/include/security.h |  2 ++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a1716ce534dd..69bc8a5fc5b4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -106,6 +106,9 @@
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
+/* Sequential namespace id */
+static atomic64_t selinux_namespace_id = ATOMIC_INIT(0);
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 static int selinux_enforcing_boot __initdata;
 
@@ -812,6 +815,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			goto out;
 
 		root_isec->sid = rootcontext_sid;
+		root_isec->namespace_id = current_selinux_state->id;
 		root_isec->initialized = LABEL_INITIALIZED;
 	}
 
@@ -1556,6 +1560,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		isec->initialized = LABEL_INITIALIZED;
 		isec->sid = sid;
+		isec->namespace_id = current_selinux_state->id;
 	}
 
 out_unlock:
@@ -2588,7 +2593,7 @@ sbsec_alloc(struct superblock_security_head *sbsech)
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
-	sbsec->state = get_selinux_state(current_selinux_state);
+	sbsec->namespace_id = current_selinux_state->id;
 
 	return sbsec;
 }
@@ -2599,12 +2604,12 @@ find_sbsec(struct superblock_security_head *sbsech)
 	struct superblock_security_struct *cur, *new;
 
 	cur = container_of(sbsech->head.next, struct superblock_security_struct, sbsec_list);
-	if (cur->state == current_selinux_state)
+	if (cur->namespace_id == current_selinux_state->id)
 		return cur;
 
 	spin_lock(&sbsech->lock);
 	list_for_each_entry(cur, &sbsech->head, sbsec_list) {
-		if (cur->state == current_selinux_state)
+		if (cur->namespace_id == current_selinux_state->id)
 			goto unlock;
 	}
 	spin_unlock(&sbsech->lock);
@@ -2617,7 +2622,7 @@ find_sbsec(struct superblock_security_head *sbsech)
 
 	spin_lock(&sbsech->lock);
 	list_for_each_entry(cur, &sbsech->head, sbsec_list) {
-		if (cur->state == current_selinux_state)
+		if (cur->namespace_id == current_selinux_state->id)
 			goto unlock;
 	}
 	list_add(&new->sbsec_list, &sbsech->head);
@@ -2649,7 +2654,6 @@ static void selinux_sb_free_security(struct super_block *sb)
 	struct superblock_security_head *sbsech = selinux_head_of_superblock(sb);
 
 	list_for_each_entry_safe(entry, tmp, &sbsech->head, sbsec_list) {
-		put_selinux_state(entry->state);
 		kfree(entry);
 	}
 }
@@ -2911,6 +2915,7 @@ static int selinux_inode_alloc_security(struct inode *inode)
 	isec->sclass = SECCLASS_FILE;
 	isec->task_sid = sid;
 	isec->initialized = LABEL_INVALID;
+	isec->namespace_id = current_selinux_state->id;
 
 	return 0;
 }
@@ -2985,6 +2990,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
+		isec->namespace_id = current_selinux_state->id;
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
@@ -3320,6 +3326,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 
@@ -3479,6 +3486,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 	return 0;
@@ -3636,6 +3644,7 @@ static int selinux_file_alloc_security(struct file *file)
 
 	fsec->sid = sid;
 	fsec->fown_sid = sid;
+	fsec->namespace_id = current_selinux_state->id;
 
 	return 0;
 }
@@ -3950,6 +3959,7 @@ static int selinux_file_open(struct file *file)
 	 */
 	fsec->isid = isec->sid;
 	fsec->pseqno = avc_policy_seqno(current_selinux_state);
+	fsec->namespace_id = current_selinux_state->id;
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
@@ -4268,6 +4278,7 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = sid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 }
@@ -4634,6 +4645,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 
 	isec->sclass = sclass;
 	isec->sid = sid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
@@ -4930,6 +4942,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	newisec = inode_security_novalidate(SOCK_INODE(newsock));
 	newisec->sclass = sclass;
 	newisec->sid = sid;
+	newisec->namespace_id = current_selinux_state->id;
 	newisec->initialized = LABEL_INITIALIZED;
 
 	return 0;
@@ -7332,6 +7345,11 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+u64 selinux_new_state_id(void)
+{
+	return atomic64_fetch_add(1, &selinux_namespace_id);
+}
+
 int selinux_state_create(struct selinux_state *parent, struct selinux_state **state)
 {
 	struct selinux_state *newstate;
@@ -7341,6 +7359,7 @@ int selinux_state_create(struct selinux_state *parent, struct selinux_state **st
 	if (!newstate)
 		return -ENOMEM;
 
+	newstate->id = selinux_new_state_id();
 	refcount_set(&newstate->count, 1);
 	INIT_WORK(&newstate->work, selinux_state_free);
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ad1db45b0d9..24ef0bc68eda 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -42,6 +42,7 @@ struct inode_security_struct {
 	u16 sclass;		/* security class of this object */
 	unsigned char initialized;	/* initialization flag */
 	spinlock_t lock;
+	u64 namespace_id;	/* pointer to selinux_state */
 };
 
 struct file_security_struct {
@@ -49,6 +50,7 @@ struct file_security_struct {
 	u32 fown_sid;		/* SID of file owner (for SIGIO) */
 	u32 isid;		/* SID of inode at the time of file open */
 	u32 pseqno;		/* Policy seqno at the time of file open */
+	u64 namespace_id;
 };
 
 struct superblock_security_head {
@@ -66,7 +68,7 @@ struct superblock_security_struct {
 	struct mutex lock;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
-	struct selinux_state *state;	/* pointer to selinux_state */
+	u64 namespace_id;           /* id of selinux_state */
 	struct list_head sbsec_list;
 };
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a5b698aae38c..b80622770543 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,8 +111,10 @@ struct selinux_state {
 	struct selinux_policy __rcu *policy;
 	struct mutex policy_mutex;
 	struct selinux_state *parent;
+	u64 id;
 } __randomize_layout;
 
+u64 selinux_new_state_id(void);
 int selinux_state_create(struct selinux_state *parent, struct selinux_state **state);
 void __put_selinux_state(struct selinux_state *state);
 
-- 
2.34.1

