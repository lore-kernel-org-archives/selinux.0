Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAA5C3F68F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED09C24670
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JyfA6KAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgBNXmc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:42:32 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:44088
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbgBNXmc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723750; bh=mdZK51sBu8gaQ8wZdlOHgByPRBos6L+Jf4Sp+s8QzAc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=JyfA6KATbos1z1K+nB6nbK2QTf4nBcMtzenOauSt6QyBse2c2k4kkFJdyGVDkpnXHtScJrOEjUVBdN2Yoc7XoYw5+KensBEzQSw+HviBeTQYcFLaZszxokNn8EA5uFk5imcqMbBJGx0AfXR1TWhkYgQIAfbs4IuHi/L/6jV7U7FKKbzlMyD1JOGLMPg5Wep85p353YWv80Zf3lDqg6+4xOTNNWJUhMEJoHFvkuqrTXk7kF+Nio438zhGuj7GDjQpP6QeytjLgWbwzvgWQtZ9CP89DL+KrGwARmR0mRKi+FsWyf1doDhEmJBAtKTB62PRlqN1NYnOI+L0NDoeVvkauA==
X-YMail-OSG: ObZUG6IVM1nx5CZa8wAmiWyPqaT8n1U16_OyWYCtjEAJS_1SUAMv8RuosHudSVX
 TAuSHWPpuWnZrTbHz71A180DeXLI52dWtF6IMyMupJkpL6sh7RjsCqBX_FgIXWBiRvclhNvVuuSI
 4C0V9d2mExBB1V0hgRjdT1MS9dzzOFZluOUzRE.U0e7Ka5pFilQyQOrRUVECKv_gX_NFfq5hHuGM
 kFZFfbiw8CtWPPXeBnwfYsmArHdXfH9ECb1ahojWaNKon_V.kLA12rFX4rdepM8EGNKKxH2chmcK
 Wdkt.1pVHoDlVWV7dxek6_VjTI0gQeEATHgI.5M0peUBW6SoaYVZ6p5QwcJ6awUSyu0t7nC7r9N5
 R7uzuvdqpcjtqP1Gd.CWwcWGaqk31McerMHsJrlKwRTUJ78RSBIpmyz4_HzPqY79weWVbBIWrqHu
 x0sC0dhIMkqveXZauFgpcHEajd84ntNv8nq9xaVxKCTiqEZP.rwoaTlEv15sAab3WUX0WjotFLzT
 aZX_T5NLodFbkDvz_IuI0xWKGzWXT8.9SwC2qtfBPA3t8R.mSmDe7apzF6XYcNaIrpclZ6Yc2Yj.
 .soemoyeojSvYeHr_1ePEsDuiQKyhUCPR64EmR0uzlRWKBGRiNwA3BdGL_sOhX2CVSz4tecQXYD_
 .SnBHaKyZUqXsStODWERwY_auhokr05upGjThMxwVUkzAJTbSQgSCEyPD..pdE4eakxgaa3ErpA.
 P0t7zWrRsZj276HxOGhdJE.emJbWZs_Vnz4GJ.vWOng4SvDfRMOxN4_D_Jav7YBJWY6L6rCjvGft
 1dl2j1f3FaKG.q18hnpb1KVs9k1gZ4Grs84AXLdFWYmb56RWQxKlItmX5AmBZ9gaaUx0Q3KewUQe
 bkayTtRcqjBlxuJ0I81_hlXhVCLKosb3lhuAVIOVKJ7O6HFwO46SnypCiw.eQkdCxMoqKiT.iucG
 bdZ.ARsZMOruOZs2M5JCHLISG69Vwpns9SmykbnBRH6wIdIy1uDc8CXvueU24F6c1ILqcT02wcwc
 iBH_b7jMSlgKHMQmqFu9_3q5DC6VDOs57sTxv0qZw9JEeYTsVHYU_P1VSnyGX9_iONR4e3uuOf00
 2mXvWGvqd81p3J6AqJ0wIVQlI.hqRRL.JBiezDM14UtX4THlxtOv0KRDWE9ySXC_VDEmPnF804pn
 DwIR36zUkiubVlOwuuzrxaS0j.QO1is1ZmaohGMaqxZgWVvCgRmYumdqpkq.4WfDTe_971jl4CCE
 LgMmBgPsch6fDbSyyKuCt1qwxFvLxNUps_UfHkSGt8Ov_4JvnmXo9sKogwWFdwCBLfhwfVSjC2Kf
 vPGNou_NSUkSURj5PlCBxXjuHwqJKC3XIG00wdUZnL5.aeVWLfgWZrS81HSccEk6.gXQn3G3j3RN
 TAxyLGAy8yLeVoy0K6CR69ohX_wc8zvQa3zvUTMI.5ixX2n1YGYzjmDaiEMNsogzk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:42:30 +0000
Received: by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aa3498465e4a622537bda8a87dcaca06;
          Fri, 14 Feb 2020 23:42:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Fri, 14 Feb 2020 15:41:43 -0800
Message-Id: <20200214234203.7086-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. In some cases this requires a
temporary conversion using lsmblob_init() that will go
away when other interfaces get converted.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  6 ++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 |  8 +++++---
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8c2751763c52..9d83c6832bae 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1839,7 +1839,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1855,8 +1856,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void **lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void **lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 3a44abf4fced..509eb21eff7f 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1327,6 +1327,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1357,8 +1358,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_isset) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0c239c29a9d5..ef2f5e7eec7b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -643,7 +644,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rules);
 			}
@@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules)) {
@@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 64317d95363e..f9e3ca96fa52 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -408,8 +408,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
+					     u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 624ed1a34842..ad48b7b60cff 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -476,6 +476,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -488,7 +489,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
@@ -496,7 +498,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&blob, secid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
diff --git a/security/security.c b/security/security.c
index 67c8116d8711..b3fab8fdbb57 100644
--- a/security/security.c
+++ b/security/security.c
@@ -471,7 +471,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2467,7 +2467,8 @@ void security_audit_rule_free(void **lsmrule)
 	} 
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2475,7 +2476,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op,
 					       &lsmrule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.24.1

