Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A881C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2FD2065D
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VtruUDoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgENWOM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:14:12 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:41185
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgENWOM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589494448; bh=9woRN+wjSNsHgtwDlSrMebhzRPiCCmrTpvDuYB1fAzQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VtruUDoI7E2ZuJxxZyeYErfbmAPItQVD+RD/+8O7qRbD2+sDsD9GOnQjC2AAzmcV5lYlH8RQ3Lf2h78CH0ZsQEOVFveO5gqXHCW28iVyMbncei/p87aFgQ2gZDB9uIafMEMr4kQJGWiMg+stYS2aAQZg8fRV/13k41jfPfarglTAaz4KHA6SxC6e0qzRQRy28qJXhOWW0GhFeAN4Pbp4mnJ7fCdKkyThZpjWkGggwFrfWOqg1wDsNkrQxs0C7Np8em9Mp9bHJF0Ueh1rVd471fXpBZ2oZ2YzxzUx1+dJKOnagWSp1l4fnwUglaCoTTJHS90RFh7UI4mfdiDLp40tvg==
X-YMail-OSG: 0MpLwIoVM1ks9DfrqasabH70tIcSHH54Fkb.7MFeyuOryNzvsO69ZAGARLu2sYg
 Ncfi4VK1vs1ICWl938HSRYJSDda22Uvy8BJ_BjYFsbeyHMgZ5KuVtWxp6.YDKyIg.4QD7W5DhOFD
 4dTe50pp9DXw5xrwoOFNLvr9SadFb.U8GVG0V.Ok35G9sC2YtSDTeHW7KyvDK568mi0olmeJSCuG
 dm3SiD86tT8TEsGXRf6OdF.jxqVRAdUxRy5NegNrqBk_wZXwXWoPBc4muZ4FZQBm0r0Qgme3mywj
 _VbA8AEXS_NB2f66JQQj6ZP9HlZ6uQuQAB0cXkblHa2mCN8qYilwJtEChJSQYvmqPPgmVZotoewR
 fKAtvHgwwJrUXs9frtGjCpWicjPOI_Sqmv.izmgjL7MR.3ZNVMNEqZuwoX9eVZmdESz7m_0eWEwL
 MJ5ZgVbX3hfDPk.iA3PeqKhV4iRuBw2cqDq6BbsSDl09_vLKFQLEvFvrMIH8udCSZHoLPQd3ePf9
 azlJJ6DMflnMQq0kES5nQ50N359G1TGOCktE0xmDzmWodJ4IQ4k1Bl3aQcPH_YEhyCX3Uoc_EbT0
 7gHPWGFWp0e6MsM6Bo9nltPr9PMk910xGFIAGIGFcNpPb8UP36BTrmEGIhrVJVyjUU3aYK54xE6E
 vYsxxyG_C2g1OeXGdRPi9ybCNUbSjR3fizrGnhxGP9T_rS0P1fHdoIs8N1GpN0qR1MCh79jUzphK
 WqpIWIi7W.febdt_OJSvICdsd4nAdpf6Znl8b1zWCeY8vQXH6M8JqelBruWro5py2P6pw4MYxnVa
 Ke_oAY3RMFAo38cWahY02HQlSRD7HIHSHNxUxOgQLu9TL9Vpvkagpahf7KPN9.Z5kKEEeXLl.Yok
 K6xIFPFmv.3nVhJOeTctzX22RQmPMFBTbf0Hjoc0sMPOeYiXuDzXJQY3NJmO0lohtxsSloHpNeMJ
 CrYDH9HbXS9ZCEa3bERoAkiOT4va9lrRwBiaF.I7g3ZDsanKz5eyrMo9WAlhJ5kKe9.pqXLNXkK_
 8t36F8CyzPHmCF.QOyZ0E3mpet62GZ7EgCQVDo9ijzZTSPtEns9UzncX6_agIzY6Rl4jeUcr6Pti
 WpVWhsSUBZeaJ.JAEj9N.ujToy68kCardYy_YuoV3e2M4U79_AR.CMRGfTqeBzheHG5gMVHYYJ9l
 FaCOrMTV.CA62.RRclHnQfuuLqC9NWMfy_dccJnkWdMzG7mmP9xd5UUr5optH44BV0y7dxEZ6gVl
 xh6sxkAHdeK9clezTwwOWoVJFyjUjUJYeHCu2VSTx8TcvYJBz5sACQKntzvFMfPRbh9Hw3ChZyJN
 InpmLiKz_bHOJWB7MJc86OfZV_dKej6D1vq606K3YakqklHTc_7I2Yk5DjWEG_PRzK2A9r0BWKG.
 ZgkjBMJExlLC0nN6y4kTKx_RVDs5RMacnYK4etVx6dwp9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:14:08 +0000
