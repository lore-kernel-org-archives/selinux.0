Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D43C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABD126FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AW1RAyln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEaXRI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:17:08 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:42459 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbfEaXRH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344626; bh=eXghUWf7mncYNfyNil+VOWL4LtYvdtYwFUq87XTEKFY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AW1RAylnqTGO9/SAxl3SlXQUrcQvIMVZ2vFxYj1iZLW6mDPL6kv/HUF6fLJLUvZLB3j1E0Q6JGAFaWxsp8l3IbXrUC3UZWAPlcEDAQIcNYoKinD4gj7xPFazK8hsEPwgMs31+q5r/bE3LQmSY7wopMzAi940sQMJxlK64Bgl0IgC5JTyLyed5XEuxVmRtQsWMN2Fjb/mqBG9aqhpB+vIiw48JWCYDFcE1k94wzVmdARqAFLKsj6vodd+Kn9bJCxs7IfL3yBY/jk4OZ3C0z4QSvbTplsqkrDDev72v1YUy6SuvNu5UNDnAb4vqNL3hgbfCTI5ROciyqMh6X5khDfhjw==
X-YMail-OSG: 0tRb9pwVM1n8ATp1VIc8q0MXZeY2y9Vosr1HVJlzmwxOWP0G4SOeVYGQH2koYs.
 .aZkPdrRXcHP0ITnzama9ZerKKGv8wRgcK_IgEZshrjABfLIqG6HFRuxN1ZfxnGy6bDGUBrgiiJc
 wfTe_x5OT4NQk4VPCcw8wmpbizSYiKE59PXAK9fQrOqWlDqQuQ_dEh5qlyBSErQwsyPBYlHah8aw
 SWnjOYISFdP6bp2yBdxDrWSBQu_Lmt2QWh212T9Zs8G8MM56i0ViuzyucIUgMB4iAA.yVb3nwbET
 2mo3fhi9poyqkxvNxRGXSphMLTPVDqb1Ep2OG27BUPYgRZhzigSNr6bWpxuXoua4C1FMn5Cb_cmH
 HtlJlmuB_VzSjK5SR6Y9IWNSM4LGJBAPfO26at4tslAtCQW_SquYeTV2Ya7jYHN00zl3QYnt0v8B
 .BbhZWyhabV4oYFcoCq6hpbwwVD3rkU.Qr1vmQ2P5xkvgu0ZRoIogvp1QGJ7S5HywCXLeeAM.WI8
 sjvqs67jd5dVt8s.KzJoKoBNZO.RtEa6rIkQqQpUPBZll68WHeilts1940dU0lYPXI286a.QzKZR
 _hDcGEdCDhEJb6Yh7NjXmMVmFjs_qUwOXH_9Rq4I4cvnWpcGKYsun07bMQoDh.Fe2fG5Nue9p6e7
 htELFHbnYhsW3TNuy8LDNlkeb6VCJbpR6YJb_E.oPOuUniaoCSQG64RCIh6Ls5cmkPBckF6y_Obv
 ZGogIc5Le2pNlWJPW7QVR_kv87.MgV8do.BEY7mBYIy_xIcDrvhkuxJDXFHw.OL8CUD6yORee_Fc
 C_1zvaPc3mFSAuFB32XjirkU4Ut9rNuWFGxGMY.WLaXdUJK7O_sRymgLSc5Uy3Qw6pvHCoswHvaj
 v7pyDXpD.kIioF6WfGsW1Oo2EwiP3j4ptnigioZTtEHIMIrOciIqe4y4KkRyVkYMyHPEAqZ1nSV0
 fZLuqbhvRo38lcTHRf6WrH0y8FcGYOmDgkMR7.HHydLvAvY0GwmRIlCMT7DGhFoJ900owyDwROn6
 NC_xCwEi.WcXW.c5K0cTk_xySHYkYmZbvuXWn3KAHYMmJrweaV4f1MFyf5PqtmVQ186LLr33WDn9
 H4Pd_FYxcYkqDWf0yxJJ.UBjHHSY5VE35bmg_duUKkrHBTHeBoFrWr6CPYy_qOHs.xuxworcvxX.
 izLoJQReYheK404uGdnAaSCkTLw2mtl3PaZom_CrKk1lTg7AIHt_JgyZoLgJto6zpHjXo256cjJm
 SZQyf6rpmZjf7vIZq6zVqzFxQJR_ynvB87Mfftad9nhLRZ.zClOpdq9X_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:17:06 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp407.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ecbeeaf97d7184c0d421bbd47d8c0363;
          Fri, 31 May 2019 23:17:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 38/58] LSM: Use lsm_context in secctx_to_secid hooks
Date:   Fri, 31 May 2019 16:10:00 -0700
Message-Id: <20190531231020.628-39-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

