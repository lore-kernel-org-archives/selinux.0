Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FF1C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99103259B8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sx1lDWUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfEaXdW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:33:22 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:35985
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbfEaXdV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345600; bh=xCs5ko0ljATg/F1vIduV+zjbu+Bg+Z+duHwS3Dwapdk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sx1lDWUu6S9kQT7njt4SZzMg/jYbdLPKcsUh8NxmqYP9O0AJYqCLgaGCR4MsRVAIQPNKui02XGR3H+mWDrGIcyhMeGD2B/EHGBo2ZKFMsbAPO1pr9jcMZAWxw5P7XC++ejGM2uwcNWXhjXVX3lTMuJgtFk83BU6efyHDGES1A2askYmcBs+DPCiDEYimYxUAlq4zRIEmActr/9Nc+O8rsicBF931aDLnkVuk5yi7/UJ/rn6Rkm4idm2UB0uXFoowxGqQkQBZOGLXn6izcvtAUYOSC/1b1pNgoBhJPgQM39XvCSz6uhZoEP35Df8DLfd0yRU88FDpTIGmogR26p6Hew==
X-YMail-OSG: F_MvfPMVM1kj3kuBDrppsvsMqWuDJoYDKUG8wOlYBovKYmn4ZUsVvAl4h5Zaegj
 pize8_37Ro5meKo3npIlykkzLOwZmwPwe5NkroXntQbQBjZMSONQ1sFxC5iHHA_yOSgp2GtR0RTa
 FKQGH2F8SXMUanoBgUfUCkleARgbHdjhMHpEhMBWlsZ1OH3pa_hB8MYifnTr3p8cEUwxQj7AU.Hr
 a.t44GAJzA4sAO67hLFJHrBzooppI2N1.HE6AlvfOTku8LGDwpN.XRc.8ENtdUyjd.RmcIAFUOIc
 PF7EQK9_q_C7uBEKwbmzjY1vYtl5sdyusrJuPXZ5E0QHFyThb.1T1O.VCj9T08O0KibAiJP5dWIF
 _hWoVAgD2jFQ8f5aZW3H1LNIlvuqhQR6wcRqqqYUjjNzNasu1ZLr2wcdZ13Ifrm1hnKmURSVSTd1
 3XUsjDi131vTnpcIY2dam1r221eUK3g2Jn683oCBz_ZDsYQcMbjCv5LfSuNrWLGqpYSxpHCJlHui
 3xrYNThLlWy82Tf86TVD7v7h1UlP_D10ftBL_0XdLpay080Qk8PNAuy_wB76uBRKruxCgtimfFXT
 dXYrSsvDNhZoeCRb42nu3yHYtg9LbU73kUAzOo5IZnFFWS_XvPUPWo8_Z7hmHtykKfC2Fu_kRdHF
 2rqAjXLBrW26TKMzj6U7qDMYA_5h7LxNsq7Gqnd20LZil8Njpbb8XQNQOImPbpL828hc6BpWQhmi
 _VRUn_7ohoPIS6rHL1zIdZywwPztwP4BCCA__Pp_0z2hzAAxrhm9YQVgl.yk3W3VgRAiiAynwMvS
 B5XJRtKpYQQl2X6TaMFB80jpigVF4tm3HCed9fhTJHeFJQDqKC9PXNwxFOqQ5pAftfj9br0Rsw5o
 hMHgHkKfaez2oaVpzKQ4eZdNSLJ50KdPGUChUpztwr6ZFtOA5KlB64tESrvC4sSLSsIdoL0WxLhy
 4Z9TK3VQIF358PQqCq1lpBkOLoOewYYu.BnWMqDgf_ZphiUIEVtH_LxOEdfwxLc0FZ1Nhp2PZ1SG
 XWklmgBQdxJA3ssczuvmrX81Nj3nVRpFFLNEmXF5Xk6Sn6qN.thsUCILJrbhGukx37YQE82gU7PK
 3SOgLUbGtPaJaNlaMnkM7X2lwA95fkJ8knsk8U25OSQCeWZCrRFQxOHxUCe0i.S1GYgbHza.2qFk
 .tjaNqqEc9kzBDQ_EL8JTG0_VSocz1N23LUU4NhDkFIxjaXmmdCN3HWXZIwaRW3W81K3Y8ARE5xo
 Ic15UqwdThhh.OtnJBdJh7Mzt4BzMSUJFzZFG5.dzNpCsH18SNLpW0g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:33:20 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2cf64f3b08f75107892893faae290b67;
          Fri, 31 May 2019 23:33:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 12/58] LSM: Use lsm_export in the secctx_to_secid hooks
Date:   Fri, 31 May 2019 16:31:03 -0700
Message-Id: <20190531233149.715-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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

