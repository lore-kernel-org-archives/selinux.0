Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA7C282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33AE21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j/CV0okt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDSAsj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:39 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:36071 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbfDSAsj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634918; bh=NriQJ/Ly+k4Qx0CdGV3MY+BheCtZdoxEEIBOuIRJP8o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=j/CV0oktmGBdcaihmWg5i+mw6b4BZ7k2KcBlWJ76M9aCxBgc9FAoSMyzQy2GiuiLUobxQTCUkcfS5ns2iW9o212ERNkYk8//1u/2RZmitwBPie9Nzlfmv8JjgutaKrCxZB8u3EKERPjyzMlMIbKYi2zYbW2mPqh1i2DsSQr/s5YhQABVZGtE0duhYoLlELlfwEMdJBHq5Mr3dw6qKHNJZzKQLa4KYucO6pNGkgyC5pkOOTRG5UtJgVWp2HO97QhKybm54eE4bpaPAkTFSAyh9UDtzeNxx43fl38b8obCO/nSna9F/iMVTtqypRunxmK294BUfItrLAJstyi2aPtBBQ==
X-YMail-OSG: CLU.fegVM1nG72SpjvTJ8RCWUp_0KaIo5Lg9vc.grXsS_ei2jiOrTIso1BLlVN_
 _H1Z8YD3rfKGK0ebNnQBlK2reSHSTIXJGH1Qnlq6Ubk_IPecrBnA9dpUL7pWuJh8CsuGGMkYS1UN
 E5ZcyrDkgB5T_X5MF9O5gkCUI0E_ZNqZCkujDpIaaMaZSwBMO0fTCG4YimiecO5m2b_uHDHZDfwH
 c88D6QrmFzrheQWgPfXBW0J1C3K2Z67Ly6Lm.y.IVJ8I7Ll5lak.9LmfitmeogeoN9Jb5GLw7meZ
 NHeEQTKEg_d1GLS8ZlBKtYU.ZvtHlL6CqKUNDqYAvogUN.ECbKxFOZ2Xv9z6S8EGgArf58QABKsh
 dcdEc_KFHWTJvei_m3sMioMsbkG4RdD2WStnVcTdUz3Wje_fM2khRkI15.xA.HsVOlHYyqIi.nXm
 KT9CjUhLzlwHYTKjD5GQDas6cby88E7R2SAfrEuneyeNGbil9bLYmNlgjKad4zqDzVjVKc.LkbN3
 6YN8ccguAwhMClm6rTBwOM5FFp3Sc6exg7tAn3RYCX0nB0sgm91ZEdFTV9mFonR._qRNjNTG_k4F
 aYCOUqFDQ6TdqC.e5J8sgGFwnDV2Tdl9nWr8JP.8f0Fy91j46sR8eg741GpQH9kPvC63tcI6SDKh
 8UllII.kZOVBijwki9GtV_xYGGkPVLv5eq6ytJcS0oKJwzH0pvNrbHl6WEQZZR_B9M5BwlKMsu0X
 doCCxewZJhOVO9WuNgdtKoWPADAQDabPHe4BWJbttjiH1bQKj3vRrwaNbGaexOt7ESiwS3zZgFCG
 2IldB4zUzlTkuW76He3CM3zu8WsRP.yvyNTQnwGWEctDwXSOn0qVM1v8Dbrspd9H.pDc8SymrXFV
 Bb8_j8q2IXxZ66FFZNBW7hUK5ADCQbO_oVYSKLXuWk9f8tYpdp_DL4fhdsnqt8eFXz56GCVFl6b9
 KSZ5LCuS2METOABUZ91hdin5BeFQVuN_Lp2msympKC4DiHkzcXcSVf69YbUSzKZcpILXJs1jAGet
 h6RUpKBTvpEhQJ6ey5vkwoldyZVuwo_qQ.JmVnU7yEtYUqBBEBqzCTxIGmQLmweFOLqHE7OYWWJA
 mYcWu8lbT..1xZfuRUFSUJiawwsYeMf9cz38jkQY9.vwq2j.CfSv04bvpI.o.wXCPpTFKV2xPnn_
 e2M.ndZLJzHFT7g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 828306e040049ab0082b23fbf6722cca;
          Fri, 19 Apr 2019 00:48:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 59/90] AppArmor: Remove the exclusive flag
Date:   Thu, 18 Apr 2019 17:45:46 -0700
Message-Id: <20190419004617.64627-60-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

