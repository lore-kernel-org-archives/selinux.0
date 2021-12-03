Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B0C43219
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379840AbhLCOI7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:08:59 -0500
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:37223 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381326AbhLCOI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 09:08:58 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20211203140533.IKOC22188.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 3 Dec 2021 14:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638540333; 
        bh=3+PPY81aVoixhZGQ2WTru8CUTKFlpDf4d18Ysi5yDjQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=OY66lIkq7mZLRlIQLGRh0p9QKJlLMHk/pqYejq8T+9MIdNvQfpwmWK6yi7LkgcCywQOlo61aYjSxpcofP95i+JPL+jFKIrkyAGKn4w4JDwrD3Zz3+WhUmU3y3qC6Oy+uZg/zwovA8vXm3mZ4z2kIJuz2eQ0uQeU2HTlmtW3u6J4XsGMjYtpmbfMj4+EOoUc29X1oVyB+V69XP77T1yb3rGP34xc01bYDWFr/1Vq2QGOEASFlm/g/ROo4Ukc9a7Cd8HDrYxCwXRBF9Y4HkaTO+K5/bp30ctYTtn10asN3sczH6uqo+Xmt+nqFTx/UiqgeKatbXtBx4+Ss6EJLzif9zA==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A90DA061CA
X-Originating-IP: [81.147.31.174]
X-OWM-Source-IP: 81.147.31.174 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppeekuddrudegjedrfedurddujeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudegjedrfedurddujeegpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.31.174) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A90DA061CA; Fri, 3 Dec 2021 14:05:33 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 5/7] policy_config_files.md: Update openssh_contexts contents
Date:   Fri,  3 Dec 2021 14:05:17 +0000
Message-Id: <20211203140519.30930-6-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203140519.30930-1-richard_c_haines@btinternet.com>
References: <20211203140519.30930-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Used by openssh for privilege separated processes in the
preauthentication phase.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_config_files.md | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index 4b2c091..9f2996c 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -715,10 +715,26 @@ run_init=run_init_t
 
 ## *contexts/openssh_contexts*
 
-**To be determined**
+Used by *openssh* (***ssh**(1)*) for privilege separated processes in the
+preauthentication phase.
 
 **The file format is as follows:**
 
+```
+privsep_preauth=[domain]
+```
+
+**Where:**
+
+*privsep_preauth*
+
+- The keyword *privsep_preauth*
+
+*domain*
+
+- The domain type for the privilege separated processes in the
+  preauthentication phase.
+
 **Example file contents:**
 
 ```
-- 
2.33.1

