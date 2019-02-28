Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF6C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADA5206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OIOO8M6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfB1Wop (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:45 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:44811 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731275AbfB1Wop (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393883; bh=ZsUZpEZtwQ2LlXvw3CDUvBCjaKP67jDOCjv0+cURl9Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OIOO8M6mxNWEzaOevJ8E6K6hZHcc5UDfnMllz0mKkmPkBd0jf5kJMrxPEmbJDmGxg2j3gPK6vNrRBpQNGnLzU2MliXZfM1au1nkP/HpzW7i1JijHet0TkhzsrSzKClnx9LY7nCRnfZzLSdyKZc1pf00P+fDVLh05Ou4PKqJMMHIyG1rBNHQUIqEHMK75Mi3QFB+lFoOxQ3uJD5jfpMOQH+XLPeNbuBpTldfmA6iANbtafF/wMQl41KntXQAYE0BHD1wW58XLH7y3Sn5wCNDIa8ACXceYb18CITgN6ZkcH2lq0Sct4aUsy/Op0GH+ilyZqbjAzFV53hT+mcZNAlsuug==
X-YMail-OSG: sLVU7BYVM1kevKTfaaFsK2x6SFkZyRxWwiUSDSc.geBg8Z4Y_1K35mMTqx156Ix
 KfsLbxIaj4HLIMGpVNCRjFIIWo7_1ZWOOMcGjL1ZM0G13gk_3gMg_.0aY1DE27DHj1pF1L5TgsY2
 HMJhYQniMFHJJe.uRoZY_L8444v2.nQD4pPM50Z6_Mha4NFeFpEXgzjiQV781_nE.JzcjSlfcv7V
 ti3oqFZAe.SVv99YEiPixDN3DjyXvDogZrb7clOhZscOeAfFxukjRmFUUDLqN7WCeHMcQ.WWXHSm
 r_bvWWOWyo4UTj6doqvoi7LbWOQFfLSWcNOOdBUujsZS1PdEZv36VR3KeflDc4mNg79KZ5MPk3CC
 lrRPIYHvE77YvUIC7E.bXNxavdmAlqZYbuKb1A0cHIp.mzMqScGoeGr7HClLCp84nKjkomkX.num
 R2u59hnE_Og.DTImQM6fc5WTcgLjZKCVhVKo.NVRwAsNpt4dztEGvb9wkRAAG9PKjAd7XfdV58Ei
 D2UPRIRiaE2lJNXOgBOgzhAX5JN5dlaRx5mYfAJjUx4mcfJWO22y9bu9aNTxCaxOwgiGHVhm2Iyu
 Ughc9jQd1_AE2rzfE8WAEVHfXXCTlsXtM0eOJONhUEjRHvQSO9DWdZq.JtJYy9jUzdhTLR6UzEiY
 Ph6vF4i6LoLqGFVPy9fbtMDJTdW_Gx4PWcqqwrwDoFUxd6g0kjnn1q9xZWDpH7jVsnz6LET7o7PB
 OAjP2b_eeTu6Pxl4VPKYTOR.8wXSad__rdvvBQlx2GZ98qFFf0zSPqvtqxABNEkX5Ol3tCzLT21D
 MpVywvIkd2hfC23IkJu8bP0gAW6WPsxtUPT_8Q_UNKsTya.uo2mybxCZEMqhkoqHe0Jkc_9IKvNs
 C.V20T01mHdPFGJ.laWFRYN.BXipXuz8ml9fZ9FyKqG2mcHHIH1uZzT.29cA7G3WRuujVN71.Wwo
 BBWnUSBqrFmXRZcUMg_Mjcv6.wuguAHDlZ7WJe3UDIGK9DbG0Qz9iCf6Apyr7yIq6F26hKrWehNn
 hQUBb7wtneIW8w_u8TA_DXHp.HmhW5bZYGEfa1u57o1dc.BTAUn4WsO8MXAQtQhHLlggHUioZLe9
 YybcQ4f61oSCqcPDp8urDo8qhGeADlRMIN5ag0Z13Ffm13bKN7DkFet_a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:43 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 97/97] Smack: Remove the exclusive bit
Date:   Thu, 28 Feb 2019 14:43:56 -0800
Message-Id: <20190228224356.2608-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Smack can now be used with any of the existing security modules,
so remove the exclusive bit.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 885e1799df00..0c15e108726e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4727,7 +4727,7 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
 };
-- 
2.17.0

