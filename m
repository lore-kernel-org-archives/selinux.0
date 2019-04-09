Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB9C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C998A2084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GMDA93vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDITT0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:26 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:43052
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbfDITT0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837565; bh=oZw+jxmu0klx8qKKkocY1UUY4fu46NlBbhyji1WzJ7A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GMDA93vUiPVqr83w5m310mw67CyTRB4EzCO7nu56arv8aG49d8+Rd4tq19F0bVgg376r9KCoOhMLNu6dIJKhzWB5FiQmN++DcoY9eTmYbf1iTvPjCYhPy9xvvjuD5As/5F+b+JU7kbbn9FMZHbvrpWLTwc/8CuEE3+kucVcydXRVRiKPtrWLbLOUJ64KwyGCSTNEVnLLnpd80Gff8hTRkV2bpTL4PcTxKCus3NPMYVPBZnFS42U6o6A+kZWk9QfW91IlW6gIeseCdp/ztmBm0RTph+BV2qM+iRvQhuk3IHdF4W0jSsYRkiJZDfoSWy6QMSehgk58WVlnYleG7du1iw==
X-YMail-OSG: 0Tas8dwVM1lv0Fl6Ke7B18SMKR2YumzScCnNTZWo_8lkxex9h6Yr._hJYlqkC0i
 P1fRkvA.YONCc51FWLQkdF0qg_ap6oBD6tXBfpW5f9rNj5tIm2EwyzVQLRv7IzOcSjmHDyRfvip8
 iBral8AXXo0ey8017vc1raLVLyz8bYRS40679Rwrgoqe_zeC_hKHaD_R8AZSaIrRmmJhyJQWZqfv
 JLbzUo_1fs4Jpru.gOnNCzraOWB3fPuw93dhR8CBRDllY0rdUgVtVaNK4xrk0CHGZW86bqtwhMDX
 1_7fLmG6EIibL1vOUAA0dWYjjCfSNC7gh6Jog5hcSMGUUMm66T0MXT9jdcp_cQp1I1ath3rxlQTd
 g71FF4vGVPWCT0iWo3U1A.C1LwzGeovlBgRAP1VvHrXmJyym6.Fn1EecPD0fIDxgzrqH2Kl82Qfs
 MBqAjPAjuVeepeYYrKfVFCmBdUB4ibXcU0qBq2ZM38zpQXPCsOqFc_tBvTMmP5vEBaD21b451bD3
 eR1iBIf0FiNlxrTHZxC2UZWyG62uUJc4xaYYhZfhMoYS487FvZCyVlNCe9TIqcwzvca32q.H_jcc
 hDVTX009rC4lwAode3MBH0fp_f5VGL4HMXTEf89nmSjemMj6._BUMhJVg44r8f176svT2DyRDR8a
 rw_gkZbuAHlwHEtMnMfa3yDgumq7idYkFUKiDtN.Jx9Km2qFme6tUsJDJeamKOA2CFtVwNZgQtTf
 NlI.tGTGPOVJ2PORbJ.KxAFihvspBsgEuOKLL26tLmhi10fm.sV1QWPjIIYW.duabnfTjAWHoLq9
 CfjBsHKa9aYESr6O1uxxiPrIKY1OJasFeEMgzTW.6bpI6bVJANbODN1RP3rWRjs3avZxv5oEw62z
 JxSYrT1w7R1S1f0tTw99PCV1GL7z1Cc2UXmCuNRs7toK8ckZBxrbUfUIIO6rmhQZxVFwom_Hf_cF
 qPchx4HtMgSOtzGGfDpNRo0lMgphzDnSNF86M3v7FkApyVvVLlFcHRj9nPW8oMPg5QxZuH17YrnE
 gm2dNfVKW7BHn7u2FfL8SWsfigOYgwwejic6vFmY33fOOf29f6A.URcCqFL8GOB3dtpk1.5Qek31
 CFFDWLMI8Ku3I2QqSZcJaL3h7_87TMRe80MHO8M0jLfdCcj9y6X8HoQ8mRgY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 39/59] LSM: Use lsm_context in secctx_to_secid hooks
Date:   Tue,  9 Apr 2019 12:18:28 -0700
Message-Id: <20190409191848.1380-40-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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
index 7cf8e268a45c..f3788840019a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2005,8 +2005,12 @@ EXPORT_SYMBOL(security_secid_to_secctx);
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

