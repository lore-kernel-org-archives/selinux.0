Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1606EC67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B205420672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i+xL2vt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B205420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeLKWp2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:28 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:35881
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbeLKWn5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568235; bh=E8dB7le//TQ04tA/XXun+XOH+E4VnMacimoj3DTyvwQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=i+xL2vt7n+0YmOnGT6rY+QhNl7b8PpmOQljArKkgYGcVx3bRZVlZvzZ8canHpBSGNK9Ud43pXRYVleCIvXMzt4axJ8LO2FzEDxjdRLmthsmpXq05QRIVxlT5C8n9nwJxyGd9NP7Z54JUzPaWVNu0KpXEA9mQ6G4EmgRoi1ClZ3HU8cQ0zSzcekINHj4zk8nbNGil1mDEuL9+kpZon9jYtpVGwC6HQlf3W8Lk2DVIQ6cyr9OXFdjnfuCntztzVDxUUUh8YWxj4IfYfVmgsYyy0SNsnZxz8zjZsv/gDrccFds7hgl7So/aT2wLCH5U/Cxp4Vsm0i0KtsQoTtQeiI+rXQ==
X-YMail-OSG: O.k4rj4VM1k.d5C.EOXuAhUu2zfs0l74Fb8D9uBXRt7WI8PrI8EgBO61RWuwRqG
 1numN3UBqljOt4jRn9xqZWt1wXvzIAts7t4LGA.FY76LrZ_C3zuxL2A7q75TP853adjnbwnpgjba
 Q8ZqnYCE7uxptZeW2_PqtAZ4RvXBvFnIc_D.z5nYtAFa7njPduF8jL4c_M81m1Vs2uYdyiL_UPpv
 MVckeziZdOwBtMD5t_KyvbFqDCk7RcaOy53CjbiKJIovg6BH8fmH74PDHkQc4GTTigqaib0ivru2
 n6zrMLaTBFeZ86mOkWu4JgU63Fdb_q20PpN.Q2xcfh9WpsxKTmvwWBDr6Oc_olf.hYVq6lSVKTVl
 o.9T2npJ_hoikNMRqMMKVRwYKuf7TyFbR23SiZtPRGRNQNrWWOMmTFR7D_clbzmCZ4sZALzr.CQU
 ZJY1mfEBWYRzUUkQQByGLF0gcz4nz2by0sXY6S7Yk4WDPQFhd4J88.txKKnUG5JF7rK8nNVHZUhA
 dGui86_b8pzcpZPD.keZKMZsLgC9ZkBOL5r_aco1jsMBoGzk5CVZFRzeA7h5RtAIM7ls8EIg5IXA
 m2UGkejOYy8zBfs9RLETyTxSvrsu8ga1UPv_E6YGBsldj6H9b.TyFVblmx_HamK5DtQ3.4Wp8C0g
 gpZTFk6Eknc_qEu3LKcSy6g7d8Vjn6JlR0mGs85UPK1XW3QO6VI2mJZi7QbyT3MNzGhdyu1Pn.gL
 X9GCJ8zqsVV3FxaAIUzrJCd2G_rDGKNIO37zhGWoYeQN77B4KLs_.tupvU.coH3coqqcCFjTls1d
 a15GurjlJiWKUbvLLJkbJyBR6dcUjQEThLZXw6g1Jez11p8u7yBdKbdmyU2.HmGYMTjY9thzGhEn
 s3a8hBPNo5JxXOoOlec0yKAgJItcTIRXVey7eXTJivW91mhwIMoYbHqwxg9Dku6agVVzgnhoalV0
 VWftcrRcQ_1r6CiT6Bk6zBxuMAf380RRqqcH3bGVwvrgMZFxXMm1M5WspGdVjGYX4mK4puSgVe1Q
 nrzrI.67reXSWM6KLv779jcK6AGfEfwUU5ULc2wo1qyoSJz_uk.yuASiDGYXADGtSm00ngP_2acz
 207yFE.Pf2zXO.hOECH.3tVbCL77SpWa_P0dMyQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 27/38] Infrastructure management of the cred security blob
