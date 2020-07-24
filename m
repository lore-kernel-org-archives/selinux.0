Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B9C433E3
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4376E206F6
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C+ucRgyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgGXUgG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:36:06 -0400
Received: from sonic317-32.consmr.mail.bf2.yahoo.com ([74.6.129.87]:43081 "EHLO
        sonic317-32.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgGXUgF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 16:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595622962; bh=7eivXrNGttnXx9h+B0YQVsknvzFhlEcbrmZeWHpsBh0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=C+ucRgyxM0MXClDOXWZ+ueBC1Be13aK70IAvpGUQSBXZ9P5G6QJMfW2pE3MvdOJQHNHlFH6UAgn5+q505F1hrEzm2iizGTT1KllAoiTxTSrVm4edcBz/o5eZkNkR0QcWFuKteoKKhjcIadHyUGR5QS+xy4ff71P9k15OtLwUejYelW+MxrIH7+OaGzERwFE+Ixx0/XdJLaiK1BTDBlB56n6fJM5aQ3yfCbQxW1M6c4xJ0dKhmy/Ei6afx6qP1LFtAv3ALv92hZx8atD8Xl5mIppcOxZc+P5BDnbt7/EljyWtyj0bcQFQSOSqPCamVlKJ5ZZG3CUsUmDTKg48SyYvwQ==
X-YMail-OSG: dBlKsDwVM1nlvbAwPNBo.ksFfvmPJggA1m_q3ijPkZHnbab3lJzJ2kyrl8E2krO
 SfZ7U.9Bgxj7Jus3qjAqw6KxCZoKOE5Gdr4ZkoyWlPfq0HEXvCcGjnE8QayusOUwXdumCiXPw.xE
 YTyEkVoKHDt.TQJebUgAcNJITuXj55kks781KshPzK3.4z27g8KqcDQCyBnLCxLBhjq1zdpHsPR.
 ux6AP_JZuyh.WnhejXAlSFuaZS5x0vS0WY81A1iFs87U9YSm_O63g8yidFY9LLcMMHyVrjK6r8D0
 RWBRMo4P8s.k_x1LCLxMzmevDyQ2Tkp.dVt25MxM1Uz7nDqQNV0oNeWdU8R.io2tExcKjf47F_II
 mzs6vmlX89rRJmt.EqpehATgy_UICBAO5Hj73f4jDJi41KafiaiWnqWOujstXXeaRjHnNXC4IXZA
 FhBw0iyOskykGQeoXyALe4a9s2C2vjWjxauPtKaj2ckM.4sqcxzPB03lsoWp5sDZ5Oas4blUfTnZ
 L.J_JZdke5eWenAGwLItZvBaAXOyefsz7fRkXXj_zoqvKftVZs6ivSwMimGH_.c5fBUPwM69RM8w
 x6ZpS4owF_5JEe.Rld1NUC_yfUG0Mw04e1jEhgg8Df3GPfVreg8bDTx4uwGVHFPirFnBqWSFC1Xc
 vOemeabXdMdXInSkzaXOQOaF5P.jalYNLhwvVZnw7HyODncL7vJPgRBOixup3yayh.ou3JasdoFl
 MJCLFpgVbg5MNFSo32._5_LdDxaMpMAXlfKyBeDOk60.u.q8zGkm4YtMjCumsRFqCVm0sCemuOgT
 18jWQG0QIehtr5SSE3aHRdXdne.zDiLDoDGK08C519WZ51pBkW48FmuWFFi6ou87wMdK9AqqAG3L
 OArKiThaU68h8bpm7QxqSkIw2V_nfJbpKuY2sV0JvGmDDcTejzCHXRxmEDdWKJ1iTTy.IZFdW6y0
 ZFtKnHeuE6GCB1yGE_Mwg_zg_7oG_7.9YuCVKQUEqpd2izk_8kbLKL1.gB7TjjCwf1QMy9eQTPsy
 oRGffmlk_10PWyJ.UR7Dpa05rROylYGvtk03uzXbR6i26jiExAmcbVT_JNnaq6FAay3aYBfF3ORi
 Oao0hzwjm.cG3ud1fR5PJjRyRmaiIWe.jYDaACXV4pfFlj2LTaWM7K6eatRTLNUdqLQvbkEyVt9k
 gTHnTNID8Fn1tG2eOjbn1__h7SWSofQO5nM9SHauJu1OpaM78G7rZX3a40QtMHJKURaR10Iy9gZI
 KHXVAkoiXoAVmGwhrwQOATikYuBmOkT7UbEUFsYrbgg9CX7aYK5iKiQ.t.FowDXLe8AVrAVQgupr
 JatI.Vl_UvwP_X24gIcxxjPfGmIPDjdFXrbStoTUqzRivx2sH03DkXjn1ggQ65qFToWggiEqa2Re
 Pbq_4KgoroSeuD1Y6l2CZ22E_bcKc3dk_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:36:02 +0000
Received: by smtp424.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f55548587b73a51473c911cd88020c4a;
          Fri, 24 Jul 2020 20:35:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v19 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Fri, 24 Jul 2020 13:32:06 -0700
Message-Id: <20200724203226.16374-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
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
 security/security.c                 | 10 ++++++++--
 6 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 591dae299c6f..294410533b51 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1878,7 +1878,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1894,8 +1895,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index f9a632ae7be1..15a7fb80d6a7 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1331,6 +1331,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1361,8 +1362,9 @@ int audit_filter(int msgtype, unsigned int listtype)
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
index bafa03a5c866..975c3b8c8d0d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -456,6 +456,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -654,7 +655,9 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -669,15 +672,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -689,7 +694,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index 9d94080bdad8..d72af93f8d6f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -414,8 +414,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index a442b8940e93..9a0f462e8891 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -480,6 +480,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -492,7 +493,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&lsmdata, osid);
+			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
@@ -500,7 +502,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index 17d701cd7f69..f9a249a93215 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2542,11 +2542,14 @@ void security_audit_rule_free(void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
 		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2554,7 +2557,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op,
 					       &lsmrule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.24.1

