Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29489C48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ED920663
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NcRhEjN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZTXO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:23:14 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:34958
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfFZTXO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561576993; bh=FoJ3Ge2qro/WSrpRgOIoKk0f5Qoi99x+c2fRZoTHQl0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NcRhEjN2hqSgkh2IF4+XZp8+mZF9WLszJQpPWWEJ+8hbZwhyKuMGCl5C0a6SVcE70TZb1uPQ0LFX7YaOp24MNCPSeUVS0EyIoh4PnDebRgSIT3c9Ln0sm6Uk8MmOSdbmDxQR4atK1PqaeNMeGwl9OXXvdrSU87OsgWY22aYvGo4viZPcy084mj/WJuVK2qINgaH7mMFGOCiqL1QaDhRuZvoATsIJmCYvmZ8k2u3CxE9hWW1ZjFvGK4S7XgWXQyWDlEMjPXiLWTBG1Le7jDF4iGBCxEajtwfbJaZpwH3mncteT8Tv4R/iux9O4DjRy0woSX643Xj/rEEUFzKVZ0NxBQ==
X-YMail-OSG: P3qiIHkVM1kHFk9wwSjitrZwT63W7R8tHk8EYysLSBEKOPMOugMSELRqUtDH8R.
 SW0ETg8jESY91lr82gI5VLF_NnywYau9iF2eXFTz70n5ZxsdD6FnHPTpfl5rrD3HUBQP_Hqp0IgS
 NPMVzBYCDjHkws1JyNbkPD7HZsjNcS5IUWPZUDM3MWjdvlKm24rPIrkrMvfqknhpv7co2mpIXUfV
 UipfrO6rgUAPVIvI.Wq6MGIj13PcGZHDhDAYjJCJL0vM1oW_Xze0w7DAYYtVU7PeAPkhSTAb7ow2
 BfczsxFuBV9ejOWxgjwWViuyC2r0FPQjYeYc3bXwBoGaqLQj2T5PLt9xvt8Jy1d2_ANNpO5TuyyJ
 Rx1i2EwpRF29joYun55Jddzvt.Am2LVP8jm8YO_NYIC9PZb0xOMzvlfv134_ZQhY3W5StbLfDt10
 XKommXiWUeMn.xPrBfgZtWDv8yRlzAxmjJkimj79qrp835tbPHX3JmrvjCqjQMhbBr1jo7lk3jmQ
 HztmMJA.JDWOcMhoPuyQEAPoAzxTilRq1C2QTOHJ2cbt6zsQFufumgBMoXAnfX4XvWKd8Soerjxk
 ulsXuFkt3CVLgc3Oz5hqBHq8_rZBCUfXtlrTeKR5RWPzMECqhVBcYBuJSvP1TpeoYbwfL8_jX4dx
 CONqWRPeoJsMDUUj4S.yK9O8ZTnrx8lc4OHuXAWFvk4XLY7BMjK37FDiH254T3_hpCHcKUFvfFyX
 yIllgMWtqxS2xHE6m0p6taLo1bjGMMNo3f9h9YbbJTDp_v7GRMRwS4bLxFsKbyMFDFS_RUZsVUYi
 ginb_6hEG7I94QPDU1VrrJGDdKXUzEca01sFGYQLL_1IoJ6K3GWvhq5STlb_KEAQq3ULgjrN3vys
 fbjTv2ro5jFDZiU862C5qD09f8riAL9Op9DpBX0uyllMpglVhwjSuhjXNHdPCKqx_FHznSBR8gNO
 nSL3XBDQazEORv901N_PPZ1a3ALWgY.S6oLKoUfcW0gJxk1QW_43HGKGMW2Ln_i0Yw2.7qMaO2v4
 XQ6SOtpgPO3SMdbXUjy9AAF9uSyXRZ8reck8hbEyqFlFLNWs1jI0nwvfx6XnxNeWWqugr4oYUCWq
 Pep5qRzqHzvc.AWKGkSIBKrMzJADoY8drqtSmDiHO2KaftXHbzTx6iz62HXnKirG8hKgOkU67HvF
 0G0aPet7oGfruZohPbgekkJAqlvKYU8vcljKHucCKUwePERb_3yHyFwYrgnNlwlDiFj0aktrSjv8
 pQ_YuvfBY9ev10ITpHf7DHMB6uZxDZt26MQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Jun 2019 19:23:13 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b8c135b07bec32b448265b8073874548;
          Wed, 26 Jun 2019 19:23:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 15/23] LSM: Specify which LSM to display
Date:   Wed, 26 Jun 2019 12:22:26 -0700
Message-Id: <20190626192234.11725-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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
active.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c      |   1 +
 security/security.c | 129 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 113 insertions(+), 17 deletions(-)

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
diff --git a/security/security.c b/security/security.c
index 3180a6f30625..82e29c477fa4 100644
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
 static int lsm_slot;
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
+	int *display = current->security;
+	int slot = 0;
+
+	if (!strcmp(name, "display")) {
+		/*
+		 * lsm_slot will be 0 if there are no displaying modules.
+		 */
+		if (lsm_slot == 0)
+			return -EINVAL;
+		if (*display != LSMBLOB_INVALID)
+			slot = *display;
+		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
+		if (*value)
+			return strlen(*value);
+		return -ENOMEM;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && *display != LSMBLOB_INVALID &&
+		    *display != hp->lsmid->slot)
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
+	int *display = current->security;
 
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
-					      secdata, seclen);
-		if (rc != 0)
-			return rc;
+		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
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
+	int *display = current->security;
 
 	lsmblob_init(blob, 0);
 	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			return rc;
+		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
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
+	int *display = current->security;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-- 
2.20.1