Date:   Tue, 11 Dec 2018 14:43:03 -0800
Message-Id: <20181211224314.22412-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move management of the cred security blob out of the
security modules and into the security infrastructre.
Instead of allocating and freeing space the security
modules tell the infrastructure how much space they
require.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h         | 12 ++++++
 security/apparmor/include/cred.h  |  4 +-
 security/apparmor/include/lib.h   |  4 ++
 security/apparmor/lsm.c           |  9 ++++
 security/security.c               | 89 ++++++++++++++++++++++++++++++++++++++-
 security/selinux/hooks.c          | 51 +++++-----------------
 security/selinux/include/objsec.h |  4 +-
 security/smack/smack.h            |  3 +-
 security/smack/smack_lsm.c        | 79 +++++++++++-----------------------
 security/tomoyo/common.h          |  3 +-
 security/tomoyo/tomoyo.c          |  6 +++
 11 files changed, 162 insertions(+), 102 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 15fc49ee41a1..c9458280214e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2024,6 +2024,13 @@ struct security_hook_list {
 	char				*lsm;
 } __randomize_layout;
 
+/*
+ * Security blob size or offset data.
+ */
+struct lsm_blob_sizes {
+	int	lbs_cred;
+};
+
 /*
  * Initializing a security_hook_list structure takes
  * up a lot of space in a source file. This macro takes
@@ -2053,6 +2060,7 @@ struct lsm_info {
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
+	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
@@ -2092,4 +2100,8 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
+#ifdef CONFIG_SECURITY
+void __init lsm_early_cred(struct cred *cred);
+#endif
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index a757370f2a0c..b9504a05fddc 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -25,7 +25,7 @@
 
 static inline struct aa_label *cred_label(const struct cred *cred)
 {
-	struct aa_label **blob = cred->security;
+	struct aa_label **blob = cred->security + apparmor_blob_sizes.lbs_cred;
 
 	AA_BUG(!blob);
 	return *blob;
@@ -34,7 +34,7 @@ static inline struct aa_label *cred_label(const struct cred *cred)
 static inline void set_cred_label(const struct cred *cred,
 				  struct aa_label *label)
 {
-	struct aa_label **blob = cred->security;
+	struct aa_label **blob = cred->security + apparmor_blob_sizes.lbs_cred;
 
 	AA_BUG(!blob);
 	*blob = label;
diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index 6505e1ad9e23..bbe9b384d71d 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/lsm_hooks.h>
 
 #include "match.h"
 
@@ -55,6 +56,9 @@ const char *aa_splitn_fqname(const char *fqname, size_t n, const char **ns_name,
 			     size_t *ns_len);
 void aa_info_message(const char *str);
 
+/* Security blob offsets */
+extern struct lsm_blob_sizes apparmor_blob_sizes;
+
 /**
  * aa_strneq - compare null terminated @str to a non null terminated substring
  * @str: a null terminated string
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 803ec0a63d87..70669e676212 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1150,6 +1150,13 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 }
 #endif
 
+/*
+ * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
+ */
+struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
+	.lbs_cred = sizeof(struct aa_task_ctx *),
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1484,6 +1491,7 @@ static int __init set_init_ctx(void)
 	if (!ctx)
 		return -ENOMEM;
 
+	lsm_early_cred(cred);
 	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
 	task_ctx(current) = ctx;
 
@@ -1724,5 +1732,6 @@ DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &apparmor_enabled,
+	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
 };
diff --git a/security/security.c b/security/security.c
index 81ff6a71e78e..c49d4a18c75f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -41,6 +41,8 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
 static __initdata const char *chosen_major_lsm;
@@ -139,6 +141,25 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	return true;
 }
 
