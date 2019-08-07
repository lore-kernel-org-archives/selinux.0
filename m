Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F2C32757
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73814217F4
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RquEBeu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbfHGWnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:19 -0400
Received: from sonic317-27.consmr.mail.gq1.yahoo.com ([98.137.66.153]:40625
        "EHLO sonic317-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389633AbfHGWnT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217798; bh=Osu6XGAcDFD0M+ySV74N8nqsIlm0gr6gJHIRJiI8EKM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RquEBeu1b/YoxREBJjZ7gub/9K61AxuchCoOB/HXcoHeavU9PVR9MwyHfGwW5n0B/wsqmyQ9OEH7nJ8GW+ujd64XIjH3804xNSOlaeOTUpf2mmIbLSR1+VRsVdqDdSnk6y0ffuG3rZ/7tVRnVM8nFoVSYGRnzG3AACp2U/12cO+bC6TPJD0sVGui1bEOdqQbqKGTRS0E+r8p8k6t6z9DTtaBvROcQc5YTOX4I1lDDUbcE6g4r693/PB/OKgzYDbT4D6QRl539VqfXQSdQXk4eHfE9L6ykYq+PKmpAAHW7vPw0VNTTWVn8+aRX/c89cLmHNiPgVXAg+XfhN0+FjZ/uA==
X-YMail-OSG: zKbkBj4VM1k2F8fyRmZc7wxkgQ8GgHwKp8JxA7LrIZk188gCX8xMfADb1pDzirA
 TPpPRTxf3JmLzvac.LhnpC9MX3TkpqoWhRQoQGcXshFQKpOaSCt1ptwC2q2O15ZOupQyhJ4SFDWY
 yOiElM37jIAyCB5xHw0406exMri5GQ9plajmhxKxaBNWYZN8M37hKUQFc_MvfHBqaDrtGSdGKu.7
 nRJIswrkr.z4pfLhgjFauLu7yBbSQqtvb42otrARqCdpkILmFk8OZEETSkYwNsRtAB8Q8mC1AGcd
 nroZ7cbod7U8Jnjz5si9sUqeHJlDKdH.rWF32ZhROixFfGuM_9trc8u44SInUCPeJn4sw8sFz6__
 sLh8vNSUTKEzwG2x8E0S45Rv76f9.lvZ3UOksgM7eI1NVz859i4XZTxmXHLdhMK2wBwjvhYMa8Ok
 8DfkhuXoB3HhcCMnV_t7q9IVwbjvbHD_.g1MWMKvLvz6NpCmCbFe6A2ibem0NC7jjt.3dcsxuoIZ
 GCdKLQeJiRS5Eox.tCKzgewWJe7R6FCjmQB3kCxzTXXec6pOy_qYWiBGKaVP3EzIHpFfR8012XgY
 3XoMC4pgPljAWuj6OzqDxiM4TtOr6SMrq38Lah2csHF8aOLd4YrHcwhr0tu..faKP15iU5Px5l_R
 yQRBMkKp0f1O68VkABFInWXJ8tODZFgYUxLAI3rYTZPD9CsDqyCB1iYHsiq58OV9_hCLId9A7HI2
 ZEkgXvaOd.2cFFEEYDfwrzhWXTcxOhnM6KC_0rCb4GZrffhjNykf968tJzS5CB2AtqckLQUWW9nC
 K.PZhApBGEmI9kNldkve1brS39gJvG3YxW019yBfb5AEZysbbXzS3oYmKie4K_8ba_qSY3P4PnFG
 AH_ZAG4KJ0ItM5dLRBQgJAZ8xpNtFJLSSNlvHFSC9CJyD8uxdikmFBupvUG5gmI2JKc5T.BKaq7I
 FR7t7nKl6cbgRDQ6TWJhpLkywqLkg5A3Iregsoa1zwLWtVBcNNmnGYeVEWxr.IkiGkqFLAWS3q_n
 k7ng4baWQGE_r0QPsj9ht8O6xu7oKoSwYbf6t4EWvRP4f9SG9muaS6nyuw78aWCqWSWFmI8jS_P_
 FvrdJYNFVgQHdY576v7H1TtP2TDfpxTgo9xdKh9mTzCf8JPJDueIERmja45xHeqwv94JdxpVTyWS
 w5NUq3i7zPfU4t3iQsAc1vtuASSz4CIJeL9A78KbZia0hv1vfs4mqxTUw6LJN0kopO0gi.uw5uvi
 Df_FMtM3JDpH17tPgiSrcs6kmgBMDG1y0R5NfV.X9YyXecd5cvlywNcsJiawgVDYrwqeGeTELKLG
 eeLpE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:18 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b31e22a1723893410aaa66faa171513d;
          Wed, 07 Aug 2019 22:43:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 16/16] Smack: Remove the exclusive flag
Date:   Wed,  7 Aug 2019 15:42:45 -0700
Message-Id: <20190807224245.10798-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Smack no longer needs to be treated as an "exclusive" security module.
Remove the flag that indicates it is exclusive.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 122c13604d28..3b76ec6cf960 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4822,7 +4822,7 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
 };
-- 
2.20.1

