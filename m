Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A8C10F0F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFEE20851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ulr1SYjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfB1WUJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:09 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:35157
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729872AbfB1WUH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392406; bh=XvxKnEkF2sbi5gT9OtymXDF9xExofaDsGkL7ia0bjZs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ulr1SYjPuhynVx4q5Td+Du1DN038UtWX4WMeHc+AGMsGcTLldUkJNhYSkvRafB9XyIrBh5GQlvtLS5mya0+mZjI3swPg1grefA+qhHQ6vxzzWD+unt/tIXkjp1QD0n9zQmUoJPXMzMNfM6s54Snm6bL7VWFYyPff9orLXIJVmK0/leiS+VcZBFf/gk2GmQIC0ZCvDYdUp98RkW7I0ksZ2mSI1yxZKpeNTt/p+DC6S1vA9xrSqvhFsjer1+KHk1IHDRaPBhPjeHe9o9kULvLBXNJvlhIbRXuLxJOkyoRn2jkQ0739R58D0EPlcz3RmPN6MYLE12ELvqsu+7h5zCMO/Q==
X-YMail-OSG: 5sa3upkVM1kXPz5sVpCuZ8FUxZlSWR_GBxT3lSNlz1LPmb2ivM9NGcxT3FHKyT4
 v70j.chnOMOoOHLeJUkp0sTLY4bfEbKPfUTn_gvmjPsfaXRR7_M8adlEQ9_NuGZDg2jqFKNzyGSA
 67VM3okFjhrTtUr6V4f20kpLvg77nD3itlrUFOJFhS0gd1mtckQSFmMZUx7FQaVQeAOmnxDRhs4B
 eJ3h5EMhZdaLoIc0h8cbDNby96Eg99vEur_DOlCMuaEPRMJdcxo.1H7e0BGgHL_SWob0IMvVWofR
 IM5rxUz5TCaQwLRMfJOS.MgyvPpxma3zuN4htjSYDDh57_Zs7.7BxVIR9AR.JPQjNdG7jEitZ2zY
 kXnRFIPjzy.HMYk0b.LPN2RZX2dXcPb3WpE0knZZfxYU2NXOqOAg26Ql4sRW7rLorQ0Nn7T6jVRu
 o5TO6360Bz_y0zR6KGRh3ceLN3uCmGhPHLh56PHJGi72Q2HHhJih39FqFQvjvekmUflcL6oGAdpP
 8HaYuycUrTJsVEcyiB4J5i1sU4npojcnmY_l7OKB7EqfnAwxYtSuVqDsCUBLww9Y1n2lYHDHjQLz
 GAIApz4x2PjikzGVZuXAnidg5jZMEjG.j_Fo_XzRA7twgXujJLfGJu.vMZISD3T6lSlN_gWEbNyB
 hxEp4H5X3lFSsLI7qGdA0TQ3V4oD.9cHAdJsEtQByaxHLZ9Zf_nx7q7wYmHywJwT9AaZ.cMOEbKk
 1arPMDCRTYmZK41GcMUSviVessEJUrFCoW_onWHy4ysXu_cu8KNf67jRwcOmKodgO7GKz5gIiVY9
 xxf6xj5k7LTUQc6yaMxZN9FnWpZnguctPXjwbObfT0lqXgZdilHBFjizUjkD5V2Dc.EETG.grN2Q
 Fd0nTh5uHlAuNE_CoxlsOeFzDhHLxdHGUgeNBGqYihVDj1D73yUe6JwXfzWCPe4LgoXk7TQOD_tk
 EmdqHFjzR57enfSXXfgQWkt24iBf0Zyf.K0S7yrVV4EtBAI1xXC8VTiai_n8qJKneYX5swxZ1HAw
 LjjciG3CuFPTGqosPCAWgOUNOVoSG6Qf3xrwXcxVzN_VBm54P6S0b6x2RpNVMAIsFj1XC5YT9cag
 Zg9sBI6iQuQMbICp.0G.0SiMCRUo9fSxY6IfZuyt9fpld2vKX
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 35/97] NET: Remove scaffolding on new secmarks
Date:   Thu, 28 Feb 2019 14:18:31 -0800
Message-Id: <20190228221933.2551-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in nft_meta.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nft_meta.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index a03de2ab833a..9f5040140fe0 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -568,11 +568,17 @@ static int nft_secmark_compute_secid(struct nft_secmark *priv)
 	u32 tmp_secid = 0;
 	int err;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &le);
 	if (err)
 		return err;
 
-	lsm_export_secid(&le, &tmp_secid);
+	/* Use the "best" secid */
+	if (le.selinux)
+		tmp_secid = le.selinux;
+	else
+		tmp_secid = le.smack;
+
 	if (!tmp_secid)
 		return -ENOENT;
 
-- 
2.17.0

