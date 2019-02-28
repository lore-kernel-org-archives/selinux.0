Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A31AC10F0A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ECA2133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qJTDmDS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfB1WT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:57 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:46278
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729591AbfB1WT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=n/0YPWUlTL4zn8PHiK5mlki3U/dbIxLef3XO52Tozg4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qJTDmDS+QCCQbjDp1ZzTlJk8pIG/bUOY0mgQBfpKBG1olLn5UUyaFb069upIsXqncvJkUWVZoO+52fVl8Duudtr5Qj5g3l2i+L8JW+m7PXl9AFuZ3H+5Ic7Ep6AW/sjosW2Jrrj8IFtp2Tjfodz/wuVbsG3FscGg5a3eZ8BxVIygUC3/ScqGm2Zl4msOhQi37l0//hHmmWujG5Oi83kcotlAQZKf2oPPuKgH8t+A3dMX0s1JNTtX2zW7uiB6QrpNd1FlUXvYkaFTKH1zy6C+Dq0TtVakrysn1u6z2SXgROs1/2iCvxlxQJi0ucYt+42rJ0ZAYt+qrDUiSHMPxtY/Kw==
X-YMail-OSG: CLA082wVM1m23PAtjkYRntjIj0dbI16QpbvyrvW5rKHnYK5hmD166iqnqCM6KC8
 u4_vHzOQ_9b9P0Rm.1dJ96Ak4zI.rnMAFf1fPsBThY5SJQivFxPSQ61vjZF_lZHwt9Njj7.YEXXX
 rX3Lpxd2OEGDuQcyLQcKvZ5UevC43owUg1wR79PEFPXcd7rllpkD995_pb8NISKD0uEKrhM0r8ZT
 yaIVPVS537zqeU.enn0kot4CP2WdR8ugA19qFXGQYtJWcoukDfqhJFA5C0CLBQsseOdAO8k8kYUf
 wwaWz22PG_HW8eca026W_z7bGGTXmA6ZSwigDZK.05NkQnIWG0MiFbiiTLnyL83xvAPANTqqoj57
 B0QUFoeDEkgh2oK1z2pEWLGbsfqkKvmJ7K_xaMSTC0gCTHu5A8ouIUfXremlWpkxSNdgt0arrQnP
 XI2ktwCWcVioJhACVeDZRXPQGXtJbcflDUNsqAtceVZXPYWiXoWGqyR_61hFh5bIsmeM.GOYbTyZ
 tFnUTTbf_btSwYWoOAvk7M40R6cYtBcKo7p3JvW2rgLG0UKKsr4LcQaA9MtqbhPN3KJXHR7xSpWx
 agzxJ_o4C8Muze7YD_9MH9qrxYeuGGBWy6bUF.t2LppZNXib.cbChw25p_AWQHiTqPJSJ8oJ7Kjr
 AtfXjr_DRdLqs16MAfjYEXTVSUtPQXvM1zIpqopjJ0m4cKArQjFhqEvIrXxUApT5TmlzMDqDxJBZ
 EFrRII0vDdDORwfqKuDXMIj.tjLxNPfgft985h0KcaVqIJNhhv2qj.E09OwhASWpXQ8MNL4FhP9I
 asadRuPTclWxNqh1YF1.tJiHo48ZE4INdmscXcJs7a_Rx9fEbKSsXmfnG0ig_XHkcjXOFB.XTJgw
 CvnvFTvyBhIBERHKQHq_WPYizHleYhwVg6Vu61z028j8vQOhy6_98YA5YhxZGTZnf69fq_l4weMS
 pbgUwk_X4wXBSpwsG0BmeW4QJKbCo1TrekZ.c1cIgWIN9SGlsPxhjW_lAzbNhIwPsSJSPRNWq.Pm
 bI0nvUBwnhTXkLOfqejaniudcJxnsHJDUmW0yve1IVVE5lSvxIRXeKLyKoj6AvFJ8qjITsIvvg9e
 2GXqq0qnwPOw2X96DFNqY6Oq7odtvyOFBs4goOeheIRe_xgA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 15/97] LSM: Use lsm_export in the secid_to_secctx hooks
Date:   Thu, 28 Feb 2019 14:18:11 -0800
Message-Id: <20190228221933.2551-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 932af86333b4..50629fb10cd5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1306,7 +1306,7 @@
  *	This does mean that the length could change between calls to check the
  *	length and the next call which actually allocates and returns the
  *	secdata.
- *	@secid contains the security ID.
+ *	@l points to the security information.
  *	@secdata contains the pointer that stores the converted security
  *	context.
  *	@seclen pointer which contains the length of the data
@@ -1654,7 +1654,8 @@ union security_list_options {
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
index 51491fda1bc2..6e05d3127760 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1988,7 +1988,10 @@ EXPORT_SYMBOL(security_ismaclabel);
 
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
index 1cde918e4140..eae3c42c07fd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6194,8 +6194,12 @@ static int selinux_ismaclabel(const char *name)
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
index a1a9fdd3f1c7..83a2b1153790 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4348,9 +4348,14 @@ static int smack_ismaclabel(const char *name)
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
2.17.0

