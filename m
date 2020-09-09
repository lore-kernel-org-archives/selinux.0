Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C638C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049E420C09
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="T4G1Iyan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIJR4J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:56:09 -0400
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:38541 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbgIJRyk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 13:54:40 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200909133053.LPIF4080.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658253; 
        bh=y1r4vzFsmPpbm4z3UWrE7N0fVgChZngxdViObrcVJ3o=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=T4G1Iyan2ojbEaLGSCVbSIN0Jzn5YDMv4nBtEZoI29nr/0bVpsy6EL6dZFc9F0UeLmOGgp5GdCOLHDi6UPwgegQyebT1AC2j1Ne5BIiuXK7EhABF/KGzq2qV5Gmgnz+/2/YWOBq1SBz4n36KZQVeLr47rXq6KHvZQsKMvbcGwxBUZXU5EOEZM6Jk4IG0VKK2VnTSeFZiG9A2LWCzpeyyfdxBFLA4M8RjAhBfjuqzlYO6AEbUCxFTOxESkpHiTj600ikvglzyLkZkCte4jZg8OEb+20ke2iSbfr9PgVwtOFxLBZliqdyzvq2lZ6WqvI1vHzfnBqq8pAWvBFBeBiuJ9g==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheegrdduheegrddufeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134EC3; Wed, 9 Sep 2020 14:30:53 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 21/22] xen_statements: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:38 +0100
Message-Id: <20200909133039.44498-22-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/xen_statements.md | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/xen_statements.md b/src/xen_statements.md
index e2c4cc3..c7bbe70 100644
--- a/src/xen_statements.md
+++ b/src/xen_statements.md
@@ -1,5 +1,11 @@
 # Xen Statements
 
+- [*iomemcon*](#iomemcon)
+- [*ioportcon*](#ioportcon)
+- [*pcidevicecon*](#pcidevicecon)
+- [*pirqcon*](#pirqcon)
+- [*devicetreecon*](#devicetreecon)
+
 Xen policy supports additional policy language statements: *iomemcon*,
 *ioportcon*, *pcidevicecon*, *pirqcon* and *devicetreecon* that are
 discussed in the sections that follow, also the
@@ -49,7 +55,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | No                      | No                      |
 
@@ -95,7 +101,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | No                      | No                      |
 
@@ -140,7 +146,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | No                      | No                      |
 
@@ -184,7 +190,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | No                      | No                      |
 
@@ -229,7 +235,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | No                      | No                      |
 
-- 
2.26.2

