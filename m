Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9DC48BDA
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922E5216FD
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j/jX+xUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFZTWx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:22:53 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:34595
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFZTWw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561576969; bh=52gduPtiM5w/kwH1Rv51A+r3aMdnqhyjpAmlAqsFJrw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=j/jX+xUes33JaLc+RE4GUeHK6imkl/esoZ2rddLSzVpMKD1zvFVQEufpsfUAJq/HCx35ZotTRtkLQmPwfd+uI25CAFAXEMDuVZQdtXZax7t4EAauGPAxJndHZjchqQC4Cr6TQrchvlCKKxuobXBxWFlK2QyXBe+rpkWd+IOjIcCQvN/jopPH3Y14P+IpNSKoZfrBQJ/RS6wAzmeIGPXWca+E3wUcYsa49Zz59nVFz7kdvPX9j+Zgy9dukfLl6+hMSuunuh3qxPLDBUYB6w+CdkVN1W+iLTX57UWbI8fM6SsTj4HqjErQNejNmC2MENXoNWnHTZ3IFk2JSgeAnOrcSw==
X-YMail-OSG: vbXkQDwVM1kLkqs0vc0ok7.6SMKBmh28swPiVfqXm3dVwMhRSbURkczBIhAYd59
 UdN8BIhf9Od7LdZI7O6wYHeKhofeUwWjiaaftsSGAwVMjd7USusSbsO2cLKBEJ7mNU97uqN2bqvB
 AZ0hd2_.oYnnfQxwzw6Xo1hTLFjVdh39wL_pdWHSXcQUkE_kcjfQoXKMnBO7qoNXFcdQ_sQxFfaH
 EXIVaj0rqmMQoZ.0invbhNSPgC_3oFF1kn3.hHF8gL057IRGdNcYwAz0U8vGbjyKFNWGJSHPoeob
 OVTXG._oCl83dcSWOoaVfrdlTZvyN7uJyBqRyvbOzNcOE9qVj.di.BO8bJpUL6QCzJ0yWnv_Ffvn
 0c44fJyQwopSEbmcke9o2eLky7KD7rdIZqN.IJQGdYnSVI5FVnG0ogrrR4QnbX1Vu7bcEg25Psra
 ieO8COLooKQhBQNhs1hx0o33b8r2whAWdYAeRApEFFE27rnshedV4cvVNkjv6XRTW5rQEvnmr4hR
 juTL3FdN9l_W4wnscxvxtnslSUJ4jVSGbRCNEuYBR7aOj90QTVe8F81V8t1ZD2keK7H8zBdUzu4e
 6e54jsd8pAcNlLbY1F6rdCbMZjONpePmgEK7JVK_TaMJrPaLfCqDCTYeLYx70q00Gfc74RHXkvko
 5cevdcucLIla4wPSW32r9Bkw8rDcoxsvTAVxvnafws38b42lYU3cwGlmWlN1CxJ1YlF7qmzxunrT
 Ox3PJoEK3ya7W1wBs.RUECiUk_lHUP0wvotRSJQ3PneimrOAoUXJ5En58RcdFGQMQGpLgKphe5Ou
 1n4JvL87KCK9vKn1WX2kvbZ2h_JVvLzqUcNPguKgYgjR3Zx6UAa_ItuA8pkYyUi48rhvIWSwevqD
 fVuwMeb9DaNsTEuAINdSEVD4Uvy0s15SFmZ2dyYgAx0CU7x6YandqS7v1ILq27SywxIGosTSX1qZ
 8Ubo1mRCp0wD748uyk1nO2BdRNqlCbPMoGjloB4ZB9NJ6_NWCoUYQGMTB9fWr0Ix2ej4oReRp646
 H24JR88psVjWZODlcfDQDSM_Qsb79VvI4JXAtZDSoQP9yuei6kF9y4C7SVJ1wDffLSbD44iWKqzU
 CAdPrenalHqX97Ir6h1h7ew5lun7CbiNuE_uoJW2Y8vINWKkvHC4vf7rd9GkKstmR81UyrvdtqGC
 C0oiJSCdywSCFSLy7BBNfCoCCpt7ruqdGFnc4rnCLDMAWtw2BE6bEh_KApK8rshXwqhQy8r293iU
 xzDnrEVdWIeNJ0Q8r97Vu1Mzn0hbNhCAcCrdeYMUBbH_srqE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Jun 2019 19:22:49 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8851378117cc34b5f34e848cd09a5ce8;
          Wed, 26 Jun 2019 19:22:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 04/23] LSM: Create and manage the lsmblob data structure.
