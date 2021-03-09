Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA478C433E6
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9324E65173
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCIOty (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:49:54 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:41990
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231652AbhCIOtf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 09:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301375; bh=Zj6KFJ6LgPa70vJfKgOguhcWb4TDhCh9DkBBn6WyVPs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nDavTB2ifBGWdnEnAX3sbjD4Wo0Jtrr127cPC/BmBO8QoTpLXudJiF3lsK1cHHRatzzMN4UozVqj6a9pwcZDlcbaX0bI1SCmKJkImPMEhPwv3yTz7lMxNmAcMfyouEsPBkMjbcG7W4qSrnVtxpe4h0TdI5C28V/6oVFZNoggX/UGrfWuYH8HOspE+ylcNObzFgAEL1vqZfSXOmPaACLPa37v2LDJq4I17n7xL6gjoJscjnIzAT4JJTsRRBuWSyh8SLQgc4dMY9q+QHS81pdax6YivkGzqKKI1bYXG5CIbx2TNmXVZJFm8KbgBsUnn+WvqKq5vRFZJtrP2NrzklVIUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301375; bh=29U0B6v+IvprQN3aRuv0ZPk9gxedo2GdzQTMayBv4hf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fILGxMROnJMM1Z/lAB0M6Eg2vpRPSkez3BZe1QE4cRJIRtZbPHQ3rSk9+exUTGkbeKzk2HotSEtFlSXUcq4j2Eo7ufRP1hgwV5oaOLdo/M6WxCUx/4ruR/hg5XgKFTv0pVWnESn0HB0cjwgMWGCaJ674cjtIXo6XugaI/IzOCe5ffXaTyv6VgqUjOhlbl+4uNxeEDoi46tFbr9fNQjyiz+/bITn+H+ws4Dqj5jCvb2GRrbkBkn0LqXJH57jxlynkz2OGMs/cFnD1eHO1YdEceioSPZdMrixxGUcDZLgwDNO/J7v4ZC+1w/5sj08JJSaFMqjDPuwqF2+Q2FL81zAM/w==
X-YMail-OSG: JWK.upEVM1n2NXh_TB6zVSi_zNuYg0pwqA_kXnS1Y6trly0YhYWG6.k0LoncC0u
 R3qwIbraBuEjyfYiEscBRkBt5S8o2hC5TmKfhIDLN1qdq7SNRni46eNefw95zfbeGNoJOwQxX.DQ
 cfp2ifLf2NxYA4_Jl_LFbfTEPXpMSCjiwykR37nahqpUOHdQmnzjghJpBWgwm969snXgdFvudOXQ
 L2.FpTz.fbpEktZ4w4qCvqJuFVLjbWFlr7boRmYaMZ7iss2TWoERfBuXNCW49eNluCOgUzYZ4NLJ
 d1SX89zrvdTGeJP95Zvc4r6yWwku9ait9CLddDPVOFhUL6GCd4j02XtNi4nUBDrCmDfnIJ64hWPX
 lNvHJNWlaZ6i0.fGfCMjJ8IDZ5LAUMZAEMoQR3nolUHit3QvzQh9oHphstqsuPEC4azJNAW9g7GV
 CfWeHOOoRlcIHUJOka2R_uz5WKawq3D8uf8HLgjNM9ZcEA4LX16JkPZwoQ8VF90HeI4GNaR91lcV
 sORKcEB3i31BUpaPIOX4LbXGgkisdKLfq.PF9dPyxH.8LQDX99TQznp1A3BqFXoT9WCa2UoHMTZB
 me82GeNmO9QGNiEF.5iUONGdwQM4GfPx4cFwHo10Kauz9zyqpaaktpYcurrKHRKJgObKPsPgSRRD
 U.VF4FndjV0nOC0o.yDt5.91.pdEgRH3._34_Uq69ZF_PD19wAPNrxihosQqcrKEihElCr7s_W6g
 eH_O6uNuzIF1kdLCsNKPjy4GjQXBxPa8yA4tnvRUar_rGnDdM86fakEBiInyM5KqL0UymOfY.F8Y
 L6AtG2DhTZZr0wci7TNlgO7IyrOPxYBLewK7wLFApTKA4B_v5w0Jz8W9bofFmKD1a.eWZWmpgeqE
 HrbR012lJF1KxXaFKDGOYBb29EOAuCEZw5x3TtCoPtcHGEFhOxmo166wXRQ6FQFf.ZKsqLPA2ZWb
 CPjPW0Oatr4Qi7Y38JtWzy2TyzKDXKzTTJa59vUQT11XC1Yx66dI.6fCnq4nNZsJNl4mVjqd3Y0A
 MHlsfD13Eg8GNJUKV4tBhVDE_SbKSXCLw7EfTJIZnz96JEzzYL0fF_JNwbeGh5e6GMOt0I_O8Vwr
 LABoU_6RqSxfjwp6mTUwlbH6Qip.qX74m4acNAgM6InzWugNvFIcK2o2iGA9pNBBYKtNbpYraHft
 CFFzUFKnUskdPbCAibi37cD8VwL0NR7TR._RdRRfcJOJt7KCuI5XibuH1Ep_cvjkX2cGRlqoLshY
 9GAWUECds6SoGa8ak46nfFW9GRUrO.8Ng1vUeglsVk.D_9Ddek.cA3XqdS8PQAQNBB.jR7u8wQY3
 47KJlnZAiA.DYhbW3L7d9jZDHJJInjgPmQgS2TbgiFwqf31EXgtEIYXb42KrWJfsl1nX.WO_OZzd
 T07jZImDDJwj95MB4a6INhtrriVnR5sZ_J1yJdwU7qwpdAYATfBP4wSIhLOqKqj51CUvcsHODtbG
 UK8cERWmNHiG6lrW_nttPzwIIEkPvMxgp6GCJlgxf0nmkd82SDkniwiszJwulsKfYprhUxPXhpbt
 4s2ffD4yILr5iaXZYGq7VkpoupN5yT54rFm_pXPqz9EPc_NjeBXcXZHCLiT7iXM6ZkMcKeyB4rru
 m5LiZ3waX2mgnPD94T8TsdcZFUAuK2mQSoPUe5uyq4tWsZU_IxccX0TcsF62xS4QbnX2F1nuH0FX
 M5dC1ETqS26AddNukOT2NC3Ci_LdUifVNkFmpTaiuIfZ8Nu5CAe5pC5JlFXzNRpXHfJy0tpghGCR
 zj.w.fE9K0r1Cd6eErKBrRX0TLuYxQbVfjwjbF5318QQ54QnDeuO3Ci5J7VTIccPtyh34HgmVdg_
 V2WHQDU.3ROResSHn5uWdug420zFCHvlOGd1Kr8pwqQvK1C8NkZc9iNk8emkkVUoUFoK4xEWJTCG
 b.x1guwjaQPkc4.hlqze1WMtdAtyJ._xmXN4tKLkKM6s9FrNpWQ35cvVvb2T5m2vP76sRbjsRrCk
 QcZZaKA5OvQ.yWb_dsjV_Dh01p_Z5OH.f20NcK4Qi4mW2y08TDgNfuynM0YfqN9DdqJGbhZJqmXF
 KK_y6s0OA8xaLEyJY1Rtc0ldlkPRt9Gjs65BGOCINzx8UtbDavz2XlxKvm9w_BUnBKqejCObu4VA
 gOyPkQQK2ponGER3kFh9bAmSwnWi94pW4F_6_bOpE.fe4P9OKWN5sh_6mCKE_rN5X.pdKRkiHCnw
 qcoYQA6JO_VuLkgIpKTb61j9IMPDqQU5ALVLXvemvMDee8IAoDFr1YPGeFZgkFZOcw3sTJL00iui
 vEAySX08YYZctsqP02Jw7zlf_KLIwi7.SDhnYWubA7N5VDuZrsgmrwfDuXQo3tdw.6mDzDi1srBZ
 vAkrXjtXcNNPR3rQ_L5x68iprugkN0qVn8P5B45WHXihOph60ckP7nEEl5Wgo.bBfgUTZxQYIZ8E
 ePmzSdfilm9ua81Ig8ntVpE8_o1fHMwOL9FAuXRMyT2D3C_fmC_FhsSy3fB0D7ujMNZ75tlWdjvB
 BEXRftl0D86sJlfccZOYLlp5qockQhTiu.Ahl7G9OGWhys5Wm5c_scdliSQ8Calv2HxTeReGUxuJ
 OvRMEAOC9E7jdTgPjAmfajTTc9qeJh5tqWzo7ZppdxBgldJIaIWsPAub9oOgNKagPazI4IO7PJy9
 wSzbmrqwlmIIiECTvY31qEnNm0yTOMYQePg9Qhzb0yAkOyPtRgZU02IemPn4ukvuXXF.JC3Kgctp
 GnkLtRFr7MTSUZcpTqG4ew29qyCp8gUBKvhfj8pjFRohMzQP4aSSU747CCCtjpmtftir6pC.rlQh
 RErZGsRYmkRMsH9iZOyI5u.hr2cg_WN9YPXs0JrWlU_CkqQvvNw_usceMIU_hrH77X.iTFIx_IW8
 JcE5gCX2wZVg7EP9r6R4dGSLoNrHb2ucDDAbuHVXuxXCQzo9xKuKNg_YMSxSUwDY2X37vi6nuCz1
 .XNVfdcfGrjxvWNfERLh2zJXXbDGehVFLso4nMMgeRDhyYPwJz1SsI_BNXn9d_tvGjGcSK6yD75O
 kdsUH4R1h4I7MtBsVKnr8hP2LQ48rGBygI7cNstv_47ITrozfmHeg_0UNkU9y.g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:49:35 +0000
Received: by smtp417.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e3cb08b05f9d4dfa5a291b1e8992a34a;
          Tue, 09 Mar 2021 14:49:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 06/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue,  9 Mar 2021 06:42:24 -0800
Message-Id: <20210309144243.12519-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index 4c6350503697..c283981a6a7c 100644
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
index 911e74840593..b63a14866464 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -459,7 +459,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1090,7 +1090,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index 67e9345741b8..aa81f2d629af 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1752,9 +1752,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

