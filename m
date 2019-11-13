Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41E8C33C9B
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA68206EF
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g3DgM8o1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfKMR5d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:57:33 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:34017
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728390AbfKMR5c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667851; bh=i6tPPr7x71/s61Wwgk9lK2odZ7QDHQgW26n+sD1MkVQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=g3DgM8o1Q5WgOZKsvd5HRHxtL/GwQSboBOsFuMI2gCv3D6a2C7cow6qv1JusC/NyFGtCuOmnJRe95Liy9/M4cYEvfoOtzhOJ/M+Vv+OXxs88UN7CvatrHI8Fkdh3Uny0co4TuP2UlXiYaPagkRO284r8QtYVI1X9VqGm/kbTKiYqekbfpee2R/IkNO0By84S/+vHoj3W40DnIsI6UCJ/meuczdmo4QY/RUKMpIJm1WdIlSSMcezK9/6WvGZz2+Vi9hgCzaC1zrv/yAXQmpeja65fWSfslTL9WOo57q5KgO6P2LCf9nIcj+UoB5iBmBspaLhJES1PFWZyPfFJoLDm9Q==
X-YMail-OSG: NkGBq5QVM1k8PQcpFGKRRWEIgbzQKdCgCXxnHoO7MF2B5j1fFRjixWOxnotQnQY
 eeYquTjSkUmukLSk.gISq5s5hbwqfzWcC7Abg3rn6bRH4ORypJxvW4r6uaRqnNflD0qVBc7BbBJQ
 v5ZBIDWBWoJ97QKF0WYqBmUBftxlbSLhrIiU1vWUY2CwTBmqefelOY4HtDFkx5luPKrwS_ZVdf7R
 ZxVs4FxfiOjOQj6k7q5apoTy_fFaAvIrf5CoRxT10O.7HbUhiBE1YN62uSRiIa8CnVYUusM9YF8T
 dsUXKBC6qemVlYKW0WajSX_sWfi0HKY0e6Q91iynpV3VJliONy5hSSImvODlMC4dJ6gJ0Z3KTp0R
 BYXEncYwGQ2MtGk4q184CO4nvRnwFMmGf5B5YNK57KoDVaiE5FPXbe7L1Te.l9WfJssRDjoHuJpw
 fPvjzFrra6cDbWipZr58lQ7YTpro5x8fch2JxCcR..x.mDT8_bkd8oSuqFCctP.4SIn6URmGG6iR
 iFuwL6hZuHawJbnPBFJHTUBrntWW3EWmSAgpX4ZV7D9ofgMoJEjZZ.C6fTYzC6TU.v5fuGT1fliu
 y23o1mWaWgcEmNIDL1b2qq8_GV5lbN86VFQYJeCB_TLwPr_TTL9JLGiHf2fVFI8lJPOH7CfFNAEF
 2Wd0t.rNauz_CeAVcsCD4swoKSe9AiBStF1I3N1BGmHvpOiKMAy3peSCDqIIaj8za6FlWv.vtkgs
 1NU9qTPb9DP3WwwUKii1NFeE3Z_iVlBdSaQF.4fwvhaIh.G6FVneL8bEhka2m8bCmhUmilHWlzE1
 qjdjryiveu3wOgw.GowJlzC5FV6vpXsOyGUzQd7wnzWnejKTq_ro74DP32DOH0Y9sLXmCz8UrNqc
 G1_9p5inxxFJOi1OBiUlxIGerb_x7C9ytg.JynSnjrZHarWiy8BnsPWl9VJJUxaZN7hNqhhcB9cm
 m2cwHBtVt_a7o7wz_FZip8pozjNY4oyLAyf7uqrBDtaeiBskGXl3d_MvHrl2ZSb5MsYbjkICzMR9
 2iuxKZ4KuXsZx6h3A2rD2vCnXAm89tsIfXeDvtJIxr_sEy.dXYVGEm0JI3VpNtL.yis1F8.A.na3
 N4heoACzdnoW6Z7UAFfWOFFY6k2ap24GeBW1ysT9Y5G4C5UKt9a5rDTdWHdk.DxP3hGnxcWeD3a9
 qswe4eiKxA1Uz6FLO.vFEFGF086.NlavUapTxNSJwTkuCYi8Cp5VcX0mya2PenJE4REFQePMY.Fd
 wmI8ddwrJf1ZjBgMqGulKJumwdbOZ0y5NHKl9jNuQaIymxr9PQvC.lhJqEtNhDtxGbzljersKuX5
 6CgvINFtNeVwQYSLGLbBnqjJv85m8E8xYNKJMiGuMLvuq5dOtLe84i3JtM74Q3OAfoxtMCNvODoa
 zQt_8ByJhX8hwedMV4nfZD8WMptQcZhIwV5h.7J.1pJp_bdM.3MuX.q0z5JQgfw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:57:31 +0000
Received: by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID da2d7a7b186031f3cd27d031b318bbc7;
          Wed, 13 Nov 2019 17:57:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 02/25] LSM: Create and manage the lsmblob data structure.
