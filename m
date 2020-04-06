Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0294CC2BB1D
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE822072F
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mCob/Jt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDFUuv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:50:51 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:46377
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbgDFUuu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206249; bh=qdZi5+OinyEciEGRlKKbPpckElz+tRGZ86CINhJ2MJg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mCob/Jt9UAuqgfLaSL78lrCd63HDR+her6XbwN7c0p4+gEbFuSAXKYIbrYsu4FZbCmomg+g6lQh4R5KV32mcah6C5CDrmBbmocZIb7w/oCvQP1ziSiiAlhl0dOgBQFQyRIcAgaC0Gx++K61U1t7/O6kyuq0XWSgN+VXyTqfiWl3Syg0986jcXeEdXe8tiIQPTN2XukJyv7xOgk3Qy61+ElvkIqqtuo/JB6QJMgjikJaSzEBfbj2a9RoPnEx6brkulBPxUWNfFXSHnvYp5vLDnhci7zDqOyvm97kcMQDLeNGWS2KLdCrRSnixqghIH/zsR6zvObbh8grPenkDJxAmjQ==
X-YMail-OSG: Ygr20P8VM1lWEJdAwZmO9fXcNw0YFgmH.7ka9qOMN2JxlqzZDI6ZN0FIUzHfVCi
 VRmiDqSGPu.rXd4wuU7JbxHfkWYpEnYE_yGn7uU7AKWKX18D3c8vlxrEjaJXmK8cFWhhTi.2aJXg
 dJ__GBZLDCSOZvZDrK8QX7qhTV4ATGK1j8kbeueMdoqR7fpygD_J5NGRYpjtAgIKHAw7OWJc2EQ2
 WEC4h908Rh3vYo5Yq_6mdmzxY8Y5Ymp6Sn_rCuZ0DERk31yMimgjV4jjBj1pCLS4fAq2Pl8RJMPk
 64.4spumlw45MJTzZFeZT2neU5JZuEygYxWfsAzSGqnvRE1KIF3q0rKAcegDhgff6PxCU0E_xvrd
 bhBSv1PGgO5T5mhxskaSb8dqh8vJPc7jpBM6EmBaHrnSBxNX6gDXRLS14Kx.TjoOpiesZ4sTMh_o
 hO6kYp50Abpt9BPaevvLYj5vN9pB6B_xOCX0J1g_OOqoPcW0EgDsV87sSG87LXEEnSKUv2TscpLJ
 leCNd58axHeHunLOscSQYtuDWXhJeic3MfbjEUCYdVOUukqF.t9dkE0e9gTVgID9h8PFuxNMV1s3
 32c9FbftZkFOpMYypXBMunIOKLdEquW4Xh7cQs2FqNPlD2585fyNDhgWhH9KAV.cj1jthRcKww8O
 YF4goiNl_vEMPyCu.I625e6EGCnpjMhssLKrCaWY3ld.teiQF1euR0uZWgQPOYjNd8I86xMJ73Sf
 W3AvR9YxWqeMSQdLhhHx9B_zL4ASiq4NYQnvDBsxpOWZdhqOE2v..mK8E8N8VLPSWEBiDJlbzhtn
 Np.AAR5kpYWLjG_VAhmpyi1cpy8eFoRURJCw7e454LnoAewHG8U_WYjLagIHE100bSvjEYHjALY4
 XVxr.qsfi7NLz_0hSl1DpSPs2dCMz0yh69QL7QUrWhxCcQm__QqypzRKz4NJZLa2XDjABTHGwFAu
 srE.NiHyE0MAVuJOYZBQJqBecdq2KEOUJ0.A8BdhKgxNu3qHXPB18tDB7l2I4YFVvFiVHPgRr.h_
 nzipX6uIMBrLdAB_FuHHjL0KHuqLZjep0fjbJv5HKyQlMuNFVeUSJ9NQcKXvIV_w6spFdcSjGM99
 0zMVKIFQPZ6v2QBb0VXdo3mE0SunuztoVWwzJrUiHyACgHLt0jg0PsAgDNLLpcefoUiL1Xq29fdB
 a7W5BeZwYAyDIay.FVL6f15zD54GXYvsHR0.4KgjzTILSlJymNP3AVKWdHcK.Y8jYlJLSBtM3ml.
 BnldjU1oZ_9TS682ooG6l8d.fZ20EjRLATCLucVFj0oMXYix75Dx8PrBt5_4_kTzvlb9vXD9n6FD
 vl.dFOTNuuG8pQqSXGiRTBqqj7uMX5sP.2z_xgoRIb6XctrYEhqI6wSuVCtAOvR4GUgXxTuWf_rl
 FsNlfjHc.NUNtQUPtx1kbiq1785NOg6jOxSXAMhyo9IQAFiTEdasQ6fGORDOuuTYHDW8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:50:49 +0000
Received: by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d257d9e78e580e12de5a533467ac81c;
          Mon, 06 Apr 2020 20:50:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon,  6 Apr 2020 13:50:03 -0700
Message-Id: <20200406205023.42338-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406205023.42338-1-casey@schaufler-ca.com>
References: <20200406205023.42338-1-casey@schaufler-ca.com>
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
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

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
 security/security.c                 |  6 ++++--
 6 files changed, 29 insertions(+), 15 deletions(-)

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
index 978051c498d5..542eee7ad882 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1333,6 +1333,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1363,8 +1364,9 @@ int audit_filter(int msgtype, unsigned int listtype)
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
index 006447d6c366..55cca6a57178 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -482,6 +482,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -494,7 +495,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&lsmdata, osid);
+			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
@@ -502,7 +504,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&lsmdata, secid);
+			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
diff --git a/security/security.c b/security/security.c
index 8e66f27d6adb..b3fab8fdbb57 100644
--- a/security/security.c
+++ b/security/security.c
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

