Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69844C32754
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A1D2229C
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Rj8iypLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfHGTot (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:49 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:43108
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389129AbfHGTot (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207087; bh=nWg5OWOPFP5DTrhd97JKuZRRWercR0paJ3XGRCrjLs4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Rj8iypLZ4H3KxYhI5Y/cRo53cFHGfAXVuNL+ur0DOm+wYPMOg602jWn5iugW5miGzTtIcpPrtDZQ2O5WKa0xEBJh+nrJArP0C4kMckpc84TFZbNnhK7Hr4A0jftnqM+RXvR60pAqzU2gl5iJn7iWjJN5KrgdROHooPfZ6eyde6h8rvxVRUoKBZKDN8p345kn+9+rt0dhpt3BIUd6+v1xl9yDS9xg03rYPvnncT86bwbt7jeXXtrkaj2MWs249vKiPGAlOZ8I9VFTQiTvWEbPWg205aX+sJAkcAywadZMLQTWYSJMkzf+6EAo6/M1wswo8CRMSbeYy5gQpzdo1Qv93Q==
X-YMail-OSG: EK2JiHYVM1nwOHFMOqPlAdWBY011lNN8s0SDQiSRqhGnXG8GvXLCq3erJB6IXcf
 C8yHzcXtot2eXggrPIxd28IZ3ZM0shHQ8_8fMX1IA4VY9txFK_lAA8WMEFjfcP4ZeLODBNPEFVSr
 6NBYjXjJ79Mnbr4vtCpj_aZf57h9J0hphWpTid.yU43EOja_hg0RaQvr1Dg2fpqSlptkLElsZyKe
 a2s5dFBj0e5LOWzm4H_Lcbk7vf6EmCwe4gaLOg4M9xIO_.eOM8hq8xdDbyjJfmWz0N0QY3724v3R
 9WR0DGRJPsF0EpClOYm4bgmL5Sj.z0.KnmsKPWBeu2h5iyKGpiDmYWf_nkJU9qwNuWxlwCDEHOu8
 wEA_RH32pC5T4tQdiD0SDrUYfsQegl54GW624mWKRdFudEKQrPWepncWnQnx5qEjyh3pJArKe36Q
 2XsLOSecbD3dnctZJ8XevM29z0kqsVIBkCzZagG.QOloYempLWJ3O8LemIu3Qq9yZ4QIgmaRYFEv
 geavgop7VTvdc.jsMiZzNY5aWjm2.eNMepm37_vecTcN5BQXJt4TnmuZbMEv9Meh.aUfoRxig3rd
 HQJrtaIi7bibjc2Zv6Ky6aBBkEEnz5eXp.N2QrDi4Ccil6UUtvnEqIjtyCuyOlIBr2Y0qIxrwxdf
 E27mowWx6T1XECbZdR0O64G5oDgoJ88sHh8XgrMamML.9Wm6okROoSIujuDglo6SHscFgtmr5Nto
 0o0Zq5OmaV85yEYnrcknxU2JvTV.nEsK7XdpUbDguaOABK_vVnYO35skM9qFC.303R4FWNq09C_2
 .ohaU3OES1rujpSp89JUBJnyE1.L2cTH2Z1Yk2kktIH0829lHh4MG3bedJIOPqKC4j.bevmuglzK
 B.Bkmew0kYvzy3QkvdtRmTrdx3FOjOh2qFzUIf5USl7QdYF6fuELTtShfoiFhMNjJFYHawwwAYR1
 S.Oz20t4AAlnO0H1YxW5vxyXfa_bVzwkKgE2eTpHEu0wCrRVsadjQFqVKVR6fFLKvppbJnU.Ow_X
 5_6lMnTV7h1dl7vFFteILcBDYTMoqxDQ4nzNl_YDYk8QQKoXytI9sVacCBLg.O7a4RRcds3OaKaU
 YiN.X5d2RAOZDmCb46wJ9niF5YylKM_mfoa2aPFz43Jac2XBtc3cpHSqNGqEUEmnly.52LA56.5t
 06aWYzyIU13m_HE.09KYr0FjEEakXJqiYJKuDrdGoH0LTFYinQQTVfyPKe27LJTc4.atZapzd8je
 Hyv9.k675Uu4CO19OabiUnVl36zksiiYPexTK8PjnV4X57_3Wxe_iOjU6aFunsc_TNCJdOLs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:47 +0000
Received: by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8b8b8a62e307b49b2157970e55311396;
          Wed, 07 Aug 2019 19:44:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 15/28] LSM: Specify which LSM to display
Date:   Wed,  7 Aug 2019 12:43:57 -0700
Message-Id: <20190807194410.9762-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new entry "display" in /proc/.../attr for controlling
which LSM security information is displayed for a process.
The name of an active LSM that supplies hooks for human readable
data may be written to "display" to set the value. This requires
CAP_MAC_ADMIN privilege. The name of the LSM currently in use can
be read from "display". At this point there can only be one LSM
capable of display active. A helper function lsm_task_display()
is provided to get the display slot for a task_struct.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c            |   1 +
 include/linux/lsm_hooks.h |  15 ++++
 security/security.c       | 139 +++++++++++++++++++++++++++++++++-----
 3 files changed, 138 insertions(+), 17 deletions(-)

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
index 8927508b2142..cbc1c54d86c1 100644
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
 
@@ -1563,14 +1585,26 @@ int security_file_open(struct file *file)
 
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
@@ -1967,10 +2001,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
@@ -1980,10 +2033,48 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
+		if (!capable(CAP_MAC_ADMIN))
+			return -EPERM;
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
@@ -2003,15 +2094,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2021,16 +2112,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2038,7 +2128,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
 
@@ -2163,8 +2261,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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

