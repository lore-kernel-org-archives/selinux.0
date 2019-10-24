Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3CCA9EBB
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F8921929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fUps8FKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfJXUxn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:43 -0400
Received: from sonic317-26.consmr.mail.gq1.yahoo.com ([98.137.66.152]:35623
        "EHLO sonic317-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728646AbfJXUxn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950422; bh=fycG53F4jMtdrVcR7ZorR5vesqPHbEzCdlJdjHnAtaI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fUps8FKknVj0e+Si/1YulHlkxtargEAI+flDieKRdg2V4Lvv//eJ/wXGOTGE3uhJL1I0fi3+a7l8jrrdm9PDDkphOOvnsZ4vcIvA0ZxG0XIwNZwlF9jwL/rDHUtvqJy7APregjxMUgCzM9hi21kM31HI6g/d0f9Ir/PLxGBkj0FPr5gpbDqCZbeYg/Xk6TcVIb0rey9oY2TSKJoRhPDNb13CN6Wa8hY9CuBYrx5t1yM2P+vbZuF1X6PtmNVJ7m8dwEwXNNdO4I5RpkqLBTMVlSokMroGyR7Qssv/2go3qiO2AEqVOWh7Mn/z997GzTTeRsuULnm+vNwSBVbnBFmdhA==
X-YMail-OSG: neuwH5UVM1k_eybrcWjUGH5ccsxbC_uDt9ALVBOG1V8DFtyKR5wY8lqdkEHnhp5
 O2e2LSYI6vHLpEYxYkzs8dKiq0kaMm70OUq6QrRMxoEEeq2AxtYNDGYR2APtHN6rmstpfCis2Tx6
 VMXiV_U1zbtpSI8Bkl9.AQJTTbEM5Z8gTnPx_M8Noe4dhuTUgYnotKG1jt_EUhKgOI3hAkXIDIzP
 YPK81YSx0o.1F3Mwf7XxUGrIy7bxbCQ59tjuiu3kcAbb7eBitk1fqwVhVG4ffKS0HfVu3pvW9QDd
 jN45NE1PVrJYqLFCdLWvSOFi4rOWgDZWScPmX0DBh4PBWXpPBXJXWbF6B98oooEAm0y4smfcB85Z
 LXmps6j1VrRXveT5I9dLUAfqK0ul6JXasF4ST09vr0WBAEtg0orYfBRb7NuK.94oVkBqBeLEVVZP
 _wHmDiGwz_4oEK1VxlxbjK0J.r77hVT2VeSiaFKxtjNpdncvg_ETT_.3fSO3YmO0upg0ieXcjkI9
 p3_oHyFbwZ1qDTbrSEC0qrOwdaIwIEzsV.RePpsHt8mvkMIvleA1EcT6xKJbwx6TZTnH_FHYku7D
 ESHXaxASbnI2LQZghK8PgH43xzBEITdaRDsvDLCrpRtrVPXSmTRiEK94eXe8uVWqCfuYyENwJi.w
 a9uRp8pWawAFidNwpQCA.JvS5n2iVMigU41steUPRe3br.sJKhcC_mb6efQxN.EkdIpRKGkPQckZ
 CL8.2fyw1qiIz_5rxTf9iu8S7trgdn4cLbhvKGHvQQS4wfpwYr_9RtYiNaxkNsZzJeq1NyPZ7HpM
 jwWOH1AqaY_d5.1xig30jZ1NqNDLP1QWwL7fbpqM3owG8_PATzAz1_CQhkZvLyYdiaRFvH3T2TEl
 Pd.n5cr4aF8M9ByFGqY.OTsaPfoX6GYcPxKoYQ5L_xfAPpLVciUsafZSc5HHZLuJTFN5u7KcWu4L
 xtn4938FfPHqzZN7exZg1xTKr.I6jxZe4ZMGvS3RxHM3D4s0GzTchQSNRDS6_iFopvqFHD2Gq3cE
 OKI9djcqHJIzg0YrysjywSp24WXEP7IG0qSV2NqOihB.Y.SALxsygPiYqHOS5RUoN.hK4PgmM7Wu
 LkztkYJ74qyBG16WGWL5KeW_kRwoLcZcHZYUdx_V06RAU7UFtdWjel5Zhw5kxxTYb6sEUBZI_LYt
 H_kfXudWjCdUW6YBpIBvDrPN_sW4kdwrPP8N8BYXOlkvOV875rKNArzQ9xWObejlVr3RE1OF2a8Q
 zP2MPyW5mhE4jE1rKLguX7mF.mE.obyEgMGPhx5prWhnBTPL8h2Fr2L3bxxtO3ODHnJWtmceiO8.
 7uWgj2z_kIMb02GxltCoKPOQBR7DIo9p4_oegL.9AwBq3bWv.Imr_4V8cHdIPOmj.2GHQXVt8WIE
 SD.dRniI0InZbdd0rxPc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:42 +0000
Received: by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 443dae2a53c53b801c2cf8fd31310fcf;
          Thu, 24 Oct 2019 20:53:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu, 24 Oct 2019 13:52:13 -0700
Message-Id: <20191024205228.6922-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
index cac477b4c16c..d48961c43175 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -354,7 +354,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -850,9 +850,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 10ba7459f58c..d88283007ab6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1343,9 +1343,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

