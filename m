Return-Path: <SRS0=xdbR=5S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B04C43331
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A806C206E9
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="l9odtNzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbgDBNkI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:40:08 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:26259 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388520AbgDBNkI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Apr 2020 09:40:08 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200402134005.SASC3855.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 2 Apr 2020 14:40:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1585834805; 
        bh=pVcpNzXR0r8999sMbw6TYPjPgmSML1uSN0xu2fa9VYs=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=l9odtNzpByZ980qjjDOoLqi1wIQwOwAZC2JC3yfEj0XL4cfH8TS9tE0bUDKtde1REsQ1LAKA/0Zu6fcYThwPfoGolw77mEjOd2lGglXfTX/FSiyeGWu5kcoONCo6aI9bMWValp0aMgHjA3JBfiLfx/MMIW5tVZDNiiXMfJQEMqbaZ3uYkFRy/L6XGK3mUNxGTTwPQZkaU8nxS7ovRTXZSPdYns1eozv0PyAk/Z22MuV/f8i+mc8W+nxYyQTh4a+mSEplJ64bkciE91uE5q6mA3DWAIK0/j8d9Uw/NeKe/QwU4YEExuoeGwSWYm1JzvS/+ZtDnIQFXDjJu01D0Hv0pQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.154.154.198]
X-OWM-Source-IP: 86.154.154.198 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeggdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudehgedrudehgedrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheegrdduheegrdduleekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.154.154.198) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A2411093A20CB; Thu, 2 Apr 2020 14:40:05 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Add notify gitignore file
Date:   Thu,  2 Apr 2020 14:39:45 +0100
Message-Id: <20200402133945.8427-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add .gitignore to stop format-patch sucking in binaries

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/notify/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tests/notify/.gitignore

diff --git a/tests/notify/.gitignore b/tests/notify/.gitignore
new file mode 100644
index 0000000..fd7c5db
--- /dev/null
+++ b/tests/notify/.gitignore
@@ -0,0 +1,2 @@
+test_inotify
+test_fanotify
-- 
2.24.1

