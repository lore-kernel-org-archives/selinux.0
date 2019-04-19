Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D932C282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E546217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tEuWd9MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDSArz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:55 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:46576 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbfDSAry (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634873; bh=QuO58pKbB0Iy8bZpRCk+Z4JQJyApy+z8GqXKuGPYaZs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tEuWd9MHOBGaXcpll6nBVwY+1LfYYuLxxltZHtwZrFopkxCKjvmulbn31ejnmPIgMF3+NYRbGzL9AiKC9mQ+H+7kSmXF67ZSBooz9AChfBBT3OSRxZvVTbGnHVGuyLDJO2MGPQI3CJEj+GBZ6r/PDZ29pnNjmK4ML0GUyg2H0kcbZrhoX7LOGVrZWgdf2D+o7nS27L0qU8NDh+3ZEaXBwZ0y2j/3pZsv7zIIisxQf8I/9Gk/ZN6tGNvJ42qsiVqPGIEPvDJR1bflU+RIX0xTeho7YU6oqf/9+5hsCshZEiOCyKve7AmnCLYbp8Ug4EebhDjRTW0OkveyqGqohIkIaQ==
X-YMail-OSG: _LWuPP8VM1nJBGI0n.arHk6b3uzilYcWnJCR9m6gtVxP5xmGsCOQOt6Lre4M64t
 Cre2RyfrnoJ6zB0cROsAXhzqFYOmBTg1h33Su43TxLcRJjWpuAUci8..c6w3b.aYSQZiI7_7oDJg
 Kz82H0U4uGzUEWu9KUtSNgiq_YZAgMNryH1XZYq2emk1FgNd3aanBwNxrIuYaxVdQl2QUsZTFpTT
 0a81sbep2Xz39BUZFmqU7G91KedVL5M46cXZZPg2SaP5QGc3H9eKPKSDdxl0SvxG2myjRhLop2vH
 T5zuVbMCTRqt0OQocHr5Irm4pE.TK7RLJfiHZ927R3sE4Ua7DXTZAAYUtzzyYIBZNMt16oOH9191
 GHPdI6KWXQAEfpCO63Ji5s5oqfzsK32OJYx1ddn4BB.mcow6SppTBJ51a2zUIXCGSaGlL3Cn4MeE
 PdCRGL3DJwD7HP8VGqsPk903sEzVpDoA6arU0UpmHjWImdEsLjuUKvEsMan9CxqWGEfkM8ZDpGNv
 bh0Xa_y26bOX7NtZ8EiF793_4duXX5DU0YHK_ReQnUI5WOXepRBKDb0fC_RR5v5hF2vXDALMnsvC
 AgJVir7FFjaaobz0UH_8paFj0hh0kk4T8OF8ZwpOtYI5xoaHfJBxAJ617Hzh.7HXDEkQniHhyShi
 RsMzxEXLtb5Dh8lwOI7zvWcc9wAez9cCTIrNvpelPAu6j3eNRdKvDUzFD9TzikXDN.iT813R9aKS
 Ha.nXihiyvl4N9pRDjCDDTUXx.WpPCa13HlaAcr94iAdyGsXopGO0gzxG3aXrOvENzq7SVqG8EZZ
 _z_kWYxqGIWgDwtPx.EMtA66P6s8Mzo7.iB6VqDINRKct4caULuHkFMJDzGNu.FFeyLCcrTjnbcK
 hAgSaBDA8DCtSs0wUPQUyowYBZjcHn2hdN2LWs0WJUDe8LR1NCiJxiH7i4Wqd5TiyvyjSX4x0.mI
 cSQcXHZZyHhFW1in61tLRzsRAchl687jAoTqxShLc.vPDjPeprlK5v.Mpbxkmq51VBe8Ajo85mqt
 9n18XG9NfG7JIq.EJ4EOd3tLXs6nuFvfKpMTRmLpHNLeujQ2S84hXYs..BofwhNI2NYxoebbQ775
 Jx7UBhiyzkAY9rYdDqu3_ag1FbuyTmRuQ0F9wZFDSJBSt9pfJhFB0IWiR818ekeE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be9fa3e2c75d2b77c1de47e4a712b0c9;
          Fri, 19 Apr 2019 00:47:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 39/90] LSM: Use lsm_context in secctx_to_secid hooks
Date:   Thu, 18 Apr 2019 17:45:26 -0700
Message-Id: <20190419004617.64627-40-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppArmor to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 4 ++--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 7 +++----
 security/security.c               | 6 +++++-
 security/selinux/hooks.c          | 4 ++--
 security/smack/smack_lsm.c        | 4 ++--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 566714aa0caf..8b842fd13fb4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1327,8 +1327,8 @@
  *	context.
  * @secctx_to_secid:
  *	Convert security context to exported lsm data.
+ *	@cp contains the security context.
  *	@l contains the pointer to the generated security data.
- *	@secdata contains the security context.
  *
  * @release_secctx:
  *	Release the security context.
@@ -1672,7 +1672,7 @@ union security_list_options {
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
-	int (*secctx_to_secid)(const char *secdata, u32 seclen,
+	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 964d3dc92635..acfcf99bff0e 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -27,7 +27,7 @@ struct aa_label;
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+int apparmor_secctx_to_secid(const struct lsm_context *cp,
 			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 4e11434605d6..35df38592b6e 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -110,13 +110,12 @@ int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	return 0;
 }
 
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l)
+int apparmor_secctx_to_secid(const struct lsm_context *cp, struct lsm_export *l)
 {
 	struct aa_label *label;
 
-	label = aa_label_strn_parse(&root_ns->unconfined->label, secdata,
-				    seclen, GFP_KERNEL, false, false);
+	label = aa_label_strn_parse(&root_ns->unconfined->label, cp->context,
+				    cp->len, GFP_KERNEL, false, false);
 	if (IS_ERR(label))
 		return PTR_ERR(label);
 	aa_export_secid(l, label->secid);
diff --git a/security/security.c b/security/security.c
index ac0498daa49e..84f27428b62d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1990,8 +1990,12 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l)
 {
+	struct lsm_context lc;
+
+	lc.context = secdata;
+	lc.len = seclen;
 	lsm_export_init(l);
-	return call_one_int_hook(secctx_to_secid, 0, secdata, seclen, l);
+	return call_one_int_hook(secctx_to_secid, 0, &lc, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6a2a82dcd948..a2257ccaee5c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6310,13 +6310,13 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 				       &cp->context, &cp->len);
 }
 
-static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
+static int selinux_secctx_to_secid(const struct lsm_context *cp,
 				   struct lsm_export *l)
 {
 	u32 secid;
 	int rc;
 
-	rc = security_context_to_sid(&selinux_state, secdata, seclen,
+	rc = security_context_to_sid(&selinux_state, cp->context, cp->len,
 				     &secid, GFP_KERNEL);
 	selinux_export_secid(l, secid);
 	return rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 10d6c6a1a001..78c01ef707eb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4455,10 +4455,10 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
  *
  * Exists for audit and networking code.
  */
-static int smack_secctx_to_secid(const char *secdata, u32 seclen,
+static int smack_secctx_to_secid(const struct lsm_context *cp,
 				 struct lsm_export *l)
 {
-	struct smack_known *skp = smk_find_entry(secdata);
+	struct smack_known *skp = smk_find_entry(cp->context);
 
 	if (skp)
 		smack_export_secid(l, skp->smk_secid);
-- 
2.19.1

