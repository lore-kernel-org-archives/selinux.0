Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE6AC433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F3C610C7
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbhIXSDD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:03:03 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:35657
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344661AbhIXSDD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506489; bh=BVm+kSDII84nuD5Z0SIkaLsES8iiyGMMYiWYVtF6bHs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hZMXFc/TjovakpcqXzvoDKZGEYYHDxRRg84UiiaygJJVNgdNG5m1Urp9Xr0Rqn/yR9Di3yRBpCSnTv5oMmapTWqCCHysJ+/hOFcF6omF/tP8ovDQOE7rvQIEPLdxjL6K2EQmTba997ekzYV8cp/xyQXmIgz2j5Ciqh0914a9jcdmskIv112aDSCuWdjnwIHf2pQq2NytD9NozU+7bx3lsn2XemIyAPbkeZG2icrC+FMEaz8pycV2EY666UOcbtEC+blgVpiifNRX/zXjropT7efdPpTfMqzZhDSOeEgMZ/JSm8q9DCKKrmBZlcUKmM7IjvD9JFp5McKjLP9+q04RLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506489; bh=PZb7LDe2ZHIG5bWdc5MAAKXviP1DKIF71HQPB0iUtSj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EfzYz+VtA113ZnjIZv6ABIl9NsdN4ibJFMoGyK1o6vhHVRF5AuvDBH/fHc61F4eHfP0S1x6k6OUPbkxFb0GLPeVhbwzNd9kF7UfaG05OBSZnhDVRV/LViHm9x9ReCK69n1J6VOyhR6ZJE9UzHEmLsUAwQxi3uRlguDxyirQ9tUHNDnH+dRL4Q615Ix/IElxVoZkz6frxRhd+RQVsSp/youdNTphyadt/B2Ct/Dwuq+amZhBhEO0udDSfE/l32hVKYfwA6ScjwvOCM3R41kXVtVvEzuCugNRwRktRclTDHA+rC9PUCGHus+XadDTbQo2Z3fyp24/n4RBeOR8SRfTJgA==
X-YMail-OSG: jqmPeu4VM1m..uYUDIzZvewCyld2auhLosklfqQN_qWVFFQYGRI0u6tSK3.BspK
 upYxO76W5tk.PHuZj22G2br8BGvCpj5xjCt0HvVExn8acatC59MjfCtjXjDLd4jleGkBykhPJ86j
 ocKEHliTyOPD2gK2fsIyL2uRMBt118fPNKDKfS1cR81gTfxzzSsFeK6iuxKhorivnKe0rnr00Ruo
 GUxnCal2nr6YiqaDDwncs54VS06MH8k_H0fLUTaEdvn_hTKmGSsLvLzTO6_8HiHB2Vncf_cgvk0P
 nuvTepTIBMFL26_Q57k4IrDbt9Mo4LyctwtjJH9drf67RRWrjuoH2z6.pR6VU2J7C6Wo6Cr3etz4
 4sKLrG07P4jIwSKaiMjpMtqbIZ7BXDX2JRO8OBEOQMiWHRww5WSectBKi5vp5dIwFSPguuwHSOms
 gPv1s_FNWnEOuyFHf4nbCtLnrwCicpi0AJkcgxbN6PgkeHe9cAkmMoL8JAzsQ5OFcr6m3WuFTpeF
 W6dxFgWzJkj59MGxUdPzeCdRFpYNDYkHcJhk16NHJLIQsUz2HADg9iqO6CkH0RYldE5T1s.1pWV8
 ltZSLKsI8E.WPcUNod2eIhu_uB6VmlcjJ7xkcMeYaw9NCEip4d3VfmDLbmiHekzu4HQfGjYdxfaJ
 jfprnG_nIrwoFkR.9TRRgiA01lI31wyHFe3fevaNSAHvnMTqkS5zC83zKde311ZjGmJEeMO2IawX
 E4_FLvSVGhpcitUKKU8nl5lEJImAWdjgf1WksYe3UJQqWZ4bqfEcYyjl_35XhteQ5CGbTozXpcK8
 9lZ5vjdXWdvH2bdM67J88LOC4TX37zMP4sBSNz4R7iJeAEqiD1FIPEkU8dDztF.9m9RAeEyELBpH
 33yxWdrl9n0xZLtALQQ5cePIavWG555CTqSrrwVMcIuCesolZK7ufhVW6egN11nTp1sNLYqgy9aH
 dYqUG92cOz3x2wlSw4DqrxlexDsgW8KU.xOTd4Mzd.RUJpHDFwzXO34sTirQZGzWAL9wZFihiL8m
 3F6XivHHoWIUgeG4CPbQ0wUPbULyNzU2gYEnPFjYhMW64hQW.N8iC5c5osew4L35c0PySM22HzK2
 DK17dXw8SQWnbF_UvtPy7M1Adgoz9hV2kV_x3JxsFiIRSqUu1cv2GqKDWiB.rAk7ebzlrRGF6s9j
 qwuUiIpoqkq0zeG_dqLoPZxWM2Car9b8l7Nos9DhHEOSKYcf.W3dWQLrqmAEMn8DsxMxMhDGtWs1
 p2.xZ6Cafv86qPAe49gmlBrH.5TRZiFAgL0.qJon0sokMw5DV6.D8EVd54mv5LPERWyKNEy8a22j
 .HKn77n6vAaeDU76PzHeAKGIp0s4rgckfnGLyfWMVg2SslGNiDNdOTei_yPIp0FFBGDEJB_pA6Y4
 mTR7zMjZGo_65wQM61CPzOVxQr373iR1rpsUxRc24f4DZoCkDTr8IdwLkaLaQrGj2FtJDi5aKU4H
 7DrA_3PX2U2fBakawqrH9htWPgvvUTQuL3qknHkFMuQ_tSfa6OtKnEiNBswtju9wsAyUmiomGDKA
 8FtWZ_AuFsPV2PfT9f5JPg3cpNX1wtIZz0GgSUm806prC0poz7Ts27hmWz3kYOijTLD7vn9u2xqB
 r2q9x.Jf.gtPJpZYa0Wu2hHR8ZdmSDHF9Hkxe9__Ge4mCO6n0SWUJCvaZoUfvWi8_Y1t1VEOctoR
 Zc2kAoipwbF24PD7iSjFcLFhOdoHdPg.bVe2IedNhipfKSOm8uccV0Wuu638GwLTz9VGE4fk_D5U
 oIEtEY2KKXgBJ85Q4_.TL30hIOpH3GuqdyfWDmQ7shBCQlsVzR8EGpK0rVMCKDfLR6qi325YL.hZ
 k0qL3x.YTUrNyZ3hbusQ1LXJo5ziZoBarfDlfbVHDkFwexQUaPSWronS.jg.CokkQ7FW_53f15Ox
 vtuEUTr7ucFz5ilbnVnkr63Bx9jTLb83GctgdG0UWJtfkMfvceIFelCvfy69Fqh719KkyyDxQwpY
 Rp2vHapYL6m47B8ivJ_QwY2Ng9I9Ufrv0pxjfseay4b_Kkljm18Ub0meAjf9Elv2MaAg3WLLzY46
 _TqHz6zsZWEBpM1aFbMGiwS_R3zueCUNF5Bkqb_0z2RF9owpWSL0D90kDYF1PtcfKKhmw2kLs7IA
 ykYB4rXkP5BtcM1tquv8o0nttGAV9l6V14k8gUBXbJD_UCRsOZivPhjC6xgcruOKXjgdkoU20VRw
 81qjFXm0sjeQBQqOXdJCIiVNwxrjlZWMSUwjPMNki7oHGvQ7HeAfCsWcxlgJKmtMyPGIfm9YW2qK
 9.f2XCBza0x3yHnR3zN7YqW0QOWIdqT_X
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:01:29 +0000
Received: by kubenode586.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5ef65ef8086ed5c2575a48ed4705c58c;
          Fri, 24 Sep 2021 18:01:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v29 06/28] LSM: Use lsmblob in security_kernel_act_as
Date:   Fri, 24 Sep 2021 10:54:19 -0700
Message-Id: <20210924175441.7943-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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
index fcbc6885cc09..eb02e8514239 100644
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
index 0ebec0fcf313..399b83ad1a43 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -462,7 +462,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1104,7 +1104,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index f784e08c2fbd..d82fd1236537 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -774,14 +774,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -797,6 +797,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -804,7 +805,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 6f080a6cc090..a049b82d58e1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1799,9 +1799,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.31.1

