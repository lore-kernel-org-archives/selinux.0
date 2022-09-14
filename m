Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7FCECAAD3
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 18:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiINSOq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 14:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiINSOn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 14:14:43 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF159635D
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663179279; bh=c1eTmfoSkTEfrf53rZAjwtdYINeL6XzWBei0Y5dqYtU=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=eHdqQvPRwNEuH96BfU5uU9zXzHdeaBcG3E9S8evNu+lqtOrCtOzPXkrKvu2aXkv2RXWp9jOcTdb+EGM6n0S+Xq91JUWa+yrR3QlGbllXKU1qNE3zDQkmuwPmnG+MeaSTnVHVZfhc5N8k+McZJTAi9+UQZ2c/IurFigMe7Ael9WUW0bdyJoBGg1k2RbQER4nMH65buapC56TlBlfdoD7+JTI4CKVqVb6G3c0HXro0pGIT8vKpm+LuOTtzYeCDdJhrE23/rJKp4vkD4pExFOI7s7bJiTjRcuyEAC4F7FhaeLg8R0A1RfhKt1H0FtTy7+O25zcxCNSrxjJy564AyCmhOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663179279; bh=xXkq3WL4Rrwt1Dj/TUOtzm+NDz948r7SCtJzHwWeDFj=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=YqoVYGtqMwBELU32Oj/PD2EA5tis6i4BANT6wcDZEiY9dPsS1dhdlrQl5lgqp7npD/Ojd8DE79MMDbhs2sCc7x3Lu1yiSL9Vmb3zT8cEjcf9cTonIQur//C8oMiHUeH2Lo+ABQ9aQDFDJLUYYibxhqBF6TJyU4kmkbhq253/Hv/jAP6KEa2WMCMJbaM7sjlYZUiOqaXKiZk/ecsIKaj/FLTtFVIL4D7QnnE7JJhf3o+NxYvASoKKXWOenuT9wajt+r7ZfK1+UJq+dSIcfAEiGEropdbPzNokdV9mbXsYKE6hvTac9Nf7xcjv20YWQHRutJVlJ4EFb2vkfav2ajey6Q==
X-YMail-OSG: BoeBk9wVM1kwEOa9hxgFMlQlJrTlP2BphIMpzZHScgd8UYkeXwuiyA3HQon85QA
 Dbhly1EpwBgOeYg35PIBNZf.As5yVQFPu7mTf7rR.c7lsKVAxBvIC9gwfELBuEOahHyJ4K5FqYzT
 Ka8tCKYwUCbICJknANNn3LGOb6ydFJCWfHoTCmQBnQHG.f3PP6RIWrQCLr9l_ZULbyLpHnoE5Inx
 uksFkpAUV.XHM.GPTmHreXZa7UH_uscqjBeWkUntrjBmQg4Tcg13BjZDsNiaZtNBdlnVNr.zp3o1
 RvLhRO907RoLF4DyjdWwdLT8jYK4OU9CAhWbXCv2q_A7LZMbOokxs3llOWyobVDgWZClzKOcbdiJ
 JD2RIgBw0Jz.c7fjZr3iY8_A_slI9del9YFXcQ6KrE_hhftaDXQLWuOlAW.oNDsux8lquIqkIif8
 2BW5mKCkDaAnQ2AFM_XGa._mB7oxRzhcQElUt81aOS50EfOidttXmm9YgGCaRizvs10SSSgFSNbv
 ETDkynfII3fBJpKzbDyo6GdGz7fmsolltnIhJhWFGwsooHW3Ed2V.HQ4Z4or9xQXvOok2x2naKxg
 56J0QNyQSlLqAX4h681pUcjhHOhYViaNwEJGyME3JDoe8i4z.l2RLv3P_lAdk_RHn7mC5lfrg5L.
 pKflRWI1GFljwpcAIaUtoajPZF7wQPkNY1QehrM0qHPgUvfg.xz7aD9PWcvfUQ6lHWzGOiYv7fp0
 TgmxFsv9sbAWThZHDP.kVVYd5h_.dQUpWZ1sb8yD_D8YpiNiTnu1FOwq.huyuijO_qNssaC87Kw3
 Inh1BNVqy0rcQ7B8QdNgDamUTbVHpajleR3vi0GWqhZbo98olF5547HQhnBDU_0DGe_1VPMmo_Gu
 C9uXPaPBYY1_Zymr2vl38m.gz73FvpgkvGlByVsR8bRQhMOrNtKw73aAvdfmQUfqZlokgT70M_ws
 vcVWCUdLCm0LQY_7wHpU0YryRQMMEpJxnVWOE.yWWoVTcw3Le20hlHNFbSaaLGJdUYt1Z83ZBG2.
 VbUJlbhQPK8RxwBTeQ3xVsre_3WsMVjA5zJxB7HgtLBXBWBMJk.IvKQRwRM_W24w.Wr4n3ekJERc
 Tb1OZJSMlE5Wc.SZPoTv_OLR4agn3nlXvqigO1enYAdV6Li3LicUQyxxkDHgR9zSedDsOWooD0O0
 BVtGGsTG8NEzdEtaNCFmNiGDWWO1rz7qzcBk8fZFI5SZdo_OhcF_rTEnzh5wyJ.UZJa9fLU8hYmb
 yLr42VwkDsC1XRNritXLcjv9xkB9PPOV3UtQznbAYwItg..9MWJdsWcdHSlnxUetgrVjRX.hKvQP
 koGt_CX1eHOuwx4aQVKYUQYU1MIMPa5kIyTufWEunjJvQnge2p5f4nwlDlwim0t0FzN1_aiw6YM8
 8HfZRf0JPfXwWzxlWG3O4YWCj5QMixlUGqbPtoFPLWLSFl5HruHT9hjQsgojNrPy_0YgGJ3azZ12
 B1Y6IXxBW3ftADQCWZsCDo1bRuIFYtOKnMVEI9MTPho78ni4nb02GdK.o.vw6mLR29x67GT3LhBe
 5pw3J2VPbxqQKkRzVSP0kWhRf7VMvmBDIGJsUiFlsDjvj6KQ.yvTEYSBm0WG8OnJBK1O125KXYGE
 wdTJSdTf7JlefNzgVcQpqIRFIVPG7UXBhI_Q51IR05y5dg6t_KfAMOdf7SmTbaZRnv5a3XzV7lZt
 1I8byo7v0PTEo6o0eULGpSIjMFDeSutHzXJD0wbLqYAi..1WDkZE3h8rVxIjpU7YDQcSmCTcLoOR
 MPUdqNOgyLSBN40nWVwYOb4Bt6BsjjBL0wk0XrLH1kvuj9.2f1GtVJC78mllobIXHgpy_XpW9fkF
 apvxdOkI2S1iygXqoxv71W.yfN69oVeWBbsVGxyWBUHPDl9kxdL6qxiIZUDbXlItUp.QAzps3txk
 YqpXGmtwj9e._RWfDRj8w7RMKtu3q4UsB79g5LPnmQ.OukfulmVSTpXV5uYIYr9.CnfcM715V3vC
 eZBA22QRjCtCcQMx88bPvJM2pVrqMJFI3ldKh8CvyvBfFDiMI.Ck6mdU5I3_52lpah2Ep65nAI6q
 iAyVNGetxEQ8k93mt4JWzVIi71._GaJ3tTNwA2sbKMdrIDBCAaPIDdaGHI0NhC.BaHjJmbPTpjs.
 4MGASaOrUIZCTaqHlvM5wtrBya29J2OFLmSwHNan9_tkxIWK4OtDCUadGHVIxfCmKPlq98X.Nviy
 IzsJmDj1IEaY3D9zR6eNDBCYytQ4VaBhkxvZSJSnYO_U-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 Sep 2022 18:14:39 +0000
