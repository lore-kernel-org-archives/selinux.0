Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DA7C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DB020709
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hsJEjgdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgENW0M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:26:12 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:42336
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728504AbgENW0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589495168; bh=vCF+vJ3ASqjNqq166KOR7OojKfbw6jwf5nSsllazuKY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hsJEjgdCH/Ej+oFpqarN+PR2PdsSjEjDVdBERD3u1I60LydZSeqfX2WARHBj8SeBZyiJkZHEPpMWMWIAq7AVxEd9RV5+NX3CiDEU7BijuZts3eePahbYMresCr1SyPjFuEd2qk+EUAF7Y2L29dRTscARTvs63/sbipHodA689h4YixKuNZ5F7Du60Cr7VxcBGauNXX47HCI4a9WHrngbGLTAA+E2X59J0xYENgNaHEhmbRz9NEuZeyjs/RcAtU7vnEHsbP9qpqrgaVJrB4Bqq9he40QlP95IZrbgiQPtpLRG8Cz1LO7D9l45nZOYI1eujHzjrrKdIaJ7wgD4AYoO1g==
X-YMail-OSG: zSzEuKkVM1ntYL9E98ZijEUEuG3y9ad80o8xRYoQIqS9WAgw72djfzYgFnQNqTx
 rF2_W20dIqlIACubg53u3GtQDWHRPcuCAEy6uV2WqS942F9o4TewIs9b6BeUk8lJperMyhyBpBap
 Z2ddRSKP0pCKavNNP2VDK7j679QA.XacZBO.anmQIy4n7mw9XkDayOy3D5Fu4o_WYIrWufuFdQvw
 j5ixOZb5iKHVaUh_zU_o2eyGjddPo_5plWrICmvJqw9cvCs2bGrU0wS_04mMHeits.B6eF5YXyXn
 gX72z7Xou_MZZqXVUm7C5e24P7tq4OI9pTGv4fMGq8qco9VVflUdbjBW.M28foe2_0y5YPu4FQD3
 eh2Tk1UVltlVCKMrIr8QRfwOVb8i3kNthwSsaS7kaUhWwFXiA9exE0xC69SSqUdA2CP9NIVJSo3Q
 z8BMbLmYuDF_IUNzoEKeKHOWuA4p1UXJmNEeJCYpkuNWrurEtMs6AsWYlN57fY7iJkcyIv212NZs
 E29gj.MSlaAx8qbZujNItcB5LyZDLaShJJpu6pKBa.N5bLc7oz7xU5QNrMakpt6MeE4xTRba68wP
 g97hoBHnVe0v589adhV1BPvlpOdh4zrlvIV5L5ijUS5r_0WGTK2zWLNRyRwu8QC2QzGQM_frr1eT
 zURiqi3L1FXrV03jdQCrl548MtRKQDvo_ilTpg45X.lho1DlWTdrQsueG6M8OXTMI7MRqilcPhR_
 WumscPuBdfqTV2RTlVWdYHbe7dG9J4qqqgMgFLATMCBmP_2Ga9EkISEfd0qr04_pJ_N56BZdFAQr
 GVByyo1NaDzHiaiJDYzfUgsLPgcm157YS4oYdwfojec3sQCj0ghvKvvxZSAQ6UNjlZ8ZZUlFHHt8
 xtdTrUaqmGzm0HClHLjYqvwcE3kp46._dBl2H.f6AFXtxKP_trHj7htzf7C6llTJ7ep4GnzsIvfW
 ST.AUOZmLeRoVsaZzI7.RwjYex7C.IpJwd4OFWidW94Vvee4phQuMk1OYE1CMvyIqnQ15wUtWp0.
 mrOFgWo48OC2qvJIkarZ4p4c9BaE7ugjl6Y.kfJ785dUCebr8whNSX4hRmrHbib7QW09ymPWkc4F
 n_TH12yY8XUTfeRQ0E17ZFw5YPbqUHoO1wtwdmqpowuKK8bhZxodCxe2nQDn3SzXmC7ayqi2chfQ
 k2xbNfaIGul5MXPztTqBE5.O0iQbVWG7l.Zp_k.e._TjraUD2YrVQqL4fHo_9D2KBT.JaMZ3wEwV
 aNlEHXcMLhqM1Hw82dLMsdJYWaFpiCkuzP2fngmFkq_FULSSkhCFM8YlqYQegyhT7Jpi.RxWrRDX
 tzeD2rF2H58ukO.6.KFHUujhibMHMPWRPufUiAhd3odvESVvJ9Agd8rM0DD55EQataaFz4VkFvqD
 uXOOvtZ0PGdU8gkAs5dA2eAL1zv2wG2DFtlDKQ8APJ4jXkNT1f9xP5pEOrKOaXBE1TScF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:26:08 +0000
