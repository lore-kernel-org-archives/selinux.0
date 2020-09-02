Return-Path: <SRS0=BB3M=CZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509FDC43461
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 10:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6197B22210
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 10:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="qGbH8NIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIPKEH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Sep 2020 06:04:07 -0400
Received: from mailomta4-sa.btinternet.com ([213.120.69.10]:54906 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgIPKEF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Sep 2020 06:04:05 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200902131747.PPP4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052667; 
        bh=NjhidpVpd/6m121M1ZJ1sjh63xQjRovGqfndLjJo40o=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=qGbH8NIeXKPQZmuy9CsDx8e5HcBBA/LbBQmADwuJQ3GVGLO3eANe64gCEI9RGtP1p0fxH/sQFxEx03AVjukfM7FT+nKDuyXnxPyYEJQ7tNg3fm5NWw4BqUkv1YsQQqKdG5bv5FCQQKA8h63ZDFNHP7ikXpmpRMb9r/owZYcVhatRPVCeVePB7anxtTZSHm6bSJkUcObvvIyBC3q0r9R1ehuKnof/mzt3GUtJpxEWAUDiH9fqpBAdsgCtOgk7Du75y/v+vB9+jWR6KlCNdJxtiaKx5jD5TVghr9DA7JMm9YvvRjeWkWE4LU8FJ+35lYp+UfH/E47yo/dVkTtiP+7iZg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpedtfffgtdejffetgfehfeefgeduvdeiheelkeehhedvtdejkeeitdettdffjeekffenucffohhmrghinhepfihorhhluggtrghtrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepuddtledrudehhedrfedvrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudeljedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeo
        shgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36BD4; Wed, 2 Sep 2020 14:17:47 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 09/13] policy_languages: Tidy up
Date:   Wed,  2 Sep 2020 14:17:34 +0100
Message-Id: <20200902131738.18425-10-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_languages.md | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/src/policy_languages.md b/src/policy_languages.md
index 90c17fe..add93e6 100644
--- a/src/policy_languages.md
+++ b/src/policy_languages.md
@@ -1,18 +1,20 @@
 # The SELinux Policy Languages
 
 There are two methods of writing 'raw' policy statements and rules:
-1.   The [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)
-section is intended as a reference of the kernel policy language statements
-and rules with supporting examples taken from the Reference Policy sources.
-Also all of the language updates to Policy DB version 32 should have been
-captured. For a more detailed explanation of the policy language the
-[**SELinux by Example**] (https://www.worldcat.org/title/selinux-by-example-using-security-enhanced-linux/oclc/85872880) book is recommended.
-2.   The Common Intermediate Language (CIL) project defines a new policy
-definition language that has an overview of its motivation and design
-at: <https://github.com/SELinuxProject/cil/wiki>, however some of the
-language statement definitions are out of date. The
-[**CIL Policy Language**](cil_overview.md#cil-overview) section gives
-an overview.
+
+1. The [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)
+   section is intended as a reference of the kernel policy language statements
+   and rules with supporting examples taken from the Reference Policy sources.
+   Also all of the language updates to Policy DB version 32 should have been
+   captured. For a more detailed explanation of the policy language the
+   [**SELinux by Example**](https://www.worldcat.org/title/selinux-by-example-using-security-enhanced-linux/oclc/85872880)
+   book is recommended.
+2. The Common Intermediate Language (CIL) project defines a new policy
+   definition language that has an overview of its motivation and design
+   at: <https://github.com/SELinuxProject/cil/wiki>, however some of the
+   language statement definitions are out of date. The
+   [**CIL Policy Language**](cil_overview.md#cil-overview) section gives
+   an overview.
 
 However more likely, policy is written using the
 [**The Reference Policy**](reference_policy.md#the-reference-policy)
-- 
2.26.2

