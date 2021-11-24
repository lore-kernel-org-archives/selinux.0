Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755C1C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 01:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhKXBx2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:53:28 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:40200
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233344AbhKXBx2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 20:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718619; bh=0F/wOjoDngNIlqzzF/QVmzrHGqxDKlEpuz6LMG+ygug=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gXv9vuXnQZUm5j2g/mX4utCFsc9VuF5nwz10RL8OHqHIa0gpdYKIvOsmuw58cxhZjq/CX2KSMJyxGoXso0zY5++K8YIRTAbyn8j6ns7pyuyrj9K5V/yQsmmUqMlKahURQKNp0Z3kmsQp+BD8a3+Qu1/fBgliJS0g2EflMlvfEznMX0KEocedDYAimPXfCPRMDrcJkE7l2VaKbmFw/bn11dICljbmLEHzdy64w2Sl+7CHJDplFnK3h512S+C/drpCxkZjCbGXcd/axvd+PcoMRfkoqHxPhe3gdBqnd8VGaPVOXN8L1TbkjlaEoz9MO3NVYPfX3+R2zgWV2PnB1WkGAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718619; bh=KUbbNPmiKjUF8cKthrd7LCNEMGftPuH4Ntav/ueeYZD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YzsDFXfd+9cgfokOO/YExdRaPz34fI4j9Hp6sFFO5IPZFVkwFLcPPdm3hYnD6utA+bhAhGVvH/gkvEiGZUICYiJn6E8/bHYYgsni2APHewWzEBQqaUlbwiBauvV4cNkOXLS5tkPCcPMZEKNHL5IDxaOwo9DQV+bQQihW/SD1rHvBYE6l4rc7SWu2jGxteMaC12dsQR7kivDhXauruEtyk93h/ti09O502bv77N/qw30DhObQVupvZsxmOS/eL6WSsp9RiNL+2J7l+KKcucZ995C3IYYltomSCGlwP2zpnl9a0jDtVdGkAKWXvYIph74WSrQGmgATPnQKJCi5xHNNhg==
X-YMail-OSG: SYFFz84VM1mTwyOrRVqeTz5YWrlEf5zc7PfbWTeZr3nX3P5UHt_zHAP9vfeRqnV
 1mS3VvUKUJ1i0WCiM0vuPxNVi3SJOfse0ABzY41USqMKVMVE5Z4.8holL5LfhgpGaQx6e88OqBGw
 QJFD7pbhcfNuieoC4xi32M9XRSDrJna.20cggK2yf56v.jg8PH1AEzv_JV0U9CRgWcn8O8Fg9UXg
 v.nxoVOOv7mfdO9Y6rpCvvJGZvCgsbeSxBtaOJvNUJbDPMi9OCJRho98pUW0XhJ6joln0Q6u8YeC
 GfBOGR6aPa5x6_yroXlIk601Y3O3_Ud87LuLNWWyQ.fYxdIzCSVRTKn_baTL7gTUKbayMClYcDGv
 jfyoO.PzOOdxBcKEBlO6YDshjEoCOFjRUHmTxpoSB3dJvKuZiSq0F1egvddqunpvz7zBJ5jjTgHR
 du2sPsSXr.fQJlJvIaVjNGRKff1QQAHXU7HZDOfjCv6U5EQWhXDcQKeIeYBJ.x9TpbRoFryfTpuL
 dHxKTxYLRCflrJnsiudVvWb34cWBTWc0gKv3qDfsZieog2f6Pur2BPi7vYe8TVKXHlBeoxTsTbnQ
 BfvJmQOG1plfWm7_etCgP4g5reOW7WgsrjwM0GP_sPcngz71QtJAd2WVppzuixbJNG74jrQWmfYO
 wFlVm80buNUQvqEqdeIxJ_BpaGMfJS8mEdOxi5mSyNNa6AILduxm8kUZt2LqVm6OjVOyiB.oapHZ
 P2NqV1H3Sy37jVIgHr9k5EBxQSHIPBiInamJeaF_Cvup7a3.pf7LkDSvMzfP.W1z7GiSI0LiJfrk
 cJwVQI4CpqOMuHYhitYgYrdQDJvq9yIxkYf_0MMytb_HnQPo9kG7uedfHP3AIKWrEuytCduuc4ff
 eRYPXXTCJ5prELuycuMJFvxB.JvyJH1HpaL6hoe9EYk8N.3.HxQovQSJMJhPX8MKQFIc1y.cajJY
 zmoNDFLE9lkfjQkfj9I4C1H5CyZhuBRs1W9Lf4fK9hsScxsrqnHQGf2EYAE2UCuMAdeGKyUo622U
 Mm2eh31CQGyMUVAe2TIY7blXxOuGcXGMr0RN3a8G7qtzt._6Mq6xR0Tifmy6kiBvbLXeDAsPgNam
 Bv794PHcb5i_yLxMoe6Ud6st9KYPzx4OYNuv50cGK3xnSNEk1E3eYSRbjDXaDNTF.PEsSaLNgKaL
 7QdVXgIsm32YT.EF.dfKbrALwU.KAXXy00g769WxVy78kbvl0IjbQzyIjZPs_MbhihWEJbvFakia
 igD7EjKxj86fQNj5K7J6_65ncZaT4og0B87VEIpdFWO6Ta0Az7.BRDKSDKJSf6M_nK_0KLerfrQa
 rMtn8YLeKll.VmSooUj5A8gTZmz5N13uxwRHa9xp1C.lBxdiEYHy1qqcQ_5BMa5HAqYehIJI.3eU
 Vv5Zsxjv7PXRePCgM5f8MR2Qi6EIrKJqir8LNEbEkD2tu7iw0TEi6WclRLdxtcdvNfnMnzodtDh.
 ZY3GacfPFGkL3GE.UAURMDboiW7BnnFZWPempZZ8O4cyF9L1uarau6DFJv3jFnLYfTdwb6c6dVpg
 Qpx1WWnDrHpMuN7Hd0zIMILdXwfkU75DSFCZgdXieGD64ZlucBo6JONUX76MvR3OswLTi40Tnnhc
 7IvaxyzevhAzXWok0gSLy4Vj85jOJTFdhOAqscWFr95GGpQPEA9p4F1pDveTknTGQT0qMr7jtWkk
 cGI17JQDy.Pi0HE_iDyykAvjus10lrptU0B7YvyzS9euI.B5kKRJjjBaGtnoyRg_mFbjguwaQazz
 DFRrU99twLbTrI078EDn6dzcxKq6ePsk.0guxvsV.AIRadPF04U9..onKPZT6m6xckWt6RAhTOzQ
 uR0n44FjPF1GT1eIyjMHfQ4VXEoohcE1T9spmIVmo65CtCf1Jn4wdmcq.Nczyh6YppyOHarVG4Pu
 nv1Ropaa.Oquq7Epvs_U8FtuzaQWZuRWn6wLQ2dTIqMPZa_CG0Ae5Eq61mUG.Kxa6zyq5xDoeP_3
 aiCpf_DzaUTblZF9_z8SpVMEXL7rCENhlZ7lxdJMtcpXot4Q96MUYvXu6.ByVt6d2s0YrGqV_1wr
 QMq41m55CeAwXzCyXPOyb29Nf7iS_Vh6P2OS1aejuAMsgTg14ZhGpl2KGZqSI99q25LEJ10f7Kel
 9YR6WWm6Rb.1BcBh9X0QUsF2wLcTQR6SzqwRRiqplteaxQAUuwC18amkHMgvPorHGjCHltf.bNcW
 3mPaTPTanoR3kKAntEHtF4xiQ4Br1KmTDd5YYMz9fDlgIz_GzM9qDyrAk3TNR90bJMldrazxzEtb
 6kaHeGL4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:50:19 +0000
