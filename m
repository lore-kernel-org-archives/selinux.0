Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88521C433DF
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208152225B
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 20:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="L6uPUU48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbgJIUe4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 16:34:56 -0400
Received: from mailomta26-re.btinternet.com ([213.120.69.119]:35321 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgJIUe4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 16:34:56 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200909133045.TZMP21348.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658245; 
        bh=OF0EKvMzFKPDtf30JqaFM4KHcxgNOCPSMBvzkAT5oJA=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=L6uPUU48RMiTiv4bqNY5E78WH7eJsBzcJqdDxz828LXcw2a2EHoViK9TxdA4s1vbkokLbpn6cgRpzeI+69MzFxQlDjf4/PHZUf57gqQLTk3Y/8tKDInwBCuBPXoMSpKlmobN9nAMARyrolaczlFDykuoz0GJOFjiFlvqwkTgOBUNMxKYroi2o5wD+rl3zhdGHOsUbuj6YRAj59NdSsO6SqKGu3rTTbkxSyNRVebsWrJ8kT+P7FHUELCB7z3a5oQjht4YqeSHQNdjJ1i/ORMAtHkz7KV9pGFsHzH3O0Ck4gUAEPzgwQbt/lfq2LZRWznlOAQXZOJ8Y9dVTwTbfLfwbg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeduuddvfeeiueekteekudehffffffeuudfgvefhgffhtdetudeihfdugfeugeeuteenucffohhmrghinhepshgvlhhinhhugihprhhojhgvtghtrdhorhhgnecukfhppeekiedrudehgedrudehgedrudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheegrdduheegrddufeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhn
        uhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134DB2; Wed, 9 Sep 2020 14:30:45 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 05/22] policy_validation_example: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:22 +0100
Message-Id: <20200909133039.44498-6-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_validation_example.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/policy_validation_example.md b/src/policy_validation_example.md
index 8b7513f..222d216 100644
--- a/src/policy_validation_example.md
+++ b/src/policy_validation_example.md
@@ -1,7 +1,8 @@
 # Appendix E - Policy Validation Example
 
 This example has been taken from
-[**http://selinuxproject.org/page/PolicyValidate**](http://selinuxproject.org/page/PolicyValidate) just in case the site is removed some day.
+[**http://selinuxproject.org/page/PolicyValidate**](http://selinuxproject.org/page/PolicyValidate)
+just in case the site is removed some day.
 
 ***libsemanage(8)*** is the library responsible for building a kernel policy
 from policy modules. It has many features but one that is rarely
-- 
2.26.2

