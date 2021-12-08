Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565CC433FE
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 12:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhLHMUq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:20:46 -0500
Received: from mailomta13-sa.btinternet.com ([213.120.69.19]:61045 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233196AbhLHMUl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 07:20:41 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20211208121706.KUXM22188.sa-prd-fep-048.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 8 Dec 2021 12:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638965826; 
        bh=5RA/VN5JYNfEkn8QzUgtaoeQHs22yvKz8LpKsVcZB0Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=KP55vLl9e2gZmvG1ZjQyvvpi6Hyt/b+HJhga7xu62moRQxX4HMTWkx3JnB5luMo5bb8d0qOHTRCcYmuyhF6kue5YuQ4asfiXS9K+e7k3McOWrLAJH6o/aEeYNepUQ7BgFMahseL48SD5UWq4M48kNuzARTxEY9hI0MYoiiXHrQIy8xpgcuC7c3GiKL7a+6VesXDX624j20IcCVeXlXZAu+luROapWA4TVAbZgaRhpKLLgIaiCJYlOznwF5haiWWkZ1Ba6mjvQShZMb9BVp0tyBR4ovU3+VNEDQ8jNzS+uf2lUc0svMUW0t7rklbuqQeQIjxcYcyH5pS71gEVjxjkCQ==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C0D2162CA
X-Originating-IP: [109.150.61.81]
X-OWM-Source-IP: 109.150.61.81 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepjedtveeglefhvdetuedttdelffejvdetheekgfevkefggfeiueejkefhtdffteehnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghuihhlugdrmhgunecukfhppedutdelrdduhedtrdeiuddrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduhedtrdeiuddrkedupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.150.61.81) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139417C0D2162CA; Wed, 8 Dec 2021 12:17:06 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 7/7] title.md: Clarify example code location
Date:   Wed,  8 Dec 2021 12:16:54 +0000
Message-Id: <20211208121654.7591-8-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208121654.7591-1-richard_c_haines@btinternet.com>
References: <20211208121654.7591-1-richard_c_haines@btinternet.com>
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

