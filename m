Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93453C433DB
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 16:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41344207CC
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 16:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhA0QFL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:05:11 -0500
Received: from mailomta25-re.btinternet.com ([213.120.69.118]:54816 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236969AbhA0QDC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Jan 2021 11:03:02 -0500
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20210127160218.NEJU14484.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 27 Jan 2021 16:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1611763338; 
        bh=5Q/ZDaq6RSyISgZ8pqQEe7SNeCs4dRKnjD4FQxJGlqM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Bd26tKUPlQSmlzDXqrUOtxznNnRMjdU2dHczfLYpi0P9CKNJzjeuTQBQfD7FkRGLGOfterMQKHz1Y1bvMX3zjl7OncxyPlyMUvxaDilQ9cwxgUSKEokVqPkZ374LurNGjnrsONCb+b/pf+rjGUbkIVgM+tg0GZzC40xYlX0EAX5mid7FiQG5rnsayY2e9ITImfDhCfIpABiJw/TxqTyYZooNOVc6i5kLzNAYMmPqlaP+he/aI8fFY2zaem0gB2ne/1U+l+cu59a60NRcbO6l0gsBQCBYivZKUlFY8C1wmELDlQNq3UuolJGp1CnlTOBVwYilOyS3Ygk14+TCfB374w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C2FD23E09352
X-Originating-IP: [213.122.112.100]
X-OWM-Source-IP: 213.122.112.100 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdekgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedvudefrdduvddvrdduuddvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudefrdduvddvrdduuddvrddutddtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (213.122.112.100) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD23E09352; Wed, 27 Jan 2021 16:02:18 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-notebook: Add policy version 33 requirements
Date:   Wed, 27 Jan 2021 16:02:12 +0000
Message-Id: <20210127160212.135883-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update types_of_policy.md for policy version 33.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/types_of_policy.md | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/types_of_policy.md b/src/types_of_policy.md
index b9ae190..8172947 100644
--- a/src/types_of_policy.md
+++ b/src/types_of_policy.md
@@ -373,6 +373,12 @@ will be the intersection of the MLS range of the two contexts.
 See the [**default_range**](default_rules.md#default_range) for details.
 Requires kernel 5.5 minimum.
 
+**Policy: 33**
+
+Implement a more space-efficient form of storing filename transition rules in
+the binary policy (also decreases policy load time). Requires kernel 5.8
+minimum with libsepol version 3.2 minimum.
+
 <!-- %CUTHERE% -->
 
 ---
-- 
2.29.2

