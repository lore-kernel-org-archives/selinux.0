Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0F2C3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846B321874
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Tqt1IBzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfH2X3r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:29:47 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:43731
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfH2X3q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121384; bh=CbZU5iRe+yH1VCf2y2WYC0jsmwdjRjXMBNn1U3uoaKg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Tqt1IBzbk/pLGUoVSCfzx/ORlpWR1yyaQiPBZsPxMiimt8XBAtOmbowxiDzRzWxe6JZQ84un4gtGs5WfI3t5lyC9tggva6DXYtrK2kZSX2/LiOn5zug121J42cU58jmgqUIjFawFGVmZ3eoF8lH5TCioPxjUlFbaA892BHNSn+Jlm00LEgKVn9Kyj4o/c22Qz8myG3hQ/vfuP1ZALi/cPaHLC+v+iCEVyxjqyFKu9rduEzsiTPPpw7OE4dK3CQwQN+ELPAtd69wizQXloXW22UmLbBVT2jRYXgqk+CY21hsF6CQtxn8F+xgZXUkiH0pJxHfNtztsSmpH0LUMN2LSfA==
X-YMail-OSG: LebIsRwVM1nlGeAstWLDnX_6oM2.Vl9337O._Svb4NSYvdf0Bl4OqSn5E1r75aB
 rfD_Cpn.TF6Btdkk5J2ca7vOVUUnrQtftNVdOeOnuqqRe35b695lNmnQ4BdNd.II9OmV_bVIGXey
 rrAhZN7To4AyXbJ_qg2YjHMk5U647hkgdhJ2Y7sen36tw.rV7K8i0P63OoKCErwBvJbdbC3lBsX7
 G2azhpWU0rRwRJcDhaxnLpZgdP83JKCNvg_LlGqZ1eS8SUCq9nDRCWhNWdf1GdE.kKsWbMdrxxGI
 DcMoGg6dSYHnEJ15sftipz6hKY.9wk4R6Gda5y879rRaoesdtkshQ8OXFD4N9Ua0v0AZKD6C0kDh
 oZL9Wpw2YnY.lplwGD8epo0d9lw5DF7GLD4POpHjbizOX_0Grg07WXJDAE4cKM2RVYBcaMPuedrM
 ysQcBeQ8Td.8H8E_7P9hqXLsNULpGgAt4NGBnzb.8WkK_qqll7FpZCoj5P_dzEQW83JlZR5aud05
 qr0Bblwv7552D9EK_gxgac0T7EzHMHfcAV71.WUAuHBA3hFaD_XKAVMWfM6MKQgWBsVIJzHTuNFl
 kRFqIbCmcdpXyOwEb8L.AgYAqgAOl1c7Q7XkQW5ZErjXpw2WzK4qv0kW3m9TjfUo6_3414LBeYw7
 7XG8wKRDFCSHF5.9Z7jbEuEOoCuDI309f7C1ZQLMjy7mOB7E3X80PO5XOpuu2WpKpc5aK99NJDz7
 mMD4m7euO8SrXTHbfGDXRaU2DpeF6.I_AIgDF9sCijNPPkzybv2q33h.pzKqQoAzRF1XCfwlPw0.
 JLlaYjKQTH7JMqbjYy.np__KJ4vFdCP1hY9a4F5Rd8KhU8jQ6k0ewlSFIWHODJzw_.3Warm1nW35
 GeO3itgLZFur5Hs2wuLVgslhPpqkH4WGdkRpBL3f9dArcSyM2.dV2f9aQYsGD3Za7QpfecnUbdCR
 FKza1CHQ20_IS3i4gJ8_KlSV5UkwAcb1_UmSq23FGXYcs6sJTO24w_93RIZNfhwazr0IBuwJPn7N
 Vo0J91ow8DGmZh1ecOYPgRuttscKbZ8kCKAeiosY7G4q3MUxTQpzP4ngsFpiWJNhEj3x4NgVK9G5
 Z0zXCmk7ZmtefEwYeaqQ4DfarJ3pv7rJhQSvXroyIeVnfJ03UAdU37uo7V3W3ax2hHdIdyqfDC1x
 r3yndxYf9uT_AuDEk2gb1w6ZFstTcJ.jViSG0g5DN1Yg_.GRCvmFI6imFLMuQ2gtAz3ZKQ0Q0sUP
 IYC_iDPvsALxFpD5nGsMaMKxgq9CWuGszeDTS4t6MbITzhMB0hIb_3l2WKyXU2tE35.aa1xc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:29:44 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ded9e12cc42d2f561e2af538140d1439;
          Thu, 29 Aug 2019 23:29:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 05/28] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu, 29 Aug 2019 16:29:12 -0700
Message-Id: <20190829232935.7099-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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
index 5bb8b9a6fa84..4f8b478bc3a1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1761,7 +1761,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1777,8 +1778,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 63f8b3f26fab..8786b95b60bd 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1324,6 +1324,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1354,8 +1355,10 @@ int audit_filter(int msgtype, unsigned int listtype)
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
index d1eab1d4a930..18ee5556c086 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -630,7 +631,9 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -645,15 +648,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -665,7 +670,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index d213e835c498..5a337239d9e4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -307,8 +307,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index e0cc323f948f..e7b8ce942950 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -327,6 +327,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 		int retried = 0;
 
 		if (!rule->lsm[i].rule)
@@ -337,7 +338,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -345,7 +347,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index 27e2db3d6b04..fa6e425e6f29 100644
--- a/security/security.c
+++ b/security/security.c
@@ -424,7 +424,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2433,9 +2433,21 @@ void security_audit_rule_free(void *lsmrule)
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

