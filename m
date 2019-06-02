Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D17BC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BFC2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="n18yMz2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFBQyt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:49 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:41144 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbfFBQys (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494487; bh=NriQJ/Ly+k4Qx0CdGV3MY+BheCtZdoxEEIBOuIRJP8o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=n18yMz2c2KD/+Br+6EJfZY4fvQvzHNnzr+zT/HwEknds9CjcI0CpnbUFB83AvWlJWdzFDS/1Id5tvLLTQ3KiBcBTYST0MnXXDA096Pwaqz5IrVB0iMrSSkH28rWZBeO5i2tZ8fR5l7E6M03Xv3QakNMn+A1TiCZ1fuu9yE9bURo8zX5nkF7utwssPwDHvep8Oo/h2U+ZrQuFmJqHjgupdTDWtiFdB2Ex2axoI5SQWFG0NKNtYsyJ4bkK9TYiZ3p38WFB1EoJpksvZ7jFjPxwcby62G1FUPG24tPr/TEd/EKR+Z91k8fvLhkF4VcXDMqnxi2Mx1r16QP0ls9g5CA6rw==
X-YMail-OSG: mrpr6k8VM1kV7W9lW0lZb7lRfVVSLGLr3ZHhhOZusnrnbVQ60UA8nzrPeQpEzP7
 ti07etZfVHvMxLsfXA6edT1HTcdzkhhHYPBCUP089ETm5UVpqIHSyfxm0qRBs66lNoL7knbUPi8S
 qLxKbv15yDzr5yyf0JYnukbFOq3p2_9sf6zOzbS5_zl5ZGAGOzYWWgcMLc5xmbifGcWkH5S0gyqE
 81WQJV6_zxby8UWhXN7sFydYvs6Pgos.Hr92kSaz6z3NvyPm90Aea6xrRudceuR08sH4.dYk4NUF
 hdyvdvCDiJTnqVOzzItiZP6Ka4cuRVSZowosxndwutqqQiJ3DzBh8iq8ANlumrCLhmfQzGDb0UQH
 gwrxJOfcysY1GH00FR4h7Qax5xzeFJltkC9W1pDUEFxsHc6_fNXJaI2OGppbSb6n75M3s6tCxtzR
 rN.DcH.h2DgBCBbRTZou8IhVMw7RT54arSfqRJSOiMAXNEQ8AA3ZhQPRol6A.WZ782o6PSH9mQxl
 W91ZyPEkDSEcIHg9lN0YlFIIt9WEwIAKKjoiOxrUAabaHLMk85VoW_d6.eUF.gm0ZO4HZdxcMjwt
 BawIymQaJag1Xm_zWbNRGFgzT8QdofjFmf2bVX_3xZCaFUVSYXLV4eN7aGlsAOdebIOHRy.AxSPQ
 1S8i2b8GMPRUXzbhYTxsIGiGX5U7qHybZ6t0IV6HBUkwAoLVNJk_i5YVrLZOAtHMs2LF3XqxHZbJ
 Ic80hzOe5KISt02it6lyZVcpTpS7zv3pVWQ6QjVFnb0GWaHjtWlZOyfOL6dMifiUAt46fWXDmOtw
 g7l9yPFbNUQA0oU2hij5AmaRIEvpOysc66JWGsP7tsWbkYraarMocx6CNgS3Lf17zhZq.Bnmi8x9
 JqI6IKYC6ho1GlFNQ24Vyyf8LKy3Km0mipZSE5XnWGx2f0W_4kuX23.4RwR3Pzx17Ogg08Ofm3_e
 QNaovBUZNPU.8FBSiaw9ZKDW9WQD8p5Pj5PbUEL016JIyxcGPcBs8Ct9Hh5mCEYF6EMp8lt_r2qL
 4Rq2tEfmlBOu96PnUGbsjdmDDiN8NTIkXukGYq4AXqhRlBplrqFc0pCWbeisrUtFuKB1KQnn70zh
 1o3nboOB7p2SEleEHP5Re3znOHEXwjC50UyG482LUaBi0HBdO_JTDxZMsLZKbDU223uF8rC1wiHV
 w1J3FYPnNmAj7dG7EWIwz2DEHhUu1bG23SZ6eMxzY2N9Qpqcg.i8CT_gcd5Pvs8dQw1OS9Y1shJg
 o1BfezTb4hVZB7eDSEjLqJWiRyrUvLcgvRSRQLdNbm0AcSXdDnTF1I3A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:47 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4f202846722f9a871dab498da8fe7ef4;
          Sun, 02 Jun 2019 16:54:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 58/58] AppArmor: Remove the exclusive flag
Date:   Sun,  2 Jun 2019 09:51:01 -0700
Message-Id: <20190602165101.25079-59-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
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
index 771b0ae24a5f..a8b11a7f29fa 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1705,7 +1705,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.19.1

