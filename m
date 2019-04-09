Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2737C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01132082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kyzgyvU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfDIVlp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:45 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44128
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbfDIVlo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846099; bh=NriQJ/Ly+k4Qx0CdGV3MY+BheCtZdoxEEIBOuIRJP8o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kyzgyvU3PrFzJIw0Eag2wrjxFPdnjBJAb66fNwl7ltDWr3TMtK7EuSDB2IOZN4pJa0u0qUFJsQsKL7W7X4gtf5AkM9k5pI+wz9lH2PWJSbLZCFQIgAfbT+2ZXGzWuQcU3FEXVsHW/L/oQlwf+9nR1spa8v8O70wNihIkWqok0jFvIkErEp7OYm6iojjY/hfYsmOXmklMb0s5x+17kJkuz7hjXfJGy/gY80BRTXfLADScB6droPcohchBQVCKp0RiZHXcS0dctlAecb8Q1jnlEf9kpO4A0mlmvOJbIIhmhvLS+9nrutGxHMcTOGB38KSHjZKC9e31UCjmJKgco9UzHQ==
X-YMail-OSG: lYIZs5kVM1k0mFsK9L_LeHMJO9RurH_FGcFPQ6Ioi26wqD59pk72Au5rS.ILoB8
 pHhnXzV6or61lB0bzLP8Zym7vHAFvo5nfKLXYOo.WUgfmHT_3w6Av_Nuq0AiAifJBZyw_VRuuhno
 6U0We9Hoa8PqkEjwRSqUZweNQDxvXFGS0GHB4aBWAoe3FSWY1o7P4qds4a5pSfQ3FC.mU10EhlJL
 HodQalFss7ap11OLrzEUSCvkGPcR7eubuJzMwVIM92PPL8mJ0nAnKMOWlcoIHTZXBXTS8oG4CvhR
 1Kk_xcrI.ervJLWhmc1F1IJRH8ZOcvJxbWardmcCUgsXCk.HbaYi1suomfZfJo.GFCZ6OQNdMOQx
 2Df3LwWvlMAGZc3t2fMyY.283lzjFo24VCaLy7Z8sBKXPe9NjllzZBz5AxOluoI9z0X0CSME6dX5
 WdUoq06OU.25JVhgXHn_jpPjOah8GostaqhJPSzQnNe4bDVMYfto2M414.vegIC2qMa1C62ZHV6G
 7MDs3Nk_xVXNOaOhXgQWJJ8nP6M0R2QOzCPa9G8DDO50xFQoBJyhjZQmbe9NSz4sJtR.Gcz6lI8y
 Oo_2lv6MsikyoIWOp1wu12pNCTLrAA84dQUiLK5GDAidpoDuv512qZl5U0_.k0BE4KDIeU_.K02q
 fHs_RyFAqFjRFr2lW7ru4.eu1uM3VAjKASFkNm_7r6v2igZvNDusEHtqeJ1GQTem5IRgr0o8gHLS
 q.dp_n_nbK4twyXerdJR1jqoBGgIblLmNS.Rp5yZzH0qs1EtjGJ8zFZ9tQ1wLd.qfGUDEJjqt6C4
 MOftAmGPLOZzFbRZYfiIbDYQ6.q3TvPERiaYVvNmuTTRcUCFSz_fVZBCEmRAtOnB09664fSK9VyL
 yKZILDs1ZmFQjHJcyIE91O49tJqJuRIMaRXDvc2XrgDF4Nh6SaxU5cs2t5SpK998RXQYvXpUlrgq
 qQMJEB.MmlXUXIEJ2I1DN9UmA5PsBh4HoQ9EmSYpgYCVI8ND4dJwV5RkFeaZiTKDo_IisRiOjPzA
 FLYdzRoWQSr51_rU39x5FdgtxwgDRvEhryCOnNJ2pmB3eHk3fZO0MczH4tFgHF3ZQXGrnVHl5l.M
 0qIbSMjc9sjgvzr7UPwTRomTL7sm9lyZJIB1XbBjVEOeQBSG8pEwFUMZ62gh02w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3e563602cfa877b5908e791085320721;
          Tue, 09 Apr 2019 21:41:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 59/59] AppArmor: Remove the exclusive flag
Date:   Tue,  9 Apr 2019 14:39:46 -0700
Message-Id: <20190409213946.1667-60-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