Date:   Wed, 26 Jun 2019 12:22:15 -0700
Message-Id: <20190626192234.11725-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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
 include/linux/lsm_hooks.h  | 12 +++++--
 include/linux/security.h   | 66 ++++++++++++++++++++++++++++++++++++++
 security/apparmor/lsm.c    |  4 ++-
 security/commoncap.c       |  7 +++-
 security/loadpin/loadpin.c |  8 ++++-
 security/safesetid/lsm.c   |  8 ++++-
 security/security.c        | 31 ++++++++++++++----
 security/selinux/hooks.c   |  5 ++-
 security/smack/smack_lsm.c |  4 ++-
 security/tomoyo/tomoyo.c   |  8 ++++-
 security/yama/yama_lsm.c   |  4 ++-
 11 files changed, 140 insertions(+), 17 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3fe39abccc8f..fe1fb7a69ee5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2029,6 +2029,14 @@ struct security_hook_heads {
 #endif /* CONFIG_BPF_SYSCALL */
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
@@ -2037,7 +2045,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -2068,7 +2076,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..5bb8b9a6fa84 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,72 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
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
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (blob->secid[i] != 0)
+			return true;
+	return false;
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
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (bloba->secid[i] != blobb->secid[i])
+			return false;
+	return true;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 2716e7731279..6d2eefc9b7c1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1138,6 +1138,8 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
+static struct lsm_id apparmor_lsmid = { .lsm="apparmor", .slot=LSMBLOB_NEEDED };
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1679,7 +1681,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index afd9679ca866..305a6088c81e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1344,6 +1344,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid = {
+	.lsm="capability",
+	.slot=LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1368,7 +1373,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 055fb0a64169..13db59d5327e 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -181,6 +181,11 @@ static int loadpin_load_data(enum kernel_load_data_id id)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
 }
 
+static struct lsm_id loadpin_lsmid = {
+	.lsm="loadpin",
+	.slot=LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -191,7 +196,8 @@ static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index cecd38e2ac80..ca34badde4cf 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -255,6 +255,11 @@ void flush_safesetid_whitelist_entries(void)
 	}
 }
 
+static struct lsm_id safesetid_lsmid = {
+	.lsm="safesetid",
+	.slot=LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(capable, safesetid_security_capable)
@@ -263,7 +268,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index 7cfedb90210a..27e2db3d6b04 100644
--- a/security/security.c
+++ b/security/security.c
@@ -317,6 +317,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size         = %lu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -399,7 +400,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
 	return !strcmp(last, lsm);
 }
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -420,24 +421,40 @@ static int lsm_append(char *new, char **result)
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
+ * @lsmid: the identification information for the security module
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
-	if (lsm_append(lsm, &lsm_names) < 0)
+
+	if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
@@ -1917,7 +1934,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -1930,7 +1947,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c83ec2652eda..8c93b07bb353 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6622,6 +6622,8 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 };
 
+static struct lsm_id selinux_lsmid = { .lsm="selinux", .slot=LSMBLOB_NEEDED };
+
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -6877,7 +6879,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e9560b078efe..ad646b865295 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4553,6 +4553,8 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid = { .lsm="smack", .slot=LSMBLOB_NEEDED };
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4743,7 +4745,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92ec941a..57e6b845ea51 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -529,6 +529,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid = {
+	.lsm="tomoyo",
+	.slot=LSMBLOB_NOT_NEEDED
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
index efac68556b45..2263822a4af7 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -425,6 +425,8 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid = { .lsm="yama", .slot=LSMBLOB_NOT_NEEDED };
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -482,7 +484,7 @@ static inline void yama_init_sysctl(void) { }
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

