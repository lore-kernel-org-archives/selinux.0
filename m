Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25E2C4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 14:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380315AbhLCOI7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:08:59 -0500
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:37714 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1379840AbhLCOI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 09:08:58 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20211203140531.NOLA14747.sa-prd-fep-042.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 3 Dec 2021 14:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638540331; 
        bh=D7vWDOSWb8vBOYTMjKLtkZzjigh5VJOnxRRVWd1vcyk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Gz3TS4At8XtfqZPRkfCzQp7q7Xwyzplm4luCBoo2SbXEzwtFXOU7rryDsAG8CZC45xZLsPki6eI83aZRb8oxiN68a9x6nZqwXvg0goA3dXrJZj1x/VdUQBSKITYcHYLCfT5uad0eA1pQQmcDCYoW1Z4YR1PzoEjG1xR8q/6OPfEQxpqtENYJ00oESNjRIt/Dku5zSQV0aFaiPv5ALx/T8xKRR+o042e/8MafnXj4HWevcps0KH4lRK5FjAw3L0r76qeWI7lMH9HD8jDNr65+MDp48+WqRhnfsKWv2aWGGVaJddIA/jtfq4rL1NSaORacE+GZc1dNZNJy1G6fbQ1CVA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613006A90DA06161
X-Originating-IP: [81.147.31.174]
X-OWM-Source-IP: 81.147.31.174 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppeekuddrudegjedrfedurddujeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudegjedrfedurddujeegpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.31.174) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A90DA06161; Fri, 3 Dec 2021 14:05:31 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/7] Various SELinux Notebook updates
Date:   Fri,  3 Dec 2021 14:05:12 +0000
Message-Id: <20211203140519.30930-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Notebook patches I've collected.

Richard Haines (7):
  notebook: Minor formatting fixes
  object_classes_permissions.md: Correct the context object class entry
  object_classes_permissions.md: Deprecate lockdown class
  policy_config_files.md: Update openrc_contexts contents
  policy_config_files.md: Update openssh_contexts contents
  policy_config_files.md: Update snapperd_contexts contents
  title.md: Clarify example code location

 src/bounds_rules.md                |  2 +-
 src/class_permission_statements.md |  2 +-
 src/libselinux_functions.md        | 14 +++----
 src/object_classes_permissions.md  | 23 +++++-------
 src/policy_config_files.md         | 59 ++++++++++++++++++++++++++++--
 src/title.md                       |  7 ++++
 6 files changed, 82 insertions(+), 25 deletions(-)

-- 
2.33.1

