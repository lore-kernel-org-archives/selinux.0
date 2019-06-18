Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E70EC31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F042080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DShEpfUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfFRXGN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:13 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:37665
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730782AbfFRXGN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899171; bh=EJFDIYxFOn35ngfdlnRxVIuuOKU0I4n38gUvFgdAnKA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DShEpfUf80Ae+u4gNwIe9pidrGiMsOkRN1FFUHEUVqtPP4PDsAzzTHzpBm5Px0HD/yn+mco7RgJ6r0YLmwilb08f48RsG/+btdOFs8+/OB5qLNpZfTpI40K4WpV+LgnrvMm7kkju/Wma7uos1t3uHcyCanYyxY/x0CfuF05uVnSDgUHr+sWfGr4H+/+mNmbk3ILp9Zo2tWZnkswCqAczDzWlQPpBOprOGdyTU/6XitjHCNWLBLpAgKvGYhFVHXUeCljPJ5BvxssOLWGh+lGY0R0+DiSfyuTnzraOHaaIsfHR2YXzOD8Wpqz1rkEOjfqhaVFf3veOTmOJKY7GsRuOCA==
X-YMail-OSG: yYGLDGIVM1lewiE0kLAQ9OkJip8UWZeAUMzxbB_ZIwH9THwOAtMzX.9xR2ivK9u
 MFzCpcRshsdWjG4Yu.xtjQNF0G.t.QuBhBSZvpbGxQ0XTPoxwHi5ko8NZVA4CJ6HymUaKlbYoNqb
 iBC2DRM3Dx71H7O.DYBlsJfi7rjKlitQCdrSWI4I3DRYsMmcL38QixH21Vy_MxUUQtsopssAND2U
 TGYPsb3LZuCOjga0BiwFcuuaJAo1xQ2ZMx5F4QT_W482DyhXCjdb2_9TY54KXhXXy3N9.C0fq02h
 WQ4.IP53kIjLoro3Voy6ZCKXzSCVsQMvUWEhJdpIj.n_1.Dm4Ouh3T3OY8PB96Nx_iFOEb4L4lHB
 xeTL_Q5GdQwemKT8FJCUbG212vjyDhNWI3uPqlmrYai23rOBxXaCr3.UaB1mdhL7I50E7DNRS_Wu
 cTVNyF_EBbAr1yPjjD_oskMaNzXxUydDqXVbAxo9OfZiYWCTg6xf18I22y.RAlzqJPT3LtyUFkzJ
 OAhTyT_SnQs8GpAKQx8jPWyMcs410PXqpux3eLKe822ZjOTeyYN0RIoXS_K52W1Jy7o9dtXE4BVR
 XrFIWSUqJlrKz5BdBlFmREeQcAwwE9b9iZcvvM7KYPAtmelNO_Db1kI5yrgdJWp5SBaj8BHgFcm7
 7rifUQszu8X1xDCDVHv2nRscpiSW1rQcIT4_mlPnCguRbrdPWW4PnAJ9qSSj7wpKuAWZn3ZcLAmm
 VpGa3N9794PSzCTvNH04eWCGf5RDvDCRhGTMZmMY881nluKnwkjqKEu7ITpQDg8BIEaQWerkEvJz
 7ZuPwHQoVuWu2JFckBxTSCg53S8.tyD1cHkYOvLalLgfxuTR5xax4E7wFMLaZJdiiZml_6lc88CN
 8N9w1Iho.zWbj4YA83UqhJ640raQCKOqvr7WntX7M5AyuSg0LGGJ1CD5pg_fq6h6wWCCu5NtLSZc
 y_7qCgiMtXSb28iv4t7gfVVzu87_rWed8uB.DOTr7vkZ1NHGqEvCVIeR6PCVQ77cfAL3PRodYcWJ
 _M2y6oVYDuLJ.TETXAkEI2fDX1SiW_zFQM4pI2uNrdSjJI2nfZm2LX1RRm7fVb8NYccNoa0Kwxp3
 SUBKIZQxTyqeE.PqOkITTCjTg9Wy0YwDcX9dx3wYakeBp4RxNAQE0JTFK519XTPv4ryojSeGo3mQ
 U6MeDqNWJ9RTQ6O8u9R_olIeDOekEg9Dssqf8V9B0gGoijjeKrRdknVh2VXkEZ73xbg2KMdEkvyc
 YgUbZK39wbJt9WyiT6SSsgAPzzOu9n37hebED
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:11 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad2be8c6eeca573a242b1447ca635ae0;
          Tue, 18 Jun 2019 23:06:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 05/25] Use lsmblob in security_audit_rule_match
Date:   Tue, 18 Jun 2019 16:05:31 -0700
Message-Id: <20190618230551.7475-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  4 +++-
 kernel/auditsc.c                    | 13 +++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 14 ++++++++++++--
 6 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 28d074866895..067fabc63e51 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1757,7 +1757,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *l, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1773,8 +1774,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *l, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 63f8b3f26fab..934ceae1ff70 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1324,6 +1324,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob le;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1354,7 +1355,8 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
+					lsmblob_init(&le, sid);
+					result = security_audit_rule_match(&le,
 						   f->type, f->op, f->lsm_rule);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1eab1d4a930..93c74205ef40 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob le;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -630,7 +631,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&le, sid);
+				result = security_audit_rule_match(&le, f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -645,15 +647,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&le, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&le,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&le, n->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&le,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -665,7 +669,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&le, ctx->ipc.osid);
+				if (security_audit_rule_match(&le,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..fe5e921d621d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -307,8 +307,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int security_filter_rule_match(struct lsmblob *l, u32 field,
+					     u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..ae525a89e07f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -327,6 +327,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob le;
 		int retried = 0;
 
 		if (!rule->lsm[i].rule)
@@ -337,7 +338,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&le, osid);
+			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -345,7 +347,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&le, secid);
+			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 5aa3c052d702..45541053df89 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2447,9 +2447,19 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *l, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		rc = hp->hook.audit_rule_match(l->secid[hp->slot], field,
+					       op, lsmrule);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.20.1

