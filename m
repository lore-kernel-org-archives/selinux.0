Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FFC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BB920851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gERfJ57n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfB1WUY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:24 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:37780
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730126AbfB1WUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392416; bh=Ib2k94uXrs+IQbG/SjQ0KV92IRokbm9buCzGxBhJCLE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gERfJ57nwg51g43G0BWJkyqzFzvurmA0jhRrW7MfECou0z7ffor71qvXn5Mta8UWXiW1F2PIbQzuHZqRgLrJUn/TKxuktmW8imzvx3CcglTJmQoQ93RkPcO5ruGrjNxhNOgDJJzQPaoJWgN1kjvrRqT3TY3khtmmD9+CHVXZ2fhMwQKZxsoCHDzo38lWfeXiAOmEW3qH7mdvNmKYrZASbhwfCbD9+kiIAOjJGV4lBrDBC9Oxj+l3ibEP7CXOLDtwqgD7l0b44jrNnV9UAAbMJr63n2tl1g1vVx3z8bGpuFdWHeVjpU2KqLOgQrxJM9pEFnJwYXvZNgszkN6/Q/VGLA==
X-YMail-OSG: Zh90ZbYVM1kRgqGgNsl1PsglPulEXG2sP4kjnzLSNpmZwlSbOt7OLpsnn2r.VBQ
 htjZvrBTAKqvPkkcC1Xb0njJA0ioE5C82Oaa27rjdLOeXbyX0TYRb3XxkMnCXfsQToODPsVuMHo3
 aIu7EakBWcnhatZdOoyeDW2VccvGfkWBjnutpueDSC.gpBTT0HD1se7extXa8gE7KeR87G7Qm4lx
 Eqnp3NzNnGM46jmogQTRvqcImjAeotvB2NDHR3OCjA8YkJeUJgx2NWv_qXtTCmHnovyRS37J7SjZ
 29wOPw23wftNwBi814W60VVeR8poo0VyvjA1.hx5fcoWs5gF3aXcoL6p1UFvWpIbgUQyRj3UNvQz
 le7ABmgVoXCWQ24liWsVtwLft89eQDwRWoxZ.1X7meGzBThjffYuthqLKmXH5glZ7ueBknK6C.gu
 Yh44kRnyCd0pDLDw79ZXgsql_uB4uSN.5gUXr1QLcwvWsA1wJG3gbxL7oXM5uSBAdpB4yc.bITzw
 eA6Z98T6BgH_9yTfcBGbC9NEgQTVh4kryp_hwHQAsrttoB2lEBJyUdc0Au.RMYq66sXJffRRWBkK
 tpPB0zqtmPmCgWWc.dCoDGP8ZdBVfPHm4gfCeLbS3ViiKGq1HcJjzDznmiFVuEBuYxHlP9VWDrcL
 IDmGl4ikVyoHIfDk79crUCYDwwv9rcFjWdjgkBJfzYN.L4Y7XqIafzccR3W13wgxmjhckF0PXG3s
 iNL3uUgMJy7fglZ.jiE_sYZAOIKsfNoLrd8cjmGuub5DgVq7iqueWNj98Au8OpaboiHuGPqkT6Yd
 NIHh9N8NyMWV4nffVMLiz_KkIinOjpLGO7_Fw1cc7orIDH.t3lYbeBLTvVJoQYrr1KoOpn4kG3V_
 OT0y190vjYsxiLKqGme5p7y2UdaznVRdyzlZNLn_AXj4tali1OjtfcdWoQzIP6Ya9WoP_1rk4_d3
 QyZJaH.spRfRhOtrwLGYm4twJ0wl6JSa1LAn1pzWwwNt24DrUsPj4satIJIpvhJ6mIvsDPrxllXe
 8yQ7UYoeY3lAj4vxdqrVMSflNDfJ1IFg5WdJUjXcqECE56l4fh7XJSsodAASyuopABY_XIy4maHn
 vzoOQ_Tih_OcOpvBUT3zK4HRAjauPw3BLcHfa5pnvfG4cfE4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 45/97] LSM: Use lsm_context in secctx_to_secid hooks
Date:   Thu, 28 Feb 2019 14:18:41 -0800
Message-Id: <20190228221933.2551-46-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 97b258488e4d..bb748b0a045b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1311,8 +1311,8 @@
  *	context.
  * @secctx_to_secid:
  *	Convert security context to exported lsm data.
+ *	@cp contains the security context.
  *	@l contains the pointer to the generated security data.
- *	@secdata contains the security context.
  *
  * @release_secctx:
  *	Release the security context.
@@ -1654,7 +1654,7 @@ union security_list_options {
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
index 9b25f0113b4f..fa94f012a7ab 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1991,8 +1991,12 @@ EXPORT_SYMBOL(security_secid_to_secctx);
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
index 4d679697cdad..00b47c01960b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6203,13 +6203,13 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
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
index 015a2342aad5..a5108215ed49 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4370,10 +4370,10 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
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
2.17.0