Received: by smtp413.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6b3f6861693be7b45228e0cc006bae1a;
          Thu, 14 May 2020 22:14:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v17 02/23] LSM: Create and manage the lsmblob data structure.
Date:   Thu, 14 May 2020 15:11:21 -0700
Message-Id: <20200514221142.11857-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
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

The audit rules data is expanded to use an array of
security module data rather than a single instance.
Because IMA uses the audit rule functions it is
affected as well.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h               |  4 +-
 include/linux/lsm_hooks.h           | 12 ++++-
 include/linux/security.h            | 66 ++++++++++++++++++++++++--
 kernel/auditfilter.c                | 24 +++++-----
 kernel/auditsc.c                    | 12 ++---
 security/apparmor/lsm.c             |  7 ++-
 security/commoncap.c                |  7 ++-
 security/integrity/ima/ima_policy.c | 40 +++++++++++-----
 security/loadpin/loadpin.c          |  8 +++-
 security/lockdown/lockdown.c        |  7 ++-
 security/safesetid/lsm.c            |  8 +++-
 security/security.c                 | 72 ++++++++++++++++++++++++-----
 security/selinux/hooks.c            |  8 +++-
 security/smack/smack_lsm.c          |  7 ++-
 security/tomoyo/tomoyo.c            |  8 +++-
 security/yama/yama_lsm.c            |  7 ++-
 16 files changed, 242 insertions(+), 55 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index f9ceae57ca8d..8e1c759fd1ff 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 #include <uapi/linux/audit.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
@@ -64,8 +65,9 @@ struct audit_field {
 		kuid_t			uid;
 		kgid_t			gid;
 		struct {
+			bool		lsm_isset;
 			char		*lsm_str;
-			void		*lsm_rule;
+			void		*lsm_rules[LSMBLOB_ENTRIES];
 		};
 	};
 	u32				op;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 01cca2b857a8..5b9b79e07fb6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1501,6 +1501,14 @@ struct security_hook_heads {
 	#undef LSM_HOOK
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
@@ -1509,7 +1517,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1544,7 +1552,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d9310472df..94e90d7150ca 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -129,6 +129,64 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
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
@@ -1780,8 +1838,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void security_audit_rule_free(void *lsmrule);
+int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+void security_audit_rule_free(void **lsmrule);
 
 #else
 
@@ -1797,12 +1855,12 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 }
 
 static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					    void **lsmrule)
 {
 	return 0;
 }
 
-static inline void security_audit_rule_free(void *lsmrule)
+static inline void security_audit_rule_free(void **lsmrule)
 { }
 
 #endif /* CONFIG_SECURITY */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 026e34da4ace..978051c498d5 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -74,7 +74,7 @@ static void audit_free_lsm_field(struct audit_field *f)
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
 		kfree(f->lsm_str);
-		security_audit_rule_free(f->lsm_rule);
+		security_audit_rule_free(f->lsm_rules);
 	}
 }
 
@@ -519,9 +519,10 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 				goto exit_free;
 			}
 			entry->rule.buflen += f_val;
+			f->lsm_isset = true;
 			f->lsm_str = str;
 			err = security_audit_rule_init(f->type, f->op, str,
-						       (void **)&f->lsm_rule);
+						       f->lsm_rules);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -774,7 +775,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 	return 0;
 }
 
