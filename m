Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD22C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 07:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0742067C
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 07:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317121AbhA0AkB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 19:40:01 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:36853
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389155AbhAZQ6s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jan 2021 11:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680281; bh=2F/IYOOrX63oXFkSlPsj9QNKlbtTL/c0rJHG6UzexL8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UkVTKbVAN8POEmNiAgrX4C6xabnfo2eEHyS8oziaI8L/LGvDGWm8cwOK7rNbXYQ93K5kOWYdmdDfTT5XNONtKFvFxhE4iOjZkzoILqihCygCnvXFc0KE1c5UGDxyp75+Y40JShqOcC4vsnua4YRCkHGJxgaPxEW+wWtogYIBK8ciPgDzB24QWhQkrRiZDX518/Fhzdq5fZTRFo/UTMMzeK4FZEQEqrfCUuagjT9bxXC7LVt1n2rS0aWcL//ZiY2K9iKflB2lB3QSaxiwoT3AHxmjDfWBxcQt83yHTMQOcJu4PIto8qnTTxTCAycgkbXfNXGMOJSi9+EU+psoE7If7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680281; bh=Ey54waso+ONvtWKHIbJxPR5j9ldjpAQddrfhjeO1xH6=; h=From:To:Subject:Date:From:Subject:Reply-To; b=is042XtoY7FlEfbj1rkeupqzOCrjkDHyFXu1JbQOk/QdVpNa0uHL5utFOUHEr7oqbMhb1Pvcn89YpDWCHJFddbXHx+2PR/JlgPaHGCczRlQk9BgxNL/CuNB4ccq0m53hVkN4kOcmCldTfgdl5tflqEfgg9sT5ku/eXZrfJ7b4y8TQYQvx6K1T3N573f/Ool8qDM4//FtllS/OD4wYO2bpsvuPsxFzh2/rDfUK7HGO84hD+x4DnDNf0jCSS0hD3vyoMh84gCZHlhkiFZ4ed8tUcnxMVLtXc8W48nOjAviXW4l3+UeiXvSaN2OP+mUKpa2KkgMW+MKvOsCsiTrcheeBA==
X-YMail-OSG: XCdn72YVM1mND6M_2jEwLoTPfDsBdOLtppOFQ_zAcMoHZvdt43FqrQnzayy4H6v
 EB3ddGDNt9.0SudjRSKn_bFh81si6nVNkuZFbNXyf1QDR2G_xUjqJxhA4u9a28fCDU3eFDdbiTmR
 sOFfyT.tVywUD_ToidXKe84kbk0rf3tA2gWFM7zUpwk9FgBWiSLh6caYHLEBSc3z1ZvK0iUcpHPs
 afLU2SRpGiie3xYnBpnb8V1N6bNQXKS1vZsx6fqxM0wBMmN9E_i76yZgpmAXxPL9aSp4rEi5gDcg
 XpRl8ldDB6n0hEcmcR0103HVV4_JczzAyWqkZ4UV7fobya6tLAb4P96SUoqJfJOG8EwOJCUtwymo
 BQWObh0jsw5a9J0HW3qweSa_of9RkWp3OMW1.eHHLaM6NkuwUwPLHWO167CrSvDv0QKnbU97NnbI
 mEHGWnS1ucAjl.HLxML4eP_cv4RF6vssapK74x1.XhToVJ3D3tsG8a2JlckiBViSgMrPMVLhKmLn
 OHN9Q55LoFBjYjgHp14bUe1mF2Xb1gc8a0e.rWT.z4CWUNfWZmn2cKcQ09qqdEbncbhqSVlKHQeE
 0uonD8pnoitebWR4uRg0UthLnDusIF_OOiJ4MWhoVxcnIOeAKOUIOcWzpTXb7PlgbMgd8zJmxfLZ
 K9uWTFB3nqH.04urU.q6_WZ_SB41a7WzDPgowtM3ZE_7mCC_N7NLGvgpu9FalSFTOP1Da4cbRRMS
 .VJ8HtSfL5UzfbmtYhU84FruvBDqVFlU2dwFyUvfHD_PtURI2MdWdkRohR_H9WC0iC3IieoFY4h7
 0dD6xi5QZsC1qrhBfp8fw8hFVW1eh1XSob2sY609Xyl6Y198ck.7_bASYxAp_7MjH_gsY5tE8WCq
 o55N9Tyxd7skyxiKMIw82NPosciGYYwhpSyN2rEzkSst8b642clQN4Hes6Bk8bdb5ojvH_CSq3n7
 PD_v8owFyAzXLTc4bfdsiFOxNcqbFCJ055gbr_bD5MCXJOGT2DzlRy_10W_YGLkmpBIANYLdFe_L
 7mCSfQa_jFsi3UhUppARRrTYZcm38knBwenv0tbVGCqEPRks57lbNqr4Ew2gWt5scuNZNcwNMMYQ
 _lXPXn9WObvNvS.WKPusGjJQxI_7Uxfa1D.rONpEc0yk989uL4DDaUGCn_86hMbf7LOVOVd.7pDJ
 HQRvKXaEF6bUbRwpO_EqXvIFtdMP1TPvRKY5bCGLeeEdTZpuP2hQYpJKjVA9PkL1_VkUkJLyX0O4
 E0nStzJFJL7n7Acnc6.W6OATQ0MtfqSm.muXY3Ob5gIc0mMsNd5Ir9_tQAfp06.w4vOEBi0zC9RD
 fGjR3J.swdmv43._VwXK6clWY5d1Gp8filBpzIe.CUUD9GX0RPMvqJ_YSW2ZbKYTxTQo1ji1y33F
 LufkU3HRiXZqcJwcgj4Ye5Lh.zGiRoiEthM2B0_SEtHZblnnj5xpq9w3iqepU7n5wEqXsPhDCmJJ
 a0KIndTmL7hDZ4lLfguWBBX3V1X1C0Jg9UEYeJYwyZ_OciUj_mtakkcEi.834DPOxKotEb9mPyqc
 P5h6ObH_KRnfVg2Iyew9zM2Z0T1THyvQeCHSrvO_R1UxWl1eZOV86ZEqOKULJfboiKsRokCYyDwk
 X322fkvLnSpo0S0hiT2UNn9RMBN53lFCcN8qdG0HTyYpQvkObqp7ECf.n9QcFT457wkkkD_476y4
 EhOxnl.iTzH_o1jl1DzElPvVXLNhqaI9T84CR1b3Pr2vhHQJpNTt.PLDeQafPGwJapny9OYcorsT
 9OBOOJi.UhrsgWKGOLNqA0S6QqGSDKF30MjFzvQhP0oRAJSWGJmTlHQwDfxlCn2T6qXYCLOp8wQq
 1AqPIIoEDwW80SvYd7XPwFvJos82BYWMne_rhfPVf0olXUt0D348kQgsjS6IOoS_MFm4G3Xp1Sd7
 z.Lrj6Ipr6yTCbJVucmfRh0R4WuZIgrdUeWxug2FpseTFmXXZ2VlkXhj25lEg5hUDUd5Bi.qnUcs
 lwHN3P_xoGKvzctKDg4pePJyr7vm5TUKXM5rnH_ajulsA.5xtmqe13DDLlGa4MmBPA4nQDVRRa5Z
 Ehyn7vuZR1a9.Eno11G1Fxs0FUmeKLFsdWvPtKaWMqNMgWlIZjLBE7jp7FsvBsw9PV3Stz8eOtOo
 FUaaUyQ2vWw7efZjgShxEl_WWeIu7HEBOrKMxqiZW1zvOOQyh9OfPE45rcvBhIqDFqmSdglN9v7E
 VndOz70dDnkOCSXa94wy45GBkR2TdcSfAteyenE7ELUdmS8YEfZtjF7wWHj9ULeR7f0Vhr8VIhwV
 Q7HmvSZMgCaXlGkFDaDsH2v2KS2HleyB6KoAHBb9HNhMMJ6bNEM3by9gxvjgV61POEweYHg38Jmn
 lmWzNMta0hmZRN3oAcj2p1b09G3EODRzsc7FevsjZXrJzIckVemAojMAmwuVNjoLxJdbPphRuFlR
 VlcmtI9eeTqlMZSE.h1jPnboMrYlyttxoq9gKPfuq.cgh5P5DSsw9sMFFt8D5yJYFyJPGbMbUlVu
 ROQiotAvHaIIMbKUK2kLl6_pITDGfg3DYlX7IB.1d5LI_CocvyrydGJCMlwJjLCxpsI12gQ_rIWD
 tTqQ2DfiQtTAOHgObFDeCpj4OnikHM1.npdfm1Z1e0VuaLT.DJgL8HMlsiuyf06WZ3ly3b8yqisX
 _E4IXAoZrjrKMmafcmV.juo2ToXdKoV_uCapaKSpOrfMwDX4Jby_Ho.KIzxcI19s5plIlNSQN1SP
 p5WlM4ZwkHFTfa9EwZBOLejZLn3JfD.HdO9We629kNlxRp1yWywqfaEwv.Ef9.sryNckl5Dom9Iq
 qHXbvBoaepmHI4Th9mZEpFMt8PA9oFrPV2M6D4o5LvG14CjfxmSJUWrwptcdTyxuiNTYRG6P4pB8
 tYQfulqgDRS4NWpGmHRLU0UNjIawtWUj72jV.HgwkjlcBqwgbsWKYfwznbDGC5d_4MFNVYtpGXqf
 b0.5AOmVdyK8fT.MGGMpSXdIaxmQJGG0ynQjalkz7vQJ2_DwCSI0oKg0xNxqsylVqnsCaeDLignt
 tUWGb9d5EICUiGnX1k83YMzTs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 16:58:01 +0000
Received: by smtp416.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 792070e81a7e943f831e775718db2272;
          Tue, 26 Jan 2021 16:47:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v24 06/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 26 Jan 2021 08:40:49 -0800
Message-Id: <20210126164108.1958-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
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
index 112aadf3e7f9..5d8dbfb1dabb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -448,7 +448,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1066,7 +1066,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index 291db266fdc2..a3e162c4c0d3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1739,9 +1739,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.25.4

