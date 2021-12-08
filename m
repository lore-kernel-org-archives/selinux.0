Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE9C4332F
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 12:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhLHMUn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:20:43 -0500
Received: from mailomta13-sa.btinternet.com ([213.120.69.19]:49251 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233195AbhLHMUk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 07:20:40 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20211208121705.UXGD16049.sa-prd-fep-047.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 8 Dec 2021 12:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638965825; 
        bh=bX9dwZe8JKCs5chOJkncD1MILWYqH6OBDjkHhOtP4gw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=XTMBmM0vdkR7U6SU8vY4TBlrcIJM8+XjGVYUYQZVU9uGqdc9Mv7GIkDOq2NKfSlqCmyPPXwHISIMAbWoUFrGSTL7Nx7uw+F+CUT2zQ1YyWuLt6fpzCGaBM22p3msQsmdR7pNrFAF3ExeEiRCZjayC57Iv8yqKwSAIzmxi11M16pfTAU7nRkkjU8eX2Ut32OyKsBG43gl9LjAeqI/3DVe5yUNZPPbkqjzlq0x5+9+V9be7sZYwmpJZbcTW6gbaeAhiv7dCimcDhv+/0kwgS/18UQztdmgCG0u2WZbjxQPzIxK/rcTLnH0k6r7CTp5m6E8DcBjKHp1n8lmItutLEdA3Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139417C0D2162A4
X-Originating-IP: [109.150.61.81]
X-OWM-Source-IP: 109.150.61.81 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedutdelrdduhedtrdeiuddrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduhedtrdeiuddrkedupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.150.61.81) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139417C0D2162A4; Wed, 8 Dec 2021 12:17:05 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 0/7] Various SELinux Notebook updates
Date:   Wed,  8 Dec 2021 12:16:47 +0000
Message-Id: <20211208121654.7591-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Notebook patches I've collected.

V2 Changes:
PATCH 5: Added note as openssh_contexts is Red Hat specific (Dominick Grift)
PATCH 6: snapperd_contexts is also Red Hat specific 

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
 src/policy_config_files.md         | 60 ++++++++++++++++++++++++++++--
 src/title.md                       |  7 ++++
 6 files changed, 83 insertions(+), 25 deletions(-)

-- 
2.33.1

