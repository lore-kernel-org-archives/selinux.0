Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D064CC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA7B2133D
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V/UJdw59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDIVls (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:48 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:46799
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfDIVlp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=GPvWJDPXSClM26o50qIJxfLTG9C4Dy1cxsnhyj+//zw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V/UJdw59gXDfc6Yj/Ci33QbBWL/LMCYf2JTkLk3vGZCOHTxroKs3P+C2weHqXJF/0tvS9nvMkNJUnkOtzj3RvzIQSwrVt0PwMRIYwznH5i0bMMs7FYh51ryoYsfYCy4FCeI3hXyrT6H91vAeerOwgI1g2YrnBsM6Fds8L17Uysi+wsEaNkfF5EUrRDSesHR68Tx5uURypx1Ity6iedJrlurcTPTs0kMf5pxMY1GJu5ZYUs5OQnUi4/AUbvbKtl1CmVhMR0fuMPFjsfX3kyqyu0noIw0bDa8GjFXBBaTsUt5KoX2k4TZFU7/yK5VEJBeXljJfV12lGI5MFCnERG7saQ==
X-YMail-OSG: hYawKZQVM1nlGEzBmLuKKy1kG2lfdYeC9aaWgbJuhuagdvsqNbXHiioSO1m7GwF
 pcp2eeOvRnVIG44V4l6F.yz9l77g1xk03wDhSGnZ2FAgTI7prEQEHuDRok9w7AT3obBZ1hzs_Oh4
 VOrdCEzMcQUYi8RP6ozWjMjF5E54bLrWQBVSzKicjybtTXLz_L0px6oHk7B2uFYNV1CHC0FyMp7m
 d05VDrJNDYzGkiZvrS37O4SEZsWd3dTZp7wVjsfvIuuS8abMFKDQk9xCAd7q4BDAeJmGRtgdGWJs
 RCo7FMuajDiA9zgHPhw7l8cWB2QWkTMCu4TpZDdlprPOOCHjKzT7VMWWRu5Zt1xf839BxsSiHe1.
 Far8CaT3_zh.ckitlz3UONi5P.6Ao.xcxqgBvwVPBgskU8KQwmF0NdQVzS9AVPrlj1bQTO3g7j4x
 gAGwNiocmNkYyvOdABmn3twHT79t_Vl2PbAhdkCcqFVSTqZ_Et0Y.0EaSQaya89NzV8BwzxwIXhF
 a6vlGfm2SY5MUYYGpmoWHYvoRZ8EVeLwM6C2XY8.I8p7TtvIyvMWGwlI11lV8Iu8fOGMQ1M1c_lF
 YSKPjPY70ov2YE0DfPxK9AtKNK2W0mJkAh0aDacsZK7CkuCYlW85tLUvep4y.pdFgFNtVEdFGWQC
 wKM7eT_gLp.UfqBm1doyepjVd_escbK2ztLsHGPUTWEsqhAkfMklWatHF3joVePZDVia0PpV_tJJ
 _CIIMcoOJYceBhe05oAEvtPRb1_gSo9_M2CM.EQmNY1UG9Rd9KV_RScfOoIUDH1U7i.MTApfJFSl
 AWVpfOk0wKTx8i2o10qO23IQd_dU7Ay7CHP1F0HZbzUfGiEcp6zOmRmgIJHg6_pvRoAF2TtTnO3g
 Nz3U.qcofYt5Y8jFM8g84gMPYnp0_0tie6TU9FgmsTG0_WpNha1KDmF8O3lppDn7lqlOWG.h7pMH
 I3NJotF7bbK92_tPt7AtTCLN4RpHSfTgDjgK1lvO2Hii1aOolHCsQH4WPxzYVyPnCyokH6kzUbzh
 XlVFYK84LJ5LgA6rxf.cckKmcgdljzj2Vcdj4gPlzLFuW6H8y03zODraqDWlNQ2bdrwTgcIMaVVk
 IbNzU0rbt9hmRagr253VPboCumyIjAzd8iJdxEO2wj6bqigKAlEaZj_Ixk1_t5A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d24739551c480912ea4720c6639d78e;
          Tue, 09 Apr 2019 21:40:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 21/59] LSM: Use lsm_export in security_inode_getsecid
Date:   Tue,  9 Apr 2019 14:39:08 -0700
Message-Id: <20190409213946.1667-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