Received: by hermes--production-ne1-544744cc75-sp4gl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 928f112e3086d975dcae4ec920aef717;
          Wed, 14 Sep 2022 18:14:36 +0000 (UTC)
Message-ID: <271ef810-416f-a883-6b4a-94928c9c7ee7@schaufler-ca.com>
Date:   Wed, 14 Sep 2022 11:14:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH RFC] LSM: Specify which LSM to display
To:     Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <5a9ff61e-cfe1-7385-aa17-5b800e489a9a.ref@schaufler-ca.com>
Content-Language: en-US
In-Reply-To: <5a9ff61e-cfe1-7385-aa17-5b800e489a9a.ref@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create two new prctl() options PR_LSM_ATTR_SET and PR_LSM_ATTR_GET
which change and report the Interface LSM respectively.

The LSM ID number of an active LSM that supplies hooks for
human readable data may be passed in the arg2 value with the
PR_LSM_ATTR_SET option. The PR_LSM_ATT_GET option returns the
LSM ID currently in use. At this point there can only be one LSM
capable of display active. A helper function lsm_task_ilsm() is
provided to get the interface lsm slot for a task_struct.

Security modules that wish to restrict this action may provide
a task_prctl hook to do so. Each such security module is
responsible for defining its policy.

AppArmor hook initially provided by John Johansen
<john.johansen@canonical.com>. SELinux hook initially provided by
Stephen Smalley <stephen.smalley.work@gmail.com>

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h             |  17 ++++
 include/uapi/linux/prctl.h           |   4 +
 security/apparmor/include/apparmor.h |   3 +-
 security/apparmor/lsm.c              |  42 +++++++++
 security/security.c                  | 126 +++++++++++++++++++++++----
 security/selinux/hooks.c             |  21 +++++
 security/selinux/include/classmap.h  |   3 +-
 7 files changed, 197 insertions(+), 19 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5140dfec76d5..28f8895203be 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -240,6 +240,23 @@ static inline u32 lsmblob_first(const struct lsmblob *blob)
 #endif
 }
 
