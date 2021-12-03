Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971DC4321E
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381326AbhLCOI7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:08:59 -0500
Received: from mailomta30-sa.btinternet.com ([213.120.69.36]:63001 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381325AbhLCOI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 09:08:58 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20211203140533.IKOB22188.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 3 Dec 2021 14:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638540333; 
        bh=GbV2RZQhsvjogUNK0TuxgG2yUmDuDQFGTULBRr9w8d8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=CpX+RCIbj0BAEBGqJSzHsXgQ9T2Dc2I3Rgbz8Vy0ffVuhoAINUjf43dfsm+pBGejkTDm3DxKV7SCpONq+SRANsgOJAyTWNSh80pqrH9CI1Ek3Mt+md8NUW8AiQsaZaO96qsKhEh99fTzR7/hY9im7G0zi4Sff+ffQMZa/2k0ZX1kqNLXvqaJtlbjioaqWaI3xRjEZPTbJycrp5Bb+fnXIYUN00fZY028U9aYXs2UH8gQOX/qgSmUHnqdjJ2Ut44KzzMYJ9HRGLlwn5MsUp5smJGzKxg225fs6Bc89wCgH0nJBX03F0KzjAbq+xDoWp0okMA3ykeLNK/+A0zI0bmsLg==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A90DA061BF
X-Originating-IP: [81.147.31.174]
X-OWM-Source-IP: 81.147.31.174 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepueejuddvjeekvedttdfgjeeitdevgffgkeegheduteejfeffkeetleegfeekveeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkedurddugeejrdefuddrudejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddugeejrdefuddrudejgedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.31.174) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A90DA061BF; Fri, 3 Dec 2021 14:05:33 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 4/7] policy_config_files.md: Update openrc_contexts contents
Date:   Fri,  3 Dec 2021 14:05:16 +0000
Message-Id: <20211203140519.30930-5-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203140519.30930-1-richard_c_haines@btinternet.com>
References: <20211203140519.30930-1-richard_c_haines@btinternet.com>
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

