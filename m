Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79BEC2BB1D
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C559F206C3
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uWBglISd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDFUzh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:55:37 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:39808
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDFUzh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206534; bh=qdZi5+OinyEciEGRlKKbPpckElz+tRGZ86CINhJ2MJg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uWBglISdV8jHUPrxQ0skphl1DNIfZsLF8TqdaGwRrusHqwePXjFn21yCKvuyvsaEO7brGfMjorlqwlZSwuP2O5IBszoHAVLFozjOu+HN4fi5mJIzGsuZNkQgZ7VBaBS/X/lgRIetT5nNVPtrfY0EhgWGGMtPG8yjqteftpA0CMDlIAKzT2ZKzTFul3ACMRBu0hZNqOlC4v9dAtgIaaKp+aiy+EG1Dpl9gwpehf/7lx4uwu+efA2xcm2QOjQI7Ns+svCYbiWKnWwI8aEZs5vELTQkD6Bwdc+6v1UfG6xqr6BQM3AGWhPAv1ZjdIn0gU6y9NsbAmOheGwDkII0ZFh26w==
X-YMail-OSG: 3ad7CPIVM1kevygiKAO20PPS04kbcsR.5w5NkAi5b0lifyJ7MlD6KFsBjbfnC1o
 rpkHoYkBH.7nbPVAZ8hmExZ1IRuIn5viHiory_2XAQIeTx9ZaC.jOnvuElMoVI01KlZSxw0aDMQP
 ZGdCaJPLSyCcBHLIY_lI_1mD9dHGUdumdpLK9CDr8thTonoOMdtDKYU0fX02Z2In6JrYfj7AOkrG
 7rsUP8bYs2vd5DPnufZPzEsEeIb2vaU_FHX6lqR0aACWFzO0vwtdf9f06EbXKLuAsP.GlEjmaHf.
 x3qBfuZh052SOkMHXxone_Ovp4G1zUyMnsxQkbSl_2ntU2EkV6ENUpJx1IvDiszWWkXSoJrT1F.W
 a5g18t6ih4NhILr5DW2fms.5yt3QoCPiFkEJh5fiHe.6VJPm.On3lqYgRB5vcrnwDXMwMYLePQ7D
 g_U.AusQilrvIe3QcdFyidrRuw6LPXCNF2yaAYbRQsIapeoNH15J_EIjH0Q9lDdl9g87QF4uv_yg
 V7k_Rv4jXHLnv6KAC5U0cN.xeIgPuC0uLyBjKQOOmVN85QrwhDzGqtDmZj8.tJ2VP_RevXf4BAt5
 FJY8NNs1KoNLfZf06doFPF1HhhirDPgxhmgzIeKnqZgc4BhX9KwizmOsB.g4ZHBhxbGkIjWTDJgS
 zUCuR8nfl5ZeXUkSlISWiuTFDOJQJHiwF6VExI9Q0Ch3GE2ZHFrz3iAkQZC4R6Qo6pJHjX1Yu53i
 vjxmGG6GeOlqEDYHATcFmpiX.xAb39kTdhapIMJwPzzywTM1Ar.nrWrN0n749C4tr0xv9C9FpAil
 ijm81uzrCPm5mZGNYKmt9fBiPMsRphHfSzoDqpClQ7rDco5OsRmuJJ36G0CMK2WmdEcNYmqtrXmn
 H8Vtr4S9bjm8c_xcUXgGh47_Tjc.g9z5M_EJdnFagmqyCSYEc_4aKMoWzNvMJ4P7K1DZ2XrVAvET
 h8AcFBo1PV1nOuKX8bJbRp0cvsXdcS579EsQRBFNqEODwZ5apyz.Qw1k54MEz6MfWSULeqgSQ9U0
 xwKtbki9ISSN0KQ35pkKiK.Y20G6MnWYs5xJ8n3CQrpluvVlQdwk62FPRykrYIzvccq5A3jeGZJu
 4kfI0cu1JvgFMY4xA5Bjse5hW3KauP29Z3c8gFd.c0P9_VRFFD0UK.VK6pNETTRW8AAEMoWZhRm7
 D2vWXjICkflXUXOFYcvPJ97OU8uCNZLCavdmmk_8DRfD6tCe2ep0NgiNmtGeQ_197f9qGNe1HIVw
 zYN2clMPHGrnD7abzcMGPXcDcYoGfRY56pvStQOFwqrZbJc5a2L4hcfmGTD19fW4uAzm8UxKynvu
 vI77VRK.T2zs.zDd5hcuHAw5x2p9QHFdL70hkCguHk6hUf.qQYWOOArmR4bDykEHDvy6.yKr7vt.
 BysoFH1PQR23GX6YABASONO.H0w_8L54zwvqFQx224jHTVm03winJ3ksdzN3yLQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:55:34 +0000
Received: by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 49ea4b24c437c264732571eba0132136;
          Mon, 06 Apr 2020 20:55:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon,  6 Apr 2020 13:54:49 -0700
Message-Id: <20200406205509.42473-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406205509.42473-1-casey@schaufler-ca.com>
References: <20200406205509.42473-1-casey@schaufler-ca.com>
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

