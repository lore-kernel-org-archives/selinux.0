Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55785C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2427982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ulxjI/J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfFBQv5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:57 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:32870
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfFBQv5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494316; bh=xCs5ko0ljATg/F1vIduV+zjbu+Bg+Z+duHwS3Dwapdk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ulxjI/J60+FCkSFx5Tcx+2rYPTY61TtBgrEKvAjFqnd/Y8q/+eGFNsJI8ILE7N2LpsQNEnUHkzarCTH68Sc9C3f4hSzIdCunYDhS2/snb0vKjNbCC4fUyB1t+mSAY8eiJ6T+5hnsGArmp2qkhoz44DKdkpiKFtpU7cqqJIqpP4rxQWMMLip/6dABJnd2LkdNqrI9bylb6AIrr0k967cZGvJxZ/eu4R7HbhOUa+dvRbTznPASgShQ/H07/NmPXR291mrMl860NQo31OPcu+EctlQXXtOCFozqX1EfhS4/SBipYqzlFYuy24oAfutH79LytdM1SfuD8mryLFE5919tHQ==
X-YMail-OSG: mZwHyWAVM1mWjCBhrDh0rTXLMqX_QdBEzrzdlqatznEjJc3JGoF6nZd_j0oI4IH
 BA2beRBoTnRkLrWnnUi3YeK8nCrBEWSizr4VUdfKNB0UJnQM.3AUTC5K3JE_G8KouzoAeC0QrIMV
 2QM.922MRCW._8UHw2Ci9FbiX60UvJJeqZR_efpugMlMBhas5OPDTfZ_jixZtRN4QIH4plDkH4iH
 zDEvwgBXlWszuCbqs8_IKgJ0Np.GbXjK33YsR2VcvoGZRri71cT1uS5BvbEXYzvJueq2hP.NjOQd
 D505zCuuxMToT6SfTNJvK_FAAoEbKj3Y5Y7U6cb0Ny7STHXFbLlsXZyrtLoktnhBFVREMty9jwTv
 VzpT8deVV3D.dXiEs8okpmvW716fpfD6rhVUz_a9bMp7ES3F3bTzBiaptcKydWM4trR_qvf81YK7
 ftxr9uiZ3xWDz_289R5DK0houBmezkD3H8wELOYVzlxQgoDjozCwa76eHVsFOgvnYDJn95rFuEBV
 eU3R5Gfge.htX.FKS7a6shEpWQyh4bif2smM9ZR1E4cC5d7.ylT4G9m9QioZnbEtzx8FvaIhdAv1
 fxSnpgU1L0PK6ZM.RyV0GxiCzAThhU_EB8KOYWuAfBVgxsUgugKJ5nDZhbDRfFgmlPTwt2oDK40O
 hxqjUFxvSb1kQga7Ldqkk44kqWeYJ.yMod6wvMeB89J1afC.ZKkgxohAhimW0D_1KxxYFdfZ4FQd
 RcMwSDBhGLDHpTZCj1Sc5HxxE7OS31aHQf1xe7427wn70lLJ9cD6fiPVNVAMp84A5PeDL147EqqK
 jI68voT5wb78MDSLJv3JQtnSaYRwuXLV.UcVmaG.kBzhGvhZNzig.CNVtJj.WT.6lQNw4q5MiCQR
 oyBLmBoGPqd14bF3lShM0BX3Ls5_iSg33v4bcSrC9jPzhREFLpBPLdz349DrGsE3nfvnaTthn.6E
 W7i5iGXNCt1PdenljJ.MyEUjDs4RN7d_0gVDBqZN7q.V7v_Ys0K_9hsbjsYHk8XRI9N63XqAubrP
 ZevCB4naOl11J7Tfe4RUrfI9TO1elJGwKgrTc_O8zQaCSJZwmvzLu55reBjIoqafMCr3So5BHijn
 FOfuZS9vkZXv8iZx8QXZKWNalCPdwReKeLUIvh3BC17pMtQioHKH9GoIVE.BmZXqYvV0P3SYUwz2
 nZd3xs1WrpSPAt.zRWdXMQULc1zf0Lefhh92JtpOoS9SwjIWmeF9VsmLWOI73pafjjUESMcLy7yc
 9bTh6LNMcldQJgUwW3z.5YvFJNWbH2zXr0GeiYZe_fQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:56 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aa88b96425a9713222d71be7c480dcea;
          Sun, 02 Jun 2019 16:51:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 12/58] LSM: Use lsm_export in the secctx_to_secid hooks
