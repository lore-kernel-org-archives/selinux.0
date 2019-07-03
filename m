Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B7C5B578
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B366121882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XQJRKQmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGCV0X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:23 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:42682
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbfGCV0X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189180; bh=IXznDagb9ise0YzzVU/+hY+rEkC5KLJxETCf2rm6hHQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XQJRKQmHIdoB6s2CEDueVjgmr9LPBHNToSIL9C37YDlkkGKuDPujdfueskVWEhK/MUNY8QqOdEsprvBt8YqZWaVqn/VKWjjM5qxhuZfrU7UGKGgHyE6DOlMfnWjd7/YKJEvRFOa22Ig8sWvNAGUHhBSO3+m7gDg5wV+6eRU5Auf9UeJt9/h5DuS9M12ey3JCS5mv7SRPfEZRR+poYfMzW2W+0Z8QSalWTbt2THH7mqPgu6ts90I/tJeKnNG0iCj1W1ju4gfVMfe0ZeNAoC06T5v+v8jASgnZOMhjIGoWQ798k0G/uQh5D1PTqAhF1Ukg0UD3kmOUz+7Y47XgML1A3A==
X-YMail-OSG: 0NJvbzMVM1mdXdl70f19mT2EER8h5KoldJYV2VOysM9mCMM_SSjx6lr0ugqrzwk
 bvHOBVWxoXtIEh5MuiHe6hJmfQuwOF2J7iM3zBbEOj8U8_jg7VtWtdqtqRJ7mBBkpBXCI7pR4h0f
 JYLM0A4FM_BXfy0c84Xx9o9v2MvrNGK.w9gRV_17hEpqMH2M9VDxmIH1JeAuX1kOkn1N3gkRkZUv
 FYWvyglmevYKX2MUfu51bhqX1TIN6AoOfeZhEI8AN7Ureoa4JCwPB4VoWNEhPZ5y8fAieQNQcREf
 33aRalecBZ.93LQhdF3wAGhhMvhY809G1bFy6D_NIZxsvj8ihI8kw331XhCjd2YG7JOHFYC2GSoU
 s6BdosItKWsCS5Rd2PS6FSN.JCgAWCg9TcQrqRupK0CAUzkW96qge3nlFmUid0YKj1tJYw_4PwKM
 JJ3M_hVsfFO38PMia7egUtoZrPezqV6dvanf7DeCCoKl_jmAatv46DYDCd.W.sLmgIQ7zt3OrIV4
 Xs1eqgiCtHhI15Ae2txonRjIZ.2hzw9BP9wGEXlnQy_xzjQ43_MHdXjVbnTLevzlBDozM0ArETD4
 _m2yoXpN8HJ_s8rUpE9WI696.mwDhLNn2InbbyhPjvEEUZSbz.gY1gMRxyYW.X1tEC_jWnwHDHv8
 0e8ngvGZk5PUHjeQFtjCdrR6QAVPHrTcKHckLzUpjeDKfFTbHHi27S.bjad7HxZ7GI7rmR0gHCzV
 oLSPTfpxDtuUzwZEh24hTqhQfO9JzRapmnifzuYls_mNY0Jiuihhvz23A5x0PANRx0Lzvw.aVvPl
 B_Jqgs_UtihKu.4b77GjkmGMSFuEHHxbdi8FEHZrqYoOLj3XWSEJb0_BD2i9.ZB2.Z7Gw9gkMHqE
 pFP7g3_PUCAYd106FlHtT4tL41obIBNhWKXkNK7tCFuTnOqqOq5RU0OTlugZZZJ62rxA4RJgjhtc
 ettV97QPuSU9maNsdPzulqPRJwajaCSBtK3abvy8SuCz1Dqz.Td1oTNREo0tqXtmTMeh34hE.Ctq
 IJaTLZWTCOx2YewDCjtoNS4GlwbI69BWm2wCx7KG7XLkA1uuMAHTjkKjQF3QdA_sO2grdcMvVc4W
 eZ2TUS3fxcmqNdLpZ.QwsPLaX1rhQQ0PugFERSxztgY9WYbaj1vPiiJzjNhQIgqqycbJg2W5o.nH
 8wU6Y645wDL7N5o1fb6Us4G0zT2s1NoA1h1MelEZ_AABm8Y2nB.ggjGhm7OSRexC_oEbLwRfb4zX
 uK5JcJAXuyp1v4IuZo2VTgwrXDQLu0XTgX1zh25yNoqKNkBkNbgWivVE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:20 +0000
