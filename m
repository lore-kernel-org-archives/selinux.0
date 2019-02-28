Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27254C10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE582184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k/M4XxRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfB1WU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:28 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:33012
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731967AbfB1WU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392426; bh=YwEKmfUdJeYIoOk75VzJuE2RgnnRiZETVFc3PB8XYeY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=k/M4XxRn/WFSZASPaxAAVqm427D0iWRHdSrEqKDfqFIXi/KOd6otrHjyHqutnFEVX57tSVatW7w1jR4XU9Gc/2kSc/Cb2BcZsge7+Lt7VL+rdDSZE4iHgRtWtwlGZx9wtcwN9Z9/1+3JrctqfYxDfj7VB9Za2nWquaH34N88AI8poSeypMUy9Cp1SXYGhx8aM8YK3JuKVvNms87P0j0lfi4CywEfiOYFha2g7r7I+UB+WKyMQJhmZorLOrMukBx9d3g0E0Gby6d3wbLm+ePboUIUQ7fvnHGX3oPXHuQNwAOA32tPlFZoMua6SG4hHmFy/OLKPIAP2ci3O62kurnYTA==
X-YMail-OSG: 1USqhioVM1mdIXFbWhoHEyAuTaR2SBTnATZSrx9SUjd2bGJB9hMjNxuKZCzH2Oc
 9oIxMlbQeiXJswJaBEIRLifD5OegpLop2fHd32vJBoZ8YV0D8_JBR1wqapeACC6AzFnLb3zaDsQ3
 ykfuhNv3myXnLXOORSTa6TgjM1LTPgbEQ21St3iVoyVSn3o8v73tb7yBFb5bph.BJF8.iaTp5hkF
 DD5ZYk34xcOOnZp4QWrTIYAASyb3jxsUnHMlEfrCdcOMu5d8guAR.c6vsGEXwOIvD4rD6NHmTwTE
 yLT4MgS5Tuy34evcPjstAQpz_KN2pg.pUC7dLcwEslzlkVe76zFlJx_13LfrkMceCWfgMz7nl1YS
 e59KSLvcjJwNKvGq1oi0WwRBz6WCQrcHZx6Exc4WpE_loDfphuaPskT3IWV1f2XhtWk92UcTenBD
 cqCcpO6s9fmwhJCHnxxa8Ox5oljVm3tgvCwpFNRm8eWnrngtB3hvwSatULZBrMkUzrPQCJtOO5Ta
 qjsQ2nZZTW_24QZqtCTfNTFzVYx98B3M0q0A23FIkd214M42nAXH2FaXYtPdgClJQh69pmWWSMkw
 vZBIx0ylKP9Xc22ujn1zfrYNccjHQ_Fws.nTfWGB0pbZRBHROIvfd_XXZOt.3gPZZ0Ev1fBKso_I
 DbqVjccs1n5mPRF4Tx9lrJE9PAWfi0rb0c6aNvcMvfR_oPeqIY6qc0PKK_bstVjPDRQBKIeU7rGp
 qH5TNj6uL4nSWhHaBIeGrgmDvZU0FbamQXtw8j9jEZRaanAfA2P_Gi80e5EJPLRnEAGQPy6Nkbhx
 BBJrhxteKYp3UX.JGanQV1h84Hz68OjbNitg41FjQf7dm.J7NNj7N.t2Fb0BjaYsBJ0DNhbx2p7B
 oboHdQ6U8zSm136HsLVdDVm354SGTKQXSxztMmH9L9sbAwCQq1eX4SKJZceSjLQaYDYXY4qvUPHR
 2TCt3ga70sJ1FR7Iv7umdBW13OKlaoLzuMRk5viwXoLKKPveM1BHF2ZwTVChvhL7r.fmtC7teSd_
 uolNP5p7zpoaHIdj3T8n1ql2Cjgys3_zn61KBL3WrEP3YawcrY88ZoPwc9q9VEtG9rq_9tE0PL1x
 sqVPXNTv5..CSvMPOyBbuFk7FOGkkuAQuqfwMvbAPBVht6xE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 65/97] AppArmor: Remove the exclusive flag
Date:   Thu, 28 Feb 2019 14:19:01 -0800
Message-Id: <20190228221933.2551-66-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 732b4de175bf..d72d5b36dc87 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1703,7 +1703,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.17.0

