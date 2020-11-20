Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF27C64E75
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1C822201
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 20:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Mh/JvBHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgKTUks (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:40:48 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37072
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728396AbgKTUks (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Nov 2020 15:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904846; bh=H+wPK3JtwKZOAj3KpQpuqAhGVYzQ6p+weYdxzzO+LqU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Mh/JvBHahtyWZg07kydeDI4xkEBrglQ/zBvX41XK3jaFNvvE4YrIc7DNTcnGG41AoM01q7irUmYLltUwFEONSFI4otJglIwgGzjtSEywsm7B2+UTppyQNtGIfzgVMkm5NubQmjrzMtAIzp1jO7qdVEhnJ7BlZNLlzMC7sJD3tx+DewlXq2KHVtYa0/aQcPIFq4BcbBgZ6MgDeJ08CnaUehBqthimR4FA5eT9owfnLQSGVhE9QA6P6UfXDIo0StzvkJe4DEhxQuFqfzrAijA0hFSpSV7ZBxLcMrX+ImWH+X/5RNyB0a85W+9wabz1GWGMwNF+ok4Iw0B+jJkzLtyCsg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904846; bh=81Cpu7mvk7z0vmGNAmuWCRhB/FXZvR9qhmtroMCs3+a=; h=From:To:Subject:Date:From:Subject; b=dp0UE5v6w5iSODnjCW0+s71wbjuLG7Yx2FNVsvF+N/URJ8g5pdjULI3FzrmLphJ1T//jOrddWvo+5mAHWunKtARUUl4cUprS9PgBsloxJzCbgEmhGtQZcA3hA/zzCCo4EuqVUzpsTK2z5Uv3JHOuoX33wTKBPgtKaTM6PAABjs8p/Y2LdYws4sC0ObxEMlovPVGUEYwxUWZ1r19pVkvcI3N9iNqSuEWDFytWKK5zelQdhHY6NDJzQy5senh4B9+eHGhrINtv8kr5eCPTlPOrRYki8znB6Jp963bu8hrH6dXSWnYyZANRb3BCPNI5eVzqM51r0G8fFnEbKyXwJIgsjA==
X-YMail-OSG: QEJ.gLkVM1lnDGmiGcbWtMD97I1p5_lv5qCQMR7BBOH_NXWRqjZX6BIrmOuWcxt
 9uRulLo.lyjnNh3iOgQzjGFRKlzoKR.7xiGkWcvbolWUbzrnRXMzAm3Ry.mWMj.tx561X3NhOL0S
 nUqPaEqhh_.a_Rm.ek9EGWGPN3hcsn1NUFYBcBmeGO2vIUHmb7JPIXxAVNjF.ZxeDyqLz.urYexy
 JzXJXAYEjGmICr_z2xnhX3.cnSmi03_XMFB9zjVWxA5JwhflTOzQ3GcKuGCjnNcC8sn40Bu7JScd
 v6ER0HIrfvh4a524aGG4EVarDcJRNxznXT9sOUvIN8N4UJfyF5o2ojsn3seY1hdi5JQkHjtK5wG9
 4NgAaeEfFiM7QfR0_7B0IN8ZGiB0gFDtZXpB.2ZLQP8cXJZBjxps7YCJvkblS5zTYs.sTiBOIyYA
 Wp7DbE5LmcZofVZy4Bvp62vW2tdjKFi97MwgKsZQ81jjZNXvBh4hCVLUjzuV.PnjQHhEAHZKiuu6
 0YEaO3RJ9ZNr_2VZ7F_p_LOxkvQZ3tk.bkuuD1Gyc_dOGpcf0VDpWFJpAI9Ze8Nq8N8lML5uMfNa
 AHy9qynMlUCkfvNoIAeBl6xr.jtcuxgKitInaamUNk6k22kodEBQb1ks0i.zCbQtBb5TSLLk3pFX
 EmQ5KOIWZENObWQ6pTnTZ_kahuBqPOYbtcmnmfe..kxQ1UJ1.idJ8WRoR1h.zA1j3JW6JZU_MdZq
 q19lb6thWWPM8TuRKCiPzJK65tVs6daD8Rk5MVFmX_FBGGtfOrplQHYHmdkVJjAwsmD.q3sWPiz3
 TiMHNPyf8WYbGd5gjzCDtuHCAy4i1LUP5M..wCc22IwOWizU.bWeX8PyiY.pmA8boXr4_6O1eAKe
 mMAOGj4.0rhPgNRT.tcz36PLhZMZuZm3Y3dtZ9WccC.zwWNmnO1X73E0KZDhOfeygOYlxZn5ELgW
 Tf0L1IDx2h85fwo9RU3YRMlXv0Y5b1zXl2JEaEUwIfIKi_ZZjqRMHFZwMAiqe0Xzjfg7R4VYB2gW
 WlGuvl8bfCfscfRmB0he17vf7Yko__qkHBZZhciZ1BGIhQ0vb6cuNqnR78pdGbSE3jQlE1imNRRN
 KzMb2SrH0q7wG4R3MQmFegfnHExLM8rL7ISJ5GMYNReX9ELHsFLLGR4VSfqtJujG7jqMC0ZSq6h.
 _mfzppAzs12abgqWrXcSiyzWsRbhz7YF_13rGiB5n4sJX5b_Ve.0pDRM8KSvUsk5cl0FUSz0aiuQ
 2bAI0L9SUBQsUavEWgAj_HKMmeG2sR9IQpeMiSkqdEYvxYMdKGNgb1WdWGJBzA8XAOX_ayfWbI4o
 2KdvbktnFeyD8L5LPokNrXm.VsL2AB9A78Lm21pAUP9.7xh6aCLU5zBnh4u_tAta.bufmsybUICO
 nnnk2_bdnR20uix2QPstpUvk.neLGxTYvDeDMs8FlKQHYCKzGfhl8dWPSiOwHzFazdM.6ZcOtp9B
 Pj3t.VL.tDwAEZsiipDh_ZQ4a7IW7Zvx4wyPcRrQHewkfMiPltRoz_j6n3DR1kbgmdOMdIK5LGmC
 9cMoYpljK_elZLWxSkBMt_mdUvB5PhpK0aIgWI2o2oZ3nFiYceZWwBkm2BRMJqypX6gAshaqp7nS
 oaV0GTJAGWlS0ZbvkZkNjxtnoJkj1gDpGgPkBpDeHT4SML91OXAbaBU5VSoO9iEgXY.2zjh.W8vN
 OQJkbSnIMjclCgu8ernh1PpXvcvTUd5mUHiYColmVsJdoLO6VXYnyQ5rrHK.mIMBV3oUXquyO0kf
 B2Dx_tDTXmi7CsdSjyfUrFElGfGj10acrsPXNpVR2tWd3znRQBSRp5BjSqyGLLF7R_oPXieA0gaA
 KkAc6tY9B.64nEKAT6bncPGmBrrgMIqk50K4Rm40lJ_idtA1w1iSOlGgeCpk4LXCq1RraM.RBWqJ
 DGM28QizcAVQ3yN2c0aiQiDQLka8hMAH06IytQisddGKGBVVM5fVzP2_TDnKAmTt7TnG.RBY8GBG
 oJOwDfSwdgx46Cgcx26N_WLHw9fZNGDMAkPyq_Ctfnw8tn4uxBqDXcnFw0SL45Uhs0zmKLANyHvi
 F677TNE_B74407YtP4UyuVloDxmZEyedaV2cx0H1fZUfpH0RkTBNBRT5FvhGqxUEzOlQOq3HXEsl
 YGU7IwbO1C.N0kVTAgJ0rAXS_c1Lb0PUZwsi3Twlq.OpEtvGBgxN6HkBTzsofzuwfiVrlEZllJul
 q3.VcsW1EU49IktTM5SSyiSio72rhM9m1phjuVF3oOSpjkVL_qlaIARCdbvACWTMAKrwnu_ReaQp
 BY40zvOyeB7Bm2Hk3ss2FK2AukoSbMxvK6xt__0xgVABilBn4KNwHwxqJuNjZW1cs3_iaOkbcC2k
 qhEMDqEASpOU9q7A0tho0dT52cR6zYjICrnkjAuHd4wdj_zm85z0lTytHCBH5z0xz3GJOMpqO.NZ
 LAxPGoISxObvGJczQwDqXKRkySIa0AP8drIAjRUt.rCVqTmvwbcJBmuVBD2uJwjHZA.KwH29CgEt
 RD2PepJ9QzuV3PgYgcp0xp876fZHckL2IIQzNPOw0Ps.CcPpWFmkzcubk8Wjzh9Pl_wgxjxSz5CQ
 sAxs76NSm_JzWQWLgYQA0GSjZJpqoCuTp.WD2qmDZqDV12Xpx_XyOqxQrLZrUWBwd8nCaCGCCn9l
 wKa7_3o9I_.Ff3QwFeuKzZx1ZNXhAR_ryAD_rrhoshF2XczO6RUpUOySLR6WCXPESaM_ibfIwq41
 DofM2RwvEeVbdS8e659741vRuvFW2reHZ3KDlViciC8BpdT3UQV7c5DfnJfSgDmcUquVH904xpJn
 psQLbe..8wvIT06qZ1mNeL3DWdOBQ5KEStlBgQPTVKw06RbP_TIsdTTHy7zJgO2Kv8HbJ.CQMsS_
 3BpDJ_9mRPDClJpUEErZiy1dyBHUMD5w5SUv0k4MS.8qynvRAadfBX8w_SKyfZNpIRQhl1BpL5KQ
 6owO6VpAMineoFYml12jBkii.CovMQqkphX7RTJACofNJKS63ByX93SYvUqw7H04DQ2bKrFX7.rf
 7ZcZKHoXu5GAhackZr8YHm091ZpVDRFW7wtAQECHNkmCItZXkk6aPpZCDbAO2b7RxKkdO8ayNJWi
 pL.9nsqr2zWpr90nfb1OVAfEQqIF2xqpPYpIuDo2ID7JLU.rK_vLKeTbZSHspfk.nt.ovfrJqmA.
 fgWGzdyF3almS6.7ChKPSRPVcJYvxDEivqHkxeAyGGBRR0Qj4ecC7Tny_uOumgkeGxLYguh9CYbW
 aGYwP_RLr15QVszu.Uv44v77vZCVeYqncgXWD_dLBcJvP8Uf7Wg3.BULb.pO2umwbMTtVnw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Nov 2020 20:40:46 +0000
Received: by smtp425.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ece91be106397a13102061f9b7764c23;
          Fri, 20 Nov 2020 20:40:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v23 23/23] AppArmor: Remove the exclusive flag
Date:   Fri, 20 Nov 2020 12:15:07 -0800
Message-Id: <20201120201507.11993-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201120201507.11993-1-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
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
index 36be7bdc917b..29e8bbdba37c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1129,22 +1129,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1248,8 +1232,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1918,7 +1900,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.24.1

