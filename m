Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F20C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A03B2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lQx68RCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDIUAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:46 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:35142
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbfDIUAq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840044; bh=7gPoCWetxgh6OIRNGIIxTECY/QFBwCB1nRYgDUU/GGw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lQx68RCt9/9QdgNGcEIANpw736vzXjIr5lVhS71Dc8ysQZiF5GlkCc2ec1ejEt4GUQHjp/3tz5Sq7IaTBA3HOg3SChDCrPFddeb1kiQpM+TO6Z1mnTTz5ZA/5SKIsAPIf0U/Yl+TOJgDd7Ns3jBoEveinXNkowdozqPMwQCGHfFeC5IA7mcevyQ7lxX0c6JCQjUNngFCO3XlFJyNkRiOELV+Dnq/+Cz8+HOv1u5PffNLlakjmbJrV58qCf2/RhAklrgDe2+isQ1fNxOYZ3hBle9AkgLjedtASGbb647O0tW/S+i3T+8voVxx5OLexBM0JRDW2MJmkKm3vf2q1NmJ4A==
X-YMail-OSG: 0QZhezcVM1kWeUP9R1TytzQzOcI3DvmGyuo1NI2P8Fye5G8EAWiBRAnJOB4f4J0
 8vQLOTaYAUQKaBToA.op0bkUq9ES9sZpwz96UAGSKtdWR8fC8hC88DUt.YjcBi5T_CpO4GW6HwW8
 goM7wNl9qsaFQy4x.VLvPlacTL0psmIPqGXaNBwZhTvF078GQi0FFbQ0K8UtBN5wDF4JR4ayETGn
 1VAKNo1wJd91hWLa1etGgUeA3L92OFVCxrqKdJoWcNvzYQQgARd8kxcSXs2SeWuMD3I5f1Rqi0Ka
 YaV02DfnkdnBx_DqoCh4XdxvZJcN.U8UL5HyTDYWEWXv2I0rtNj.sG5uqwOrvpKFZylS.vIeaWxd
 ZqdUNCv9uURmawyODWfYG_QumMA6YIjq8jwzuL_y_1uIVkSeFjVB57k4t41_gsYG26hlYjm38vLj
 Vr4VTBdQPQvx4wA8QncfxXTe7URVhLXszugEqy2No4qBDqP9FuzptxspqDcqa3pcEg4i4oGX_5Ab
 M3jeAppNr7YQBHWYmh4.VJwChkMCTBG2CraFoBSeahntb.sT8EoBgpKR4oBsZEVbEnzHMR9Mxgum
 Hd2lLuU1uegTcJ9Ev4uqIYShsecm8WyB87PBlmH6LtLztMA1cxREDZrSYrLmvvWL8cor0pSs.K4H
 1ozo0udCGnoCzCbnbF04MhZvfaJld17owV9qqJrsHKyqeO.XbgRiCtaZ9P5L.rapeRGstVATYOBQ
 MHeTU0LRyk6Sh_gwHG2EENiiMKGMzhqdybq3CHj0m_XmRXmKM439bf4LSBoEEyeBAXtVTIc4YF98
 R3GkbIrxRb9jzIvpUQ2KIu6z1IulVyBST5sbE0kImXlu.hxL9AmAnk3Au__YOqClGAjV1wPJFRo9
 bknW8xWECjrp82ShP8YH2mPHzL.ESpRg0PRnS8wWENlcBV2ySynk6U1EVIFhEG8p3YleKoIwT86G
 vJKBssI19aAkcyslZyQInfRRaSP6557lm7GrjD2o3J7kHBTAAm_il81c8yUloxT5hNSDyR2bq1nb
 3UzQsfmFYuRoHnXvY2a6wk6DS.H_Tnv7TVscvPVcVLJEfhTZjsIB01vPr2b.ceOgD60XVmWYih5y
 5Lllptff.QL5rWQQSfjB3onBGtj3YFWBd251PIsdyc3cgrGMzfkAohvg3Deo_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd207be9b16b6375049b46b06443493a;
          Tue, 09 Apr 2019 20:00:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 38/59] LSM: Use lsm_context in secid_to_secctx hooks
Date:   Tue,  9 Apr 2019 12:59:03 -0700
Message-Id: <20190409195924.1509-39-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppArmor to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  6 ++----
 security/apparmor/include/secid.h |  2 +-
 security/apparmor/secid.c         | 11 +++++------
 security/security.c               | 12 ++++++++++--
 security/selinux/hooks.c          |  5 ++---
 security/smack/smack_lsm.c        |  8 +++-----
 6 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index af0bcdf8fcfe..566714aa0caf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1323,9 +1323,8 @@
  *	length and the next call which actually allocates and returns the
  *	secdata.
  *	@l points to the security information.
- *	@secdata contains the pointer that stores the converted security
+ *	@cp contains the pointer that stores the converted security
  *	context.
- *	@seclen pointer which contains the length of the data
  * @secctx_to_secid:
  *	Convert security context to exported lsm data.
  *	@l contains the pointer to the generated security data.
@@ -1672,8 +1671,7 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
-				u32 *seclen);
+	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen,
 				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 5381eff03d4f..964d3dc92635 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,7 +26,7 @@ struct aa_label;
 #define AA_SECID_WILDCARD 1
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
-int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 69d98a89db75..4e11434605d6 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,7 +81,7 @@ static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
-int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label;
@@ -89,13 +89,12 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 
 	label = aa_secid_to_label(l);
 
-	AA_BUG(!seclen);
-
 	if (!label)
 		return -EINVAL;
 
-	if (secdata)
-		len = aa_label_asxprint(secdata, root_ns, label,
+	/* scaffolding check - Casey */
+	if (cp)
+		len = aa_label_asxprint(&cp->context, root_ns, label,
 					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 					FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT,
 					GFP_ATOMIC);
@@ -106,7 +105,7 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 	if (len < 0)
 		return -ENOMEM;
 
-	*seclen = len;
+	cp->len = len;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 7bf16c547010..7cf8e268a45c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1989,8 +1989,16 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata,
-				 seclen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, &lc);
+	if (secdata)
+		*secdata = lc.context;
+	else
+		security_release_secctx(lc.context, lc.len);
+	*seclen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7dd333f133db..6a2a82dcd948 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6301,14 +6301,13 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
-				   u32 *seclen)
+static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
 	return security_sid_to_context(&selinux_state, secid,
-				       secdata, seclen);
+				       &cp->context, &cp->len);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a837af153ed9..10d6c6a1a001 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4434,8 +4434,7 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
-				 u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	struct smack_known *skp;
 	u32 secid;
@@ -4443,9 +4442,8 @@ static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
 	smack_import_secid(l, &secid);
 	skp = smack_from_secid(secid);
 
-	if (secdata)
-		*secdata = skp->smk_known;
-	*seclen = strlen(skp->smk_known);
+	cp->context = skp->smk_known;
+	cp->len = strlen(skp->smk_known);
 	return 0;
 }
 
-- 
2.19.1