+static void __init lsm_set_blob_size(int *need, int *lbs)
+{
+	int offset;
+
+	if (*need > 0) {
+		offset = *lbs;
+		*lbs += *need;
+		*need = offset;
+	}
+}
+
+static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
+{
+	if (!needed)
+		return;
+
+	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+}
+
 /* Prepare LSM for initialization. */
 static void __init prepare_lsm(struct lsm_info *lsm)
 {
@@ -153,6 +174,8 @@ static void __init prepare_lsm(struct lsm_info *lsm)
 			exclusive = lsm;
 			init_debug("exclusive chosen: %s\n", lsm->name);
 		}
+
+		lsm_set_blob_sizes(lsm->blobs);
 	}
 }
 
@@ -255,6 +278,8 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		prepare_lsm(*lsm);
 
+	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
+
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
@@ -382,6 +407,47 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_lsm_notifier);
 
+/**
+ * lsm_cred_alloc - allocate a composite cred blob
+ * @cred: the cred that needs a blob
+ * @gfp: allocation type
+ *
+ * Allocate the cred blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+{
+	if (blob_sizes.lbs_cred == 0) {
+		cred->security = NULL;
+		return 0;
+	}
+
+	cred->security = kzalloc(blob_sizes.lbs_cred, gfp);
+	if (cred->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_early_cred - during initialization allocate a composite cred blob
+ * @cred: the cred that needs a blob
+ *
+ * Allocate the cred blob for all the modules if it's not already there
+ */
+void __init lsm_early_cred(struct cred *cred)
+{
+	int rc;
+
+	if (cred == NULL)
+		panic("%s: NULL cred.\n", __func__);
+	if (cred->security != NULL)
+		return;
+	rc = lsm_cred_alloc(cred, GFP_KERNEL);
+	if (rc)
+		panic("%s: Early cred alloc failed.\n", __func__);
+}
+
 /*
  * Hook list operation macros.
  *
@@ -1182,17 +1248,36 @@ void security_task_free(struct task_struct *task)
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	return call_int_hook(cred_alloc_blank, 0, cred, gfp);
+	int rc = lsm_cred_alloc(cred, gfp);
+
+	if (rc)
+		return rc;
+
+	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
+	if (rc)
+		security_cred_free(cred);
+	return rc;
 }
 
 void security_cred_free(struct cred *cred)
 {
 	call_void_hook(cred_free, cred);
+
+	kfree(cred->security);
+	cred->security = NULL;
 }
 
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
-	return call_int_hook(cred_prepare, 0, new, old, gfp);
+	int rc = lsm_cred_alloc(new, gfp);
+
+	if (rc)
+		return rc;
+
+	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
+	if (rc)
+		security_cred_free(new);
+	return rc;
 }
 
 void security_transfer_creds(struct cred *new, const struct cred *old)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c82f11270de6..ac6d8a2d00f1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -209,12 +209,9 @@ static void cred_init_security(void)
 	struct cred *cred = (struct cred *) current->real_cred;
 	struct task_security_struct *tsec;
 
-	tsec = kzalloc(sizeof(struct task_security_struct), GFP_KERNEL);
-	if (!tsec)
-		panic("SELinux:  Failed to initialize initial task.\n");
-
+	lsm_early_cred(cred);
+	tsec = selinux_cred(cred);
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
-	cred->security = tsec;
 }
 
 /*
@@ -3899,47 +3896,16 @@ static int selinux_task_alloc(struct task_struct *task,
 			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
-/*
- * allocate the SELinux part of blank credentials
- */
-static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-{
-	struct task_security_struct *tsec;
-
-	tsec = kzalloc(sizeof(struct task_security_struct), gfp);
-	if (!tsec)
-		return -ENOMEM;
-
-	cred->security = tsec;
-	return 0;
-}
-
-/*
- * detach and free the LSM part of a set of credentials
- */
-static void selinux_cred_free(struct cred *cred)
-{
-	struct task_security_struct *tsec = selinux_cred(cred);
-
-	kfree(tsec);
-}
-
 /*
  * prepare a new set of credentials for modification
  */
 static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 				gfp_t gfp)
 {
-	const struct task_security_struct *old_tsec;
-	struct task_security_struct *tsec;
-
-	old_tsec = selinux_cred(old);
-
-	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
-	if (!tsec)
-		return -ENOMEM;
+	const struct task_security_struct *old_tsec = selinux_cred(old);
+	struct task_security_struct *tsec = selinux_cred(new);
 
-	new->security = tsec;
+	*tsec = *old_tsec;
 	return 0;
 }
 
