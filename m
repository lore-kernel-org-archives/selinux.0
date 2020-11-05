Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E611CC2D0A3
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7867220BED
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mqHuRsVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKEAxF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:53:05 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:39739
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387871AbgKEAxE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 19:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537582; bh=LCB9ydE1w9hHkpb8wYy6jD57eyJtJQ5ce5sXeiV/bXE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mqHuRsVt5jaxZfWDtbNnIfXq6mHqXI/WZp7Wr3RrQcXypZ8CLC99N7uQlPD5vufsoygrulJ2Q72ajKuPlD7rZQmH9VgB5PvW2sxRdIuOVkU4Qdzhi/t7qRgHxcPub+p1s542PA8TZnBvF4Je5vzh5aope+IGBXsiSI/oObms8+bvufZWvg4dFt6+wxVowoxkccmGWmZYQJ8sRCiskHMPVBOKw89GYlrsf4M+VQNI1oMc2LN9xUeNEFk2JPus/v6a6lXqDTFsJWABepGrWHmNnDcj/xtT01E6XzAuB4eXO3IyrCO5Y7KtED1QNgbw3QQUkDA6sX/FrGGeLri1ocu58w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537582; bh=yT6ufNc1WFDqB7VisyASMNlomPVSdn7OPY+WsdwMays=; h=From:To:Subject:Date; b=VTvBHl2hu/fMi4l9hTTDa05pd9nwdPI2XfNpzGkjcNtFfVs6su3DIiPSUhtPRzIvA14HfRqPpnDdJ7gvp11zbtY0CKIffM/ThIGjwDytcRRzSpNU7ubchVA1DUt6Vjsp393aAqTYwSZn7ZOeEgyQV7N9CRabWs5kJ2qcfgne1s2AKhkfsRJmq81ImUgW+ibdAaivknV/44gLJxaxgZO9g984jTm32OvMZLbpkhZBbBM1/Q8e49pcvrVBW8JnJlqngqOlPcMFBw3a/1KX4JHNgnH8bG9kVot1T6/mMznPOP1DzfiOTh1+Qwx9u4ZOCddcTaWc0eae2pxeRKiy6/457A==
X-YMail-OSG: kkSg44UVM1ny..rNG7E4Cp8vRNvKe.opZXpUK3fBsQTRLRz2Am6zTnZcrI7nwB9
 PkliTZ3kMuNKgpHqjjzuiymENUcwBOYS6JLPimfqiXZXibgDTIlJ72Ktpfpaf8cQIP4iR8oZ_YMw
 GUWAdNlF2hAkKscCsNAkCjgTYJPlhwSiNI6aCvJCOLAYmHquiJXuAwm2I8L2dNQAA4Vqweppeqxg
 R5ivwPlgzZIZx6t_6iMmm88YiI3aURYZOKb6VFXU5AMeVMYEXl0ZagFedIDT.WfhI32u2o5eK._M
 zC3lmnDJLYg241DhkPu.6.BC4iNo77p6j0gGlYBHFiDiPOuU3Rq4yaOuJD.vEZSDLVfDs7Qr0pOH
 gLucn9iSqVh_LffrjoYfRIQS6r3S3xPyFTnv0UOXkO1KPDyI84RoZOtI6_JbSmtPS1rxMxVHJJcM
 ezAUt5rEEkbY50a6bW_nz1OF7.1nzB.7UD0sDqGoPF8x9uGZltdKa.FZWNGIDZYBFXLKg418zYDs
 q08GzreK_.8RAIRGgCicP1yONmmu4796iIkc9pRLwx..UhNAOVFC9PZpNKonWzi9qm5hvER6bzZS
 MFFHhjT3D5oUwVpMpBKOPkqRinl6G7EMA7xMlhjgGf.Js9pWHFwjB1wHRy3.FLdnbnUmOS5.6t1i
 AQBWfpYZVxQuN5nTO.M45LQXi6hAJpeDKzY5oBIdGEpT5HXZIVHyNxsTGU1Jha99y4lFIKXQ0UL3
 PKj0SiM3K66OG47GmAG6BYsUMVrEL4K2etNS39Wkn8mwlhJTomJojEh60RendueVXxW92nrbbBtF
 oRbEIw9nQzKE6.Tsv6YM7CWeGKXQ4hEl03soec7.8P_q59qpMTMxrocyIafllRkxQYOEMhD9GHAj
 IcBXzbKi2VP8B5i1.0XDTBJL3b8Go_rToLbYlYKKaElFbyVQGEIeL0.44Nlk5O3IkPi3IZUB89tS
 I072ALvF3LTs64MyyJz87AbQOXWh6.qcSPnhj0zcLDuwEaVvnjui1iDY5MOkIdiimBwCSTGoT1ba
 teaTS93wzPD1dz2jMpQjIxQOQNcd9Nb7lLThw3MWuvn57_neEhHc5orYcb6m0pTq14wIcjnXKOGN
 isUeVs8Jd0SOgWK6FD_0h8HgqdgzAZUJMvjVoce_cnMpD7ZeW5FUdjM7WlnI0l0nYUMT_GOwoDhq
 5sR6tyu3mg4ufkWp1UdMImiSRuuVDCvyJEJ4Dgt.iWF2ASDHTHNKtNGGFfj4PHlWFl6veMKd6b29
 bUngr5v1KM4domSVKdT.CnTCynedQXBEjJ4qgR60HBVEUau0TPDIsqOBEd6wzybuQDxVPtmzEWdZ
 pfTRVJTeNUkMG2Py_eVqHchxCguFUYh7_Uxx906RinrCpjc472vUbIGmayjlxgzP1I2G2c_JiHfY
 DSTukqErpZOpVyPEgzAsylZ89tt_bfD1M1rgAQvPhmmrLCHhfwVV7HITFJ97R3WLvAJEqcGQl91B
 _b9qpvNIN_qL29pC9e_T7B00YTags8J0lvM19hRZxnWXlUc_c0bW9wyFkHK7eqpqpWItnBnSwX_i
 lGIQy31fevoWSIYy2ZPCc6ylbH3Z_yBZT0CDMsQ165D8MmMZO3K2Q_GSjh2bL37laBWfm6Wa90gU
 9bSVkVeDT3JSZehcz1yyJoZVRJSD6MMwsTC3zgd4EQAt93oHmmNQU.cnpQ_.vcurUKjnXgucwS.v
 4l6aQCC9OcJ5dT_Gvw0RCrOoQy9F.Dhaqtq8vPwGd3RcmI6U4VfYjtGaRvyKcQI3V6TIW._ygtje
 BSPWmV6tGox1M1bDvJoNysPjbQIaO4TiefiKkdewPOAaDwji05qxQEecRBg3K0cbwdqwYM5ocTbI
 so2l3m.K5QJ_Og.NOK9.YO2ZB26ZyYwvbWgk4OGEKL8xLJD2yY8xNEdBmHGLbzpya26w.s_.B_qP
 pg.InpV1GqjmiQVgaW.OxlE5_Yyf1Uyxh0ZGZnRcz2CD8_i42Q24YwYAo0XFF4gMof4oRu.ghE3z
 CBfS69FhBsoAgUxN26FWQfn.AMRdRKUt9VCabfZ6Z_qC9mNzCjaDxXyou8T3EyrlLjPQA72sfUOT
 w4kq5xyc9TJ7usToOkDnkZUm6eThThV8ctWMpNfJXYUBoAshuAaBh9hQqP5Sa77.UmJQ.Fjeuv2_
 kUDzbsfWaCJ79l.guB25hmR4lcrSL3ly6LlkipGYwfdseVszfjShadEZdMl9NL84uezfN9zpHSfv
 jYzZ9ZEJNboYExVfPTOtEQ6l_mh3MrC2Ccs43spdA.6yH.nVS_7mRNB0cyoZ4HE7Fvy6Wc4OUVFT
 G94cMFxP8mAjabw0ARGAKX1DXXYatV7CIx_klfCwDMLlxX49VmNnIjNtiFyTcYzlVLdZ50P5GMLR
 eq_LtRz6UJEAH.D5_chnMjLmdW9tAdGNwYAZVtC11M.56qy.mnKvEeDQwaDKYuDPZEI2TJrf3xNU
 Ne64BtkfCNIpowoWN6T4vpRMfuI3.0djiFBm99DIJADMRCfdIRDNoXwsG2CbQlc2AqD1Mz4wGg9F
 0YaPaP7yEE_27QR._kif.d4CODPWPtmYccMWutIsQLLSop2Wv3MrG30rTEgeX.NoIz35PUx1c.6j
 u7R5a9mD4eMB.Q8PrvXeeqFG3682Xn4HnvTdCTPjSt7yUPmzxQ157ffw9ZR3r7UpVhGeT8aMuLlP
 27_Yk1lLUtUNSODyg6fM_03GJJQtRscIXgtDPNz72h_H1fHoy_PFSFExUUXd7AYTLpQO7WBpB4vb
 4usxadrr7khrteWKZ8oVb9tI4m5elGHFhBVK2JoLGPSwtFsEB3QrCp6N7fFhOiEazouXwNHZld0H
 Z.iijGyou_WlUN4gErjVRd4MxDn2oSWykiGp_ze7nYJrmgH9d270DFim6Yszz_4c.OQk5.SeabVt
 8P6PMI9dk3ydXg8.TUWZjK_D6RdB6G_Z13dHTserGO53MJXHs9pLMG6P6Uei3ZaSuGExCRJ7kI9p
 BzUvcWoREkQOx5LE5BqhiLDjMoG7Bp0IaPXG1aNRVD298789kMc6xAaVw4IL08xTIXDDeZmFXGn9
 UuryYTw3Wjii7LiLlA47DzcyuDYfoNazuLyfU1l1JKSnZtfqL_CEQbHMnfO30lJwlFe1vSr8oYKB
 Gyc2O8T0lwLYxKogX_ryLLZe5_95H5teUbhSphkyhMFB9O7cJ.GOyX75EkrVVD._NMZbipibDCfO
 KgO2iws6X__AuMlTpdyxbN1O8DQi9SAq1UPUWgnFjoVp.zhRgMGg2SAuoOHFU2yQ66dqy9yEcho0
 bZbwqivCeLWCsOwDw2.xtCDZz4jXt7NdDi.afcZ.HFE4DcPOFzhmtb14w6P6afdnmSznGkLhRI6t
 b63eB.rlQDQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 00:53:02 +0000
Received: by smtp411.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a458fcfd281d572b410e7853858d8d29;
          Thu, 05 Nov 2020 00:53:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed,  4 Nov 2020 16:49:04 -0800
Message-Id: <20201105004924.11651-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
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
index fdb6e95c98e8..89c538aa283e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1892,7 +1892,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1908,8 +1909,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 45da229f9f1f..e27424216159 100644
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
index 16e3430f7d07..7dd6b815a9eb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -474,6 +474,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -672,7 +673,9 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -687,15 +690,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -707,7 +712,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index 38043074ce5e..d7fe1d5ee8c9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -429,8 +429,8 @@ static inline void ima_filter_rule_free(void *lsmrule)
 {
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field,
+					u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cd393aaa17d5..3e47cc9b7400 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -562,6 +562,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -574,14 +575,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, osid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, secid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
diff --git a/security/security.c b/security/security.c
index d01363cb0082..4ecbef074809 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2558,11 +2558,14 @@ void security_audit_rule_free(void **lsmrule)
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
@@ -2570,7 +2573,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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

