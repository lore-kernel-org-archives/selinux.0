Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F092C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0919821736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SxGB6Aby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfDSArO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:14 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:32828 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbfDSArO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634833; bh=GPvWJDPXSClM26o50qIJxfLTG9C4Dy1cxsnhyj+//zw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SxGB6AbyI+x0GaadzlOsICFdFMjwPn/Zwi4Tuvl6xEx73iVaVAkKozV4bHA7oEIUzz9wrUg+S68J/6WZMtOF9zfSvIYPjLY2T/v2r9RKq14qgDjVvHRdh+NCBnVt59JcB11uB4/Z54Xzvhf7Nca+hNStz/VkFl0wi4SOJxk4WK71KWN/Ym/We1mvVpwjV13pVgsSOoMz7AD39vsqlyoCx26Rx9emKkyAs7YkmxfXJehLdPB0YkRerGRVw30Uc+wDwJ8lzGe+CFmonqeF2B0unvptDcF8Wf6VdsCmV1gAo8NJrFGZXqZivU0gGrWvEsPoTYefBgCgQMe/k8BvLbCypg==
X-YMail-OSG: jWHKai0VM1lhiBATWjvMhTOFqk70jzY1brGjw1UN4Mc6L73Zfn.oKrpryKH1g7w
 _54458Td.Bq_xW2uHyRu1qwakZURrqVqhLepG8elXf8.OVLVGG2dUP7wLQa1ESZC8Csv3f8wag5r
 YZPuJ2Fy6_2X2bKNy.4T6pQgyXYA1S5GNjVEDYL5pQ6reJ1Pwxgn1Hj9MYSACIbaPTmpi8gQ9MnI
 pKzO9zNyl4y_5ItJcCmk9lpRS92_Atu6Mkz5jkLRGZERPEDh9X.52DvXa_xpfXEHBqJxUyH4pskY
 LjTw2_wEt2RCuAcSrCTNRPPO5cBa.Exr9kSBHuvRlygzYH7YxCjSjaAJDTkmme4rJqOtvqHp5AU4
 ThqTT1hmfvzMRrLa.w.y8wrKJQDWNA9kQOnbQmUQ1hlhNZmOvlCsl29vG60FlJsp0QMKZ3JGigyb
 WIdwpszQZqeWsD8cJ5THpV4kNz8ZVnL4syHNOuM56idfmD7KZXr_jWqjC.lqznCi2sqJvtf0BmeD
 8udxbLZGR4OB8.cSM0YYhaPYFrSp1_bpHaxD61KsmhhQdqVeFJxJn5SLwtlPSI8JGiZFm.c0ci9.
 5b_wN94zlFUvEvA2h4hKvO3tFOLky.229cp3DPTa2vLdFQfGYAbeAVEYdtytj_P9HBafUlc3nSAT
 Kn0m06v1Jb4n6aeGtPk02Dl4Nxfk0WXDmAnv1HgmbY.3DZTHw6IvbfG.n_dRKFBT3gtUHgyRlu5t
 JiA.NecXaDidzRs1Cn0TrNMNPFXWXhJKP73NQGVPQCDRuWuDAjmufLkQbsw2TqXN.N1Nc.lX2eK1
 4Ug.eZyqW5FNLUqe4IM1yqMlqJODoGpWfRVbeYDtuzmNuWoGIZeO76m32.721NnkzjPOD82OCDyT
 pVkCOoyV4WqNXGUWaNqx_z1JNZ1X5_lMwKyfeb_FRqhbno2e245J8kUM_mGKUEVwoj0tpKENQn79
 bMvenbobpNCOjZ2C2o62HxkXVe3kApiZ95F0oHBnZE0OOXvS1LlA_V5LmtUbGbD23iAhox3J9LJK
 Yr7ZHm0l0vk8_rdIsCxDv8drDeUsD3lsp943rszn_xiNI4BT25I79w9MA0jogBBe3R6oiNNHuhuB
 ltnhTwmCwLQSmtgIG_GL4kERDVVvXP9x.whDuqd7loSvc23HpMVzd3ydy9lY.6A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2b98cff5dd7fb51e7c7719cd11eecc1a;
          Fri, 19 Apr 2019 00:47:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 21/90] LSM: Use lsm_export in security_inode_getsecid
Date:   Thu, 18 Apr 2019 17:45:08 -0700
Message-Id: <20190419004617.64627-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

