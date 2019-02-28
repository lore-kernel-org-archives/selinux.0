Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD73C10F0B
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C282184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pU9d6haW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfB1WUE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:04 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:40416
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729783AbfB1WUC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392401; bh=oolrFMQ2hX0yuhkjwNb5bUccD/Sys8wBNq/oV2egimo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pU9d6haW4+gGFJaNbvlhnG6fuK7phdzftUWJhdVL4bL4Zho+1bCgW7lIcxZbRsGZOyviz+1Fia14Jj9KA+BFnMCs1RuQ/52nsWjVkMKTSQxUtIENWKvuyadrqRpIaifNUI1xwd/4PAua8qckivHbbj5ARTeSozfD6dtYt7Y7yhalZPOHIsiAk499R7NIEN97QcnHKNN4PVdFjOipvU7S6djlziZMhJPVAfl04hA8IHyf1SHVwfmf93MoDQj5XPAYiX0SIfjQtjo2/MRLqSjzh3wCyJS9fM0lDO5iCDtU0BNwPqvh8v9cW6moE7tbEZxoOb3m4D5rk7mD2UsPtfVE2g==
X-YMail-OSG: Qm2M75sVM1n.xr5RdEsQ60luOJuYDUXdkpAjYHfjB4vQJijRJiaUvy9nqOzYoyp
 C1w7JCfso0jliIkeOT8cLoACeg6qKZE33gjgDzbj0Xb_YnlDE0ZM4ptd6K2l2ntlVJrim1EE1dGr
 VXMZhEyBYaHd_XwSDWLN9vNspngppLVrkhHn7puYNeno__0AW9YdFB1IAmV4Zjm1fZ6b9FeAd5A2
 hp0evIQWYSsEwjMWHeRzkil_jcvTXOQ9WF.Oohwydv8j2Gfq5b71L8pDotyZZsZZjlM42g6kECc5
 iuvHCL2hFa.AQEyJXXWwQlbY6g3vlvVDmX7OFbnT6bWldkt5V8eCLsDHV54dOlJDAqVK3auWVP1H
 _8153jNfaAeHI4svlkYeZFeq7zXro2WL8ye6qe84crNsG0ga98mVsqBnMPQ3j6Wsf_Kinf0O3ftV
 aIx469Pwq6O_cPocxu388GyAE4Xdr.DINFgkNVJSsPql90dKyE4SgtTkLUEQ8VTQ1UB92N3cgtI6
 IhRGkGXV3.34BVN06gm26bWVMt7NMQAgKxqJEd6khz2Io0qQGLMEyb2YdXAz6O8wlGAxyngifNnj
 nZz6ugieanD7yjYsQdvNflkpVh5.eeiiVTQLVvymKsADuzhuisWWgraKClPGZa_Nw_g5dceBiBWk
 sCYFuq5yqShKfqevkRjoQLQbwtSt9RaWSFgjgfm0_ZkOIfMEepMjxlPpK17A77qMeJDxNVzgCiPH
 R1_GESvF2ruR9ilxpZ.NojSo2Z8Iw0tJE5OKdTNjWzpQwawfsmgI7YLJLR60kIuqUu1D4DSlk4xj
 D2LNdlkG_dSVRM1wl7F63dNULS5oL7Qa68uQzJaRQs3Q5.UGwiwTmR_lP6B6dSTxBdnNX36Y49pG
 Pc5XTYdH2epMdB5EB5U.2SFBivPhtzT4Y4pt4PxsP6fx_gvk1B0Y09zbqlbfzL_anrvgRtQUzquM
 g7PxjWsJJITwpvAPb1t7.eiN6n5eTdUC7pbXU.Q0N33naiASeb6qZlSunO_PobMXdnDZmw45qxIS
 SWbSquU501xbg53AsX8RZXKbPM9RVt10T.oy7TpOcVuE0CHX8Z9USvMRAZJniucsiA7sVFEebvA7
 u4aOo_GU85JftV_qJYpB5v_b1gWSjsUf7htGJspHh3taAD.I-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:19:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 26/97] LSM: Use lsm_export in security_inode_getsecid
Date:   Thu, 28 Feb 2019 14:18:22 -0800
Message-Id: <20190228221933.2551-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_inode_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            | 7 ++++---
 kernel/audit.c                      | 5 ++++-
 security/integrity/ima/ima_policy.c | 4 +---
 security/security.c                 | 8 +++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index d6c56bbebc84..07fd36f6616d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -351,7 +351,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsm_export *l);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -836,9 +836,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsm_export *l)
 {
-	*secid = 0;
+	lsm_export_init(l);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/audit.c b/kernel/audit.c
index 32753b1e686a..4b1fe327145d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2104,13 +2104,16 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode)
 {
+	struct lsm_export le;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &le);
+	lsm_export_secid(&le, &name->osid);
 	audit_copy_fcaps(name, dentry);
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 72eb0efb22ad..6f05e96e5db0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -326,7 +326,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsm_export le;
 		int retried = 0;
 
@@ -337,8 +336,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsm_export_to_all(&le, osid);
+			security_inode_getsecid(inode, &le);
 			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index 66f8ee392af5..c2cf82b063ca 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1373,12 +1373,10 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(inode_getsecid, inode, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(inode_getsecid, inode, l);
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.17.0

