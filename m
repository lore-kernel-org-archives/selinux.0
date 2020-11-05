Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7B5C2D0A3
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45A920BED
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LjTcWGnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbgKEAyR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:54:17 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44838
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727246AbgKEAyR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 19:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537656; bh=31g/5HzX6krn+gOjEWAqS8zvx9XmSVzOa+BADnOe8TY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LjTcWGnEtEN/RXTIPE0RyBMMZz/dxBJhkZSLDtfTi8PCjw/nKFg6i6GjNuKE1z7T2o9DhIiNoNYEsU1ntLpaSmCD1QcqdrCCPRTGJNB+Dfyn6VNTiqhPreB1w/WhhUWKYvauWkDUYzGy4NEO9uuAdQaDfaTavqzL/OSzqBTyVJW22whlyIdnPYAferUZMDLuRnpWo6bzKJmzy7T2g3sfqCu9uTec3LCSF+78p8RvlEMGWoWk8Y/ErFTEeAc2pN5R7syYenxhMhbV812FwhunJFwFH70mJnC8VRtsM/+A2bHDnG+qjWdzNdkTsBvxChw2p+mwP8QFkbObx090EzD7Pg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537656; bh=5xxOodsEPGAavw86xvOGAbWnTSmZnh6yKBlYnH1SFD4=; h=From:To:Subject:Date; b=g5y4JpJcwphUZkIQeNml2kyE2VTJllunGzCpHZiDSmmpw1UyeyvZEOXc33ubGJ1+6ZlzzJorgAj7x8oDRwnhV+ZkCHaUl49gP1412P2KTYbJzp+HhX/7P1jntJJJvrf9iB5+ozx7x95Ady42SsZx013itvwKzYEGwf7MQ43mTqTCRqoggtzf5yRHxvhWJq0Ij9enS1smdvG2XvjhrrCleYGR6HPH83bwEIwNFHXFmEWcusSDVivGqqW1K6pXG4PN7jnZE2xCPO8tPQrKlqowQ4p8RuVyllgjeJ9OV1BHmECI6sk9k3d6g/qG3uKUHshiOFbgSJW0AuHPQFcwCiaqLw==
X-YMail-OSG: aaSSyosVM1m0FNP9m_xQ_fENPZcYpDWQmHu87DqQ5JXBoKNe8xoBaLLIl56SgCQ
 CH2YsvKGqTaIZayAF4yBojVtl281gejYlBqOYFttG11BpL4Lyoxte0ACvLOrs6R1mcVZxvInC9Ui
 5MYpmN9a_liBGLCTCz1.aCiS9E2HlJVRuWy1.rZsy1pMMl4r5Pq14FOeN3aRZkZGJZPtgX0o2BQ6
 S2OeEis7CqKgWK5IkZ9i0SaaP27kG46F4.cn8D74_0EvzA5s83cmCcbibFqgU3JeM3XN6xKHKmL1
 rp7mzt0Rvevw2qfvpi1pBc8pG_pOk9nuXRSfddd.JrZG2_9VBiPvqAT8AOUi2zHg3w00_gKEzQ8C
 J2tP6RjSOoP3YqgaT9r5xHQc8Xl_hU5AT2UFBriZp5mI_PJ4_C0M2oDTQPA7zR1DIXWBroAqx7IN
 .OB9zfylvL_Ops_GsejPnrpbz4iDQAGg9_.EqwO.RaLtP5Y__zf2CPvBvAOAYbSkMxNtXmrlhP_1
 wF_0KTwZC_IJzFhDsHBHQYeShbz5snOT5DnBA3SH83T3X2tvnRhTnP8WshTvRnRov53lOR892trT
 uKnf5SycsPGTLsD48HuNMWqtPG2Kwpvbu7TSUC.RbyMqPzP10GTy5Wt8F0t34wPJayy8MjHDYsEm
 tyGeDQooGjpQlZzqAVG88YQPwKV4W5snwwKoXaLi0LI_8zr9b_0pW6E0c1e4JbkfsADOpK5TZAHy
 T5CNYCydU1nCbqpNl8hxVDizXrEMVOYyyaPwNzIBw9_3Ww0OvJYCkfXtgEKBE__vq8RO6sBmkley
 BSL59Gk5nBWwDSIy5bnHbki5Mqv9K08Uoj0ENwaFJ7OaFVuR8B8.rnFIURg3_vRDVfTTiaCFbIzF
 4DGnkKqVohf5kMOBTPwg_GlD2X_AAeT_CO8ulYHflSIh9h3owGwCrghlTPnyrgyBsR2isNBKza7X
 k06u.1SVbC0SXq93SBgM7ZSTpBqCH5A3oXv0eATrWxdpIC.JTaPRp.E6I_SCml2uN47DoWvGAyZC
 KVpjg.neclm2HBGFxURcCx6ee9uV1zwr8e5Rpe1gmQirDfsvX8o_1buTbCNoHIVt5qgzjVVig1Kj
 OUyytoUsJW08Ptz5.z5eKl6OgqC9sT32hKiIeTiuZ9XkX97Qecj182wNmjOOdPqSGsvVb.6KgQ4M
 wjuYBX6SiKf3O6m7PmeSsgoTTn3fT.GKfH_5s6C04yRT6kFWgr1IEqzykbouIyuiCq7nUePqgoyp
 ePX1pb7cup2PjGrgxBFeMQumtdbYsOwWva4Xqguh8Qy0OI26S5DL8ASVNvNSdamjX9eBnKjwqkH4
 Ny4Vu0K_Bg42.btwCOg1Z168Oo1VcUQxh96yG0GN3ttO.PYZpmkylsfNx4AgAcaLCvLe23wE3YTO
 nuaFd_oyS.h6jXv8hkaIvpwWkSwVDpq.IFZCyADACWW5YmfhlGhznrF3VZpbqp4t5SAAxGruzoXW
 wOdRxu.SN5UkaH9PxgZorQSLIRxe7ZMfKejVfrLoZGzkqaS.WivrDDijTAoWxxLvfmjFsgPZKYav
 hGC1O5O4GAaS9XqA5Ya2r9EcJBEnR1QCiTbRBxhaYY0K1yfIG_iJ1NExx7CZJO8oo21LKmxiJFwR
 zJOqRDPhO0xHlWcqNB.VdaflmbHbp6U6sSsVHxBNQ2rQjjZKwXgryWu8o.ONH_SKff0ikk6u6iVl
 M3LXQrZw7f0GKjHJOOHf0YZcWyiQXJdBTqmP4Cbhnzzt1qYM0HQUTKgvC7ituRu70MVZ42rVr2vM
 38oX_fVcQ_AmivIKqvFhCs5NK3XpmUGEM7owWuJUKhbGIrrXjuJbyjYZq7ZpZgN.CsRxDCdpgD1x
 Co06XoLdPPqvRfIKu97l8RUs1737z_SMyG8vYelBKYbtbcciUUQzWdNCl3rcIGwHO9tuMWJuwb3_
 O1SZO6LDagirHYKiiO7EDpwevYNtIL23sVgV3Ok64RDPiNUW1XfOzKbx15GVcjY1gx1kROnVqvto
 rIPLC622NllmGfgMURCOP_6zB9HiYm0e3KU.ZtG4iqK4Y18UYQj4UBEQvhuCQJIolHyLN5XtsO2B
 iHQaLg0Jh4B5uCdBwjZ4GfK1kKYgWzqAkmlnjRbF5IFl0ArGtIzr0Z3xex3Za0L2STjqo.rwGtrT
 KlqQa7eEimIa5Ei5lWgsbkrI5foX5r0J4tpEErPFNHJsCmYngo961yt4axszOaoYHffzOJZJXE47
 YKNVjeZ2G5Z_3TlN1A6E2rjJPTsCkrcPynFidVfzK9UFoHKC.g1gcqp4HFG_5PzpLDr7K_8dg37n
 XtyamOq5ytr0z966xu7QQkEp7Et5B5NsmOyDTGjLVerZt8OWuAQc_esKCrvCKo7D_8Bj4l8YmAxx
 UsssPqRRW2W.8U.Vvc83ux7aGE_0MCZqQqaCQxn8LAGHMq2b3vki0Cz34X1tURC82v5LzSFvK8Ms
 ZgiTgjwXJjYY7Ogt2Xg.3YYiH0JsZNJkKtZNrsILzDKp_Us8WUg42iaavVkLU8Zi2fgFoCjsjeWC
 wqH3YxH2Ll5qO_L5Oihyd.qinYY0NOHxoHSwpOywp.gEkIrPcrhaLlwUhz5ZTH6EVVCV1UWJAyZL
 e9zIvCYz76nInH4m0cljPUb7Diw9lVY7_BEG5QP2nB23An6Rmb8va6YPM9dC2vTzb8Tn9I_7sDY6
 E.I8N8ao4cNnAYds3WMGuHD2UMdE1f_vZQv3OXKtNL52tgpPLGcZRV1K36ya77I42PmUJrLx4Rth
 Vhgau_jav96PWwGEZKg2PqNUpL6gPOfNmu9WBkahlbnFlLtGDeNRTOzGinc2q1wQekpETu7Myosv
 .ECUZh19yQxTFanhVoceTKp._6_LuUP.9Oz5WQlUEb1q0rAP079_Wc4MDiz4Vs9wsyHAxrhEpksi
 gFHxZfZz.g_ygsilJewDIQzCg1TBf_Ey4vJbYJqiLnI5X_DYI2._YXJVgRigUq2_pR2bOWvL1Gn4
 1fxe1zmBLHPa30tufS0Nl7cOoSsSQgmJVCo5MNXkxJCwU0w70akSq042FO9Dfpt7hvZPlVFFrq8S
 6gAPQ.p_O6Duk2WXiPWXve.Jmgh_i8UAse5GtAy3mDCYUYxaPX0IEwjFzjI_QYhUZEq_pSEqtxxy
 VbcldlwgoRmlLiQdhIHnyKScQX3IrY2.G4L4dsQ1n.5AhE_.clt5UetJgo6sUzBMFTO4kWsvjp1x
 qBweJlYXGFvqGf98SLuqeKLmEgNZTmTN4_MFakr2w7tMe89E7AsqkFP7938sKH1815Z1xXAUKwZg
 9EbYmLCksgaQlQbZvbWjcpKp1gZRvMBBwr7VglTQs3iPp4GyGCqPK3DgHvI0bwnmEAllZR.RLSM4
 LaEc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 00:54:16 +0000
Received: by smtp417.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 26c2d1be78d8ef90873d482e51baf52e;
          Thu, 05 Nov 2020 00:54:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed,  4 Nov 2020 16:49:05 -0800
Message-Id: <20201105004924.11651-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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
index 89c538aa283e..948d12a5eb25 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -443,7 +443,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1061,7 +1061,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index 4ecbef074809..3a88a90ddba6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1693,9 +1693,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

