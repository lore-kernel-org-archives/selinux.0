Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292EC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 23:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8DC20707
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 23:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="X6P2s2jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgAaXAW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:00:22 -0500
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:16336 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726246AbgAaXAW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 18:00:22 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200131230019.LGUD7916.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 31 Jan 2020 23:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580511619; 
        bh=lU6iuJU9fRBJtZ3TFlP0iL8uAgrae5s6AsaL+feESqI=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=X6P2s2jfvq7x3KOTQny1aqX0tbu0kBQ62bWBHmIfvkhN8/vj/F21sykxxqGbwJgDJdTqWz1/CVJ2ntpB8XVuMbG74Aqlibx/GuT1pxq0Rie8p6TmDSiwEJAaU8imxVIN1YwTwntPDrlXm4rMZH9iz1wwUgKTjOu+rjj/gH+c3iRzJ2aQEMlwVgmCDjy9Qv5yQ28P3G3jQfkDmUEd3h0yifYUlc6jFXDJFso2WyqVZUbqyt7VE+p5rBNUYMgyQjZ8chgGiNMDQx/T0fFMmQeKEo6j34YrrCxvqaViUs3EjJdVmBISDbZYDhFXTjUHQRgHMdiuYSXIBcciWImxyaJXLw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.1.149]
X-OWM-Source-IP: 86.134.1.149 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgedugddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedruddrudegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrddurddugeelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.1.149) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DF93CE107537504; Fri, 31 Jan 2020 23:00:19 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Binder goto brexit fix
Date:   Fri, 31 Jan 2020 23:00:17 +0000
Message-Id: <20200131230017.199775-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now the deed is done, correct the final leaving date.
Could not resist adding the relevant dates to complement the 'goto brexit'
statements.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
Before anyone asks regarding '240616' It's the result that counts !!!

 tests/binder/binder_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
index f60860e..319b5dd 100644
--- a/tests/binder/binder_common.h
+++ b/tests/binder/binder_common.h
@@ -43,7 +43,7 @@ enum {
  */
 #define TEST_SERVICE_ADD	240616 /* Sent by Service Provider */
 #define TEST_SERVICE_GET	290317 /* Sent by Client */
-#define TEST_SERVICE_SEND_FD	311019 /* Sent by Client */
+#define TEST_SERVICE_SEND_FD	310120 /* Sent by Client */
 
 extern bool verbose;
 
-- 
2.24.1