Received: by kubenode551.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7c0e493102cc6a75e535814ae41a581c;
          Wed, 24 Nov 2021 01:50:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 06/28] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 23 Nov 2021 17:43:10 -0800
Message-Id: <20211124014332.36128-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  5 +++--
 kernel/auditfilter.c     |  6 ++++--
 kernel/auditsc.c         | 16 +++++++++++-----
 security/security.c      |  5 +++--
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ddd4cf48413c..d846d90f5624 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1954,7 +1954,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_rules *lsmrules);
 void security_audit_rule_free(struct audit_rules *lsmrules);
 
@@ -1971,7 +1971,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
+static inline int security_audit_rule_match(struct lsmblob *blob secid,
+					    u32 field, u32 op,
 					    struct audit_rules *lsmrules)
 {
 	return 0;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index db427e136368..ffbd8396bdc9 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1338,6 +1338,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob;
 			pid_t pid;
 			u32 sid;
 
@@ -1371,8 +1372,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 				if (f->lsm_isset) {
 					security_task_getsecid_subj(current,
 								    &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   &f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1aa8ffdae0ad..de22e852373a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -468,6 +468,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -669,8 +670,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid_subj(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
-							f->op, &f->lsm_rules);
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+							f->type, f->op,
+							&f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -683,15 +686,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-							n->osid, f->type, f->op,
+							&blob, f->type, f->op,
 							&f->lsm_rules)) {
 							++result;
 							break;
@@ -701,7 +706,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      &f->lsm_rules))
 					++result;
diff --git a/security/security.c b/security/security.c
index c472cac72641..238541218ca5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2680,7 +2680,7 @@ void security_audit_rule_free(struct audit_rules *lsmrules)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_rules *lsmrules)
 {
 	struct security_hook_list *hp;
@@ -2691,7 +2691,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
 			continue;
 		if (lsmrules->rule[hp->lsmid->slot] == NULL)
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					field, op,
 					&lsmrules->rule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.31.1

