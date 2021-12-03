Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE9DC43217
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 14:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381327AbhLCOJA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:09:00 -0500
Received: from mailomta6-sa.btinternet.com ([213.120.69.12]:49293 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381329AbhLCOI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 09:08:58 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20211203140533.GKH30965.sa-prd-fep-041.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 3 Dec 2021 14:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638540333; 
        bh=Cqp6+TX0CQHo51L27Em1XZZ2IjmCUyP1aPLF2x5Reqc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=mLa7M5bebutg29rBCjfBUJbHpU7yTpQDuE3hLUDVpG5YqDkyOoQVnocW4Ymrwst4kg8CYfvJqcngDSjBGaP9RfqIwZe9MFrFgTlFcD7qLa5ZtgOpgKVRImFqf7KmEhunI6QXfCMWTM62vJQ/jqRYaG1Ug3B5mpgylZfNXnF8QgYdR8xkf4CCZXKrh2dJOF8WahhILkjfQJy7Fll3SnkeSFfpiRUxF0H9a3YzVYmT7F1niFzk3e6khUyfo4aqy4Mac6fn1YH6bFRsnRp/ZD6Oj3SG7sJETnKxJ25S3mmcUMD+x/SQtHuZZam9SNplmTOlqNlefTzX493kGt7KjwRMIQ==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A90DA061D2
X-Originating-IP: [81.147.31.174]
X-OWM-Source-IP: 81.147.31.174 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppeekuddrudegjedrfedurddujeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudegjedrfedurddujeegpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.31.174) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A90DA061D2; Fri, 3 Dec 2021 14:05:33 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 6/7] policy_config_files.md: Update snapperd_contexts contents
Date:   Fri,  3 Dec 2021 14:05:18 +0000
Message-Id: <20211203140519.30930-7-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203140519.30930-1-richard_c_haines@btinternet.com>
References: <20211203140519.30930-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Used by snapper(8) for filesystem snapshot management.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_config_files.md | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index 9f2996c..ffc4fac 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -816,10 +816,25 @@ db_schema         *.*       system_u:object_r:sepgsql_schema_t:s0
 
 ## *contexts/snapperd_contexts*
 
-**To be determined**
+Used by ***snapper**(8)* for filesystem snapshot management to set an SELinux
+context on ***btrfs**(8)* subvolumes.
 
 **The file format is as follows:**
 
+```
+snapperd_data = user:role:type[:range]
+```
+
+**Where:**
+
+*snapperd_data*
+
+- The keyword *snapperd_data*
+
+*user:role:type[:range]*
+
+- The security context including the MLS / MCS *level* or *range* if applicable.
+
 **Example file contents:**
 
 ```
-- 
2.33.1

