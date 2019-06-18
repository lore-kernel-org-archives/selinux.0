Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E00C31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887F72080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lAXZUep4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfFRXGS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:18 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:45039
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730476AbfFRXGR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899176; bh=0I3d5aBbRj2bpjIIF/6kgLzw1O0SOJhU43jZoVYaBjk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lAXZUep4CrvEBC+gXm6/dTbrHm2Vc4jIEUn+dgpirgnAGvtknoLB2gIc1qSxdk7qh7Xu3s7qHGfUexjLRmEjB446iYh6pIF5Aj2SEayJCbAVvoqU3U5jQMCjileeqGytUYiCpgnqC2H8bbluAFJEUFewatFbb0N2batAOSVieqZLKITsCATj3sjeGljq8yIxxC9qLMmZrUdLuP6cXTFzqLgmaubYBKbSWZDMT0S2qvDolVIKvxbw+3FoAm5xbCyc9yXSR0Rif/dkw6JcCSa+lzfLAu9Y+uU/jt67hW+O5Q/jPVLtj/beDt1KKPSHAZhRxUUJlyK2Y9IsGN6okW6jUQ==
X-YMail-OSG: ElXU16gVM1mXAQIfmwoTW1vYIT.FIetVKG3UiRgHHf3ArEeEs_QRji6y4QufJob
 JrzYVM6RSxyYXtocPa09gMUKCsNVkrjyJjOfS0GxgSPyrHt5pRM2pnelB2KwyaeK8fhXMbJW0rRS
 pCMRCGipXms9.h0fh58il8TS.en7XSIOANoPXJNzvFNge5ZrU06Dxmnon00O0Gh3AhMM4P5q6BDw
 CP9LVRIzN5JgE6pkn0vCoJRY4eYeNEKP2Gydxfa_v5fJgkVuNDEoVMfiHctMCjBxGG_c.mWTOtc2
 DMiID4hOTatIAMRZW_2k6kUI_V18imHTktXRaWXMgdM_3AbSJiuOqlvc3uoFoJoW446yUuAmOnYu
 rIJnbOfrToqAA8U8rr.tuooRmujUq91RhTXLvC4fUFQhSaeVzpm11CWHMz5vjwksry1fXKaTuNez
 fTljQK67WIKHy4oFSm88IFZ.4Vt8VeIlt8rEdiexbLith2OxcbGt.CkVh92ShMzQ3t5XoZStONjq
 60mCWBOnvfhBpN7sZ0G1F00xEr99TprczF08IWPdZzsD7ZcEYTOa1r2kIWU4_0k7Js0Hf3y_kt2_
 2AQHuatuEY1Vt1XY0fsej6j2c41Yl7XPudoQ9IHi63eOxpGW1AI_FndgBtTBhGCPG.m_0Px6.iPs
 qqBm8CaTDFPATHqXm6eMG8oyko2RF.3_0Iiz.1BcJE04Bp9VH3hGjLvW1ng10bR1qNJEYcukZn8l
 7Ei6OPDvKD6Hjk_ajd8ovdP1xYT3BYkJ8VMpWXNFscdWJG0XJKZzsJe9RdEAbd5sEnQ7eqL8QjTb
 .PgNYtzzqD4hZpHKqZC2XSdUciNL.Ipn06KOKVCNsPWc8M5Cuyp8x7EJnoxN8uJdvPuLDPQ4FTD7
 3ipw.oE.MDiuEM8.QYzJAcFzFOMo9MLPFOL.MOnxhSXHoRM8aciO_IP9c3G1Wx..TNnIfS5jYinq
 k7al4Gz8Y1AlrmUS4BRHmzzybYhA12Vb.63ECX8gZDshX7aFGyuT4jk7QMAP7cKsYrY1ssaGqCzH
 HUT3HzAzWGc_ALrCTMt_cO.3SYStKXpQrZHPo8KIeOjmCeq2O2kTtiUDaz_a3m5byvjk8Wy8ugLD
 Ijgy4zzAZtZ9W4_lU1BhSLGDDSeoEG6WUvVmlp7l3TD2nrju9ySe0ZsZvWLRrgP0TAFSUTe6fvzZ
 IMTdR29xXyIGZ57pnoRxC9CgvyAYjI8.L03Lkp6hJN7Tni12K1BLxkKxHihJQN8kYu6SZMwtWOjT
 v.x0V8xH7dXea2EObEDO8Kj3VuPSug5L0ssVJjw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:16 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad2be8c6eeca573a242b1447ca635ae0;
          Tue, 18 Jun 2019 23:06:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 06/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 18 Jun 2019 16:05:32 -0700
Message-Id: <20190618230551.7475-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change it's only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 12 ++++++++++--
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index efb6edf32de7..9a21c376ed97 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -22,6 +22,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 067fabc63e51..89a5391f2441 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -384,7 +384,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -967,7 +967,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *l)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..e71a16f177dc 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @l: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *l)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, l);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob le;
 	u32 secid;
 	int ret;
 
@@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&le, secid);
+	return set_security_override(new, &le);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 45541053df89..4296cd2ca508 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1641,9 +1641,17 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *l)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		rc = hp->hook.kernel_act_as(new, l->secid[hp->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.20.1

