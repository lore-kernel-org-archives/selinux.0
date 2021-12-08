Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F68C433F5
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 12:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhLHMUk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:20:40 -0500
Received: from mailomta2-sa.btinternet.com ([213.120.69.8]:16002 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231674AbhLHMUj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 07:20:39 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20211208121705.EWQ30507.sa-prd-fep-049.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 8 Dec 2021 12:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638965825; 
        bh=GbV2RZQhsvjogUNK0TuxgG2yUmDuDQFGTULBRr9w8d8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=EUl9wkvwN+yEhq6bIE7VxlAzkH4entHvNLW6Uu2Xh4K06VymB+TNXYA9Yndg66mHnDHQsj21ohv5ZdvKfCQf9O0OdRS9rTtuPscUPfTsxi+EDbMu0L5TsbTnuf5V0tFnCaXLaa8psOGCWAkqVflIjIVoBecYZ3uwJy0wd67AeX48hWE8f9Vja8RNewh5JeMMNVOKMlDuIXXDls8KNJlkS12FCkT2ILgtjUPOJZjqm0PeOMzgD2+yoxf2mv4gMy8raOdS5zV3Y7lJa0HRSxLQLiQCCcVOOaMlQd8jU2LlIoBaZh5HwyZrkAppz8iI32BLWn0QLtZuVMNRqrsj0EsqCA==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C0D2162BA
X-Originating-IP: [109.150.61.81]
X-OWM-Source-IP: 109.150.61.81 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepueejuddvjeekvedttdfgjeeitdevgffgkeegheduteejfeffkeetleegfeekveeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddtledrudehtddriedurdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehtddriedurdekuddpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.150.61.81) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139417C0D2162BA; Wed, 8 Dec 2021 12:17:05 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 4/7] policy_config_files.md: Update openrc_contexts contents
Date:   Wed,  8 Dec 2021 12:16:51 +0000
Message-Id: <20211208121654.7591-5-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208121654.7591-1-richard_c_haines@btinternet.com>
References: <20211208121654.7591-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This config file will only be present if openrc is installed.
See https://github.com/OpenRC/openrc

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_config_files.md | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index d186b98..4b2c091 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -680,12 +680,34 @@ matching of network packets - Never been used.
 
 ## *contexts/openrc_contexts*
 
-**To be determined**
+OpenRC is a dependency-based init system that works with the system-provided
+*init* program, normally */sbin/init*. This config file will only be present
+if *openrc* is installed, see
+[**https://github.com/OpenRC/openrc**](https://github.com/OpenRC/openrc)
 
 **The file format is as follows:**
 
+```
+run_init=[domain]
+```
+
+**Where:**
+
+*run_init*
+
+- The keyword *run_init*. Note that there must not be any spaces around
+  the '=' sign.
+
+*domain*
+
+- The domain type for the process.
+
 **Example file contents:**
 
+```
+run_init=run_init_t
+```
+
 **Supporting libselinux API functions are:**
 
 - ***selinux_context_path**(3)*
-- 
2.33.1

