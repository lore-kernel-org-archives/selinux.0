Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7795C43215
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C681206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z131zVH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfKMR5t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:57:49 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:34630
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728394AbfKMR5s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667866; bh=5GryetjHS9DsS6NvVDShqBlcVkATUSaTt+1DCEu2n9w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z131zVH0GeDHuXVLHMB5roZr+gWPnsyPGRKsaJuC1OvXE9ZrNVWpj9aHWFONg4L0BdoPOmzG8EbwxRhlwh6LwH4jSZN6WcJoS+lN7jka3XWWf+KzZt5XxwZ7yycoVg4CvbzrdPaBiDlpZWmtJZueebndDQppYzC9fTSQQXft0o1g1Bet/Q5xLdpwp1mRWFeJuK/yHJYjyd0gl/d+faw8NuoCqXCnBxK6ELEI879YKvhYJrkMCjxnkSCeLgMRWbzUF78ocCDT+wphoagiVYlfPt6/p48duKW/1YULaRvM6qXc0JkQy/qGf9SFbugxdYNOUAlHDxVhdBb0Q8PCi/82iA==
X-YMail-OSG: 9GansjIVM1kxRF7ykXVyT9f5cdUZr2MQUT2WY3g7dJxVI_7l4G8X9ZquOWwPsof
 savSqTZ82YyvDd93CbVasMZIT0P8_ZYz9kJotfmwAvjQL_vRitPXkWFNhpAQdLmgnfOcbESrNj8N
 8Ekd3gW98ydvJ5byf4uFBM6kFMwkWKuc7tcOeZDRpADEW8.s_7api5gxtLzem5lTuRsoA4Zf0Zdq
 maa.3xyqmEbLEo.Du6qnEzah2C7nOAx5hlxkde7xCkcmlMuwTFAvctkd1jauD7h_D3mw18oxyGW7
 2L8Lwg4A0N.pKo6PD8I8hqk1edr9_tAHYc_p9pG8jnSJXohySwn4YLyoHKhTcbSer3ocbHoFuL4z
 lym8sPZ1piiYBVyrItMN1U9flQKBDCiN9PiRiQ6yw1oTHAAAkVKJfpk_TitRBqn1KTFC5CO.PJ7R
 unia30ABxqm3hGBhSO7VYpj5igUPFSXZAWQSjpJkaLiw83u5Ncg0pQ3WkDKvktCLwag3EDexmDT_
 n70XUwwVyh.2xQcqub7jXA985wseBIPr5eKSq1KIjuokZKafLc44Reyl0yXGDAFUZwX.q3u.0yRx
 ptKgif9KjieVYIGfSacBt_DzorTD2ixZPoVqzuKkY1S4fW92nwoVGkcEuwpKuQa3BtZAmjv8APky
 hpBzQF24SWV.N2.MB08p3iEaBMoVu.SAhNalvhIGxd.JYFxobFxAOPz_UxVsUHHrd6K8ENVdqZco
 NxqT37EdWwlOrbz5JTVRrGEVUq6k8jKQyASzCAh8gqQZ7_zkEXw4ir4w2wadzn9vXiivcO0cOPkY
 wAPDxr7Vr3kvwESJxoLIN9rBNivzF8Yfoxz4QqYn9VQILyAEagLZiUoiNi.tSVNT8kjkEEtOFmLQ
 xlvj_.0YjuPJmwRwsbZEbxf9Jx7KX_t3ZuhkI1dxQoE09qvtL2tUR7asMwQzs9aokZEo5LYNNDhs
 ypWVAqBqRtuGk6Fvzouu5ojtihP2joEo4xAHup1qnP2jatGEaFnDs018u_tt8Ypjq8s7WXcZu73T
 e35Ky1vPkahLApd_Lg.6uNW.fFdKQVGOBOtXhN190noY.SU8_9v.5kmmYVmRPLDVDe_qH5hyiyyO
 RYrmJeohR__FYru2RfzPIr_95KnT_p5UQtS3J_nLnO8sGCX7zhzD0ziVQj9p08eJRCC_VBqoQa69
 6YlLhM685pt4s0WYaERO2e9GoKeJX58PsukYdmPlTPTj3v1woZbFieXQbXjPRtdBbSnyo9hx1yjE
 jocWotLwwR9FUtBAwOW6RcA5gCuUP0M5Y96ccZPabOr1PL8e8v6cUZvdhKVc8RH.IsVLicch8vRX
 HVsftHsABl4nyjtNzHUJoImfbf_I8TqgTfncrn9QicExFX9cFv9EpTwFCtufjopfcKkWdOgDsuT2
 M928KKubj4G5P4gurQMJlLR3jeupDPGfFrGjQ7aiKe9UvcKwNOVpI9BAxg5rniF_hW3K3nNs3d5Q
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:57:46 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 86d8955fc8bdd0cf32fd2f9119ccd325;
          Wed, 13 Nov 2019 17:57:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed, 13 Nov 2019 09:56:59 -0800
Message-Id: <20191113175721.2317-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
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
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  7 +++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 18 +++++++++++++++---
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5eced28fa0c9..2df58448f1f2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1835,7 +1835,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1851,8 +1852,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index b0126e9c0743..356db1dd276c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1325,6 +1325,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1355,8 +1356,10 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+							&blob, f->type,
+							f->op, f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..7566e5b1c419 100644
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
 								   f->lsm_rule);
 			}
@@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3689081aaf38..5bcd6011ef8c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -370,8 +370,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index 5380aca2b351..7711cc6a3fe3 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
 			continue;
@@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&blob, secid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 5f503cadf7f3..7c386cbe4cf3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op, lsmrule);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.20.1