+/**
+ * lsm_task_ilsm - the "interface_lsm" for this task
+ * @task: The task to report on
+ *
+ * Returns the task's interface LSM slot.
+ */
+static inline int lsm_task_ilsm(struct task_struct *task)
+{
+#ifdef CONFIG_SECURITY
+	int *ilsm = task->security;
+
+	if (ilsm)
+		return *ilsm;
+#endif
+	return LSMBLOB_INVALID;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..531c6e8d2d18 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -281,6 +281,10 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Set/get the active security module for /proc/self/attr */
+#define PR_LSM_ATTR_SET			65	/* Set the display LSM ID */
+#define PR_LSM_ATTR_GET			66	/* Get the display LSM ID */
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
index 9c3fc36a0702..c9e08102c96f 100644
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
index eccba6667458..183004c864ac 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -15,6 +15,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/ptrace.h>
+#include <linux/prctl.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
 #include <linux/audit.h>
@@ -642,6 +643,46 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	return error;
 }
 
+
+static int profile_interface_lsm(struct aa_profile *profile,
+				 struct common_audit_data *sa)
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
+static int apparmor_task_prctl(int option, unsigned long arg2,
+			       unsigned long arg3, unsigned long arg4,
+			       unsigned long arg5)
+{
+	struct aa_profile *profile;
+	struct aa_label *label;
+	int error;
+	DEFINE_AUDIT_DATA(sa, LSM_AUDIT_DATA_NONE, OP_SETPROCATTR);
+
+	if (option != PR_LSM_ATTR_SET)
+		return 0;
+
+	/* LSM infrastructure does actual setting of interface_lsm if allowed */
+	aad(&sa)->info = "set interface lsm";
+	label = begin_current_label_crit_section();
+	error = fn_for_each_confined(label, profile,
+				profile_interface_lsm(profile, &sa));
+	end_current_label_crit_section(label);
+	return error;
+}
+
 static int apparmor_setprocattr(const char *name, void *value,
 				size_t size)
 {
@@ -1195,6 +1236,7 @@ static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
+	LSM_HOOK_INIT(task_prctl, apparmor_task_prctl),
 	LSM_HOOK_INIT(capget, apparmor_capget),
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
diff --git a/security/security.c b/security/security.c
index ca3b1216e5f6..b29145de891f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/prctl.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
@@ -80,7 +81,16 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
+/*
+ * The task blob includes the "interface_lsm" slot used for
+ * chosing which module presents contexts.
+ * Using a long to avoid potential alignment issues with
+ * module assigned task blobs.
+ */
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(long),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -673,6 +683,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *ilsm;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -681,6 +693,15 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	/*
+	 * The start of the task blob contains the "interface" LSM slot number.
+	 * Start with it set to the invalid slot number, indicating that the
+	 * default first registered LSM be displayed.
+	 */
+	ilsm = task->security;
+	*ilsm = LSMBLOB_INVALID;
+
 	return 0;
 }
 
