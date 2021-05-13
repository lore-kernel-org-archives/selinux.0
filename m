Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DCC433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAEE613CB
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhEMUQG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:16:06 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:38253
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbhEMUQF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936895; bh=7GLBJ9q9xynOHHMnv5lf6iZMWnRl8q+xA5RjkGSHJmM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ba0n6fCDseURLL0DluqAHVt4uNRdvfhJDGA4B7ZQN0s/UQazTdNAoSmhTSJB7JixcH7KA7PX2+uPYBgmyS68KxprxHZqgY/X6DooMWKOhNhTygquHvIy4Vr2p4wsf9zH0e6C9Iq9caRiFnU15d8xm8j9+0Be/JcpV0fyclHtrJwFczmLTAHnUNNV+CjQg6Bxr3aPLbbFWqFd5I+ZEx2EHQl0KcHc4QN5gF7s7dEUhmhzG68AiN39iAdmBfaMKmRI3tKrR66Fp7UPBogfebnC1SPp9hMxAWbXgWJ2LT6Unpr7Gmxr00DDHcIgvlLOL0RdneQf6wcSTRLykqg7fU9nFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936895; bh=MY9tdjYo0reChE1POFOHjb/j14T0MdaZ1zLsA9QAAyL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KtexYDdB4KVFzkAMo/NN5qkZsdmrgGhY4LZqPz1FJHm3gmA1INqTqeyW7pzgcNO8Olkq9NJVVivCFWSpQ1vjoZ+ZzU1ZPaBZMmY5RgZL7+pHAEyrrclRD3uU5NFOd39m88F357M7OAZQsK3lZzLW4Yk+uJ/BpjcmI3L/EHQ72INNvc4tAmI1llH1bbOkNR5WOiG97g4pp0ewBGdurqrXmslQcaq8enLkvTuDq0nw98etodfiDr8UcuX6FcVZ6TuGksjMuKY4dBZCxqwU3FnCBKmHD3nq6ueI0cHVqiODH1ibBJYDCDxxp4WNScVh6nerhAtq0bzKshAGK7/S5JJ8wQ==
X-YMail-OSG: sW0HHFMVM1mQUgJ4sLJk2aQ_5JrRNXK4kXRdp.aTBk5ift9KUZiKmizyl_ccmW9
 pD0kELsEJw0ym.AG6.vAin7ynt3AR_.AwbydD4gh3LKvNLpqZQsXuz3aKACwmxbXe9awpJ1z9_Gn
 GhFs_CGV3WWSvubAi8hJCi.E.BHTWQeO6AIptLrsrjwy63vxZnwafkJ5CQk1LsSsdABrjwhhoEii
 YaLtTa5edClNkotI9zILyI.EFBHW2gXUqJvql5e9wSMgkRA_MyB40adPrNeXt3ypfaVh6GWDOHsI
 6bpPvmVV07Md4KsNFXMSSVKjAb01T66AxRa6pVHsNda.sYucxkjAjdwMwztuu8WhklaJ1d4nMID3
 kjspB6ygtZzHDO2JZa..eIUeQtDAy7Pm7BmpbTd.HZvMXCbDiD7014aRuLgh.WSsF44eHbjQWN6c
 PEpKAHC.CcRS2eaRtU.Zulj3ax0hPnrtKjzS8UkzRa_3hXGWN19JFixHWqbWBaRylGwDJ5VdjtvQ
 s2mEzGjX3BsLo3Kn0_aJcXhjCPn43Smt.b5OIkmHZf5BnS24asVl4omozqph4oHURol0ZXwfSmoM
 at.uGbwWIVTw9PEVKFdl7_pN5pefYjjmWKSBfRcw1g81NOVH2ZGO6BmqhAg4jFBGL7fqEWju4_xy
 hzuAXkGpSBr33Wyvmi24LZuoPGtiLe3txyTirmREiqJz_yO_HtkHW9NkLq5UK8AdxsMg9PMfXL5r
 Zz0RpXlikUbaDnG2dTeoFUkd8GTpkyG2Rllu0ljD8H6.uHlsdtI14inqasIECpMYafonPqJ5NmtF
 4w2HQrWS_H8VbZ6bX02OBxJmVYJR5d2I5pKiUssVguqNHvZFTlGnThntAdgNVntt.45p5x6DeEe8
 veWIlkaNKfdE17wkPBvkFnwVBcZl8tApLc59V5NwQFxstiibGQZ3j0_Pl2LMwfkeW0hLGRYjWFtu
 3NXMaGDFFhfvCKoJCG3tA0YUKq_Ep.hZlnPsayDS04EFwH7EzZjqM1093krC74Lw8ucHLpWeDV6R
 gVb.vdEkw7ISboqjQHRnOKW_OA6XXDKOdwFAKox4d1S8o2sYCnWtBjf91jxXiw3b_nN5T0p9FELt
 ezPBbHhBRocNA046QE1awDsWajXZItvUKwSEusAoP48Mtbwj3WJkPwBRIWy6stad3s95An50SAfF
 ODNo7pYGrJn9q636.JFiDE6qJwMU2bPsEols1P3cO7M_22mjf47WAyqBZfLx_JW.orXEM8E5yHUN
 NrAZPB_RHbEOr1n.ScbRHciyLKiKKI4CWWxg8S7yF9WKLFpyDG8DMk0yp2Rs71eqDjvhZU3_MXOu
 W6H56eoUQGmIqAslhsQBXCP8IBqsNaF2L_MRpzBEBl3Pqy5INGpcyewR10cDP.4adT1zwb4BDhLI
 3_ahyU1XDvhdlRbLT.imwJgr3EpikgUipNIXOkJsuI32pjtylWzg4hgiDv7LzgCf3LpihLBD6eQK
 COWm8OyfaI.nn2rSydCP2X5dSF9vTFMJJL0_YdPrzj8yF59CwlSGITPjPhv8OD5NPGLX4bKKHCvR
 vEcUlmazTBWtWZRvJfyHVtztV9czzTt_ogVyN6sXLzHKxB27ffDRuXRhmglGOXsFQir_yJ9_hENN
 VxsygPAfsGJqtpCPjGCW1zAA4syohrueKDRgXjRpNKMhSvnwipbdBApPvIg9xjlaaCKv_dcd6PXu
 V5GcfjkRI9h24WfTAFgfurs5ztgeTTOiVAYGlrN1tw1VWb8rwaM4rpxcKk8Eq_nQtMOKeSSz3ChG
 ngjCDeCeYBW0CFqrXigp_P4NBo7TTVd11aOf8EtNPwWeIXeVetarHiHY1WjJHjSUims4sfitykLu
 75aGA6GcWhYRMtdbNd.qEIHf9S0FY0FE7_0Ai6GZyOrihAemRuJTF6L45S1y4W4GSU604A79efY9
 FeAmjiyAFxaZtR1fpj7clYeAL2_I2VNcRQrD7nH.l7kbNAXUgLXzKc9xt34wAMniiLdKqm1c2rWq
 utkYgwJ9LBvSb0el4hjJIzemTaMeDpJmJp1wz80KetAFrV6n5zSPOc_KVHZH8CWd81X3i53e.S1I
 Xq07Q5hmkU3FUCHdQJcs3_q6yU8o8WKmFXiHbjllJ3LnzpSbJZ1CaPKNvVDqAePSYk7TMNXjniQC
 SPOWqaDcFQt9C5bh0oMnHurQVVeG4xFalgg68.HcKs1djhs0.PCQJ6rTmIg5HdSrsFgEFGBFQ4zc
 m3sbpOifcXRrQND0r9HzK0KlluPNUrD3WwW8ZCQI1n.DRNjP9XqnToP350cB199QPojxO5EfbXjw
 rYkH.PPItnuHPnKXK5yOeksqcV74TCyfLjip4s1A80DZfPlW159Y4_hqum4Z2CHQm14MqffctT8W
 fPmOKpk_EmL6BMGrLrLCBeMiV_Iim2ORDRobjoXlHmDYJ024fMg00MQr5YdNdhWCRafJ0RCriLcR
 b_Pi4beThY7Uwmjbwb__itrGQ4R_zszBzHFaoPRNg1CksPKFX0LcEl9_O7uStxwsx3xPI3PeSD9K
 KtxsyfbNA7YCCEds4L2dYG1zA3tXLE88vZH_YA0lFNJOOGbdDk5NIVe7iB8mU60K9OfAJvXsM2Et
 pPh.exgM_qnwDwP5zXYOjcThz4TFK.0yJ9QdoFKYsHDyJehqp5ff0W.xFY3ZOL031SHlBHhZd8WJ
 oZWPTqGnSezM.kz0oOIpbYaVrM.5yi6afDYPynOD8e1QMO6td8YHZRdWxm1fkYl7S2I9J6KlX_9i
 l3mQVPv_DAsTMb2_OS1XZRrmDksTWFnaFtEQxlTAAhMlqUqs9J6i3xrqOG772dQsmd17sSOiUN9z
 dMeRCpC3hxK9vHSt9a9pOZeSug6KGZEtlFVkgtQF0oacCsosrjs3OnWa1pw19tZwp8obka.I11Qa
 XkogLnihTHAn6V8RIKco3aypU_JOVit_GORJ2F0zui1T9m2uMj73TJCBl2Im_7LEGBt5eGP0OvHP
 dHEdeWJXpkA07_6F37kOnupjEr9UyTzQHRuRga2iiw1suhheD89HyKUC5ZD8ToYcO_XqgStPNtFs
 WxQpx4i8qbXWwFwIca9TO2Bk00n6LZb70TKoCO6kil0BfiHjMA3eRCjGtWrGYkrNZwXUAs4unVS_
 rBHMi3DRsnYicffYH9n8sUERTCsxAt4poCVNl3nw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:14:55 +0000
Received: by kubenode545.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 736f0a4fea2c7fa7a939d0171f4f5b63;
          Thu, 13 May 2021 20:14:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v26 06/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu, 13 May 2021 13:07:48 -0700
Message-Id: <20210513200807.15910-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
To: David Howells <dhowells@redhat.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 14971322e1a0..5a3f0fc3090d 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -164,7 +165,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 916a0f606035..5c664ba0fbc3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -461,7 +461,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1103,7 +1103,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index e1d274cd741b..ad845c99e2d1 100644
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
index a5793b4bf684..6a8233d746d3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1796,9 +1796,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.29.2

