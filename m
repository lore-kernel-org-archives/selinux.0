Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A174C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C6C2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m+6x4nqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDITTL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:11 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:33034
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbfDITTL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837550; bh=GPvWJDPXSClM26o50qIJxfLTG9C4Dy1cxsnhyj+//zw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=m+6x4nqWu0WnUE1/B2PO8l2fj6eWP5iMIMQxef05FgrhKAlp3mBNYITqLc06W4dsYhg2+Xit3g/OOPcjaAyfjiEGS4DnhCF7IsWswNtRmzVM4K0veqqG4k8kAY8r5C3qPH4aQTxFsU2ByXmId9ggVL0gqt4ATEEhfeARDnI4NnVRyW+Rj56kRPZoqatkNWMw/e9hcHr02ObEpZ8+XCNQZs1L8Ov/2i0S/gEfuJVAJ1hi/wQFzORerBMKb2OuJnlQssut/dt9sUgUF0bjVhBPKKE+uizUXSXaHIdRq9jNT/BiaMO/sr4csLsh5nqJPRSaDKBql/rxywHnOtz7ivJT5A==
X-YMail-OSG: ZGHeldUVM1mPfGd_lgbA.9D9ejeUBvFMpwEaPcdS3uvnsepN6iQifB1.uG6P7CR
 vlP2dR406II884VsZyoStBlqlgZdjO2cjI1j0AbNGu5bsCcry1gTE3wtNndnOULSzI8eW3U.GrFB
 TOSC94.8akTSUYfE3euK1w3zVONUgRtTGlzFMv2j4_jDrjXdg6DFVy_eZEuvu6rweIvBulWWorwJ
 4ModVHQECQ7Nq.t_rjX130Dco_0FQKKIY1_uSOZxsljWz1jPqqYaHvJWEgoWsT0lpNMAGMAKvws6
 ZEcbDnOYmGkIv10w5zkvJsFtnlh5M.qC1m3_EKoYPE3MZ1FjrUu6Ixz94OcZtNBW4UZAt4GRqlMj
 GuHYdKmUbVLIYRoqCLKomrpk_f8y5z0GeLr7uk1Wc6FIfhJ0A65gNCY5zSzGKoUIkbFd8Y.MhvEF
 .mdTaXXTxJj89z_QfJCH4TdiUt33bmivE96ExKWvMFR2P8UvutbUdQbp8x5Xog_PVWoxJ.qZOS7K
 SApFI3Srlm8zy.n2NxlAMqWnyee2a5MjR9KPlNtvKLiGh1u1XaofSBh3o.mSI75o6eSKio0TxPRL
 YH62buT2xXeHLqpXogJjYpLH8ssSn1lJJyinKCPnvGmMpzD7dZbLxBzOo1.CQVA0ctujzTfvxRjP
 yhju5IyHaAILWQEz5x2kBz5W.hlgLAwlFmAW7s3_aaVjJAXDIPPbXNC8XvXqeEWJbQbj3LFFkOh8
 BR.UmoxKdb2Gi.cT.OJw.V9cL20WAHoB.0NT4LqEBKPvwThT.6PEcMhyn5rP5YUi96uPkuDKP7N0
 VyvBbXAXnzHMPOQEGe5EhXnoys4HynFHXNE7HBrzb91Oknwkkm6veDwK5_FsfruGa1rWMjZtrgJf
 Q6fynojCKOKsUDHfsOxZutXHoUjoBoYTW3aOH29uWjaIQuPYIOkGz97BLkOXWydiSHgkc_AcidQ.
 Hgv0cxyGPfAuNCiJW_DEiwomOqBZK.jOwxnRsPX2DQT.LCtjtTHdNFQgQfSla6rjR6PGGgMHMlCz
 lGV33J4k9OFRWCq03qe.Kr3azKMvvsk_6lRCb8EXqW6ogtBW7TRdSq1abWlgZt_g2Jlkb6bXkGMU
 JIcSDrCjcZs6JzxmF_wtRJWjd5SC0mwHlYO0.MlPkljzxoK88gRtCtFw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 21/59] LSM: Use lsm_export in security_inode_getsecid
Date:   Tue,  9 Apr 2019 12:18:10 -0700
Message-Id: <20190409191848.1380-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c                    | 5 ++++-
 security/integrity/ima/ima_policy.c | 4 +---
 security/security.c                 | 8 +++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ae4c058abc5e..2d04687c3fa9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -356,7 +356,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsm_export *l);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -852,9 +852,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b06ffcf9bb9f..71daead619e5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1908,13 +1908,16 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
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
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 090ef8ceb116..280f2410e551 100644
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
index 22ea709593f3..e12ce930dfd9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1387,12 +1387,10 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.19.1