Received: by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2c078f1d0732da9907514b19d300052b;
          Wed, 03 Jul 2019 21:26:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 15/23] LSM: Specify which LSM to display
Date:   Wed,  3 Jul 2019 14:25:30 -0700
Message-Id: <20190703212538.7383-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new entry "display" in /proc/.../attr for controlling
which LSM security information is displayed for a process.
The name of an active LSM that supplies hooks for human readable
data may be written to "display" to set the value. The name of
the LSM currently in use can be read from "display".
At this point there can only be one LSM capable of display
active. A helper function lsm_task_display() to get the display
slot for a task_struct.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c            |   1 +
 include/linux/lsm_hooks.h |  13 ++++
 security/security.c       | 129 +++++++++++++++++++++++++++++++++-----
 3 files changed, 126 insertions(+), 17 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..7bf70e041315 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "display",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fe1fb7a69ee5..88ec3f3487ae 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2134,4 +2134,17 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+/**
+ * lsm_task_display - the "display LSM for this task
+ * @task: The task to report on
+ *
+ * Returns the task's display LSM slot.
+ */
+static inline int lsm_task_display(struct task_struct *task)
+{
+	int *display = task->security;
+
+	return *display;
+}
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 8927508b2142..f3a293e6ef5a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(int),	/* slot number for the "display" LSM */
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -423,8 +425,10 @@ static int lsm_append(const char *new, char **result)
 
 /*
  * Current index to use while initializing the lsmblob secid list.
+ * Pointers to the LSM id structures for local use.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -444,6 +448,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
@@ -564,6 +569,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *display;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -572,6 +579,15 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	/*
+	 * The start of the task blob contains the "display" LSM slot number.
+	 * Start with it set to the invalid slot number, indicating that the
+	 * default first registered LSM be displayed.
+	 */
+	display = task->security;
+	*display = LSMBLOB_INVALID;
+
 	return 0;
 }
 
@@ -1563,14 +1579,24 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int *odisplay = current->security;
+	int *ndisplay;
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
+
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
 		security_task_free(task);
-	return rc;
+		return rc;
+	}
+
+	ndisplay = task->security;
+	if (ndisplay && odisplay)
+		*ndisplay = *odisplay;
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -1967,10 +1993,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int display = lsm_task_display(current);
+	int slot = 0;
+
+	if (!strcmp(name, "display")) {
+		/*
+		 * lsm_slot will be 0 if there are no displaying modules.
+		 */
+		if (lsm_slot == 0)
+			return -EINVAL;
+		if (display != LSMBLOB_INVALID)
+			slot = display;
+		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
+		if (*value)
+			return strlen(*value);
+		return -ENOMEM;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && display != LSMBLOB_INVALID &&
+		    display != hp->lsmid->slot)
+			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return -EINVAL;
@@ -1980,10 +2025,46 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	char *term;
+	char *cp;
+	int *display = current->security;
+	int rc = -EINVAL;
+	int slot = 0;
+
+	if (!strcmp(name, "display")) {
+		/*
+		 * lsm_slot will be 0 if there are no displaying modules.
+		 */
+		if (lsm_slot == 0 || size == 0)
+			return -EINVAL;
+		cp = kzalloc(size + 1, GFP_KERNEL);
+		if (cp == NULL)
+			return -ENOMEM;
+		memcpy(cp, value, size);
+
+		term = strchr(cp, ' ');
+		if (term == NULL)
+			term = strchr(cp, '\n');
+		if (term != NULL)
+			*term = '\0';
+
+		for (slot = 0; slot < lsm_slot; slot++)
+			if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
+				*display = lsm_slotlist[slot]->slot;
+				rc = size;
+				break;
+			}
+
+		kfree(cp);
+		return rc;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && *display != LSMBLOB_INVALID &&
+		    *display != hp->lsmid->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return -EINVAL;
@@ -2003,15 +2084,15 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int display = lsm_task_display(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
-					      secdata, seclen);
-		if (rc != 0)
-			return rc;
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
+			return hp->hook.secid_to_secctx(
+					blob->secid[hp->lsmid->slot],
+					secdata, seclen);
 	}
 	return 0;
 }
@@ -2021,16 +2102,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int display = lsm_task_display(current);
 
 	lsmblob_init(blob, 0);
 	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			return rc;
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+						&blob->secid[hp->lsmid->slot]);
 	}
 	return 0;
 }
@@ -2038,7 +2118,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int *display = current->security;
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (*display == LSMBLOB_INVALID ||
+		    *display == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2163,8 +2251,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	int display = lsm_task_display(current);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-- 
2.20.1

