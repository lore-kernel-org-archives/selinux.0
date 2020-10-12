Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FF3C433E7
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190B52087E
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a8FnHIW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgJLUX5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:23:57 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:45335
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727433AbgJLUX5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534236; bh=isPZvt9ae65Fp2cG8CZ+mCvTCzI7HK9DyLVMn9ittBM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=a8FnHIW4mlKnLhJ7el5R99tHwZcLysLBZkSnkvi0TefMXH4ko0Hj3AcIlIk1CC/3nGQyKlG0gjGvnKWoi4FffpLDSDBojwKRlLNiqIG3cNaFBVkxZS7csOO358BzPUY32yML2ub5C1SzsHp2U6GqU0tUJwF+8799aZsRaqgkpFBNUJlsTKHFY3do8ok58ZL/Rcfmbc51+DEE+S7oDaiHsqfThigWH+gCrucMhanghbzRjrTrHKfQKdPsfaluF9NI6h/G0eDtMhhcuKrgnpClz6F6QvJh7w1QFLv6xMvY6Lp9QO7I6dFAsoN4B6um+/kCCd9mjXDz1TgfMgdEqAOErA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534236; bh=1NQ6/sbnFEDPBPKLg2KWqII5Tj3TuCV6+TODkdxpRKr=; h=From:To:Subject:Date; b=smi4XGA+5eCLgXjTVUVW3rp/B/PqKps6pTxLaBr3HetLSwWkbWUxyea+YFFKFqO+PFNbQvJaAaKRJ1D7z/8AzwJu6HZTMV9TNymcMAyk0AP8hzHaP4f8RipWief5ayTl+wL121b4I2e1x5V+jKqF4O5FNFrCVjOgCK/ivIO96kHgAsuOZbGLbKG9WzCaiBoq4TjMiPgb/Z+NulEBwbJon4tw/zPmJ5mFAoCjU85tHJt3JCt10HcavXCGNeL22kcoCd1+KOWYMekXlMADWBqE4I5vh7I3vl7sM6lHp57DoM+RNosHApoh5nKHMc8EtnZlNZNb2clhoMOh5GL1nPdsCA==
X-YMail-OSG: Lu6Kf8MVM1lYZVG3VvBhT3K_2LWTRhAg64Pt3iOZ7yeeM5OA6NetQKVkp6cZbRY
 gZ8OymAyj.gZjeVGPdrfqX2ZxBDFrYRmy1_6tYNyO7E_qzGqnSje_NQeX_7hli09DrrdOUlIHnka
 96WEHD6QjvIAdqoiXXivgB2KiG1jKdGov2wK_F6F3MMuNrkYtQELBxr0PRanld5j_pHUuJxYcla.
 gFbcW7knn6pwI_.lO2Y4tz5106cRNF6OOFF8qcMFUyK0sqmuapxbhGs9vPz_rt1EIhpPyVKMoIWW
 DwFTsbS5GAsfn9h2CHewsDGnKlKFsjJtDyyiXYoQlSrzyEW0rHUD0Xm16.7fzCx6TILNs2lIGKDB
 cHzVTWj3zsfuMaHdsscOWwVVuvBlScWysdQIi0sQ3XW7jF3KaSov1PNF3MTiTFYosO6Tj7YkYwL2
 PZWrjTpFg0fImV6cxjKmdF9G2y5SeHdClPTqVlUXXJN.a4lCJ0wsqF9bOPpma5dLU0uVFG4JyfLN
 j6_FUchHmMndF_QrJBn6m.eavsixGma.hY52njQ3djI4s73L1XlU90DOEuFH9yJ2lkg0NhYnWhlb
 4J9FMiqcIxn4IouLUuRCGtCKZtfyUKFAAwee1neEMxXVqBfFWRdIJpGw8o4n5fUcNrOh_Jktk9Uj
 u.are3egqsrBFLTWDrk8JcQrk8WdyWExrWW0WkJPNGB3r5M8jn7KgOCV7xHBfJaI5X9MU3SCHMwu
 aS785zajus7Yg_FiHY8je7rMFz6eLO.NrcAw1iXlYzXcyQsdzFUZOuRPhNslZUtOmv3M870SqRMD
 oJoWiMZ.acydqt_zRgLASvT.jjbdA2L1cNpha6tYDgWd0F7d53NbWkeVpMuyeWe1HLDDeA9lfXXZ
 xcRWSKXaYYvW6eKZlZWxfNuJkUG.xJAshB9XiiPYMOGkgn7Qwf30rXkC.CcbO9vAHDH_97XM4n.c
 SzCHObNraQwOpecsAIA542j.dZD_HvrQA1gK50tBFkT9_mMvOckriiF0V0X8HnX3CXRYURj15n7y
 Vc0LUJFEGcaywImN8BLfFhyHjqVQJc2hdGRxa5yeF.wfXmZ2QTKMXnU1caCUmNGZN3.mn38QVpRE
 ouijEysVihA0Yd0gPrU.0.bfv6jfAMJbyzRJtBAcaafJHozoRjnCvVWFDMCbAIYQeGh0c1HJ34YJ
 NJA9MtjPRT0bSUtUlvKtdlU0qNOFf48AH4La4oaJ7B8H3uhWZPE1PVF9Q2aorgsNQzMvuOw7hMCU
 ZJD.Qwp.I71q4ZO8c0i.N.Z0046mKDOdAK9dTaIHgkfGiPnU6zXNmJu0NQke_sedIgTpYnYn.q.L
 tNbBBX8hQu14d2l6Nljhr1YxlJ8cqlQ.Runc8yTjNyeJ9GR7E97OnM9aR1eypsFHOYqyYjbpsJwz
 Sc2qwSGfT7q67Kjeq3VtU0smqka28AHkwFVkruYPbg3EKbyYBsn7Cn8BtePlngVirFb_J3Vu_K3v
 aYNI_wLtPGhsgAqEHG7Nq5Ewigp_p3JV68VLtAkK8HwNHT0cMNMwYW8etyh7fZtnrXC3EGj2TCEc
 9pEezZGhS0cuxzWnQ2ZZCCYPn6abK50KEEdHrQ8oABfNfYV6S9w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:23:56 +0000
Received: by smtp424.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ce34801972830366278caf76cfac350e;
          Mon, 12 Oct 2020 20:23:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon, 12 Oct 2020 13:19:05 -0700
Message-Id: <20201012201924.71463-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is updated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..03ae0182cba6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
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
index cbf1eea42e72..e2ef982b3dd7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -442,7 +442,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1056,7 +1056,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 421b1149c651..22e0e7cbefde 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -733,14 +733,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -756,6 +756,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -763,7 +764,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index f9a249a93215..d6d882b1f7d5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1692,9 +1692,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.24.1