Received: by smtp416.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5cb7cfcb4823cee55264a27615f23f55;
          Thu, 14 May 2020 22:26:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v17 13/23] LSM: Specify which LSM to display
Date:   Thu, 14 May 2020 15:11:32 -0700
Message-Id: <20200514221142.11857-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new entry "display" in the procfs attr directory for
controlling which LSM security information is displayed for a
process. A process can only read or write its own display value.

The name of an active LSM that supplies hooks for
human readable data may be written to "display" to set the
value. The name of the LSM currently in use can be read from
"display". At this point there can only be one LSM capable
of display active. A helper function lsm_task_display() is
provided to get the display slot for a task_struct.

Setting the "display" requires that all security modules using
setprocattr hooks allow the action. Each security module is
responsible for defining its policy.

AppArmor hook provided by John Johansen <john.johansen@canonical.com>
SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c                       |   1 +
 include/linux/lsm_hooks.h            |  15 +++
 security/apparmor/include/apparmor.h |   3 +-
 security/apparmor/lsm.c              |  32 +++++
 security/security.c                  | 167 ++++++++++++++++++++++++---
 security/selinux/hooks.c             |  11 ++
 security/selinux/include/classmap.h  |   2 +-
 security/smack/smack_lsm.c           |   7 ++
 8 files changed, 219 insertions(+), 19 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index eb2255e95f62..8217e2642096 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2777,6 +2777,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "display",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5b9b79e07fb6..7799c6d2a63a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1616,4 +1616,19 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+/**
+ * lsm_task_display - the "display" LSM for this task
+ * @task: The task to report on
+ *
+ * Returns the task's display LSM slot.
+ */
+static inline int lsm_task_display(struct task_struct *task)
+{
+	int *display = task->security;
+
+	if (display)
+		return *display;
+	return LSMBLOB_INVALID;
+}
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
index 1fbabdb565a8..b1622fcb4394 100644
--- a/security/apparmor/include/apparmor.h
+++ b/security/apparmor/include/apparmor.h
@@ -28,8 +28,9 @@
 #define AA_CLASS_SIGNAL		10
 #define AA_CLASS_NET		14
 #define AA_CLASS_LABEL		16
+#define AA_CLASS_DISPLAY_LSM	17
 
-#define AA_CLASS_LAST		AA_CLASS_LABEL
+#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
 
 /* Control parameters settable through module/boot flags */
 extern enum audit_mode aa_g_audit;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 146d75e5e021..16b992235c11 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -612,6 +612,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	return error;
 }
 
