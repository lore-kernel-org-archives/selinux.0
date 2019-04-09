Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC430C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B212133D
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RavP5LuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDIVkk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:40 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:42714
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbfDIVkf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846034; bh=HePCWke2c6I7BkpqTHfPNmlfpR/ZgJTIEAfrAn5Ctvo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RavP5LuLw0V0LS3NgYFJCacnGzNBF9gEPdxMEXXcFZqMIQ8zwv/aWedJ+6tvVvKNHHKQu2/wMTZAoe5XQLQ9XGNwPnZKjAohteH6X9Nq1xQVCxvVwL0uzFGXBpZTlXWw+ijqB5HoBagN4iaSdS9BCutBwEuYphmFsF0Y8UnkZFhqp7o0MRpDdwfgsMsFNh4ruXAfT7BwR8iUyKq84cTcU5YKaunN4IWaqtUo/yxL0yYH0r9LRspAVL4NajsxHoREqamjrSa86ocVSAerbGgA4mEmpzy9Ij1V9LTmuwevEezz8RpQxnj8c3SjhC970Gl2gE4z8I19Ffe9AeHUL5rbsw==
X-YMail-OSG: x8_mjywVM1mNb8656Bqzx6HjpolPq6Bas42SzM8kRKqjybiMb0_xOFNTLbIGWhO
 7rOCGO0MVDd0b5Q4ppLVgl9__mTA63pe.wGN3e3UrIyBLhtCpV3iR_ChvJ_BuUtnPuIJv.BObD52
 rJJPtytkv_Vmls_6bfV0yCQ7TkC75trmDhxoO6AlWGd28e1NGeA4PzlVFa60uZ9fyjFOpz2F5KqF
 vU_IlG5OWNCBiTfOhYH5OYAxndAtl_pFy44GhN2aS_gOEuIHUx.mELrcQcDOGGcW_8OL0b55mEHC
 Whc3PazV8_AId8l3bL.zVN5afRtKPKWgkbnUViNUkVMGpCvTWMf55FmOQdoSHxMVQN8FXSiGtK3G
 S6aXcfdwS_zWALha9P_MKhtSMIEDd41AyraPdvBCkRuc4eaAFPzQ_kM9HaTUNDplaatpseMPGY4e
 _BeKnTl0Rf502gDavvJ2uhmQVjYo8rwhp3U0xyPJXmQQBfoz2KZd.6HmBerpQ2jfQWZszx2LySWt
 mWG5iPwGmyUACYgEZnP.MUaDu7mUgFPcWYV7a0jeqanu72b9KsrWNzoN36WxRNgfM1Pn4PHdrZue
 f0O2HdsB4Wo1rI5S_yeMEoaV4t63qm2JTlw9UEz7Z.Oxa_adfaQmSNu50F0VdzGaiCbkvfyW8W07
 l1IhbZ8VTwF3pBW8bEE8EL4RvCR.hsnJn6bIHwLFVLiW6kRp_ioFfoBFSx2M2cYVU4.IYtia5sjE
 vDZSfzmJLqaz73ci_24jfjtEkL5U.qCOAGPljSvxkzipho53GQ3dHLl5t13P0O8c8kL5TGBpX5pr
 a_4W3iFPptKMrfA6s53m95UpvjTudjfq5t4OFa2Jt0Fp9FcBJb_nAWwM5IM_Vx2JN7Z1uYUTRIL4
 ZYLv_jmv07daBMECjwunYnfmYLJYCaU0yAx8Ug1RwsZj_jRQYg0Dd10nz7DzrAOcjOpwd2PTbMjO
 zv0E3OPFpMCSIz8Omt6Z_._2HcJ16bH.TwGkuoV1AyEjVOQ22tecc6_ziW0fiVnwFcHFuvQOaA9K
 pN2LFbenopwCDFh43iVMguXVtIsGrbYqLa625R1OJ3HCqQ2HMSzRkZ6H8yu1_s.10LklHRnPEwXt
 pmZ5P.gj_NWhj1SYmmXgxlTqDKV1b0RVvpCO8bi5u4T9jaJTSHJE7wGugnWg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3d2ea789de6b345569f1c9b3872b02c3;
          Tue, 09 Apr 2019 21:40:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 13/59] LSM: Use lsm_export in the secctx_to_secid hooks
Date:   Tue,  9 Apr 2019 14:39:00 -0700
Message-Id: <20190409213946.1667-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index 11ace5c923bd..af0bcdf8fcfe 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1327,8 +1327,8 @@
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
@@ -1674,7 +1674,8 @@ union security_list_options {
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