@@ -6889,6 +6855,10 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
+struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
+	.lbs_cred = sizeof(struct task_security_struct),
+};
+
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -6971,8 +6941,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
-	LSM_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
-	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7191,6 +7159,7 @@ DEFINE_LSM(selinux) = {
 	.name = "selinux",
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled,
+	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
 };
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 734b6833bdff..c2974b031d05 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/in.h>
 #include <linux/spinlock.h>
+#include <linux/lsm_hooks.h>
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
@@ -158,9 +159,10 @@ struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
 };
 
+extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 {
-	return cred->security;
+	return cred->security + selinux_blob_sizes.lbs_cred;
 }
 
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 01a922856eba..b27eb252e953 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -336,6 +336,7 @@ extern struct smack_known *smack_syslog_label;
 extern struct smack_known *smack_unconfined;
 #endif
 extern int smack_ptrace_rule;
+extern struct lsm_blob_sizes smack_blob_sizes;
 
 extern struct smack_known smack_known_floor;
 extern struct smack_known smack_known_hat;
@@ -358,7 +359,7 @@ extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
 
 static inline struct task_smack *smack_cred(const struct cred *cred)
 {
-	return cred->security;
+	return cred->security + smack_blob_sizes.lbs_cred;
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f34117b8c3be..459f7d523ca6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -309,29 +309,20 @@ static struct inode_smack *new_inode_smack(struct smack_known *skp)
 }
 
 /**
- * new_task_smack - allocate a task security blob
+ * init_task_smack - initialize a task security blob
+ * @tsp: blob to initialize
  * @task: a pointer to the Smack label for the running task
  * @forked: a pointer to the Smack label for the forked task
- * @gfp: type of the memory for the allocation
  *
- * Returns the new blob or NULL if there's no memory available
  */
-static struct task_smack *new_task_smack(struct smack_known *task,
-					struct smack_known *forked, gfp_t gfp)
+static void init_task_smack(struct task_smack *tsp, struct smack_known *task,
+					struct smack_known *forked)
 {
-	struct task_smack *tsp;
-
-	tsp = kzalloc(sizeof(struct task_smack), gfp);
-	if (tsp == NULL)
-		return NULL;
-
 	tsp->smk_task = task;
 	tsp->smk_forked = forked;
 	INIT_LIST_HEAD(&tsp->smk_rules);
 	INIT_LIST_HEAD(&tsp->smk_relabel);
 	mutex_init(&tsp->smk_rules_lock);
-
-	return tsp;
 }
 
 /**
@@ -1965,14 +1956,7 @@ static int smack_file_open(struct file *file)
  */
 static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	struct task_smack *tsp;
-
-	tsp = new_task_smack(NULL, NULL, gfp);
-	if (tsp == NULL)
-		return -ENOMEM;
-
-	cred->security = tsp;
-
+	init_task_smack(smack_cred(cred), NULL, NULL);
 	return 0;
 }
 
@@ -1989,10 +1973,6 @@ static void smack_cred_free(struct cred *cred)
 	struct list_head *l;
 	struct list_head *n;
 
-	if (tsp == NULL)
-		return;
-	cred->security = NULL;
-
 	smk_destroy_label_list(&tsp->smk_relabel);
 
 	list_for_each_safe(l, n, &tsp->smk_rules) {
@@ -2000,7 +1980,6 @@ static void smack_cred_free(struct cred *cred)
 		list_del(&rp->list);
 		kfree(rp);
 	}
