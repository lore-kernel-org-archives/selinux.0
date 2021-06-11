Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637D9C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A5C613E9
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFKAN1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:13:27 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:33528
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhFKAN1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370290; bh=8ZnnCIqabTLKWTmx25eCvkeRzHbJCxzkprcyFzNecgg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HcJcu3ed0Pr12XCqrXWRUVbhFtsxujHC+gPanjieYflCmC39UhbMYdisttTEk2OP2mW4vnmtJrI0vqtTFANEDftccYTC8ks8/t3ldSzy4f9Igq+o+1vqmnPFJecLM47OYxxtYgdWk/pMEyrfCT3dh8hiivvOKG6Xu5KLyaVnGLZMG22aNn9pguJSH8X/FM8NivcOIYMB+u8ZYzl7x0msBUYkixVhpXBd7byJ3urfUnS6r/Zm/Q4iGC96kF4oyqNzFGLVq7ZEAdsQ/lZLZ/2X4ge9xsnl/H6RBux9fVw7FxMz5k48rS0hsob3W/C4ExoMJMihEtLNFZ7A5e3TULpjSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370290; bh=qoe6H3Xh0zecLzigCJFBppLKzLvxNKL4/Ld8Oct6Pza=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iexfKrjEFWKun8/Mw27lNxk6VuPSpkqXaIZWn7sqUk66Uky2voFrsFJKSaUhwDtl4CQvxfY8VSEOUh0uCb4uNr50UvG/7BuPot09U82F+UlS1cL725cqSimTHXycuASIHLsDKkRtNpwLY6/Y8PR0k/J/lAVAlXqxWJAaaUPcQHnm4X3E1EDK1bCV0dW4OGxL+c0oRKeyIEK1/rXrFHyWiFjRD5oQKn3zlfV8m6Hh5BZMJ25FRvpdP6pfVApyGeYBsmuJtj5Kj3vPS5y7FVM4KYtdnQmVuBhbWuYNpblCOC63hE/ejyIH0h0/R+PCJhJsqM+s/dWGWTLo0g01ioVn/Q==
X-YMail-OSG: 6V4Uk5QVM1mxoYuxXKQ.9ySpbx6vFgbe_dHvW8uNoMDOtsQH29zokvopuzRYjsq
 gIMDpZ6J.eiZQoxAFYCkcgQfYcXtPI3oZdGY12hEPKbJpAaGl7pQCK5aOaDZaSaPtT1k.paQFrFZ
 jdFXVBF1GjU_g81FBc0mk.K5eWERecK_B_pvlHhFJRuHIXQc0bpnFkBu1Lu10EXTwY0ne.GeVaYX
 KNXbeDbnjQ_2KOK.SD69jBavd4i2mjXG.NgHusdTYS0YOHO5s9zYNxC0zx2phS8xcBswUQSdTzH5
 hD9QTH1lJO5J8UtnPyKFGiDxDqWWWbf5wCXXY6ioy2dEVAwbaCH4_2Z.NH2vp3teM1gBcm6z6dUz
 3U6_dkaCArf0uBhucKygIo0zoyQNc6ZB6dq6eHbXripnqtZhwHHHyzgjEI4FqCzHeQwww2OY6jYa
 ghvsx1LUCJgWOM_VBPSgi03ApFmQ9k2Lfr3yDXjkiPJWWyWaSC7dy2_j6OGV1E6zihm542D8g3Tw
 J1z2KWPG9iF.cI4IPZAYmQSw3H4T5f8ktvIETWEwUkVspwq33Vk4oCN_BH9Y73M3LuDqihItqtTy
 nzLYVrboTYMWAqKWP5gEA1GWcZSM.r3.sobw7LmiK8pw5kQMZvQrAfr9AivIV01Uy8Bc.huF8NWg
 3F1Pv0Vmvaxz0kdX429SEtok363ItzUEX0QhX.mHn5wQl.NFVxDYyRWBPeeYuLD4YCMB9gRzTu2y
 nXuHQETHRS8Gqo.OXi4NbN8tMi25LWOhnbRJWRnG7u_Dld6TM231JpfrX_bvF450TW9bxg2z_39p
 GrvXR09zvHuELr9HPmDz.U3CqOpPZQLwHybnltU1GF.pIoJvM8_KBGpkzb4XQXAVbCiKaK782JnG
 zsXAdtnbP8l20Id1hITfLzocm9asqgjkPzeJIb_hPH2MSzNnfb.o6vOXjTCP1jWtXIYAdOUE8.Pw
 kkwywA.ha9gaaI9vHjaYIQCa7UQbBeOMjh86SBkP3cWGo.IpqhM1hvey4olExF_AMSRbWF65qEzf
 nYXv5k41lSIQ5zIFFShdzhztpwMdvpchcNraGxIMEpX.IzsWFtHtmiXUV2oIu.nY8HzxrV.k4W0G
 D4Kz9dKQJeZftF6BvMNrhB4sM0_IQmGsWTb7oxCAwzaB6tZ5ULWBEO9XqhIoqlgk6DnJjiHakxj8
 LSfb8G8I4TkMnpczUyhQ_TeB.KeRf951qT3y9kO7WUAeIgKghtupfM1vDRwRFIFG8ntftH8p9ohy
 2X8KCTAWyT1mnET6ZKbhOF3W0ryh6r502Uzzg10wUmUqCFXBPC3zsftiPryPpB_N_Rz4UxaOiI0p
 KkP4N_enyXPQ0P7FV2FnyQ.KTiA8pms4M7mhReqvhGFDivcxkuQW2njaPchitym8mUoQG64PKZZH
 VwpCUNSXOijD.aAXGNUM.Cj86pPF.AHfAllQC64RFEly_b2jp0zrfIASN_6wnb3Twi4gSS88aEZU
 aebdwDj.ejKK2BNRJLc8NlYrQvn2o6m4yYng3EhKEEChJEc91aaedNVd1RAQVVRE6gfP4wqtN5dF
 A53VDZ.S7z7Xci4JFjcx_maWP7LCwq_D34rSPm6nji8E0eDIxKGVumUne.BiuMdvqek8VOO0OSKo
 Z1NriWqZDoYbzbqLR5rbRTrO1cYPLEmvgUu8eJgKRh64IA1u0Y1cnvoehGPBIOkV.tcvy0eXzLiz
 U9utRMOKGbribcFHb1PBk9B_gbrsT2j6ZGuLWdZMOyvnWbhtGmsgA7lQN80PolxYxAc3Zef1ZQFz
 XohsXUPoIXca1tinbVzZ6dzcAVCXTq_hx0jAYiBf_jGbPnfuhcTZrjSrMLysHhzAwvINFgkIFWjm
 plrHPzu_GSCj045_nMy1_UVGndehhTPFcNH8_vKm5LkJiZ589j00sIK_xlqKkzG.._kZr9FA0A7i
 bbxS4j9yPianGmLyjPNSD755b1sspHAG5qJjmDauS.eLcIAKI9x5GYAtf02V8t83nt2KKdsHjJtK
 fa6W2r22QzH4u3XRSpto6ru2rAnACN.w7MJenQDji0ptPUM8wqH6GqiqLw5jMAP7HSygtP78H8yE
 cCG7l4ZQxl0Wawo9vAJgICpSo_0DjgrvgGiWGUr13nZ3eBedCMncFlGbneTYMOmaVfwgJoLuYIeF
 39EVQePbsimuSv5NGGM9IbLFj6jYgmwo6zWpvDQ5fp.naJVFcbx6OFu9iHVseBUcQfu.b7Pcd5Wl
 EntYMnVNIbU2iPK6AO02fYmu1JHknLKmpGN.NWisfY5gxh0Ne.6TVU53XOeY3tZ5fvVrhQcfKxrt
 oJY0qUgen8qqm3sRvurVDPBqgUSMch1TjVKg5zTNaIXkCarhuBnlqVbIB5tB026WbLsXrCJh1K16
 sZwNdgCFNMAhfarGwni8YGfe4qUFbc1w9h6gnoPhQPD6gm.keyjYZ4qVsNjgLkB_DeE11uB0_Yhp
 lJijpnSQmGBfq9ht5sW7rLl0_Rjw6yrNtSfvMtTP8rwZzL4PrXDQAr7a5LorV.EpzVQDX8aLt4cW
 mfH4qiRGMZdkbRQdj0Es59htqCTPFATipjTqigAm_OgcIloAItVM_o.JFcv2ZO0Xd_rBhvklsLx.
 oW0PVI6kygqGs7daTvp2_0lRz_9wbAnKmmy3okoRD2g7wl3BU5E1MOifXtDAA4c30yazTtrVwJ.E
 CDQR3BxDnS_pMNdSevJ.YarE6NcGyd1S_kySaEAeYt6Ee6av747pUKCTt7pLM3_QyAFYY76W3JcM
 e.tAw5hCxRCt5xO222QWy.nbXjmnv15T6gBzUDaXHXzPaF.ayiLEZ5YXlg0pcZmX9FHsUSNXCSzM
 h0i76UeQru93_6NaZ3LHmG1YUW.nrK23Py371TkOWPyzcFmZwP_kUcRFA04JZtCTkh7jPV6LgMp1
 7Oowq7uInYZ5evS8m0Im4IL3xvuUXrZzQb4dGSzlg677WKSL3x20dlZoVQ.j7Ro6P3DJzEzgwQZ7
 IpX41EoeFvIZ1LVblHcz5r7vRIlttgV5ZQV714mYCm5NYBCrhdBIgx30QgbNhp3mW9gGR5YF1oi9
 w4nhwq1tesspL41UkTkmhbyEQsvJ1DXQ50cgZnYFnIurGDctuhPtx
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:11:30 +0000
Received: by kubenode567.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4152b76121a5a39c38d12a14db81df6e;
          Fri, 11 Jun 2021 00:11:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 06/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu, 10 Jun 2021 17:04:16 -0700
Message-Id: <20210611000435.36398-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index d467231342da..5ec929f97963 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1798,9 +1798,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

