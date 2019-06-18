Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB2EC31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C254B20873
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IXt0x3HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfFRXHb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:07:31 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:35407
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730935AbfFRXHb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899250; bh=OlmFSyJ/XKQNX3wHGNWwNT26/n2hT+UF73RlDfHSp2E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IXt0x3HRaVCBfiWHb6WcZt6d+HSbMKT8KmF9dOWz9ssinKf48RA6Q675YN09sdaJL0beoRTweR3Xk/SEzEP6POaC7VYlfOyhIbberI4YFfw26Fbn1+N93Ko3QAMqVUTWFFoyXDuuFvdAAHkV/9uRUi5FAy1jj8bFt1QcZBZLdwMqfVeXCkP8pHVL7wAQiRezamEPeeav+NEx2wcLSdu5RlQMQiCDiJLsLiZiV86vFxLfBeArbE2ugDMYd5PIjIQaNLP0kkP06HYw/UDKyyBfBUlnuUcM8v2FurydRJSPdFNLtnHGirJn4OpLQbgJuay1YOoUKCqap/dnA/SkyO7MUw==
X-YMail-OSG: SwXrmXkVM1nEqJLUU.tCHI68grhzHeKc8wszqGmtMeK2n1kY1b9xbnIat_FadFL
 AjcVcuv9mBoEtV4hEE0BZkDnHwnu0PHZHNxJ.8K5K.wmBMZDt5AH9iGGOOemakhvzNCqL1QsTNzz
 WQcJD07tlrrV5LN5sc8a_kXg7s.yCCX0i_ZKUrBZSPmXPTBWw9vCAfrw9JfOkKnGxPStzgIpqr4g
 dWUkJGLuNEkJfnsy4qXm8JDdJsRGJQK8uAT0Mg2s2uwT.FWv.TnQtwMXVhfN1xZ_t8MKRnYevG29
 NmmafeEk9A1p6JIIEnbZP4d9BLa.EARA0x9gl27YuDHfRgC9QOea4IjdiRZL6bSwX6tBCi66oiH7
 5bZi9VickiejlPuBm3uGbRix718xa6YrGQ18zR6hKriE3okdhG8e5S5N4iZLPehPyUIvv5CGMfnS
 hvaicqRb7slDBbdbEVjL8ZU73NZ5p6jJokPOGLLzB5J22LNkfdJaxFdJLanpdUDk1GRFTx_uSHTp
 LGncqBTB6v_YbH2.fBiQd4SLZRW5Rn_sSfYnd1hwZDniOwKVr2Hr3gJ7Rfbf41G1AsOazbYLjTcD
 6Y7jmEo0Tx0Yi.e7fyk_ozOzmCC1wH7anzn_1.RSTxmyy8cVZh1mQiSQSl.kh4dGcl60QxpbmyiL
 t_qFeB6hpJg7qtGRT7.llt6fq64hLgL3i36OEVOIWD8uR7Vbj3aduPp9zrDL7MjdadMqNonFU9F6
 VcaExqJJEy3xUfVt_r02PlS7Tj1gvq4Cv4W0X_MbYw6vjuMJH.Ajw_XBsDKiOhw.CjpN6K9ABGLG
 gIwg4S4py40eLANVnzTVddYKhIfj5HjpdeN3vo8jLQulfDSO6DNpPPqyfjyMDSIqj2S.upN_zHG0
 J7t7bP0fG6IVJ4VW1OZ3lOYHe9__4WE4tUqp0QxSbZGQUVc24AWHKZq.Y6aPr0gfWZtGnLD3wN.q
 WLsrcuEGAP4pQRgaFe_SNsdK4ubSJ8wCsAluQW6Tp1slDGmocKp1WQxGHLTvHxwXUmRRLrAR08G7
 ihJl.IWvF1SXjhgc3XhQ1311jrN1AMpI6._C2sZpeyo9bpnlmAy6.DFbXTjMdfzgQjRHtaP0zcYt
 zY4qQ5XRpGlMEllaRQb2GlT8FRoeESck7c8phet2mNPe6N5oaGSF0MA5IpPMcyHfrjvXCxNYRlJz
 qKkGgS0UdlkhVsIfaNvYZdQUyP7JQvMILxzYS.6GESmibD8K4Gkf3.hC6IhEJwhvQLW_V7jyFwyD
 3jK_O9gvYLUSaUfsnYQhCfcplkFEq45.cGfZUqR9e6g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:07:30 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 32802204b4a4d598b4026998dc749035;
          Tue, 18 Jun 2019 23:07:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 25/25] AppArmor: Remove the exclusive flag
Date:   Tue, 18 Jun 2019 16:05:51 -0700
Message-Id: <20190618230551.7475-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the "display" process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index dcbbefbd95ff..6bb44bfe2761 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1709,7 +1709,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

