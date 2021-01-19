Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CDC4361A
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 11:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313D5221EA
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 11:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405248AbhASLMa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 06:12:30 -0500
Received: from mailomta2-re.btinternet.com ([213.120.69.95]:14967 "EHLO
        re-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389184AbhASK7O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jan 2021 05:59:14 -0500
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20210119105757.UGLF30383.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 19 Jan 2021 10:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1611053877; 
        bh=3R2bmY6lM2gP0FuzWUAVzCmY4Gzvf064QiRUU1LvdM8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=TDbi2/VtwYXE6A/5k6RSN5gojlBNWtNYryCx6eOf4Yvkzl3vwKJ0/FQw6LUL3hbrxdqk1WaBMeO7lumn1K9iwWiiT7YMHYtna2VhGTTEn86adsFwa0SQNIaA1FSK+1XCqThO+Modnn4djT2ZFA1gCxzbJBQKKcAgLLMZ6mGAFUKfYA1otzxcsG1NT2wVHiXYWBbdg9ef0erkHAn4q6g3ilRUkTqkYL8fRE93lEp9RpXLkCTnPw/VbUvsS4lStaK/pMMCAN/1WkR5AuvnKfH4/CL1XZs9olcDmy7R/cPmXY+MxLL4R7WjOCPTCvD2BIsCFj4d28P56eYa4t+r4isO1g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C2FD22DF7599
X-Originating-IP: [109.158.127.23]
X-OWM-Source-IP: 109.158.127.23 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledruddtgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedutdelrdduheekrdduvdejrddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehkedruddvjedrvdefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugidqrhgvfhhpohhlihgthiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdho
        rhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.23) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD22DF7599; Tue, 19 Jan 2021 10:57:57 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-notebook: Add new section for Embedded Systems
Date:   Tue, 19 Jan 2021 10:57:46 +0000
Message-Id: <20210119105747.9680-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In light of the recent queries regarding embedded systems, thought I would
add this new section.

This is an RFC patch as I've not been involved in embedded systems, therefore
looking for feedback. There are a few TODO entries that need resolving.

I've made an attempt to build a smaller Reference Policy that can be extended,
does this seem reasonable ?.

I'll issue an updated patch in a week or two.

Richard Haines (1):
  selinux-notebook: Add new section for Embedded Systems

 src/embedded_systems.md                       | 517 ++++++++++++++++++
 src/implementing_seaware_apps.md              |   2 +-
 .../embedded-policy/android-policy/README.md  |  34 ++
 .../android-policy/android-4/Makefile         |  32 ++
 .../android-policy/android10/Makefile         |  40 ++
 .../android-policy/brillo-device/Makefile     |  43 ++
 .../android-policy/brillo/Makefile            |  36 ++
 .../reference-policy/README.md                |   6 +
 .../reference-policy/build.conf               |  84 +++
 .../reference-policy/modules.conf             | 236 ++++++++
 src/seandroid.md                              |   6 +-
 src/section_list.txt                          |   1 +
 src/toc.md                                    |   1 +
 13 files changed, 1036 insertions(+), 2 deletions(-)
 create mode 100644 src/embedded_systems.md
 create mode 100644 src/notebook-examples/embedded-policy/android-policy/README.md
 create mode 100644 src/notebook-examples/embedded-policy/android-policy/android-4/Makefile
 create mode 100644 src/notebook-examples/embedded-policy/android-policy/android10/Makefile
 create mode 100644 src/notebook-examples/embedded-policy/android-policy/brillo-device/Makefile
 create mode 100644 src/notebook-examples/embedded-policy/android-policy/brillo/Makefile
 create mode 100644 src/notebook-examples/embedded-policy/reference-policy/README.md
 create mode 100644 src/notebook-examples/embedded-policy/reference-policy/build.conf
 create mode 100644 src/notebook-examples/embedded-policy/reference-policy/modules.conf

-- 
2.29.2

