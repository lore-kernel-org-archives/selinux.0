Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD91C433F5
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 14:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381325AbhLCOJA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:09:00 -0500
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:57734 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381330AbhLCOI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 09:08:58 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20211203140533.WMWY6353.sa-prd-fep-046.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 3 Dec 2021 14:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638540333; 
        bh=5RA/VN5JYNfEkn8QzUgtaoeQHs22yvKz8LpKsVcZB0Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=RrZE466SOS+/H4UH60Fwqv74Dz7QeDx5Tccn2JT2e1cBZAnakZO90ZJ7NsTyzgns9YCx/6q74RrUGCa0i8vvsjb/a011hNONjlsdNr9yFdgWa8eU8JWQvpuAI1r5sVPJsAdNTwta1BlabWsNoghR/XOAkPkM4foCEamPiFoTLlp3L4oTouC6MZIiYx82MeUbGVIIzsUoOFmKev25qNFyP+OiueRdwFiO9t/2W6LcH4sBWXOs1Mkg5W04zH3OezttIeDVGoEWK7lb56FX5iK6MMqDk7YjRZPDHeFT1VDdFXKosg43Y99bfQkoxuq0i7EC9XwoIsfwJOlD1roGcFNP2Q==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A90DA061D7
X-Originating-IP: [81.147.31.174]
X-OWM-Source-IP: 81.147.31.174 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepjedtveeglefhvdetuedttdelffejvdetheekgfevkefggfeiueejkefhtdffteehnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghuihhlugdrmhgunecukfhppeekuddrudegjedrfedurddujeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudegjedrfedurddujeegpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.31.174) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A90DA061D7; Fri, 3 Dec 2021 14:05:33 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 7/7] title.md: Clarify example code location
Date:   Fri,  3 Dec 2021 14:05:19 +0000
Message-Id: <20211203140519.30930-8-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203140519.30930-1-richard_c_haines@btinternet.com>
References: <20211203140519.30930-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clarify that the example code is not embedded, but linked.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/title.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/title.md b/src/title.md
index caf5b41..03c5795 100644
--- a/src/title.md
+++ b/src/title.md
@@ -82,6 +82,13 @@ Android.
 **Object Classes and Permissions** - Describes the SELinux object
 classes and permissions.
 
+#### Notebook Examples
+
+The Notebook examples are not embedded into any of the document formats
+described in
+**<https://github.com/SELinuxProject/selinux-notebook/blob/main/BUILD.md>**,
+however they will have links to them in their build directories.
+
 ### Updated Editions
 
 The SELinux Notebook is being maintained as part of the SELinux project, more
-- 
2.33.1

