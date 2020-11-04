Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014ADC2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9981120684
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 23:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gZ/+HO+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgKDXqZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:46:25 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:37851
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730276AbgKDXqA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 18:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604533558; bh=LCB9ydE1w9hHkpb8wYy6jD57eyJtJQ5ce5sXeiV/bXE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gZ/+HO+w7BQqocEnlUfvRIt8ioh/gFredxe+Ja3kaZ+n8r/lYgYFHXdZFpeghIk81e6/qcTVoba51k6pj9W82yrcnyOdg1IGZotio6p2GRMZSw4SyZ8dnRnUY0I6oaM/dBTOMYjqCD48vBxH1/GNm7U0xoHYri5zV/rjKJFal+IlLVhnjfxzX3DMCLr5jQfg83Cz8X2zftTL+OXvn2fGM3BNCrMPdiY+o61emUJlMABzrNW0HqkodE4cFMnJQ1b9fWFVtypCMXYS9YhlnwVp5kNN4nKzh0m9rMZDZkL6qlbX0Y5tF4teeh7Z1erpjM7m4sSB+ivws5rjI7qcQ1VxcA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604533558; bh=1pG/hS+NXpOHsMz7wD5tQTPWY1FNdAEu8otDkklYa2K=; h=From:To:Subject:Date; b=ZSguEc0FFZ11Jg/hTfsxrsG7wExMJmVXNzkZKujXWn9RilsDxwjFIVGldZG5/XS+Eq3znY5xTof75q6wGPJlqpXULuKm6kEN/S7/CeJxwH+JDUx8wcBmBR5p8q8jFQrl3BYyehb+o0wwUWbH/ul9G7LyW9/EY1/MqjW6V+eKkvP9vHF1f6JOI4HUHQms7ID5uZsBtQNIAQDISGwz/JNftj4D2wNfBgnK6W1MUVPD7S6V8XPH42L/qVYNmR1hLYTlUanXfA2VglvWtOHF/8OP+toacJ53idrm8VgRXQ1ZwM0uqBahtK28uGMp0hvhIHG5aDUwpnZ/JL24x1VjuOB4cQ==
X-YMail-OSG: Ibqzj4IVM1kVhtR_ahkb1CcoWFYqQBNdOmez4IRmnmFGnQpje4ojfPmbjTph1L0
 TiM3AKazRA_XdKb2D2tSG5.TwGo8a25c6gfEebXPVMftW1FaOINKA1.yTNtGn1EiKfiynPDUvDXe
 Sc4CLal9KYMckzSHSmfTn8DLu39sQ_4eAAHGUqVfFIaVxmhHNT9PPfe8jWZDVu1nicF_B12VvhvV
 J3H3DXriqp6uD_hj.smMyyYa8h3xPwcNd..O7f_ssbAbgq38Q5s4kz22034zZ_SMhiIfzCEljWtz
 PKkd4HcmUSnl5QXIVqaQKUIxD0sOtZrig0J2grVjGlIYcYQ.k0cZHCkb2u6_Um7M9rukr_NVp3Ir
 2yFzt4ad_ma0y.glNmS7B094B0yJ_lAxBB5kF89XLOf0kJemZTCwVQekMhmsW4LlKcZOuep7AOWy
 Xx9ivavNKJS1IUDJBvAWPQ3ZnsRc4VjLaHrxBES94q65G0.67lkEx4wUbP93vT3.3opuz7DL5VLq
 8vjeVzfDSMVUptI2Svu6s44uh33qpDtX_7uocfZzNd58UB9ULoaxz3yb48ujaM9bGwq_.61GsQpG
 Ee3f3Cs4HkddOy6Kv6OFIUUiWcVrbHpkWvT_Ytgo7VRnqM34U1KBznu0HelSdc0z3m3Cl4hq6QxE
 Y488WrMYgNg0b3aZKd7fuwV_7wDGMkLvJMYO4FyIiBzRevZ3PDE7h9eVNbLcazp7DEtyCPExBDyM
 VhiQTuQHu20sTW2KVBk6E4o5Zez0MlL1LOr4EKc1VdiEi3zfQY3pCVubNMZJK4hETh0echJNN2SR
 BHnALePl2d55EHYoddJDjEf1eeWQZnih9bYlsWi9g_PAHMv7hwLUCIUAKGsI46Js1DfC4inLJJO0
 G5qpZG8QQFleyBP.7RH.sityhbQKo2WBlhgOQqlxyHZDceGWdVsF1Cy8WFrVYiBIKA2ovbcNlBdp
 o0FgKWQFQe5d7koFGbBu3UzqroC.Vd5xxx3C7_PgCZZ1pFb.wDY4rYpdlAntifz8tCNvL92zGtSC
 lipaK_MmokHKWy3l4N7mHSDWEtuX2TDY2B8ZArW7b8cJvQPQ7joDJ6cogYb04cz1eFST2wnSGc84
 1b4gp_7gg5gT93MD_YjkSrbSQ02uHjj3MSP7pHZ_zs8a59cUCNW4baWL1wYYoiuEKBUB8FFReSGD
 wF9.VtplKOQ4j4lrbv7Sr3x_Odbq4joar30yieqmUMr5uZhzNuy3VNxeJt91WQtoklNx.tbOPLZg
 hrcH8_pmWQt8cOI3L06HzPGBPgA3xsuGeKqthhCigd4Cqb67VRXId0vdxnICBkgaHDzeAY4jFma8
 5.JbdkOWND7xyanjeyn1m2PPTHu.Ffy8Uo8T6u6fLDh8PT6pGCBSde9hZskb4vBQf6uUOgJ5_ZGG
 fZRq5a_.0vUJ6CdbQR53j7RvCwOjn45NmtwK1c04R233kr8UAOP6L8HGncGShnmkwr3lMBomHUIN
 5xD5fnw9ZjM.UIIl2m7KniZwp92JY1yK0bXCoc_rOMl1ldUGFHq6wTAPHY_hOu03zFnDtC56HjZo
 B555NnUdQbSEOs7dYRZ1.V52FlTe8vHTa2zchwtkT2B_4sRYFfhreQ0vVnuiLixMlbN0I.qW4SmU
 MT47Mf8LiaIXIerbZBCcIs5kGG4KlOE8DAKRv1raO39dHbrabBpwVKjIdU9tQ2k8Ib6BPT6YaKPH
 y1Oq8WBl3Qv3XfsZs_i.Ji12IoufD.IWyeLRyWB3J_.W_LDT_R5TGfMRUmw2uYlnq1C_3zAKUOS3
 WUW862mSlH.0zLdR.0zEc2idZTT_4N6QZAfOTGI41KBdzyR0xEkjw47w_w9HHyar3L54vO2HnWn6
 IvVh0.QphEsL6IePJJhY3.PkvEjU3eGGjNl5yODVPRgps1kV7iC_lcsvkVRvVzfbnW_4lhP1wE5.
 5Y0XdwiqbnXsGaDOJHrXlsqBoOmhJBwjY_V.3ufLdC0BckZo63ODm1Kzz8NsRFUHt4TU1MiTw0XA
 9GYmXUCK79vLaLHlt4dAkCr0A4hM_RM8JUfRCwHaD3AIwnBINIlV.Krf.5hkIh8s2yCryhwCT.Q7
 ObLxztCYYTgLm119cP.X1Vj5AjwCkMUDDWCbagI6uwKiwqHSmeGXV7emUR2HUP4BPgUUK4CVlsah
 y2fdSsvxZ4xBF7iNeBI3SyHp2_KD.nszdZqEGHl7_D3HGZWm4vWZCGVBiRFsMeS4aIswjIDfG3CB
 SS_JdTY6regehqPS486hYGmuJ6VvNE4qqoaxQJrR2V_4ipy1wijr1NcqidlMJnKuO59BSxiF8NWP
 igd8TB_IiOw5rCEZt_nykSVlKpUUjm7R5GGfbKuQ9FmYsWz50EA34ngstZ3b10k2vudn7mAeSvYh
 UxfT99Prd_BuMObKrxq4fbBPEIOJEy_WxbFYvt3F3oRxzzkoWoiDB5w2IVIT5LEQMfAXWz6bKGm4
 qLAkn0Rm8m15T7Kv7mkUOvef2LL1KMJoTZYnbyQ1lDQlcpxG53ctQheJP2JT6G9gatnmNZgcXw73
 cl0dByS.Gxcj1oL61UTv.KR8raZAQbXPlcO2m1fZbVwYgdRU2GLny5iggTj4.FijUeHO5OAjOjls
 q.bkHpHvQbtDUhaX9MKvFp36cJulWHsu2P6HYxehXyK9cVpBS8Rzf6abRwg.X_YEtpDfDbzd9QUR
 Lq_4VQ5vKBqA3pIGSzGVabzoup0VZmD3a7s2L91iGWSpKpG50purm89G97FI9mb64U1PXZXnTH_c
 WGwc5taiVU2lWgqcJ1ZjLXdmbdQG_EgWfTYkmGe6ipWBu3vvV_HfqSS4V3YtE7S6MgUBF6d9aHtK
 43xP_i3zMudNW04IpYDD7fOhLuHYqJ25biBLbhdvvYpkXM8u4sp5VO3t7cwefx2L1.vhQIErTcKS
 VVeIS25KW9tDM7Pjx3isRywDO9eSgVAKcTEcaG5hOCkMVibdogzHfq5Sb.ug7xvFkt9AsRC2Lka8
 pSgMrsJmAEYQC5eFN0N6bBHSAq5VOoStFHSCU2qnnNgtN_hmj.mJu.llM7f7kAdXt17RWn0o4c4a
 WCrQ6rlyXCWJVKZVh1fZHw9.JTy1EXlpD2CCvOSvrM1NvnXz8PzZiublb17p0my9ZdBxxfPhvH3C
 0QVIhI4KpVtbClmKmzuei.UQyPRzvk0CDVhkX.AyaYRJSb.TKNNF2bdHkVt.RCbCW13PSqTF_E_f
 bgIV1QqLKyPgE8X.Pmb.CpQ2D3_Pz1hfjDXuXtDMJNyolwlK5f40qh6y2OwHpTow04gR_uZpXf8B
 FQMWPo55rXYNrtnTYqJAA4ji8rifpDSHA6bOZHraF5FWZx.pkhluLhjyttIFQ3EsUQaLZotQx_GX
 wyDb7PPXF08Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2020 23:45:58 +0000
Received: by smtp401.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9b9e375e4e591189f65b01f46bb2c359;
          Wed, 04 Nov 2020 23:45:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed,  4 Nov 2020 15:40:54 -0800
Message-Id: <20201104234114.11346-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201104234114.11346-1-casey@schaufler-ca.com>
References: <20201104234114.11346-1-casey@schaufler-ca.com>
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

