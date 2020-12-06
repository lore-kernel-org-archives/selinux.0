Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49639C433FE
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 18:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4592311B
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 18:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLFSTI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Dec 2020 13:19:08 -0500
Received: from mailomta17-sa.btinternet.com ([213.120.69.23]:37318 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgLFSTI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Dec 2020 13:19:08 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20201206181825.KTLX29410.sa-prd-fep-040.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Sun, 6 Dec 2020 18:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1607278705; 
        bh=u16omNl5B7Z6OnIpihVUoqTtzlEFTfy2yFzr0yJZnso=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=UwRvK0ptkywIYhlUknOm8lSTnq/ZV1GlLwiuveQDWow3iuhg5kt+VmSObK6s0Q0jLbF9CMVuTY290e40dNQHEDA+bhcT7QHnRi6oYZgJSojCNvLtzlLzkiUQFS2Bf5HfIcfOOltDE8Y0Jon8lXL2aSTcz2NouTHaaqauUExiCsPGi7rivAAApe7qD8Vt218Ke8maEPj2wunZcPqhGH/wqX0uYpSFw2cjvzWnNKF/hHbdhHfRy/7YbkDYAG+bajxXaWbLHJFzOdhpQGqgELSDdtMf32kuXNHnhakmQeIrmwLGd4O1xmUdacfv95m2YD4z/4vzGksOmi2uVVeTf0jU3Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED99EC91D964BC0
X-Originating-IP: [86.183.114.64]
X-OWM-Source-IP: 86.183.114.64 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudejvddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedukeehieehkeeigeekieeiuefhleegueelvdeftdehkeefvdeggeegkedvhfdvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddukeefrdduudegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeefrdduudegrdeigedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghr
        nhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.114.64) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED99EC91D964BC0; Sun, 6 Dec 2020 18:18:25 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] reference_policy.md: Remove Ref Policy 'contributed modules'
Date:   Sun,  6 Dec 2020 18:18:18 +0000
Message-Id: <20201206181818.103862-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove the references to 'contributed modules' in regard to the
Reference Policy

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/reference_policy.md | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/src/reference_policy.md b/src/reference_policy.md
index dd2de00..08e7744 100644
--- a/src/reference_policy.md
+++ b/src/reference_policy.md
@@ -86,11 +86,6 @@ repository that can be checked out using the following:
 ```
 # Check out the core policy:
 git clone https://github.com/SELinuxProject/refpolicy.git
-
-cd refpolicy
-# Add the contibuted modules (policy/modules/contrib)
-git submodule init
-git submodule update
 ```
 
 A list of releases can be found at <https://github.com/SELinuxProject/refpolicy/releases>
@@ -1265,16 +1260,11 @@ policy a copy of the source is installed at
 
 The basic steps are:
 
-- Install master Reference Policy Source and add the contributed modules:
+- Install master Reference Policy Source:
 
 ```
 # Check out the core policy:
 git clone https://github.com/SELinuxProject/refpolicy.git
-
-cd refpolicy
-# Add the contibuted modules (policy/modules/contrib)
-git submodule init
-git submodule update
 ```
 
 - Edit the *build.conf* file to reflect the policy to be built, the
-- 
2.28.0

