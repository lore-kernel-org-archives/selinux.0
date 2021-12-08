Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155DC433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 12:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhLHMUo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:20:44 -0500
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:31073 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233182AbhLHMUk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 07:20:40 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20211208121705.UXGF16049.sa-prd-fep-047.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 8 Dec 2021 12:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638965825; 
        bh=pzgR/eXlr2Vcrs7KLXB+1BdIgGebICa7/wbrMbKBd7c=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=hRm1K1Z29BEiyus6Z3JBJAZ+WFKA9I0uccqJelWCPTmY5V343lrOyCIpmnxQOLePZfjLH5hLf6FFjdI2ll0gvLdtHbORzWQfqbOr2W9ww06VcUD59+bTNGt3Ifk0mFwhBP12BiEdYCuV+BZixSVT6UeVv5AW0BPYw1TV44skRYJGzSW68HDgmWeyLlQbUK7zGwI6pJl50K1/AugGUKWPm5N/DYtJ9nMQt+aIZp8DtclOjWWfL1AclkT9Ekh8TL0XN1XkaoMuF+tjdo+6n5YLEKPGO2wXa9k0hRlBz7a9r55/lZnWGcfoIfkGM/Be+xTehxga0zveeS6qCR6jV+3vHA==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C0D2162AF
X-Originating-IP: [109.150.61.81]
X-OWM-Source-IP: 109.150.61.81 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppedutdelrdduhedtrdeiuddrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduhedtrdeiuddrkedupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.150.61.81) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139417C0D2162AF; Wed, 8 Dec 2021 12:17:05 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 2/7] object_classes_permissions.md: Correct the context object class entry
Date:   Wed,  8 Dec 2021 12:16:49 +0000
Message-Id: <20211208121654.7591-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208121654.7591-1-richard_c_haines@btinternet.com>
References: <20211208121654.7591-1-richard_c_haines@btinternet.com>
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

