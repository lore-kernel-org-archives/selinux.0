Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C6C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CAA2147C
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k1bKm3h8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfDIUAW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:22 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43361
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbfDIUAU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840017; bh=GPvWJDPXSClM26o50qIJxfLTG9C4Dy1cxsnhyj+//zw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=k1bKm3h8GDy4igaIbHa+kTmNlF1EVpSgftT7fIkBRVu9ZxhzwIqC9sdKmjJvcMjmvi+Ph40yLTFoRoQLyjKGKp39nGv755wPL5/3XGQz20IiUbKu+yIM8hGymtmTg9qZukGPWiPtgcmPTZOWyvp6HZ8+vjutbr7PSbVDI4iKCGFejWnpb8aFOJUZ42vyWBKW4K6EvzBzNQfVrxrlYG70/5rP39VSsEkHP79Wq/yz6CulkWNyap0ydeMvJyNjUopMum0KtHbQAHQEpsrzIjxWKdIOPvne2yCCI1ils8Bfow/MkXaMSe5JFDzqrIsgND5AcaZMfegHWFYsPxa06n6qLA==
X-YMail-OSG: YLZP4fIVM1mFWcvsweBuX.AEWeSqgDpfZFTS4Co.0utsmfdd7UJiHyvyHbj94fS
 23i2pDDd.m521GVwXmW6TgsyuQ2ndiWKPzjX3hRhYlJ_W3AuLJoOcanF8u5kISiIi98W3DeqgxST
 wYmUyjEUFwSNFNrWUAxDRTAqzbAaRfubo.32pKIyWCKoOVHifsdaTfrUADO1aZN0Z4cr68C1B5l0
 qlwhMPLGlYJKN36kBBeWgHrdfv36ZIhOhCeE5itqU7IhDxn_U142qnt1SYsjFvtGpPmJTt1rwO3u
 jjrllvHa8V8jbAvckCu6B7GhTAtSzQzRmD3eI8E5bnj_wLucoUbwENKUkZphvTFF4mmfqqhJtPZ4
 bX3cTTS88tAlkhBd08EuBEdCmQTy3AxRBTN8AtGT4kGAaqKmidDRZwnvbXP3wTPolRI0oQASWDGc
 wCpSfA5aeUDfI7zqS_OeWpBzqFhvs0a68KRplBI4L7IehXKr__ny1xNigcb0NRY70hlZMQfDWcsL
 hJ4P18zz9_6nPeLyqQNm9iDWcQIUEomWXFj3rk9C5C_ZiGVB5zHHcuq0ckPpDcm94D6B0v768IYe
 63MtVHTzWx6H6xkS_0ldIctu.he4e5I2WFwy6JS9HO4t.duJRKaU5qrfPHle6L_HyONVbNJfOgFP
 nGadJ8kGZp30Bl8Y3iW57mzn.ClP2XtU7523K2GcuOM9.u3D36xW4.svD2AgzAHDKvipXyxRL._Y
 eKSYWDBDO6gCwx9Yv3h105CB6tP0HFgNJk6Pejgz_voLaVzlw8JdIbkgrieISqCK.YfaMEX1letw
 bLENeiFy7GhXF0U2bvkIR569W.ylyDRCVmZyS2ifvYts7Zbj_gkRc3lR1YrYuRSc.x6gXm62BDWx
 89HYadS7Kd.m3kXAhL2kTGX3ydxpuZJRcV5nRgt1X2qQI1VS7.Y8pQGghXHSayemrPhYHHs.RvqD
 QbwHeVhsEmZUzkyxUugTqUQ5.rh131CDwdu3DWKU3qPggZpzLzJ7O0FV_sDvHoXS5AxLxuVBZmrm
 IKqPgDfHqedS0iNEW78QRPe1SAkZ2x.xNP72wWCOXwaSDWxiMF3ubB1VfEG0sEvFcm4zLnU7CavL
 gn7SPE2jUAcXvzE3JfsHD2KziDAI26hQczK_09ABTvpwdQFPa38SLrmvQxAID
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:17 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 24fceb1ba198cd68afe9603a17bf6fc8;
          Tue, 09 Apr 2019 20:00:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 21/59] LSM: Use lsm_export in security_inode_getsecid
Date:   Tue,  9 Apr 2019 12:58:46 -0700
Message-Id: <20190409195924.1509-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

