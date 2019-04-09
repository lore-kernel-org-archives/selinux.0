Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FB7C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163A520833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YtQ3HT6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDIUAF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:05 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43419
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbfDIUAF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840002; bh=HePCWke2c6I7BkpqTHfPNmlfpR/ZgJTIEAfrAn5Ctvo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YtQ3HT6smqaHVbwEAptIlIZp4Zt6AoXr3tjx+ZtpDy/vjYdg/tz5PYu5546ageTQyKZmtJTQ+mupyC1GTvTCgPXn5uY9ae0gIgZzHC4HMFC/x3JZiosSNBX5D1/pfvlIcilr5pTrHK+qZnVGSk2XufImrh4IC2drT+SapzuTvRdPeKfxxbQA4DYrCpSt/OyNLtLiSpcTIjIk3RjhlQgJCSuS0KJjoD2vvGpeUWIsI4R0zy6/AWUKPTn2avS0ZZWyGs79mIa/62wpvUOgbtE0S5TfPiq9m3wulYB+s1Tn1Cf+KPGtMnY/a7JVbL01anfhdd6EIcwCGvXndsgzQCHCSw==
X-YMail-OSG: 7TVw8.UVM1kFo1yA4qtvdJLFz15XFjFfJj8B_l6RTMIrtqJNHw638IoYpotVpZ0
 nzEBZPRdZRcjVsvH7LsGElGY8UfCzl76WQdXO1zW3LecdYdhS8lXGQid5NyoXHdUO3d0Hh97A_Lw
 l6MPZ0HEBf7BKVsZBnfeUe0tlBYwIObPybhhcRRCK33C1vj_El8SibqY4B_s.EPdRriNSiyXqQeB
 VK0oAF8lOMg8VJPxppPF.OjcKKVsc6oEi6HumhgaLq6YT1r4E_fypt6zXkENRpF_SWh4eIMLT78I
 4iLMKYxABe0IdPLufPED1bbidV9wKJIX01NbQ4q8JqF1ZhNP_n8AApAdvpqJ0Nd.693ftprfE.kf
 Da80cSTI0dEkPj.3AiH9GVZCYrtYjSsRSlDeAtrFKtqcP2cj72Vzh88dA0lS3TZaiD3hgFXLQDUa
 cmJWodQk9hl0gz5Jqw4bYycjjRfwSqRC3gtDiBxBtMXGNNpEAAAnyVfPBT9azF8L2.6D00Blot9h
 qHNRlOrkTaQbvw1gs0Z02ZSNK01mxft7kkP7vxYcQNYvgxkhxW0BjNnxGQtM0gz3gMPO4JWUAlam
 JBx7okfwpk4jtsal9WAyF3x3qKVbj6Mg893BO_gUalM4e2HhsoT5q8yboTS.ciICY2jgyS6XuFVX
 y_U.w2hA82DoPsDGA1uDt59C9J4N75ST367UU0zNT_KwOv75zPBoqA6RgGKepFJsLbXFngS_fyN8
 x38GB7GLIrHEzvwVydukPP36CFqst_xrUtSlchTgac3m4xRx3V1PlIA9uHIilmyCZeqXV1kf2FvO
 .WJdludDokol.VUAbn8LpSz5_uLWp_YhpL9sWgF0XTXfHIMtw8Wckocja7sT0XOxSHsXZZelINEV
 orrgtP5Zs.SY3DAb1JKhkkhaMkfM4EcjuaJSX1KxM.9vPaZ.eu6WE2Jsb.73ZiL70c13ZuUOKsnk
 COhcXlT7gKD_Q8LTxFKUQjEGTHwX16BJrJqLe3zZlCVpSu6tR4dAV7BIJZ.5BAQnawZ.wmR7SzS3
 Y_olFQhPlkAolfmOgaEq7THaST3Dvst0c_u3BCWvJw24f8tziF_yNB8mqC4gCY1PiGD0hpNKUENj
 wvJdQOjyUFjAs1wLjXfpyZq4y7E9Pm2oEcuqST.stwOUp7DGEI2EUAU35rgc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:02 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 552806e231f63bbc1dbaec1014ade557;
          Tue, 09 Apr 2019 19:59:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 13/59] LSM: Use lsm_export in the secctx_to_secid hooks
Date:   Tue,  9 Apr 2019 12:58:38 -0700
Message-Id: <20190409195924.1509-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

