Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0620BC2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5DF2076E
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="thzwbVNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDGANF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:13:05 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:42803
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgDGANF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586218383; bh=gXCv5n91bsOtLHSkxC5uAy4prA7Ztc1oCVE97fmyvY4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=thzwbVNVpyN8yYbAkhzUAHRyRyG8rY8MihwFA0a8CyiJjxmj+mjzkZVOgfmKsBumE2sGIjtN7bXmXoRglTVOHcUmvuqicxGMnyeD/vaHh1IRQbaOkHdEZnHrLmj6AfdXp8vZgef0MRr13cBNdD4zjupj40ef86lLsJGbjUoULp0E55pc8PSG0wP+Miuj2x1C5IpkQR2AqO2xHN3DH5CBgaFAKCe81hO8K6/aDU7tQY/ZIL6Xvm+8gZuwa2PtUN4isH0IUGHd52FmzSN5RYHR+FtoZbI86JAd8O+o4JVbLcAeb2BklSZhPlEmS+9TbLzSrKe0P/MopO6yduShtlM9qA==
X-YMail-OSG: DlV1f.kVM1mPGzxT6.vJaFz4pYC40Voes2wY0XxpN2nhRTDupFb9iZq92ehBv21
 ZzileCcui1EHEPvmoc0F7pFymfP1GZG2Cpf9rIeyT0Um5MZNn36ff3cCMA_pMG79UFF.exDxowez
 YeqHuSLGaAbIgGtra3YwEwZ9kHpL5orjeHdUwSRfF.yKZja0nuUrzcg727P3jRyKBn3CgReyJm94
 c8QwyqL_mHD8ZYYYkBcl.ilwyoYbBhaM0xY5xMnfDMIlpl0QJIUIeQacCwtQ.oaFMJKdB3amG_WN
 wDxd5hCIAggVLmozTmkCPhqvzys7UM7DyHCiiqEqGR72QhGCse2zTiaNpV.FDR4cwe7kQsRmS58g
 YJrBl4.5O0MCyyPSNVk8_JvQm5DgJyoDgxZ6Mce9Y.kXNARENA8DVcwV2RarQMqaQCXlHn19qb55
 RwmQ4HbqD5lVr8UL.HvmuayxSkCCPQlUXERvex6KQ.HXCpsWqwPo4MRusdlM0fq0ou9niym1H8E9
 Q8uFcXMtu57idIAbznccqc6Mn_xlyyRNFNStX.J.hhEtBl5tNGzm55WaIGg32vfifb5xoGyelgSG
 c7XpC2pak1Uy.sVkc.ZE56oIkDir7msxdsU0_8vg8BEyJ92.EfuuYj3ZRHQcGw7ZWO8i2b4xZySM
 rg6Ul96fB2xVwllehLl1G.5O3QLF5H1sxSw8PridIu.AZ3XNdkzaZV_QJ4znduTXHinZvRX5ZQWR
 JvlMcK.KKpMiqRrg2opQye7PJGiWg64Lj9JfbJakGsDuBrujF7.hutj8Ay7WFU2sVySb4WcC78gI
 pDMA9FlCcDxJdTXIUIwsZ5MvPhbskovS.rN2NsF_GFhjHJ8JeiqZWeUAygYzMnowcPetjp46lZDJ
 pScPqxPfgaPc_febpfa6T9Iz9XfpwZfRnSrM40lB23maTJbqp3uBOn0P9uMeXRzKzL.B3lkv.1yo
 Buf6jof77PgahxEcNv1EzUmPB0ogh8jeZV521ENMyV3VO8SyofUhDAfj5OF_LuhdTM5AliKDb._y
 2AiioXjspdyydRpuuisO37kN.kHzc4OGAYvi162g0LBWBwsF4_BK.CGc96wLjDz1xKc08evmbd_D
 WihB.aOlnfZuz3IZsV1EVzMexJ.8RAgeISPUGO3msQoST0LD4Kl8VaQ3ImiHt_Teauh4xRV590Xu
 RAXBKzD5yVcqaDmLib8WHYMEFvMOO_gxBF4CIdXxLNswL2NgxQwQ6R0ky6hT.uOVFQ3fLyd_5IJB
 ZDcn5jvbB74NRIg4qLdWsQWOUwFNeItrz8Mx1Te.60hskpKFLYs.d.cINKwiUWJHzXbq7HNbrYGh
 smtoSXL1Ns_TJ8i_u5WsHi3PlOEtQo8oPEfqa2ROgjTTzroUEr9je5zz2J60dvENjUmflFBx6nV8
 _oQE.WJRJR3JR56d4CjCp88S3SUMZT8.VmyQJHvuWEBw5FyLqV0cTQkkpLI8gcETxrqo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:13:03 +0000
Received: by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8db2901e53ac4beb8f71170a41efc7ad;
          Tue, 07 Apr 2020 00:13:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 10/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon,  6 Apr 2020 17:01:46 -0700
Message-Id: <20200407000159.43602-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index cbc02e13e4b4..3f07ba240ec5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -432,7 +432,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -947,9 +947,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index e64f73cd5bc4..5d4ce44bff91 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1938,13 +1938,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
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
index 55cca6a57178..594cf716a16b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -481,7 +481,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
@@ -494,8 +493,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&lsmdata, osid);
+			security_inode_getsecid(inode, &lsmdata);
 			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index 58c8866d2871..8cced3fc9ad3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1418,9 +1418,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.24.1

