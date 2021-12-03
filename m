Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29566C433F5
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 14:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhLCOI6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:08:58 -0500
Received: from mailomta26-sa.btinternet.com ([213.120.69.32]:13136 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237277AbhLCOI5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 09:08:57 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20211203140532.WMWW6353.sa-prd-fep-046.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 3 Dec 2021 14:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638540332; 
        bh=pzgR/eXlr2Vcrs7KLXB+1BdIgGebICa7/wbrMbKBd7c=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=VkSK9fvRghSzWXBbbJGTwN70DF6GqqRZpRJ+YgRmU4a1iDHaZOp/8BpWQVIiUQb7f3t6L/tVUKI1YNAEif76KSnhhrBUwbkn511Apv6gCieGX1qQHzpqA2ou75snoemo8GmGgwaOvVINuB9ESAvlXebxr3mjhaWX0/ycuBc3zLcKO6pTBu6lNmQ5L3fzwGOJm2c8BsaweXVx8z6fI+FR8RTVEiI5cZb5IytBGkgowAlldIwN32Dq9mPiKUvXpcM7MOz4x1xM0HwZ0Ej/wcJOZKcXzZFbqnBSnyHJHYe0u3RnOyXOfgg+rQw0BYqshbJ6AY1WjDi680xdTzjGq9MVhA==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A90DA0619D
X-Originating-IP: [81.147.31.174]
X-OWM-Source-IP: 81.147.31.174 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppeekuddrudegjedrfedurddujeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudegjedrfedurddujeegpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.31.174) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A90DA0619D; Fri, 3 Dec 2021 14:05:32 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 2/7] object_classes_permissions.md: Correct the context object class entry
Date:   Fri,  3 Dec 2021 14:05:14 +0000
Message-Id: <20211203140519.30930-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203140519.30930-1-richard_c_haines@btinternet.com>
References: <20211203140519.30930-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clarify the intent of 'contains' and 'translate' permissions.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/object_classes_permissions.md | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index bbc703d..b092a9b 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -3081,21 +3081,18 @@ Manage the D-BUS Messaging service that is required to run various services.
 
 ### *context*
 
-Support for the translation daemon ***mcstransd**(8)*. These permissions are
-required to allow translation and querying of level and ranges for MCS and
-MLS systems.
+These permissions are used for SELinux configuration file context entries
+and context translations for MCS/MLS policy.
 
 **Permissions** - 2 unique permissions:
 
 *contains*
 
-- Calculate a MLS/MCS subset - Required to check what the configuration
-  file contains.
+- Check configuration file contains a valid context entry.
 
 *translate*
 
-- Translate a raw MLS/MCS label - Required to allow a domain to translate
-  contexts.
+- Translate a raw label to a meaningful text string.
 
 ### *service*
 
-- 
2.33.1