-/* Duplicate LSM field information.  The lsm_rule is opaque, so must be
+/* Duplicate LSM field information.  The lsm_rules is opaque, so must be
  * re-initialized. */
 static inline int audit_dupe_lsm_field(struct audit_field *df,
 					   struct audit_field *sf)
@@ -788,9 +789,9 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
 		return -ENOMEM;
 	df->lsm_str = lsm_str;
 
-	/* our own (refreshed) copy of lsm_rule */
+	/* our own (refreshed) copy of lsm_rules */
 	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
-				       (void **)&df->lsm_rule);
+				       df->lsm_rules);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
@@ -842,7 +843,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 	new->tree = old->tree;
 	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
 
-	/* deep copy this information, updating the lsm_rule fields, because
+	/* deep copy this information, updating the lsm_rules fields, because
 	 * the originals will all be freed when the old rule is freed. */
 	for (i = 0; i < fcount; i++) {
 		switch (new->fields[i].type) {
@@ -1360,10 +1361,11 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_TYPE:
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
-				if (f->lsm_rule) {
+				if (f->lsm_isset) {
 					security_task_getsecid(current, &sid);
 					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+						   f->type, f->op,
+						   f->lsm_rules);
 				}
 				break;
 			case AUDIT_EXE:
@@ -1390,7 +1392,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 	return ret;
 }
 
-static int update_lsm_rule(struct audit_krule *r)
+static int update_lsm_rules(struct audit_krule *r)
 {
 	struct audit_entry *entry = container_of(r, struct audit_entry, rule);
 	struct audit_entry *nentry;
@@ -1422,7 +1424,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	return err;
 }
 
-/* This function will re-initialize the lsm_rule field of all applicable rules.
+/* This function will re-initialize the lsm_rules field of all applicable rules.
  * It will traverse the filter lists serarching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
  * LSM field is re-initialized, and the old rule is replaced with the
@@ -1437,7 +1439,7 @@ int audit_update_lsm_rules(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
-			int res = update_lsm_rule(r);
+			int res = update_lsm_rules(r);
 			if (!err)
 				err = res;
 		}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 814406a35db1..03cb9841d1a4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -638,14 +638,14 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   match for now to avoid losing information that
 			   may be wanted.   An error message will also be
 			   logged upon error */
-			if (f->lsm_rule) {
+			if (f->lsm_isset) {
 				if (need_sid) {
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
 								   f->op,
-								   f->lsm_rule);
+								   f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -655,21 +655,21 @@ static int audit_filter_rules(struct task_struct *tsk,
 		case AUDIT_OBJ_LEV_HIGH:
 			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
 			   also applies here */
-			if (f->lsm_rule) {
+			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
 								name->osid,
 								f->type,
 								f->op,
-								f->lsm_rule);
+								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
 						if (security_audit_rule_match(
 								n->osid,
 								f->type,
 								f->op,
-								f->lsm_rule)) {
+								f->lsm_rules)) {
 							++result;
 							break;
 						}
@@ -680,7 +680,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					break;
 				if (security_audit_rule_match(ctx->ipc.osid,
 							      f->type, f->op,
-							      f->lsm_rule))
+							      f->lsm_rules))
 					++result;
 			}
 			break;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 61b24f4eb355..146d75e5e021 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1147,6 +1147,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
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
@@ -1847,7 +1852,7 @@ static int __init apparmor_init(void)
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
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c334e0dc6083..db6b62c5c035 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -73,7 +73,7 @@ struct ima_rule_entry {
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
 	struct {
-		void *rule;	/* LSM file metadata specific */
+		void *rules[LSMBLOB_ENTRIES];
 		void *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
@@ -82,6 +82,22 @@ struct ima_rule_entry {
 	struct ima_template_desc *template;
 };
 
+/**
+ * ima_lsm_isset - Is a rule set for any of the active security modules
+ * @rules: The set of IMA rules to check.
+ *
+ * If a rule is set for any LSM return true, otherwise return false.
+ */
+static inline bool ima_lsm_isset(void *rules[])
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (rules[i])
+			return true;
+	return false;
+}
+
 /*
  * Without LSM specific knowledge, the default policy can only be
  * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
@@ -256,9 +272,11 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
 static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 {
 	int i;
+	int r;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		kfree(entry->lsm[i].rule);
+		for (r = 0; r < LSMBLOB_ENTRIES; r++)
+			kfree(entry->lsm[i].rules[r]);
 		kfree(entry->lsm[i].args_p);
 	}
 	kfree(entry);
@@ -293,8 +311,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		security_filter_rule_init(nentry->lsm[i].type,
 					  Audit_equal,
 					  nentry->lsm[i].args_p,
-					  &nentry->lsm[i].rule);
-		if (!nentry->lsm[i].rule)
+					  nentry->lsm[i].rules);
+		if (!ima_lsm_isset(nentry->lsm[i].rules))
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				(char *)entry->lsm[i].args_p);
 	}
@@ -463,7 +481,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		int rc = 0;
 		u32 osid;
 
-		if (!rule->lsm[i].rule) {
+		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
 				continue;
 			else
@@ -477,7 +495,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			rc = security_filter_rule_match(osid,
 							rule->lsm[i].type,
 							Audit_equal,
-							rule->lsm[i].rule);
+							rule->lsm[i].rules);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
@@ -485,7 +503,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			rc = security_filter_rule_match(secid,
 							rule->lsm[i].type,
 							Audit_equal,
-							rule->lsm[i].rule);
+							rule->lsm[i].rules);
 		default:
 			break;
 		}
@@ -870,7 +888,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (entry->lsm[lsm_rule].rule)
+	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -881,8 +899,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
 					   Audit_equal,
 					   entry->lsm[lsm_rule].args_p,
-					   &entry->lsm[lsm_rule].rule);
-	if (!entry->lsm[lsm_rule].rule) {
+					   entry->lsm[lsm_rule].rules);
+	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			(char *)entry->lsm[lsm_rule].args_p);
 
@@ -1583,7 +1601,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (entry->lsm[i].rule) {
+		if (ima_lsm_isset(entry->lsm[i].rules)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
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
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eb..924292f7bfcd 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -75,6 +75,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.lsm = "lockdown",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +88,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
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
index 43a09787d0f9..8d92c88d0da5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -340,6 +340,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size     = %d\n", blob_sizes.lbs_sock);
 	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size       = %zu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -467,21 +468,36 @@ static int lsm_append(const char *new, char **result)
 	return 0;
 }
 
+/*
+ * Current index to use while initializing the lsmblob secid list.
+ */
+static int lsm_slot __lsm_ro_after_init;
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
 
@@ -490,7 +506,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -1957,7 +1973,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -1970,7 +1986,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -2434,7 +2450,24 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+	bool one_is_good = false;
+	int rc = 0;
+	int trc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		trc = hp->hook.audit_rule_init(field, op, rulestr,
+					       &lsmrule[hp->lsmid->slot]);
+		if (trc == 0)
+			one_is_good = true;
+		else
+			rc = trc;
+	}
+	if (one_is_good)
+		return 0;
+	return rc;
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
@@ -2442,14 +2475,31 @@ int security_audit_rule_known(struct audit_krule *krule)
 	return call_int_hook(audit_rule_known, 0, krule);
 }
 
-void security_audit_rule_free(void *lsmrule)
+void security_audit_rule_free(void **lsmrule)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
+	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.audit_rule_match(secid, field, op,
+					       &lsmrule[hp->lsmid->slot]);
+		if (rc)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d5b0c9e42a85..44e9d0a332ba 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6897,6 +6897,11 @@ static int selinux_perf_event_write(struct perf_event *event)
 }
 #endif
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm  = "selinux",
+	.slot = LSMBLOB_NEEDED
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7205,7 +7210,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f6c2ec5b60b7..12e01d450dd4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4577,6 +4577,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
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
@@ -4775,7 +4780,7 @@ static __init int smack_init(void)
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
2.24.1

