Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1F0C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057AD206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MLrBVreq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfB1Wo3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:29 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:34211 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730119AbfB1Wo3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393868; bh=DZ6t+DXWOolC0BApfZ0rPkxLybTRQPdYfxYwy99dDN4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MLrBVreqjKaMl6Nqeb6CutaNwlSPpMQ7+DQQBVqB03PT2YYDBrg6cm/csTSAyPEa/hQCrDNSafSvZdFcKgnYpuZvDJc7XexaIcM8vz8t8oG6PmAEg+LhaH64Mg1ccx7zLpC3Vxu6ldYUR1Zv6IrGLx144p95QU3jvH/Rd7O6VOC80/wJeiTOw4sGnjCXMxMtdUYk7mMcKTDTR0eyHx7logcmDA+A/Pxl+d8eic3ksyPHPAEsmKQi/jnopUu54HM8seiveKdBVhr9SIc0a5IOBtujMeQRtPJNE+m6IA7ild+vdsUvj3uPxIZzB9vtxihR8/dCPgNc2adEFWgDR8SeHg==
X-YMail-OSG: qK1RDTgVM1kp.L_FiJA3Wiv3v0z04C8gMorrq5FpHf4n8g2JSIHN6AldXeisFof
 ilWsgPFFVkOXdE4HNtiiOQdxLJlrSl7VIahICo7B2OLREj1o1u.k_o3x7iO6M7INzNKugO5tYaTf
 BDEMjI0QoKflMs2gHc2vQQ62kTBE0lsjSCs5NzH2M9h3rahFOqI.SyTRrWKEeGe4SnoDRnrSJil9
 TrnYrcOUH4422Km58PCbYI4F5zc1M6ONA.cwMs261rcCPaa31wwo65qF4G6Kv47WyRVf4X07XwTy
 .ricKKi4K_pQGoKgvvIxI8gnQOjZro0ESDBHZbsabcPzTi_Eroelw4pWA9MD2MoUtEWhUH.kD0KG
 7JL6f6yR_Qm1IknStzdsHzxuXueDuI6x4tOz5XM8jgDj6ii643LGGgliER.nieFlOC8VBoj9JVwk
 Ir6ASKqX7.smbSKqZ3W7V1XGKBUb3uDcV5xL4kLUgS2wxS2iOYENLltdue6k85QpulK2mOUxreMB
 78kadNOF2jToVHAMT_3axcGMdAWjC7rxKATPb9RUXumE8IP0IYrjo5rlO66cb0F.LNN7UDd_gHRm
 9UXvqQm6EA.GiIlY5KQ7leBTFhMhjChGo55.gqlJdsCc4D2Osfh7M8VmKtyjIO2DK_H6wsu2CU3M
 oyLHaaESIZ_XufR9a5LQVpQK8JTlXawxaTgX5kvUjz2euFWlPi4Ax18XmK2R4OQq5rIYf5FdYHDm
 2_XlBAaO_rv8g0Z0d9JxFVhAeB3ov8odG0VOvyJzTIQPfm0FkY1Y1orgi7c73AC6GaREjHqVLsEy
 Mt.t9ObRsSQa5FoKuMy9k_7_N8bHwW_A.PouLnqH3kv4LIKVIiX9aTdvZdlsuNucO2_Dx99DjbZR
 41cqLs9jwkZsW1g2Y7wLbBMQ_yQxQKtm3RRDqifA6uSaN4ITUEQqP6tv7prCq2mG0yTT062Wz.Pp
 8Qx2RHtS9Kmw8GqG08wAb914xtCit0J9lzg9cbd1iVAAxv4PFwOrlBEIhWi4TJo77G1_sODBQm91
 pHEuNinl7Iwat7spNcw6GqaFa6TP2ECLYKxGaCrxP65F7f22s2KiZUCcqaiYoUckwR9JKWOFVXXU
 CwOxcZxTDuXW8QaIIEURWmGSR0f1_HOvL3bUl57z2I8UeyE1LbpqN2FDG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 87/97] Smack: Let netlabel do the work on connections
Date:   Thu, 28 Feb 2019 14:43:46 -0800
Message-Id: <20190228224356.2608-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rather than removing the netlabel socket attribute
on connections set the ambient domain. This is more
in line with the way netlabel "should" be used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d9055a0df75c..f965c9e6287e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4057,7 +4057,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	if (hskp == NULL)
 		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
 	else
-		netlbl_req_delattr(req);
+		rc = netlbl_req_setattr(req, &smack_net_ambient->smk_netlabel);
 
 	return rc;
 }
-- 
2.17.0

