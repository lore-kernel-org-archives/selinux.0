Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDA0C432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD82206CB
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XpHfK8bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfKMR6V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:58:21 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45414
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728434AbfKMR6V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667900; bh=fVLWr87l6j0R/gnScLqNrHSBH1hKgEnFzkqP1Bp6da8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XpHfK8bhZYzGLZ8GJwmGNWoOCYttpqlHalHaD97yVcIpzn/XeoorrmqaS3gzHf9Hc2RLw043wqfnqO4x8ap9Bx3IyXyoOIErVdwDR3g/yee8Ig0nViU0hVauiDZ8Bc0wV5VJRsp7uDXfjJ++WEPf2es9VlwONXwRB0Gwo2ELCYrKDxEoMnQw57ZZYN7BRXpb8n4NDGEJXR1QQMV68th9VHPWjEmUQmkqFhhsliSpa7Uc1JFoxMxJ9oZCfHMOfwrMq0l2GB46HcVdPYoHDSzzfl5LKilO6xboJR+aLscR9LHNmWLgWPeLsWkSwTNqW1MUUt6KYwe2oV1ZPGY7VKBMEA==
X-YMail-OSG: _NHJGuUVM1lLUtg01PGpfhOrhjq3XaLW9XJOHylBSBGI0GPhlJfxCv86zaXppAG
 S2w0rYNVWySlfIjiNhSl4ggGPjM0TxgyhpB07p8o0WZ9eQcYoHKjh1J56TspLsOq81MelVBJt9qZ
 eHK7lIv1_TA33j6I2tQ2oi9VP6OtCX2zSsNOCZR3J_B1NkJCcWKlXB46nsmeNuFmsY4Cnn3VKi5S
 b3yxoAqF8q2aB6M87LbZWbr6E.kYo8UURexcYJBPf5V8mv8qxkrHhVt2QimItlot5jwXubIs56SI
 mYOKsSBE4Hm7IRUKrYUnxacVj20RbLDCRPzXcxbVNP4KzCubBqaD1MSv_CIVW_aY5ZPRzCZp33aL
 Us4Ig3V4RzIN_VqdjaH1pGJNpt7bUnTvAZy0D_KH5kT_ZVNKxTWuC9rG65z2qUb20lE7vI9CavAz
 0H217S1CY7NDEO3qW.W0WapkrGX4nAHheeIZ3pbSjb8qh8GOg2GpBdIrdwaamHJPi1n3pd8bBJ54
 oyL1MkLfr5Ys2LMhwqrmCmL5HTGpksb5_gA2C8hs62wwRq5YbsZfIXMLDQG2ij1C1.ZYCgEMZV1s
 zDVa3PharFnw98LAF9BqiO8rutalBhKouvU_0lBS6HQUHV.yn6mJA8XD5wUn1XTJDbxQxBwVp0ZM
 gIQwCDYRKNsAjvtyrKPIAgYtcUQR1j_6g8Xs1PiYJEl.SlJEIklPicKVWUnWiXiz0xtm7Ipl79CJ
 FNcPAPGPs3L4fIA5VkGxvIM.MZq99OV1jbTzT4kvMmtOYoLWNeviAI.5XF_oO5QTVHk2ac6_ROO2
 QQKBJrI.b_cHTSviiJ8b9NZygFIqsHdw3poPt3k4u7EQ4HkMsFGpZ_FBBCdA.jYiVh4mF6zXVpgu
 qLE_Zi4eoucb2CDhX1.qa32UaMbbSKSnyJ7V96rtkMHuDuFju.5QNjObtZdu1jXDbZXqbLQ2XwNo
 H8SKhVAOM7233gGVbrPv3.E7OWaG7U7b.vhxhXquDLtJSCI3VYZTInAdYuwSIJoPEcKeONw1Qus7
 rOYyQVJ__P8OyNqZhuwa26BcktDV2qGvu73VMbqVu3GrxiS6SqS.f62CVQhfSyqVEFTW2M5b8vlX
 w9Rp4_H5S1pSJ.qO6fUFyatfTqQatp8I2.e2u0c312Ggm8Erv0Id9p6oPqys6TBe6M3Z7c6AOR8t
 E3mEI84lgbtu8zOpbYxdXDt2MO1LRJ9ID6ZXi4rs5fJ8Z3Bsw9OemX9_zFwyPipK4I8KeBEw2ECX
 0PKJ0nbyFODty3lh615HZ8iIWABgYwfxRO7cQuYxZmkNRrJRkoPqPrQHRbQ4qCh.CsYzM50R6ygv
 vmqjNiFiUfEHuXLXP.ebbpPiFlst5aIoUWmRfrC.1HiHvuMssVWo95sbN1pWw4_nFenDrS0uN8a8
 6Qi2VwqxgDyjxrvBR7QJPoKrzZrBbxYawhapiX97rtFPwXjNswz_tYV8pA1YXSre_mtk3M.M2kA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:58:20 +0000
Received: by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2f3cc019cbfb17ea49bb53244c03e5fa;
          Wed, 13 Nov 2019 17:58:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed, 13 Nov 2019 09:57:06 -0800
Message-Id: <20191113175721.2317-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
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
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 67f95a335b5d..a845254fc415 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -407,7 +407,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -922,9 +922,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index cccb681ad081..5752e51883d5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1931,13 +1931,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 7711cc6a3fe3..c5417045e165 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -413,7 +413,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
@@ -423,8 +422,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index e1f216d453bf..bd279a24adfc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1386,9 +1386,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

