Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7396C7618F
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A241421994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PFuTV19q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGZXjo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:44 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:41987
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbfGZXjn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184382; bh=0wsO8z454GAwyTSZuoE1n6v4nI3EoSJOJcCAKC3T7I0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PFuTV19qDlmXSOCclwQ7hBpwErLo4yEmtyQ63chGRNwZQoRL7dvi3lMT/HkUTkAq8KzxEXGVPNBd24jmv4uqDXplvxbU3rQm4odKo39PIZT464G/fQ4RFeBIHPmDcnMTljnuUAqOptAhWhYTmDIKWMlofpyWZw0KZMoLVBYbBUQxaZCfjDN0J6/H0eAURUQQ2qirTyGel9dqy+yizxKy8suz9sDT+pLv3tmRXVcZQ52TOTI0sfnWjDQnqScTWfZaD82ObrwHz/uvQazbUkbKP5bPdQuvpbe/H9GSSyYdNb7rvoPWbEbN3eTpQhBBZOZ/g+QXnH/Iau/UXxT/HjTpRQ==
X-YMail-OSG: AsPc7tkVM1ma9_kkvepefiAkv0OGxY5MVnZTq8oBskWijmqjEiss3LuL7n2RB9K
 7yUsNq8b2X2ovaUztMi_aAfUl_P4SjF.t0LwBhiQRtGgTkJvY3VZLRCuuG1v7OVhXSioBu5lOZ6W
 udXH37dSfF5k9vb4bE96bXtnfgDkNxKP_dJkK5O82BfvZF_7uBySVP9kjPwDfr1zX9ud.1XuPP0v
 ETF9ZTJftK0v.J2Heu3VVQYn8LCp_1KBOEyYucuMYAXMwwwDHRzAFKYSsKxBBgKxPzGJyshxKzRK
 kyrOthkb0fjELxYlyL89tjsF1npuKT3cVSjihtqFD91vdmp48FFl_YVlgTjuDAdUqQoJ_3lUS8N5
 niUdycbjRxhl1zgBGhCuUjzgcGZJu7Chk4UGLfGZGRtDVLTsHe2C6DX9ghGlJ6BB63uCAGFaIg6i
 3YJO6GbkJbBStiWELtKZHn7Bw8EE44o4c8U91_lZdTsx403ZcE1WEbDcuyyVHYpYz8yX13h2xct1
 IoT63ulHCr.F8Kq3.hinJMv5hU55fOhFWfMssTdA8kZSd_1kf6VRyEDvFB1ZC_DZMdt6hxMCB56Z
 L1thQfzag3Gj8BRyr1aB_.XqU9Y_motQW1Ri5ZLNy.6zccD9MiAGMNW1LnGV6Kzj_hbY4w9ADhPf
 cSl3iEo4qwRl_otvio2SHq4bTiV6c8m6ZQVdrcjnvKUkiuYRbbFDX7vV2O3kDmU2ScQX0SupDph_
 mfGEiAGF7C_60xssnpG4vzBeVKaqGjNG94lVXsOAoautqhqIU29dHo60sI91bRG8KJGJGmLzCJ2w
 AkA1Yk6jDCxVA9fe4AsTDaEBsPlHGmbUsIWFx1ybrSjlvKM5b7ndiqy_Zl9b5rzsPy15k9LSElQT
 ZG59uZK4k.bUPsMznIRsBDxeLHBmX0rz59Oy0cfQr4jVOEJRyPQ65H3tpuuegh.d1cf2q.v778DH
 UIs2DipK6p0PBBtP1AGFiayIr5lMSDa_TvDBRxtbYmXUP2lIXSZe36E.ybRtHZiUu_ql35rDIWyP
 Src2APPZxTeFtD8Cjzr.3ggpoae_WsD8WyHts2Ff4jGAhXjVl4L7WYGc2wmn5W5UPL5K_xf7YKXT
 UqwDeRC1MgIKo_9u6ZBncoH3ZuYRkTRQzB9YudL_QMB0zT1kkcfSBZiMGf4SybWr5jMcaBy8WA3z
 jvY_oDGslizhTHH3eoeIEv1BHFU0R1H8j4Z6me35a9rIkCOJoRt8RWbyLhorKnSszTbv5n3lOiBC
 GHa7V6lNEAmLlID.eN5M3UNC1aW_emZ0vRB6HzD6ge2pzuuNfq67hVg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:42 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 78a02322228761c8d5b60901ce41d5b3;
          Fri, 26 Jul 2019 23:39:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 14/27] LSM: Specify which LSM to display
Date:   Fri, 26 Jul 2019 16:39:10 -0700
Message-Id: <20190726233923.2570-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

When a program is executed in a way that changes its privilege
the display is reset to the initial state to prevent unprivileged
programs from tricking it into setting an unexpected display.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c            |   1 +
 include/linux/lsm_hooks.h |  15 ++++
 security/security.c       | 150 +++++++++++++++++++++++++++++++++-----
 3 files changed, 148 insertions(+), 18 deletions(-)

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
index fe1fb7a69ee5..33e5ab4af9f8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2134,4 +2134,19 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
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
+	if (display)
+		return *display;
+	return LSMBLOB_INVALID;
+}
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 8927508b2142..4dd4ebeda18d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -31,6 +31,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/binfmts.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
@@ -46,7 +47,14 @@ static struct kmem_cache *lsm_file_cache;
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
@@ -423,8 +431,10 @@ static int lsm_append(const char *new, char **result)
 
 /*
  * Current index to use while initializing the lsmblob secid list.
+ * Pointers to the LSM id structures for local use.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -444,6 +454,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
@@ -564,6 +575,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *display;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -572,6 +585,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
 
@@ -835,7 +857,18 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 
 int security_bprm_set_creds(struct linux_binprm *bprm)
 {
-	return call_int_hook(bprm_set_creds, 0, bprm);
+	int *disp = current->security;
+	int rc;
+
+	rc = call_int_hook(bprm_set_creds, 0, bprm);
+
+	/*
+	 * Reset the "display" LSM if privilege has been elevated.
+	 */
+	if (bprm->cap_elevated && disp)
+		*disp = LSMBLOB_INVALID;
+
+	return rc;
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
@@ -1563,14 +1596,26 @@ int security_file_open(struct file *file)
 
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
@@ -1967,10 +2012,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
@@ -1980,10 +2044,46 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
@@ -2003,15 +2103,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2021,16 +2121,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2038,7 +2137,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int *display = current->security;
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (display == NULL || *display == LSMBLOB_INVALID ||
+		    *display == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2163,8 +2270,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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