-	kfree(tsp);
 }
 
 /**
@@ -2015,14 +1994,10 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
 	struct task_smack *old_tsp = smack_cred(old);
-	struct task_smack *new_tsp;
+	struct task_smack *new_tsp = smack_cred(new);
 	int rc;
 
-	new_tsp = new_task_smack(old_tsp->smk_task, old_tsp->smk_task, gfp);
-	if (new_tsp == NULL)
-		return -ENOMEM;
-
-	new->security = new_tsp;
+	init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
 
 	rc = smk_copy_rules(&new_tsp->smk_rules, &old_tsp->smk_rules, gfp);
 	if (rc != 0)
@@ -2030,10 +2005,7 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
 
 	rc = smk_copy_relabel(&new_tsp->smk_relabel, &old_tsp->smk_relabel,
 				gfp);
-	if (rc != 0)
-		return rc;
-
-	return 0;
+	return rc;
 }
 
 /**
@@ -4659,6 +4631,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	return 0;
 }
 
+struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
+	.lbs_cred = sizeof(struct task_smack),
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4837,20 +4813,25 @@ static __init void init_smack_known_list(void)
  */
 static __init int smack_init(void)
 {
-	struct cred *cred;
+	struct cred *cred = (struct cred *) current->cred;
 	struct task_smack *tsp;
 
 	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
 	if (!smack_inode_cache)
 		return -ENOMEM;
 
-	tsp = new_task_smack(&smack_known_floor, &smack_known_floor,
-				GFP_KERNEL);
-	if (tsp == NULL) {
-		kmem_cache_destroy(smack_inode_cache);
-		return -ENOMEM;
-	}
+	lsm_early_cred(cred);
 
+	/*
+	 * Set the security state for the initial task.
+	 */
+	tsp = smack_cred(cred);
+	init_task_smack(tsp, &smack_known_floor, &smack_known_floor);
+
+	/*
+	 * Register with LSM
+	 */
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
@@ -4864,20 +4845,9 @@ static __init int smack_init(void)
 	pr_info("Smack:  IPv6 Netfilter enabled.\n");
 #endif
 
-	/*
-	 * Set the security state for the initial task.
-	 */
-	cred = (struct cred *) current->cred;
-	cred->security = tsp;
-
 	/* initialize the smack_known_list */
 	init_smack_known_list();
 
-	/*
-	 * Register with LSM
-	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
-
 	return 0;
 }
 
@@ -4888,5 +4858,6 @@ static __init int smack_init(void)
 DEFINE_LSM(smack) = {
 	.name = "smack",
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.blobs = &smack_blob_sizes,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 41898613d93b..4fc17294a12d 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1087,6 +1087,7 @@ extern struct tomoyo_domain_info tomoyo_kernel_domain;
 extern struct tomoyo_policy_namespace tomoyo_kernel_namespace;
 extern unsigned int tomoyo_memory_quota[TOMOYO_MAX_MEMORY_STAT];
 extern unsigned int tomoyo_memory_used[TOMOYO_MAX_MEMORY_STAT];
+extern struct lsm_blob_sizes tomoyo_blob_sizes;
 
 /********** Inlined functions. **********/
 
@@ -1206,7 +1207,7 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
 {
-	return (struct tomoyo_domain_info **)&cred->security;
+	return cred->security + tomoyo_blob_sizes.lbs_cred;
 }
 
 /**
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 15864307925d..9094cf41a247 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -509,6 +509,10 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	return tomoyo_socket_sendmsg_permission(sock, msg, size);
 }
 
+struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init = {
+	.lbs_cred = sizeof(struct tomoyo_domain_info *),
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -562,6 +566,7 @@ static int __init tomoyo_init(void)
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
+	lsm_early_cred(cred);
 	blob = tomoyo_cred(cred);
 	*blob = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
@@ -573,5 +578,6 @@ DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
 	.enabled = &tomoyo_enabled,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
 };
-- 
2.14.5

