Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D76C43215
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662C7206EF
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aNvKHy2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfKMSUX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:20:23 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:44951
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728391AbfKMSUX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669222; bh=fVLWr87l6j0R/gnScLqNrHSBH1hKgEnFzkqP1Bp6da8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aNvKHy2fDGA3WjoOJR286dLP9vwhmc1aHgDAotvOntUfcMFQdxyG27YEwBu27YPIIMmgFhumZgL3lfGzFUGwVxLX/wvAha3fiT9sS1WWavgWppjQD5npwz7AJYuz4IEzGUaYXdDk/EMQMutiOf4F6Dr90pDbqvExooN98anf17MMO+w+JQ2+Jh7xDrDu9Yayr25DvxAP5oONi/tW9EwMBV2PesnddMD13LgenNxLEDyv+NLVQOulg4ZqgNEGGaqDs48nuJzgEgxzu1rh0itOv+76zSR/IHbjuug9MErA4FFdXDwNR97f8jkNrXUxBvw1t9A/tmiBar0xt7YmFTDARQ==
X-YMail-OSG: Bn8dkMEVM1mca8eDralNMD8Jye8bxshcdNutpVHx2u48J5Z4C_MuAue5xl3RaM1
 dkoBhGHay9tOU0S8VXGqLj.NtT7xWexrzsMAC9tDizpK.VarEs7uCf03jR21asFNysY.hyrJB7IT
 ot8ZXeL2REU3oLcyUYzWsk69JgRo0zqm7EB56Hv1s1tt8Yssfe.F.L1coVV6eX5dEkvbmdda.yM5
 WZcn1ZT6DD3dC9Dkxai7b3_gjYazBnqceAifbAThCNUNPc3u5JREvoBFdUGF.b_RIO.4vQ1tfA0P
 2rK3R8uqkz3ftxROQyNnLOlyBI2ga9eSerzI6n6mpCpNEcv46RYSL20D1lUV0yZwfgzhFZ9V1vdH
 9ey1AErj4AqVxObpRsY1HGgEBJ4mAVJBm39zhno6ZI30bo3_Kilk2FJsCXjBJwX961fKyJJWZbfe
 pOzUED_y46j0zPX4wm9tRyldL2AoPbCcRFc8X_1y7Dc6O9GzBkrRmja69Rh47PBgkjx_axNWScC2
 eGgx0LucPRKhVkoj5qyx8YHbPM.LuKUzIYm0FEclaqfcSKqjOoD434K2DDZcxEc1BXOBt1QCZK7y
 xFXrPvAsQ5kTIoJmPlYRQGKPfANi1Ewpr.msbg90ZsOFtLsuOjnoxiUHLcdcsgdYtzuu4euzszeX
 7sjLvML6tq278LuVoVEBJa4y0vOE.V3oHg6Uj4XZtIitrqlDU.cf6nLedEhCuvrdcEKPIw_H_pHb
 hP0K1B3IobO7CJa_niu3Wgp29wTfln1plibojhLJwcS_1P_DXilHJovu5RzxtPSErt_pLfc1hE7A
 zspmE7pY_HPHf_pbJGsKpsL_g5fc5Lsv_9ev0CTuZnXb0xJbEtGhM04Q7P65tM8MX3w_uF_rQ6jo
 TbXQGgmCu4MJV0tm0T8YplY9cRLcphSloGUwHS23f51OuAkNb1NADQC8F5HcpXLcuSZA1kKWbYCj
 zfa4nW8S6m5RfIo_oFn7QbptSSQbY81UIB2.ll9MLlLe5L98sad0zWfMqFOUmSMULoWfJqVKK4HJ
 3G74l5VLpryyTTQZ3waPfP1MS2z6huYmAISgYQxyPbkBN6BaUpYZ8Vfke_QgESKXzJYCVODGVHFa
 7HjGRHbM9RqOF8a8TugKhPELnezlWtffOS_b00YlCp9qW0gaM4V8h1yarceKihkLK.fpgXI5xykO
 dNTdMIe_BbpnrIGlH4okjGyJQ8rC3F5Dc_H1COjV0tygkczTTok5mWZ3WrhzyWcO6Xq6u37Zs7y3
 U1kZ3X7.JujWrYkOCiAv9howk__4m13sv_xNjoUbYM1gPv_07lHqsMggAKP4F.jX5UEdiIuoSOnL
 Uc2HqAbvvZ2MWManzCSju09Qth_ZJud9eAGysyJw9EAKE4fFkq8PeQe_9XYhPRZw6OuZZYo_Z88x
 XEhicHZNa6RH_xGfm.14yhYWniV2eqaiCZXGOo8uqo0nehadFeQWZLWcK99HerpLhPg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:20:22 +0000
Received: by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b828f38d84f12b2f532665818f8cbdd2;
          Wed, 13 Nov 2019 18:20:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed, 13 Nov 2019 10:19:10 -0800
Message-Id: <20191113181925.2437-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113181925.2437-1-casey@schaufler-ca.com>
References: <20191113181925.2437-1-casey@schaufler-ca.com>
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

