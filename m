Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC8DC28CC5
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EEE2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TKmzOips"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfFBQx2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:28 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:43240
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfFBQx1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494406; bh=eXghUWf7mncYNfyNil+VOWL4LtYvdtYwFUq87XTEKFY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TKmzOipsbKI6thV74iSElZaYrTsc05RD7ltnaHy0pGbWEhd0u+F2ByO/YEu5fV4eNhsot8I1yDMLB45L319NEt1Q/5ExOpyTPCgdRUoHmDChKk2pLF0VNbhK8ljLszK4yBtHyGtwLIlEXcskMCsWAxWKsElDdnUNBDsGk5lEMtmxJNNDv2esuIKn98tyMlY7c6KrShmqYy88HdT6Iwv4b0ggsTEDQYUf9rSJ+orDFYmGZg2k5UCng/ygFt4bsafei/PXtZDHFHIRR6aHlf4kI7xwH6OfFhfY7rlcEkNRJ8m2GhCSBViMtvHMgjxw1BJZYw0NChVgNQnlf9THoDCuUg==
X-YMail-OSG: jhzfdUIVM1lr6btE5.n4wh9rMhFFsBt5FI4ebks7L61QX.R6JVAdNUiv85cHetp
 ZbOUhOHZxpb3eFo7sfeiBaeM18x3wyHQi5D9UtdWEATJMdt67LaqhVpdtfMbtaWb.HEawU6RDQ3M
 CStGPlLaDmJssCgCB73kQ2IfiSFwIfqczfbC1W3UtqcvLJGq4YVpyQNyLcn7w3H_qNN4WVHFiT7q
 OvI6Dd.2qq8UqcrHZeHFWiNY4HNlQSQhWaPP60Hde0uX0adZXw.pXd54WtateVqDTY5Cj1Wv6_e2
 sKtaxCPQvX1Nbfoa8VikRYmG8ZBiS9BrwPdfsXnUD.HLRs4hhSeRSEQsADHgojTmkNihROJW0gMB
 rmd8oUkJfNkwMR6AmtSCNloikPyMUrZYzpG_Gyyvy31w0vFna0Ye3ooTNV5ZeOn8TPtR0LcaQcz3
 PHmoFyyt1N1wlorWMbhPeDxdu4vtOjhjSfDNrfhOXJ0F1TfP1IQc1Iet_6VVFOHqoJdTpGcDuPMC
 BOweGSE8EGObYcNZJ_I_BpfF3DfrzetAAqWyktLIkCzfNSkC8VNLTrivmw6mpKUS6pSh2qUT2rwt
 ASbL6g_.w.U6Pw.1llc89XZn5XEZKvWhsobnwCxtcsB90W_iNiAbTWq8c.foBqqI7cAbK3lQSIfX
 h7QVV_BETdj9v0EIDt8AD.SNKiODPcgfB8cb_a.DCCAS2NOJF_EqxgXthmpwbAkpr.BQCHgyo587
 bkBf8dOeFHbV4YOWOfgDx1YdR3m0Yu3s3lr_orR_DoaEjJI28Q64M30stQOXpCvaQc_.QAjjetC_
 Nsp9ZB3gOy7THqL4Sgq7.jOsECcYde0tAWwYio3jqgN7u._ZNTXMpTP4V7StkU5l6GpqN_fBWjlm
 TWjdW3ovz18HTOD20AbRnLL9mFqveY7BaDt1WFtmZeCCTed0PbfCnpK2pA6NuPtfU0S4l14xcMSt
 J0u5dHKATNnhYvEHEatbocpapj7I_5a5BEY7FYh5W4qPyfgN_phZ2ma96igNgT_xw4hNLRCmVA2T
 4C5Qxn7ZuM_5966BTrFYdQHYch0SpvRM0VN7to7gPKdHo_Q2sp6a4Bu_2vNqV_dH3IN8rO94CSpo
 kDH0BOPOt_wf95brxWUvYiDo2z6uysKVT4oNJuZXQ8KIEaXVpXnupwh_9t2JGZ.APABwPjrA_Z8T
 1K27k.ICX1p7mRJ04IfqNP5BVu4cKUDomiTMgPmFsMmm0tfG7.zsRRR.ujHdbdFKI0jMNIP0sSWU
 cS1ijFXt145OWI2MhOGFzRYkSOkJC2cKnejJbSZ4FvpMgsLhOTCH9FA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 037f0ce5b74e0a8af50a9035f5845b74;
          Sun, 02 Jun 2019 16:53:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 38/58] LSM: Use lsm_context in secctx_to_secid hooks
Date:   Sun,  2 Jun 2019 09:50:41 -0700
Message-Id: <20190602165101.25079-39-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 229899452678..c983d573a005 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1324,8 +1324,8 @@
  *	context.
  * @secctx_to_secid:
  *	Convert security context to exported lsm data.
+ *	@cp contains the security context.
  *	@l contains the pointer to the generated security data.
- *	@secdata contains the security context.
  *
  * @release_secctx:
  *	Release the security context.
@@ -1664,7 +1664,7 @@ union security_list_options {
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

