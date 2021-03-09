Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDCEC43381
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328D3652A8
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhCIPKw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:10:52 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:35779
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231856AbhCIPKo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 10:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302644; bh=gHD52fMIACzOJbAaDdQvy8CsRFtkwZuZ0JBEN4PuE/E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JZkVehK1bY4yJZkYrdQ4JRPhtBhTzsBJaawDynV2L1H3Pmnup795X6x0E+Ag6Die8BBJzdFnnE6tXx9b2yyGuZmhIiLiyntPUzfupg5D6MdSGHeCb+GL6aP3fK4b3Xm+AxawIRBvWiUGFViHthaARrpZOOCQTIKJwAxK0W9G0ffUUbP/UhDqr4oqw111W6q6eF4GoPhyUOvhgVNGtgHSNzVVUdBneejWpq1BDKJzIK0anAvMBOMc5HCUgIhoroDrfJ7p+B6cocDLx0ooae/twwcx0sSeKdWxuPZjuiWTS+X0IrehSjV8LS7AqpwzARPH8hZwPx+RUtnPAGLCqiOSyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302644; bh=Fr66v8YfSWcF+FMj4vvmtLxTndb7Jhev3isJiuxX6K9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bnyqiGpGtxK4deoBmqMCLoUHfIit9RhpkwMDYKSWvyAAaSmRtrI9/vl7QZfBHaJ69MsHwpE335j0qptCPQfGiYrBrXQ5AmeXP2n2qiMrEen+cKJH9/n1OqtQ9PQE5eTsWMEOL0LHdXifIn4YXxx4wbY3TMf3LL0/96GseW2F/jyU9BGJOeSTGJemMTPXNiM2MRoNa/o/RWLel/Z+Cj2OctHgM4BWkpqxw//eNbK4+Han4aFnuKT1jPZilTRC/rEj5yobcp7nsmyuBEtpCLh8nCiktCoP8uk8+7/b2WOYBqahUCq0a0fjkhyCUfD3md138TzdNyOttMGgz02LzyTz2g==
X-YMail-OSG: XXkua7IVM1kuws67QmCalJs3.K01Mtn0Bwc59BRbh.4c1mImTlcfCyujo6i6RbV
 WXz3v3XuMHPhpe9YszFEzg3sn_MYGERukVo1mSejTLSJYu4aJ_u5pXR3tK617thags59u7UuDIFg
 M5xtpm2zLp_Mu0lOPCB8V17bBEqx9CtlscHxTqNvvunPN_3n9fIO7booRYFPwYm.ie63lQ_LDdQg
 QeThmRnGnt_b4IfMnBa1Yf0ZMBSXh1CSYu9lzFCE20W9b16jUx_GDPyIRnSK_CuylihLTju47wlZ
 vJT9odFW4DvYFckg_4qvgIiIS4RSp7X5mafmMtASu0gCUgJGlRKftY5TcIBsJnKy1PSRBWuvom5b
 Ts2YsmLivKrz..9rwPuIFbb.Nk.PBW8g348756nf7xFlJkUjxSg3zjQf_wfgj6lMbdUr9YiYcTo7
 ooTvUgt9GZT11hUCkeOo8B6BVIAuWM8fXXCsvkjDue._CBJkRHU8LoGUvxNmcI_LOkg.WlYOce2L
 jcebl2cARB5l2o3tN0VPJ3gWFcnfBJU3wwjQYXfYQUSAnuJcgGKCE81WRtNhBoTxjvcaCDiouvcA
 fARX4pZjZVtPefylyWbW4IJ2pD2mPoBHyyTWTo6a_wpa3RfYjPyhKReKXxueg4lSzFe54cx0gaAh
 rIZOEGAM8wuxKzvWiLRc2Gp5QAQmLw2ww582.eOKermHMY64Q_8JuLfEjB3B1bF9RA9wezloEN0K
 raDlsZN5.ual_c1FvwtZ7JlmBkTmlB6NfmMaIg6ZKeWz0MlpsgR6th6460.bjaSDx_c2yicvyHC2
 fL3xwCjD0wdTVFMxnI2iS_4JLpJA2G.nPo8rXKK_FUqpko.QsDpjgIh8zArDSMF8hz8L0MohwHIu
 vC14zBLmUqhZnOyK4qJQSnLRpMo75gZxUd_bqT0jrtK.29WhswH.Y1qrTAguFWWeWZoMJaAu5Iup
 h_rR0nhWPV6u1bZT8xXs.5hiX3yXBfN_ELuAcjjnCbJF1fE3UpxVJTB1usZvdeVYVapx7rNjyWfv
 Ott28mPlM1NHsy_al_2C3R.ZnWiwycBLGujAyhyRlfaNmhxOfspHkviyJHx428p5iQO3PYzaGpfC
 WADCOB5wO73xDNC0ym_vV9uokv7Ghl1RivAlld.p8zs.woshAPWIR0BEqaS279gQHUN5FJcsk67x
 n3O71.vaNKYTtKzIAGhK5MsjYHTbbqjYVKpK1Qb7k6RKif.Ibne3GkiH5gyBNDFy9v8wm898.4ON
 4LL44tKQaka4F4QJJuNibqU4tNpCP2X_Ye8Ij9YcgwvdzF0A_7NHkTW39E2a5jCm3oDdBnrhWzsK
 .qjIuRE42rF0MXYPLQbV7KIZCJCleg31Pd8ggpvWIzPGFKeijHFD9987OdGHROBN_yd_d32DLw0u
 UU4ZeRYE271axMsSpXDYQyFcmmOEtYHvDbz7.U_XqEe.xbalPTwfJTcehUrfeOGLIL6IGwnwHAOa
 TShoHT5Vl_seCMNPV5u0DclclwaAMyXcEyE6yhZNc4r96ARyd9siZo5hjmtM2n8lEqnO9YITl3Go
 d20AewcAb2GqNaYpheZtgnUVAVDDfVr3zF1BhafLs3IFKdY5lm4kMGfa7jeFsrX1kI_KOy8XS2mi
 ahTHGF0x5BfzkFIDEVAm1XSlUjjhedUpm9NjLdxQhCDvDSGZ09OW97q1FC5tP.gRYa.Xy2f.HVFf
 OV0ba.o8t4YTiomAm4aZNTbA6Hlj1G6BGBTmr1dpr0_E91jPdi47W_SxOYfxL0cLT6cDj5CJYTNv
 ow4AXh1pKj3wWoQG.5zXm.BcxKbeMGcHh3b1APjvazS4QJD5hj_9l_Dyh2Da0zvMzGBVGaPwdRc9
 u_fyVRYoeeq5l2BDz5ricF5uDMMSmvzFUb9jgQ_pw2irD7wPaj1umc.etIMh0C6DhW.lgYI2mgGZ
 7ase0q2C65RCp0VVRx6CrNxM.o52N9x34NdO1Bddz_m_dwVA89__QPwVuzY9S4brBwgJ9GGXwIMt
 uY7TnudlEib_dz8p8G1_zzCr8rtZW81QPA1nc8aYLXBr07rs_Klqjzsu7oidLAFyhXbrf_SN4V4k
 gWOv7Cc08AsewQFs4T_bM3dJcKT.oN4iTFGvZixNaXi9I4DGhPDb2X2fWcgbBw6frqTKN.GtA35P
 Ure6fDlhqnkj0P1YUucFY3onc95WLNxsu9WLdBwPehJLlueQ3iauDp5GpNtHHX8SskQDuHlFlY6Y
 .16O3OcE._WJoHvvET5Uq5_d8K.K.ufiK4EwcAuNI_SPUHziIVYbOg6d3A9PBCA2Jm3N8C8ip9cW
 1_JokWMIVWUZGcV19VOK1w1pcQUVHyn1dqCdBERmkvNfLMBeAI3dRZ.yfPwXYfLv4Iuu7QJJXzBz
 q_OaqvAgM2BZpWR5SG_JWxFZREcsMS6CT7MohHvtvH9.zmP9HtOkjdv.k48ZHnpEOY.rvFNjvxQb
 h.OdR2QjH4z_cDSHKjlWKS4K.YNdcdQceEIYfeQ2pAuWKMP2Z6UtE9mckn9QezGFfAeI8MtXSHd8
 jtw8tT_VgbvoL_9gFMvVy9eCukq0TRdcMdBfWwELS_T7bkFoNFOIcMkXhSe86kTyjsspqG9Idanp
 aljMKeDfOkcpYPewE.lYBIcUUjiqjxJQZJtjz84.ME_IIuCzN9XR8exylLPYk6qNdUvduqFz0Op3
 93jcNxZppCsZefGl0SuN6WyXyUT_HAC1kV2i6iktfV9JLN6fuGxQoTqcHLKNRF.g8eOUI.ZXG3aM
 .B5szUbAofAd.Gkqn08D2N.hOCvq7vBirJpg9NlJnm3shGPm2LS_D4viYjtccW1TppM0SMUK2tXC
 MXHqhtS7Uu23aSVlJCl4Fu7GWsHxkc7V36V5NcNDntTBSMJl_UOyenqK.EbFDRdLV1EwWgOerBhc
 ys4kkv4fS7uFiLhl5GedsqruTCQt1dtGd1d6h3WG2PFaCrpxn3nPCeujRL5rmj7k77C1KtfIYBSR
 PQOXKQK0PUjlkFt_LLdOy0pWTHVBZUplSszwmhnFIwT2lwHLE34IRaxzLHK.I3_Oe5.qZLdEsqav
 IbMg5q5R_.U8cCkZTNPCksd7V6CCcHNXQv3BlSh4YHWXEbBaIye05K3EwpOlse8lf.PsQwLuGBRY
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 15:10:44 +0000
Received: by kubenode506.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 34830140df26597516d4b8ee418de2e3;
          Tue, 09 Mar 2021 15:10:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 25/25] AppArmor: Remove the exclusive flag
Date:   Tue,  9 Mar 2021 06:42:43 -0800
Message-Id: <20210309144243.12519-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the interface LSM process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 16ccc4a002d0..c6dc0b6f6712 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1138,22 +1138,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1257,8 +1241,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1927,7 +1909,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.29.2