Date:   Sun,  2 Jun 2019 09:50:15 -0700
Message-Id: <20190602165101.25079-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the secctx_to_secid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_secctx_to_secid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  7 ++++---
 security/apparmor/include/secid.h |  3 ++-
 security/apparmor/secid.c         |  9 +++++----
 security/security.c               |  8 ++++++--
 security/selinux/hooks.c          | 12 +++++++++---
 security/smack/smack_lsm.c        |  7 ++++---
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 433d98dcb928..0837c214cc17 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1324,8 +1324,8 @@
  *	context.
  *	@seclen pointer which contains the length of the data
  * @secctx_to_secid:
- *	Convert security context to secid.
- *	@secid contains the pointer to the generated security ID.
+ *	Convert security context to exported lsm data.
+ *	@l contains the pointer to the generated security data.
  *	@secdata contains the security context.
  *
  * @release_secctx:
@@ -1666,7 +1666,8 @@ union security_list_options {
 	int (*ismaclabel)(const char *name);
 	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
 				u32 *seclen);
-	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
+	int (*secctx_to_secid)(const char *secdata, u32 seclen,
+				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 03369183f512..5381eff03d4f 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -27,7 +27,8 @@ struct aa_label;
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index ab4dc165e43e..69d98a89db75 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -75,9 +75,9 @@ struct aa_label *aa_secid_to_label(struct lsm_export *l)
 	return label;
 }
 
-static inline void aa_import_secid(struct lsm_export *l, u32 secid)
+static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 {
-	l->flags = LSM_EXPORT_APPARMOR;
+	l->flags |= LSM_EXPORT_APPARMOR;
 	l->apparmor = secid;
 }
 
@@ -111,7 +111,8 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 	return 0;
 }
 
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l)
 {
 	struct aa_label *label;
 
@@ -119,7 +120,7 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 				    seclen, GFP_KERNEL, false, false);
 	if (IS_ERR(label))
 		return PTR_ERR(label);
-	*secid = label->secid;
+	aa_export_secid(l, label->secid);
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index adf4cb768665..1645ebe06715 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2012,8 +2012,12 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+	int rc;
+
+	rc = call_int_hook(secctx_to_secid, 0, secdata, seclen, &data);
+	lsm_export_secid(&data, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 16d902158e8a..7dd333f133db 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6311,10 +6311,16 @@ static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
 				       secdata, seclen);
 }
 
-static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
+				   struct lsm_export *l)
 {
-	return security_context_to_sid(&selinux_state, secdata, seclen,
-				       secid, GFP_KERNEL);
+	u32 secid;
+	int rc;
+
+	rc = security_context_to_sid(&selinux_state, secdata, seclen,
+				     &secid, GFP_KERNEL);
+	selinux_export_secid(l, secid);
+	return rc;
 }
 
 static void selinux_release_secctx(char *secdata, u32 seclen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 809af981f14c..ecd636e5c75c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4456,14 +4456,15 @@ static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
  *
  * Exists for audit and networking code.
  */
-static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int smack_secctx_to_secid(const char *secdata, u32 seclen,
+				 struct lsm_export *l)
 {
 	struct smack_known *skp = smk_find_entry(secdata);
 
 	if (skp)
-		*secid = skp->smk_secid;
+		smack_export_secid(l, skp->smk_secid);
 	else
-		*secid = 0;
+		smack_export_secid(l, 0);
 	return 0;
 }
 
-- 
2.19.1

