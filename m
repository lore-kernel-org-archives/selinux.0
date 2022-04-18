Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E8C43219
	for <selinux@archiver.kernel.org>; Mon, 18 Apr 2022 09:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiDRJtP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiDRJtM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Apr 2022 05:49:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0737165B2;
        Mon, 18 Apr 2022 02:46:29 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KhhrT44HPzfYy4;
        Mon, 18 Apr 2022 17:45:45 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:28 +0800
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:26 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <alexander.kozhevnikov@huawei.com>, <artem.kuzin@huawei.com>,
        <hw.likun@huawei.com>, <igor.baranov@huawei.com>,
        <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <yusongping@huawei.com>, <anton.sirazetdinov@huawei.com>
Subject: [RFC PATCH 6/7] SELINUXNS: Fixing superblock security structure memory leakage
Date:   Mon, 18 Apr 2022 17:45:51 +0800
Message-ID: <20220418094552.128898-7-alexander.kozhevnikov@huawei.com>
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

List of sbsec per state added.
All sbsec attached to state are cleared at namespace creator process exit.

Sbsec state is also replaced with namespace id. Original code provided by Igor Baranov
with refactoring to ajust current changes in sbsec handling.

Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
Signed-off-by: Igor Baranov <igor.baranov@huawei.com>
---
 security/selinux/hooks.c            | 76 ++++++++++++++++++++++-------
 security/selinux/include/objsec.h   |  7 ++-
 security/selinux/include/security.h |  2 +
 security/selinux/selinuxfs.c        |  3 ++
 4 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 74d32b6a4855..e17175ff707d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -104,6 +104,9 @@
 #include "audit.h"
 #include "avc_ss.h"
 
+/* SUPERBLOCK STATE LOCK */
+static spinlock_t sb_state_lock;
+
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
@@ -2755,11 +2758,21 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 
 /* superblock security operations */
 
+static void sbsec_counting_init(struct list_head *sb_count_head)
+{
+	//* INIT Superblocks counting list
+	INIT_LIST_HEAD(sb_count_head);
+}
+
+static void sbsec_counting_add(struct superblock_security_struct *sbsec, struct selinux_state *state)
+{
+	list_add(&sbsec->sbsec_count, &state->sb_count_head);
+}
+
 static void sbsec_head_init(struct super_block *sb,
 			    struct superblock_security_head *sbsech)
 {
 	INIT_LIST_HEAD(&sbsech->head);
-	spin_lock_init(&sbsech->lock);
 	sbsech->xattr_handler = NULL;
 	sbsech->old_s_xattr = NULL;
 }
@@ -2779,7 +2792,7 @@ sbsec_alloc(struct superblock_security_head *sbsech)
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
-	sbsec->state = get_selinux_state(current_selinux_state);
+	sbsec->namespace_id = current_selinux_state->id;
 
 	return sbsec;
 }
@@ -2787,18 +2800,18 @@ sbsec_alloc(struct superblock_security_head *sbsech)
 struct superblock_security_struct *
 find_sbsec(struct superblock_security_head *sbsech)
 {
-	struct superblock_security_struct *cur, *new;
+	struct superblock_security_struct *cur, *new, *tmp;
 
 	cur = container_of(sbsech->head.next, struct superblock_security_struct, sbsec_list);
-	if (cur->state == current_selinux_state)
+	if (cur->namespace_id == current_selinux_state->id)
 		return cur;
 
-	spin_lock(&sbsech->lock);
-	list_for_each_entry(cur, &sbsech->head, sbsec_list) {
-		if (cur->state == current_selinux_state)
+	spin_lock(&sb_state_lock);
+	list_for_each_entry_safe(cur, tmp, &sbsech->head, sbsec_list) {
+		if (cur->namespace_id == current_selinux_state->id)
 			goto unlock;
 	}
-	spin_unlock(&sbsech->lock);
+	spin_unlock(&sb_state_lock);
 
 	new = sbsec_alloc(sbsech);
 	if (!new) {
@@ -2806,15 +2819,22 @@ find_sbsec(struct superblock_security_head *sbsech)
 		goto out;
 	}
 
-	spin_lock(&sbsech->lock);
-	list_for_each_entry(cur, &sbsech->head, sbsec_list) {
-		if (cur->state == current_selinux_state)
-			goto unlock;
+	spin_lock(&sb_state_lock);
+	list_for_each_entry_safe(cur, tmp,  &sbsech->head, sbsec_list) {
+		if (cur->namespace_id == current_selinux_state->id)
+			goto free_unlock;
 	}
 	list_add(&new->sbsec_list, &sbsech->head);
+	sbsec_counting_add(new, current_selinux_state);
 	cur = new;
+	goto unlock;
+
+free_unlock:
+	spin_unlock(&sb_state_lock);
+	kfree(new);
+	return cur;
 unlock:
-	spin_unlock(&sbsech->lock);
+	spin_unlock(&sb_state_lock);
 out:
 	return cur;
 }
@@ -2828,9 +2848,10 @@ static int selinux_sb_alloc_security(struct super_block *sb)
 	sbsec = sbsec_alloc(sbsech);
 	if (!sbsec)
 		return -ENOMEM;
-	spin_lock(&sbsech->lock);
+	spin_lock(&sb_state_lock);
 	list_add(&sbsec->sbsec_list, &sbsech->head);
-	spin_unlock(&sbsech->lock);
+	sbsec_counting_add(sbsec, current_selinux_state);
+	spin_unlock(&sb_state_lock);
 	return 0;
 }
 
@@ -2840,7 +2861,7 @@ static void selinux_sb_free_security(struct super_block *sb)
 	struct superblock_security_head *sbsech = selinux_head_of_superblock(sb);
 
 	list_for_each_entry_safe(entry, tmp, &sbsech->head, sbsec_list) {
-		put_selinux_state(entry->state);
+		list_del(&entry->sbsec_count); // Remove sbsec from list of sb-s for this namespace
 		kfree(entry);
 	}
 	if (sbsech->old_s_xattr) {
@@ -2851,6 +2872,16 @@ static void selinux_sb_free_security(struct super_block *sb)
 	}
 }
 
