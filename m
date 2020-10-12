Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC54C433E7
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4320BED
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lvoZtdXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgJLUo5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:44:57 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:44619
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730705AbgJLUo4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602535495; bh=yY/yFVl1emb2zJDw1hk6NF/KbSJkukEm4lylfgSZeVc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lvoZtdXt6BywiYHHdzjNSdLAkAzj6auEZvyrDbISa+hq6gUrFKi4BpfZUDl+U9MwrvigdHAu+ISpEbAnL6PT9YNA68twRjSfePrnNGJiB3uobo7ZfjIMZClZlaf09ZFrm+liPG+aEoso/Krx5vWF76ezKH6uec6cVNTxV6+jlOSF4riPxe2my/N0tP/y8Fc3zHuIBlRx4aGgbZm22HLtrc1+ZEV95QKLqpbwZ2baIR2O5X26yk9q1TOqy+YFvDHR/AP4fV8Fn2u1KW5rmFMZ4akZFzbXcnxXuk0y9qZ4iyjHe8uSGVayFK5DFVa3JHmSD5zX+qtKD+SwhyTNG1/b3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602535495; bh=QVDTnK5RSvNGdtnoHEmA6TIsda58Ah1+jcCHzL4V3VR=; h=From:To:Subject:Date; b=XnXQsW3kSPElMQNc0b+ZL/+gMN0VLw20j0QPU6g2CH7HMmNxUqEGmav3h2UELGaeR7/MvC2pfELoltnXZitOjBd3ZVPfIFQk/pa1WNvS5XYHSiHdg7I9iifTtA0CDnsGOFFby2z8UHUiD8aSs6AOXsfqAV6+agE38gyjBYtbe6rz875AfQ3exC5uHoS/cX9+nz7Bu6nPmgMk+N6EjxrL42pTYvA7W2bB1jXJ7MpGV0AjDr9JBCRO6ujnWCuLd4D/sWBRKCaR2YL6F8k04kIi6kbI2HHPA+nLdvbyWf1CLOyPdy54XFFUyWpbEMtDmcC52rWGl2/8mRWajHrBY0vXXw==
X-YMail-OSG: VruIYUQVM1l7qbiXi_7KeoBA5sqvPWyYfXNV7DJGxuvzx2jJfP576k.SWLxrvd2
 512K7YEhm8O7R6aoz6.6TD2QVkJJARayR61cgvUkGjsYa9Vv0L3LuexSbQ89EUtezbENmlYfUmR_
 7KmQBV8l2Y6goVA_ez59ADYUmoSRw7D3EiQgUwAfgJ_MQpxpaq2KL5Q62vjyY4h1jf5PduwE6mAn
 FwWpiNCCdc.2qIBXXXN9rm7o11rPOaEGiOdST.DS6mL7chWtobtTB_uitqqiXP3DKH2eMx.vw26H
 d00OxkmFTLw98pC8gx3sXWnMqJbqBXs7UdmTmgO6ZQ9FgbccC2NhGVFW1PK66RpMRpGFxYoU7SOn
 SF_515sHM2gYatc1dPh1JhHyj5DlRoOeerVZxFAKKiwd6_wSXhuAa8Rr3Q0fAJbFxAxaGxuNM0CG
 kh83JspJjvhCMN8epaApRsRrO40az5PiFgZluCkeAMpbuEjgkHMVlRT1lU8gpNYc1VsFM5a52bKg
 ODHPrfHJrPO2kMqvH1sD6NU82FAI24Ld1M57xmegqdK_yF7BwWhFbhzzZUGNV9ZFxJD3QvZhGl.4
 pVYma2R74sPEXCj0UrSx0KAcGJyKpHC2wLsR4mC9E66XfrckmJppI5s_CDw8pCBnwneyPE0JXgEh
 mLhj4LwHSWQQQwgzbvvKMjCGvLYIbAKZvqerAL4K.SspwN4nLzFXE84Rwg045dSFGx.lUqd2bC98
 zZYx9MiqvbQgmnkCJmJNvVNvrjYuzF6cMwqN994cYrn2VRaBYyFSzaBPZs8is.hIg4xo5NjXkm.a
 P753v7yM1RMo3Ndr4GxnhWtXHaRkUhn.2BSBtYF6U.JUb.bI1lG7hen2oZyemHxUvk9NCuxiKJCa
 eyyidmK2_wrAU3PzpJnCDf9S1AfQh5eAyGbT1zvazhcZF3JUY15bLYJQjgA1WkLi8EhhCP7UvvpW
 24TqvKhFY76kLrYBS10AbKMETxAft1UzMBSlbZJmUugk48GwtbSQsllpSMRejTgjR21kBle_g3dq
 oBupOryTp5E8dO2XaTjshJ.q54F6ViJkddFOHgeMV9_clyv0VTQQvrEBcO6gBW5XLMqGUYs8gwao
 oJ.TSctjQ7sC_jn68U0Yl5MUGERPY6tr8i03XiE8IQpDGY8T9LmCuB1TpdydU8.9d8GCnzmvFX35
 D0wEdYYA1S0grsU2pfDFbEPWGS9DLPDvsKlWKwK2jb8rM73S0PXjCA0Zy1ZvL05qsIvhh0RE_ZgY
 0.7TKoFHU7e2ihUIxfl1fRA0ESxdnrM7N2g72WN_zbPO2HKxOrvYrXtoawdwnjErblO8JHfqxJyY
 f5n99jsl44oxQ9AQ56QGrPhDE6LcI.42_FxVzA2P7zUgzeupioYbv1HmdP2PjqllbbVc6.7W9mNW
 yEC2QbYH8fi7IEJmNbwj4qFC0GFpdri1WHM9VpBjcg__DwST81L5Sy1w0m0Mr5ZIr69geZPwdnTp
 dUagfylWLDFFbtdEjFjUEWc3O8jLtL733bGFIm28aMypS0n.NAHVQmlEwuNaI_mM1JNSAu2y9cRc
 ULd0lvsPtbeyLQIMxsqyMszeVL588NUhBsatkR0ni.EbgzFjIVoiJKQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:44:55 +0000
Received: by smtp407.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 561d699d5555ea26bc71d1774629ca03;
          Mon, 12 Oct 2020 20:44:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 23/23] AppArmor: Remove the exclusive flag
Date:   Mon, 12 Oct 2020 13:19:24 -0700
Message-Id: <20201012201924.71463-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the "display" process attribute
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
index 7ce570b0f491..4b7cbe9bb1be 100644
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