+
+static int profile_display_lsm(struct aa_profile *profile,
+			       struct common_audit_data *sa)
+{
+	struct aa_perms perms = { };
+	unsigned int state;
+
+	state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
+	if (state) {
+		aa_compute_perms(profile->policy.dfa, state, &perms);
+		aa_apply_modes_to_perms(profile, &perms);
+		aad(sa)->label = &profile->label;
+
+		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
+	}
+
+	return 0;
+}
+
 static int apparmor_setprocattr(const char *name, void *value,
 				size_t size)
 {
@@ -623,6 +642,19 @@ static int apparmor_setprocattr(const char *name, void *value,
 	if (size == 0)
 		return -EINVAL;
 
+	/* LSM infrastructure does actual setting of display if allowed */
+	if (!strcmp(name, "display")) {
+		struct aa_profile *profile;
+		struct aa_label *label;
+
+		aad(&sa)->info = "set display lsm";
+		label = begin_current_label_crit_section();
+		error = fn_for_each_confined(label, profile,
+					     profile_display_lsm(profile, &sa));
+		end_current_label_crit_section(label);
+		return error;
+	}
+
 	/* AppArmor requires that the buffer must be null terminated atm */
 	if (args[size - 1] != '\0') {
 		/* null terminate */
diff --git a/security/security.c b/security/security.c
index ed33ee97afe4..e86c84a904d5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -75,7 +75,14 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
+/*
+ * The task blob includes the "display" slot used for
+ * chosing which module presents contexts.
+ */
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(int),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -470,8 +477,10 @@ static int lsm_append(const char *new, char **result)
 
 /*
  * Current index to use while initializing the lsmblob secid list.
+ * Pointers to the LSM id structures for local use.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -491,6 +500,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
@@ -620,6 +630,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *display;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -628,6 +640,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
 
@@ -1602,14 +1623,26 @@ int security_file_open(struct file *file)
 
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
+	if (odisplay) {
+		ndisplay = task->security;
+		if (ndisplay)
+			*ndisplay = *odisplay;
+	}
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -2006,23 +2039,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
+
+		/*
+		 * Only allow getting the current process' display.
+		 * There are too few reasons to get another process'
+		 * display and too many LSM policy issues.
+		 */
+		if (current != p)
+			return -EINVAL;
+
+		display = lsm_task_display(p);
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
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
+/**
+ * security_setprocattr - Set process attributes via /proc
+ * @lsm: name of module involved, or NULL
+ * @name: name of the attribute
+ * @value: value to set the attribute to
+ * @size: size of the value
+ *
+ * Set the process attribute for the specified security module
+ * to the specified value. Note that this can only be used to set
+ * the process attributes for the current, or "self" process.
+ * The /proc code has already done this check.
+ *
+ * Returns 0 on success, an appropriate code otherwise.
+ */
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	char *termed;
+	char *copy;
+	int *display = current->security;
+	int rc = -EINVAL;
+	int slot = 0;
+
+	if (!strcmp(name, "display")) {
+		/*
+		 * Change the "display" value only if all the security
+		 * modules that support setting a procattr allow it.
+		 * It is assumed that all such security modules will be
+		 * cooperative.
+		 */
+		if (size == 0)
+			return -EINVAL;
+
+		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
+				     list) {
+			rc = hp->hook.setprocattr(name, value, size);
+			if (rc < 0)
+				return rc;
+		}
+
+		rc = -EINVAL;
+
+		copy = kmemdup_nul(value, size, GFP_KERNEL);
+		if (copy == NULL)
+			return -ENOMEM;
+
+		termed = strsep(&copy, " \n");
+
+		for (slot = 0; slot < lsm_slot; slot++)
+			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
+				*display = lsm_slotlist[slot]->slot;
+				rc = size;
+				break;
+			}
+
+		kfree(termed);
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
 	return LSM_RET_DEFAULT(setprocattr);
@@ -2042,15 +2162,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2060,16 +2180,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2077,7 +2196,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int display = lsm_task_display(current);
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2202,8 +2328,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 44e9d0a332ba..ada6f6d65279 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6332,6 +6332,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
+
+	/*
+	 * For setting display, we only perform a permission check;
+	 * the actual update to the display value is handled by the
+	 * LSM framework.
+	 */
+	if (!strcmp(name, "display"))
+		return avc_has_perm(&selinux_state,
+				    mysid, mysid, SECCLASS_PROCESS2,
+				    PROCESS2__SETDISPLAY, NULL);
+
 	if (!strcmp(name, "exec"))
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..ba36a55b5ea4 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -52,7 +52,7 @@ struct security_class_mapping secclass_map[] = {
 	    "execmem", "execstack", "execheap", "setkeycreate",
 	    "setsockcreate", "getrlimit", NULL } },
 	{ "process2",
-	  { "nnp_transition", "nosuid_transition", NULL } },
+	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", "module_load", NULL } },
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 12e01d450dd4..00a304861657 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3510,6 +3510,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	struct smack_known_list_elem *sklep;
 	int rc;
 
+	/*
+	 * Allow the /proc/.../attr/current and SO_PEERSEC "display"
+	 * to be reset at will.
+	 */
+	if (strcmp(name, "display") == 0)
+		return 0;
+
 	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
 		return -EPERM;
 
-- 
2.24.1