+static void selinux_state_sb_free_list(struct selinux_state *state)
+{
+	struct superblock_security_struct *cur, *tmp;
+
+	list_for_each_entry_safe(cur, tmp, &state->sb_count_head, sbsec_count) {
+		list_del(&cur->sbsec_list);
+		kfree(cur);
+	};
+}
+
 static inline int opt_len(const char *s)
 {
 	bool open_quote = false;
@@ -4191,6 +4222,12 @@ static void selinux_cred_free(struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 
+	if (tsec->state->owner_cred == cred) {
+		/* Free all sb security for this state here - do only once */
+		selinux_state_sb_free_list(tsec->state);
+		tsec->state->owner_cred = NULL;
+	};
+
 	put_selinux_state(tsec->state);
 	if (tsec->parent_cred)
 		put_cred(tsec->parent_cred);
@@ -7573,7 +7610,7 @@ int selinux_state_create(struct selinux_state *parent, struct selinux_state **st
 
 	mutex_init(&newstate->status_lock);
 	mutex_init(&newstate->policy_mutex);
-
+	sbsec_counting_init(&newstate->sb_count_head);
 	rc = selinux_avc_create(&newstate->avc);
 	if (rc)
 		goto err;
@@ -7587,6 +7624,7 @@ int selinux_state_create(struct selinux_state *parent, struct selinux_state **st
 		strncat(newstate->xattr_name, suffix, rc);
 	}
 	*state = newstate;
+	pr_info("SELinux: State create.\n");
 	return 0;
 err:
 	kfree(newstate);
@@ -7598,6 +7636,8 @@ static void selinux_state_free(struct work_struct *work)
 	struct selinux_state *parent, *state =
 		container_of(work, struct selinux_state, work);
 
+	pr_info("SELinux: State free.\n");
+
 	do {
 		parent = state->parent;
 		if (state->status_page)
@@ -7623,6 +7663,8 @@ static __init int selinux_init(void)
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 	init_selinux_state->checkreqprot = selinux_checkreqprot_boot;
 
+	spin_lock_init(&sb_state_lock);
+
 	/* Set the security state for the initial task. */
 	cred_init_security();
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 21566a1541f4..6d9c63c57620 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -55,8 +55,6 @@ struct file_security_struct {
 
 struct superblock_security_head {
 	struct list_head head;		/* list head of superblock_security_struct */
-	spinlock_t lock;
-
 	const struct xattr_handler **old_s_xattr;
 	const struct xattr_handler *xattr_handler;
 };
@@ -69,10 +67,11 @@ struct superblock_security_struct {
 	unsigned short behavior;	/* labeling behavior */
 	unsigned short flags;		/* which mount options were specified */
 	struct mutex lock;
-	struct list_head isec_head;
 	spinlock_t isec_lock;
-	struct selinux_state *state;	/* pointer to selinux_state */
+	struct list_head isec_head;
+	u64 namespace_id;           /* id of selinux_state */
 	struct list_head sbsec_list;
+	struct list_head sbsec_count;
 };
 
 struct msg_security_struct {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 0ab6b433dc9c..48021a7fb92f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,6 +111,8 @@ struct selinux_state {
 	struct selinux_policy __rcu *policy;
 	struct mutex policy_mutex;
 	struct selinux_state *parent;
+	const struct cred *owner_cred;  /* cred of process created this state */
+	struct list_head sb_count_head;
 	u64 id;
 	char xattr_name[XATTR_NAME_MAX];
 } __randomize_layout;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 18c5383b87a9..5a29516d81a8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -410,6 +410,9 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 		tsec->sockcreate_sid = SECSID_NULL;
 	tsec->parent_cred = get_current_cred();
 	commit_creds(cred);
+	tsec->state->owner_cred = current_cred();
+	pr_debug("SELINUXNS: State init finished owner cred pntr = %p - %p\n",
+			 &tsec->state, tsec->state->owner_cred);
 
 out:
 	kfree(suffix);
-- 
2.34.1

