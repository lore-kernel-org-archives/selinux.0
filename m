Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF91C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A67217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E00x9vpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfDSAqv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:51 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:43270 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbfDSAqv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634809; bh=seyjgce0pdmEa+cpaRVpjQK9OBPNuMErUFViqdarFKQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=E00x9vplU2AZhWLoh6V4GKvq/bsbM9km3ehZT8bpNKDpoQDmMkf+bzAOUMkNhOtXKGjX1aCjQmVUx1FXjLArXxSktvCqrRPpj0EFFKA2J2MOP35KTIq/t9tlKpA9vCZOT7YXfrQECHcwO3/EAN2zkCNOBL3axNB25kf+qFFWJ1ITgK87vzS+tLlSJDq9RBCpxJeee/EDKcRVNgaVL8wDy7YMfQTKDIgWJQWGAVLIGcNNmRHWzv0tGz7yrkPnKJCqzTcgEjtOr7zYEeLpq5emq4GVJ/QQ2R43ewzRyKlamS2Fq7A44xM1y0KC0EYvgvoYtbK0FysQD+F+LGo5ECc9fg==
X-YMail-OSG: PBB8Q4EVM1lEM4EMadN1pN1zteZj4j4xm5qH4PGlHvj0hqLtQQxouxYvTc8jz2F
 0p9ERyxwmymM6J6tjcd.3KySmDfFRARg5RaaR42N8Xzmc6Yto9V6rpYYD7tS8ejz6g6_L0NMVz3K
 ur_M0ROFn4O95fgGfAUF2j1gotiO1FvtNgwjqSKJ1ymnQNjipcBwme0A.LYvZH7WFS3CSXLd4Q.M
 0z1EIQ92zwhsa0aijag7L6SgFhuhRb1dHBGU2LlLXtt1Hy_QxYrMU9mYW0qyVvsXQavktEF1b890
 Axa.Bs2p.rP2JU.enKrrhnXFae5.ce8NV2hiwVHN5I16feR.Kr9X31zcUj2uAfIkwZ0soj88ytTf
 xCZscXQpIfN_V8jYKZPYlYqAxSVn0q8v199s7V3VTEJH1V_H2OtncHKIFn0x1EKb.3VRD1aEuP7y
 nzNeiPbbvw5ICfwFli6ICk82eZkdF.JZWR1OE_UOmq5dS330H8PtlO7UfE53aNOgg7EGI2ghxXfs
 MPjPBxYnmteeS2xP4gWpYu9Ao.EHqK_zuxURVLd_5iPsPpLJ5uTL0ToSe3iI3CEfz_Ro5V1GW0TV
 p8BwyENmTSENJQVBtSErgNlcVD3inU29MDVPdWSC75oSYi16fQkssZyCuk1Lz19zm6Di9RQ6yuyq
 15OlS7I8IHkdxMj1djg2FQkVbNtXsx_acjNzd9IwtOBaCmMxVbsR96WZo_Px9bPRCZY3mnypeSmH
 cX_NIa66TZRWJpAZFSWjal7bktTAmrMlQb9OnxqDlDbV3NH3hCZe9zy1vXo1mnE0p0BsOIFrRRbL
 P0VcqM1UykusWcLPR80Ozl2RGoSf5i5dyLBHhkR7mlRxW1LjVZBTieR5FMjI5NKGYn3bD5GivxOS
 auE1nherfa9d7dNh3vcW6H2SUF7vaN9Px4D2KBvkE9L9zO4PCRZlJXbvmImYiV4KlpWebdssYVTt
 ZuJc_m9y3BVqostvUcBfdJLLXSBPnAPYlh._yktJoAFlMGAHZwf5aq3idI.Eii50FWt7CTZJ.DuV
 2eK3_nidI5LGqdvDXDuOra1aW7LhdfuNmPbLmIdfTFtWRAk1zM83n7IWM9zGY0AqHNiMH6Jni_79
 1KSw91ls7Eo4CD9BPSOc3mtEeQXewYePKkAoL9u.ECdS6Rlsj1TnJ_RhBMKZUd3IK6_0uXG7o8oC
 c7v__UVQiHAG1Yg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db33df77ae90d094534f9c2fe92816eb;
          Fri, 19 Apr 2019 00:46:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 12/90] LSM: Use lsm_export in the secid_to_secctx hooks
Date:   Thu, 18 Apr 2019 17:44:59 -0700
Message-Id: <20190419004617.64627-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the secid_to_secctx hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_secid_to_secctx()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 5 +++--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 6 ++----
 security/security.c               | 5 ++++-
 security/selinux/hooks.c          | 6 +++++-
 security/smack/smack_lsm.c        | 9 +++++++--
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 690ab020508e..11ace5c923bd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1322,7 +1322,7 @@
  *	This does mean that the length could change between calls to check the
  *	length and the next call which actually allocates and returns the
  *	secdata.
- *	@secid contains the security ID.
+ *	@l points to the security information.
  *	@secdata contains the pointer that stores the converted security
  *	context.
  *	@seclen pointer which contains the length of the data
@@ -1672,7 +1672,8 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
+	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
+				u32 *seclen);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index c283c620efe3..03369183f512 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,7 +26,7 @@ struct aa_label;
 #define AA_SECID_WILDCARD 1
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 1546c45a2a18..ab4dc165e43e 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,15 +81,13 @@ static inline void aa_import_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
-	struct lsm_export data;
 	struct aa_label *label;
 	int len;
 
-	aa_import_secid(&data, secid);
-	label = aa_secid_to_label(&data);
+	label = aa_secid_to_label(l);
 
 	AA_BUG(!seclen);
 
diff --git a/security/security.c b/security/security.c
index 60dd064c0531..adf4cb768665 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2002,7 +2002,10 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
+	struct lsm_export data;
+
+	lsm_export_to_all(&data, secid);
+	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, &data, secdata,
 				seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bfd0f1f5979f..16d902158e8a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6301,8 +6301,12 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
+				   u32 *seclen)
 {
+	u32 secid;
+
+	selinux_import_secid(l, &secid);
 	return security_sid_to_context(&selinux_state, secid,
 				       secdata, seclen);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a3776501965d..809af981f14c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4433,9 +4433,14 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
+				 u32 *seclen)
 {
-	struct smack_known *skp = smack_from_secid(secid);
+	struct smack_known *skp;
+	u32 secid;
+
+	smack_import_secid(l, &secid);
+	skp = smack_from_secid(secid);
 
 	if (secdata)
 		*secdata = skp->smk_known;
-- 
2.19.1