Date:   Wed, 13 Nov 2019 09:56:58 -0800
Message-Id: <20191113175721.2317-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

The lsmblob structure is currently an array of
u32 "secids". There is an entry for each of the
security modules built into the system that would
use secids if active. The system assigns the module
a "slot" when it registers hooks. If modules are
compiled in but not registered there will be unused
slots.

A new lsm_id structure, which contains the name
of the LSM and its slot number, is created. There
is an instance for each LSM, which assigns the name
and passes it to the infrastructure to set the slot.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 12 ++++++--
 include/linux/security.h   | 58 ++++++++++++++++++++++++++++++++++++++
 security/apparmor/lsm.c    |  7 ++++-
 security/commoncap.c       |  7 ++++-
 security/loadpin/loadpin.c |  8 +++++-
 security/safesetid/lsm.c   |  8 +++++-
 security/security.c        | 28 ++++++++++++++----
 security/selinux/hooks.c   |  8 +++++-
 security/smack/smack_lsm.c |  7 ++++-
 security/tomoyo/tomoyo.c   |  8 +++++-
 security/yama/yama_lsm.c   |  7 ++++-
 11 files changed, 142 insertions(+), 16 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 13a67fd1a767..cfe5393840c7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2062,6 +2062,14 @@ struct security_hook_heads {
 	struct hlist_head locked_down;
 } __randomize_layout;
 
+/*
+ * Information that identifies a security module.
+ */
+struct lsm_id {
+	const char	*lsm;	/* Name of the LSM */
+	int		slot;	/* Slot in lsmblob if one is allocated */
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -2070,7 +2078,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -2099,7 +2107,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/linux/security.h b/include/linux/security.h
index 9df7547afc0c..5eced28fa0c9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -126,6 +126,64 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
+/*
+ * Data exported by the security modules
+ *
+ * Any LSM that provides secid or secctx based hooks must be included.
+ */
+#define LSMBLOB_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0))
+
+struct lsmblob {
+	u32     secid[LSMBLOB_ENTRIES];
+};
+
+#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
+#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
+#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+
+/**
+ * lsmblob_init - initialize an lsmblob structure.
+ * @blob: Pointer to the data to initialize
+ * @secid: The initial secid value
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		blob->secid[i] = secid;
+}
+
+/**
+ * lsmblob_is_set - report if there is an value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a secid set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	struct lsmblob empty = {};
+
+	return !!memcmp(blob, &empty, sizeof(*blob));
+}
+
+/**
+ * lsmblob_equal - report if the two lsmblob's are equal
+ * @bloba: Pointer to one LSM data
+ * @blobb: Pointer to the other LSM data
+ *
+ * Returns true if all entries in the two are equal, false otherwise
+ */
+static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
+{
+	return !memcmp(bloba, blobb, sizeof(*bloba));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4093fa231671..11845348eefb 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1134,6 +1134,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.lsm  = "apparmor",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1722,7 +1727,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..9dcfd2a0e891 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,6 +1339,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm  = "capability",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1363,7 +1368,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ee5cb944f4ad..86317e78899f 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -180,6 +180,11 @@ static int loadpin_load_data(enum kernel_load_data_id id)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.lsm  = "loadpin",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -227,7 +232,8 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 7760019ad35d..950dfb7f931e 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -149,6 +149,11 @@ static int safesetid_task_fix_setuid(struct cred *new,
 	return -EACCES;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.lsm  = "safesetid",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(capable, safesetid_security_capable)
@@ -157,7 +162,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index 5e43d3f64c1f..5f503cadf7f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -308,6 +308,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size     = %d\n", blob_sizes.lbs_sock);
 	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size       = %lu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -435,21 +436,36 @@ static int lsm_append(const char *new, char **result)
 	return 0;
 }
 
+/*
+ * Current index to use while initializing the lsmblob secid list.
+ */
+static int lsm_slot __initdata;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * If the LSM is using hooks that export secids allocate a slot
+ * for it in the lsmblob.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+			       struct lsm_id *lsmid)
 {
 	int i;
 
+	if (lsmid->slot == LSMBLOB_NEEDED) {
+		if (lsm_slot >= LSMBLOB_ENTRIES)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsmid->slot = lsm_slot++;
+		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
+			   lsmid->slot);
+	}
+
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -458,7 +474,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -1906,7 +1922,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -1919,7 +1935,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3feb971068e2..5570a6ed49d5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6791,6 +6791,11 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct sk_security_struct),
 };
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm  = "selinux",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -7051,7 +7056,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 796f78580c17..e42336328446 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4586,6 +4586,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm  = "smack",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4784,7 +4789,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92ec941a..f1968e80f06d 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -529,6 +529,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.lsm  = "tomoyo",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -581,7 +586,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 94dc346370b1..0f0cf7136929 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,6 +421,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.lsm  = "yama",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -477,7 +482,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.20.1

