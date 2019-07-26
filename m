Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B571C7618F
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C2121994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fCOsihNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfGZXjm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:42 -0400
Received: from sonic311-31.consmr.mail.gq1.yahoo.com ([98.137.65.212]:35256
        "EHLO sonic311-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727888AbfGZXjm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184381; bh=uxcHwgOpzC/adUgk2d3S1gEWM4FTxZpivBefUTTskGw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fCOsihNhBwRWTshiEsGuf46BKLfeBIKF/HVyZ0673LiuGoqus/u2OSJHWRD70lVxvhuEf4gYziIUDl5OZcQNfYKWqBp8mkLBRs1SZz3VsQX3bDFzra5yzo9LdeFao8vlW9HgAGBJZBQlyHFQHMSAfRm7PFJC0oY+isjw0K8v6i37u5aHiCd2xRmMnxqVV5jrr2vC/BKlXfSswEvPunBsVQcDv1vZpnnBBYggxFzb6zVzaJhZVERrgH5W+KpVJtGFoEYVf134kXJt7C7p9UcLM4hmHwkIX4qQMCVf77fIEO5PFGG97Bz+sonNFD3gp9y7raOiPliEhjhnFf0sui1KMw==
X-YMail-OSG: ppRo.wYVM1mTqWpS8wLNWY4gHD2.Itj7eax1JWOymzFXPWMWnX__4TNXcRaXdEU
 CdpGu8PSYteS0CiPvc1O5jpARAwsdrh8arO3ZQM79wZbap9NSANwk.bb_UwHjmMswEW7EQPOqsFe
 GY7_stQA0.LIsCphNNpwyAG9OmkWRucXB6ExcA.ynrXUu1QKnGmBHpTVBfGqxRmnEZUBmigl.mVD
 daituRgkDzMrkpL.qeV5p9vzZhgDzTRJVzvVQI6qQDl4wwZpE_ta0UeOH5gIRol_K.REF40ZCCrF
 TZe9w.uxbqCbzWHbF9KiSzYrripNPA6mebQwCHUBcy.bFpIZkAzR3dHGC138aPqfC3Vk5Z57XHwh
 nzSb8FkuOp1CcGrvc0.Jp5UzoS7V77Vm.RQ4IVz9m7ykbXdRLMfkxRrAjvkDvrlfZPMuif.7Xw9H
 p2MoSZPb7t.cavwADVuRbXrhpMnn0sOCzihZBMYJz5Iiqam0ogOFkrs9006j9l9zZ_PU9JPOf.Fo
 a_4kyvzb_h_qkDtp_exr1u3On.Z_JkoE8XOpvTHsH2SnKcWWfSaoHxlJ2Oyvh_WTKED5q2WDlt2S
 5CBsfpigbtIhQBHmDQjAZS2eNH7IDJJrQnhmfGkoTfLa.2NVHbLOmUxHSMJYqRTCwMQxwyO0hdiy
 0Mjnsdp6kKPTcp9fNxoH5LP2qkIwqIzwlQ6lnRBWuNAEPyBY.GuYPWHjSFW228LHnV131tAlqG3U
 HNPocWGSw3ei64pJ2SJOQdljSp0DFVc0BvnPXyU2vZ3sBbx2Ouna7gbwA08MCZYqO0eWEClPHNZx
 VV9XZBiXUZL870RiUWyaFxtljNmVGjdrrTfqbK9MhbF2SPn3AZLyMvLuVpKvJl1PZAOmv5a99Vcq
 M4u_XBeJnIspZkAQ1YpHzsEIMak2BCLdVhXAqVldPKc0tBZ9zz66gYbcys9997TZx3YF3Qcc5G2j
 LnZXkaReD3dgS6AMZqdx42vWe738mCTW6sIiiXm5Tr_dcssk4CHJS_GyHB7cdK1gD5hKJUaj53ux
 3jE7vYlCz6BjrtQHdNp5TDbR.P_78Irl8iX_SdIEAJR11A8ut2SRFqlIG86JlM298FUq2fCgmc5m
 IbFOWL4ZP1_wvMgb.JgwnRxM4f1FjbLv_UGHRS31XL0v0DxxgpxR7IKkAP6ehVGVDcWmnFBPh.hQ
 R3QPvPC_JenyLSNE81Ea9NJTYnebHRMnayEHNYhKLPNNX.6YkBHcJNVvUaedKBTprEaPE3dEmt18
 WJZopl2Q60xOOGrmXMHFJb6VxyHM1x2Nm9eCY35wsBBMkFgdIQw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:41 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 78a02322228761c8d5b60901ce41d5b3;
          Fri, 26 Jul 2019 23:39:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 11/27] LSM: Use lsmblob in security_inode_getsecid
Date:   Fri, 26 Jul 2019 16:39:07 -0700
Message-Id: <20190726233923.2570-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

