Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B3C5B578
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE4921882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tNmXiDhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGCV0S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:18 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:35137
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbfGCV0S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189177; bh=uxcHwgOpzC/adUgk2d3S1gEWM4FTxZpivBefUTTskGw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tNmXiDhs9Jm3GE5iYggTxeNhQe4e1Fv1zVQ32/JaJpSre87SyBOUSzIfR2fiU/OLXlbLnTL0jiBaXjk/LVNr5Uto6Ou9M3Z/u8nF7ke8WYtQtIAbWaTf08/r146RvMxofEF2Df/thb61TNn5eimaOdhEOQYXCoOs97Y8gNR46E+5fgy27L5XRqatt1zCtC/xnUw/wHJdZDDjej9evCUTN9L3rqh2s8BwWlns2RBD5Kmw37rs6lYAyyqRwxC601aLv8wrXVgWkwPQ7wM5j4x0ZIQGUlMfQ0kRlKMwJ+Yrx1ZKUDsreqTumNmp3o80pUYjjZLUQb+79+F9dFpObMQfqg==
X-YMail-OSG: hper4X0VM1m5MOsbO6wxVym83SUkVUiWhiif4wJFQBENOnP4nOMfKLEA4nWmpGl
 VNbj2bWbKmull15QNuia.rO91eShLaMKiYajp9XyyLKQdWyoHwoGyGT9_OU1U.rClBPAS4eW4o4F
 UnJF8qaEE533dO5In9AUOoM6Py9GV.FDSsNhXBcp5gUURyb_t84vd1l53QYzzzuwVBCuSBeLzHcL
 d7eUMCxiri_mYSVF08xN5FIZ4V3hnaSr78oAt4OKFLirVTk2aF86zHYQRqRVvTBWIrETpVStIasl
 GQMxv4NQgfYHumaWO8dJq.NEpHHwVvginm_.eD0ThYTqRJlWX5JW8P_.MKpY4UJNQOQBziJRQZCm
 JGpVPMqyVV2pakLQsNoXY2H8TcWYUZ9Q.pEO3Y.8AtCEruk4jY3Mwf406tnwAf7Py.WikKLWQddG
 S9wT5IMXRFqfLORLqIiXRQ3os_23xSFnOzbsZ8emtjuKMVM5pjn.bZKOinhaUNEYJ7vQkl4yByhF
 WYJkTqmmdLq8ComHbe73vXNHHu3EdWPsBG_fWjCddpFWNlnbvZMxIWffHkk.VkK0XfBTqxE_JJwb
 L4rHP2tIOl9DvOhI3jwqtqy6MjkcCgNAUORsNJDNcys9gZxUg3emILqOEqBY5HeuDUn2tB_Cop3c
 IntWDyZqb1QMXQkX8eL7_gM.eAM1zVlmYfMIhR9hnqAcOfrDtwIOxC8K55yIPfVIZcHuNywtPih1
 fWKGz4TgGSFQ30AtherCcqApSpdysQZOtOTIWQ2yQ3E_cwGvCLhoiWHam4mgFA3WE0ww_4.HAvoP
 Rpv.TA63CHMo.Pltq.AQoPBKyVJNLe6laRylE4g6HQw_oPzYQbQ7yQCRdyNK8Qc5YBMhP3UhK70w
 FB1fRRbPg1Q0z.2fLV.dqKz4bb9ThEJHQWlR0GIvXd9_WndijSNlAAkfMh5CiDcOeTqkIvMVxSIf
 2J4lVW6PxRMNGWyOh3xtfIgyLOP1fT7Q_49xwmbAoVfgXZytZ5.pxuPs08L6kkVhzA6_AQJlSUmK
 1wRE2nOppD1XNTFCAwpWTYMUUasc7_z_.4LldDFi_dDMG1QWewSkRbOp6YIkVnBAO7nsKU6G2WrE
 OOQMwuH5gQ1ozWn3CyHYj9MACVuc_4ZJhvurXDP8Lj114QI93k3b.bo1vTCLREJDUYDv2804XyQb
 426VPoFHwBTq9dSv648tPvL._xJw_EnFJHa6Q1osBnnJIydMC2J7nySUsxF..TGZrQf7eN9uKP42
 r9kiIh6n0n6F30yb3XSOGG75Q.gvwL9aGi8i.Jx07DSRmZvxQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:17 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e093f62029a4b38b2a118356b3265900;
          Wed, 03 Jul 2019 21:26:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 12/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed,  3 Jul 2019 14:25:27 -0700
Message-Id: <20190703212538.7383-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index cfd7cf4b0be9..2d81cac418e3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -362,7 +362,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -858,9 +858,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7112fe31684d..54797c0fc3b7 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1910,13 +1910,17 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
+	struct lsmblob blob;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &blob);
+	/* scaffolding until osid is updated */
+	name->osid = blob.secid[0];
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e7b8ce942950..92ee3d984c73 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -326,7 +326,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 		int retried = 0;
 
@@ -337,8 +336,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&blob, osid);
+			security_inode_getsecid(inode, &blob);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index 43076ae0373f..745e8791b6e3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1404,9 +1404,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.20.1