@@ -1747,14 +1768,26 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int *oilsm = current->security;
+	int *nilsm;
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
+	if (oilsm) {
+		nilsm = task->security;
+		if (nilsm)
+			*nilsm = *oilsm;
+	}
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -2013,10 +2046,15 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
+	int *ilsm = current->security;
 	int thisrc;
+	int slot;
 	int rc = LSM_RET_DEFAULT(task_prctl);
 	struct security_hook_list *hp;
 
+	if (lsm_slot == 0)
+		return -EINVAL;
+
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
@@ -2025,6 +2063,25 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+
+	switch (option) {
+	case PR_LSM_ATTR_SET:
+		if (rc && rc != LSM_RET_DEFAULT(task_prctl))
+			return rc;
+		for (slot = 0; slot < lsm_slot; slot++)
+			if (lsm_slotlist[slot]->id == arg2) {
+				*ilsm = lsm_slotlist[slot]->slot;
+				return 0;
+			}
+		return -EINVAL;
+	case PR_LSM_ATTR_GET:
+		if (rc && rc != LSM_RET_DEFAULT(task_prctl))
+			return rc;
+		if (*ilsm != LSMBLOB_INVALID)
+			return lsm_slotlist[*ilsm]->id;
+		return lsm_slotlist[0]->id;
+	}
+
 	return rc;
 }
 
@@ -2191,23 +2248,45 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && ilsm != LSMBLOB_INVALID &&
+		    ilsm != hp->lsmid->slot)
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
+	int *ilsm = current->security;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && *ilsm != LSMBLOB_INVALID &&
+		    *ilsm != hp->lsmid->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return LSM_RET_DEFAULT(setprocattr);
@@ -2227,15 +2306,15 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
-					      secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secid_to_secctx(
+					blob->secid[hp->lsmid->slot],
+					secdata, seclen);
 	}
 
 	return LSM_RET_DEFAULT(secid_to_secctx);
@@ -2246,16 +2325,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	lsmblob_init(blob, 0);
 	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+						&blob->secid[hp->lsmid->slot]);
 	}
 	return 0;
 }
@@ -2263,7 +2341,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2404,8 +2489,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	int ilsm = lsm_task_ilsm(current);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f03b98b35ef4..56ad1fd62df7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <linux/prctl.h>
 #include <uapi/linux/lsm.h>
 
 #include "avc.h"
@@ -6373,6 +6374,24 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
+static int selinux_task_prctl(int option, unsigned long arg2,
+			      unsigned long arg3, unsigned long arg4,
+			      unsigned long arg5)
+{
+	u32 mysid = current_sid();
+
+	if (option != PR_LSM_ATTR_SET)
+		return -ENOSYS;
+
+	/*
+	 * For setting interface_lsm, we only perform a permission check;
+	 * the actual update to the interface_lsm value is handled by the
+	 * LSM framework.
+	 */
+	return avc_has_perm(&selinux_state, mysid, mysid, SECCLASS_PROCESS2,
+			    PROCESS2__SETINTERFACE_LSM, NULL);
+}
+
 static int selinux_setprocattr(const char *name, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
@@ -6384,6 +6403,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
+
 	if (!strcmp(name, "exec"))
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
@@ -7038,6 +7058,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(task_prctl, selinux_task_prctl),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 1c2f41ff4e55..6b8569347bc0 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -53,7 +53,8 @@ const struct security_class_mapping secclass_map[] = {
 	    "execmem", "execstack", "execheap", "setkeycreate",
 	    "setsockcreate", "getrlimit", NULL } },
 	{ "process2",
-	  { "nnp_transition", "nosuid_transition", NULL } },
+	  { "nnp_transition", "nosuid_transition", "setinterface_lsm",
+	    NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", "module_load", NULL } },
-- 
2.36.1


