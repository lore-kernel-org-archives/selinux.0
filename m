Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1BBC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FCD2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RazMJFvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDIVlR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:17 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:37631
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726923AbfDIVlQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846074; bh=0HvNAEM5ldRD+uctL0wTIJl/wIYr3ZZyu0EQxH10SGs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RazMJFvAFzgp59t15OZLvw54cOfj/nN0G5I/B4iqGf77kEWOYfTI828S32wzMRSuEPHi4F7MlQzxopDXHuFnnE2d+wxJhGpjQ02QVYQHaHvbZPX5508m7qis4pMfBkQ+B7bNT+rSq1A5ldvJMD1d0FdSTCqILeHSAGjnlJZlXNPr+U7FXALouOanCBmXbe7J2CkGXDukdkKdhzxRQJVHz2VvSCtB5RnCyQPoSkmTWBAnro4Q6V6qqa9SMNyuUYTsjVEKpS1K1xfjXzFYAhesFlpgnacHXdFY5x9dEh0SqT7psXv8BAVgO1TslKMTy9sBS/nd8SDPpUIS/LG7lEdFIQ==
X-YMail-OSG: TLBxVA0VM1ky8EeBddCh0AnGIEg_EPU0sHYiQY41DaFZXrHxYyDPzJ6BNPgZZY2
 2e7UUGxLUK7dFqDOzUvalL2M.Hslnk3rRmrtlRj_Ed1aUzavIvnZtfR0aROFH3IgAfvKSu1A.yiE
 GrXnay7Y8QGBOzjvoEU01rTlBYbtximMt2k_4k8RYfRr0pEFXtz0F0c47I2QiasvqcH3yTWsMkGd
 dHp5NAIAe6K3XuJAl307K8X1u5Hdggaf4uUagHs5HvFYjRMk3zt3DNHmBFC6MPU68L3mOoyhan1D
 m0Lh65KM_DnlkU35SRhiNLBurfuCjdKoYNXx51duMw.gjl1m7vqH0N5Xs7VK7gDSKjXuD3Og.Jkk
 tXfQpo8YKKI4YVHQKuPS9VDDQT35AWk7H5K7AJgjvaTqujNvrGPBjBiTINr.KUh.cczWsQpoqx4a
 wQZGHpM3T14tblZd35N0IMJVoiFXhoyPcsarPnUICuiJ6vn6YSYR6D.GFvR8DrWLgZCV0KHRbFao
 PJffQFIAf7jBqJtIkjF.pBIg_JQduDIbDtP9RnGrdTOuCI29lBCFdT_eJJ8dzoVKheGcIBh.os_M
 ry9yMBznGe4cb9CR0qKMZabcZUFyLEXiQePg95BAxDIcEd8nEDQKhrYiPd9w8EoF1DPpQJbMI.C5
 h.RFytQLzd8XDoKIPc6QtB58eWYVYFbHhSrI6BoGBCs6N2Vw70m4SuJzfRLQRnNqFXM28t2x2ATR
 XCbIyuRIdHViooBgjkdRtuSbeZfNvlThdNqJlzlKUqstqa35dZdCFJHD4SpGIDcKtUdoxN9wRA6U
 1TnrbR8U3bwVU8L_b7aIT1S5IbYDDlaSv7F5dw6KcYDzXHpI9SxAeBgQQ9SfpQhTvfF85CIESsCL
 qkT2vtrJoLjkd3zWWQSNFa0H_udjKPqyGwQoAsXp1WrJG3jw.n08LdnMhEA3Anv2bAXWyx1ctZxt
 2JTkSF05BvtEkpWnNInCtpmTsEbmgsZ0DNnVSFReCTqmi0tnFoqzmReL_6jeTxbAGlj0LohF6B21
 kwDbOLtnPiyX2dATAxe9sdHfyVn_LjiCFavLCzBy769tpd9ibQgaxy.bouBcse.TjRhgRhR.sJiJ
 Aizg120mpI1DdxwXvIRcB7_g.sBvIpKbj5tnFVMfYivm.Vag2N6TUJt0hoSTezw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:14 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 909a163ce0f03793fff6be9a79785446;
          Tue, 09 Apr 2019 21:41:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 47/59] LSM: Use lsm_context in release_secctx hooks
Date:   Tue,  9 Apr 2019 14:39:34 -0700
Message-Id: <20190409213946.1667-48-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppAror to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 3 +--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 4 ++--
 security/security.c               | 7 +++++--
 security/selinux/hooks.c          | 4 ++--
 security/smack/smack_lsm.c        | 4 ++--
 6 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f60ec98596c8..11bfa0a4f188 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1332,7 +1332,6 @@
  * @release_secctx:
  *	Release the security context.
  *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
  *
  * Security hooks for Audit
  *
@@ -1671,7 +1670,7 @@ union security_list_options {
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
-	void (*release_secctx)(char *secdata, u32 seclen);
+	void (*release_secctx)(struct lsm_context *cp);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index acfcf99bff0e..a780e56d4f5b 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -29,7 +29,7 @@ struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
 int apparmor_secctx_to_secid(const struct lsm_context *cp,
 			     struct lsm_export *l);
-void apparmor_release_secctx(char *secdata, u32 seclen);
+void apparmor_release_secctx(struct lsm_context *cp);
 
 
 int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 35df38592b6e..46c8b9a67ac7 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -123,9 +123,9 @@ int apparmor_secctx_to_secid(const struct lsm_context *cp, struct lsm_export *l)
 	return 0;
 }
 
-void apparmor_release_secctx(char *secdata, u32 seclen)
+void apparmor_release_secctx(struct lsm_context *cp)
 {
-	kfree(secdata);
+	kfree(cp->context);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index f51ea4a134ae..149cceb5e366 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2004,7 +2004,6 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 {
-
 	lsm_export_init(l);
 	return call_one_int_hook(secctx_to_secid, 0, cp, l);
 }
@@ -2012,7 +2011,11 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_one_void_hook(release_secctx, secdata, seclen);
+	struct lsm_context lc;
+
+	lc.context = secdata;
+	lc.len = seclen;
+	call_one_void_hook(release_secctx, &lc);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fe09905d013c..332296f69f76 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6322,9 +6322,9 @@ static int selinux_secctx_to_secid(const struct lsm_context *cp,
 	return rc;
 }
 
-static void selinux_release_secctx(char *secdata, u32 seclen)
+static void selinux_release_secctx(struct lsm_context *cp)
 {
-	kfree(secdata);
+	kfree(cp->context);
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3d24503029e5..cf27905ccaa5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4468,9 +4468,9 @@ static int smack_secctx_to_secid(const struct lsm_context *cp,
 }
 
 /*
- * There smack_release_secctx hook does nothing
+ * The smack_release_secctx hook does nothing
  */
-static void smack_release_secctx(char *secdata, u32 seclen)
+static void smack_release_secctx(struct lsm_context *cp)
 {
 }
 
-- 
2.19.1

