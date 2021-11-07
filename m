Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9170BC433F5
	for <selinux@archiver.kernel.org>; Sun,  7 Nov 2021 14:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B55A610A1
	for <selinux@archiver.kernel.org>; Sun,  7 Nov 2021 14:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhKGOXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Nov 2021 09:23:51 -0500
Received: from mailomta26-sa.btinternet.com ([213.120.69.32]:47970 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229683AbhKGOXu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Nov 2021 09:23:50 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20211107142106.WYLZ16049.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Sun, 7 Nov 2021 14:21:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1636294866; 
        bh=D6T6H9jSAoXN25ttQzJnQv0tD4aTaPntcJ1y5w+TvaM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=IbPWzEt/hLjTh7Hh0u9m+tU25pwAcAmbQHZDx/ow69TO3zfPZgRJilxcq4ktoPJ4tCfoVFQQXWybEAIJ7Ysa5zHCKSiF/Fg8EzETlAlx2CAL0TRJThGeSjBo+qDjQHx5tIDGqsGwATjv+QTErYn+pKKQcLKhElN+jTDW+g1eknsHqKfAcrJefZcN96ZQ19GJA33VZ/Sc4AA0gVCOfWwF+tlfmH1Mv9lJgWWPXheKdo7vJlDXQn5HPrRnR06YdKLkXvNge4ETv2wkfx5NQYLc7MLaTyfaBqqLYsftBlcbPQQBQCsWBpinUdPVMCJNxtHxsPpk1L/FfIVm4whjYIQpKg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139452E08A6447D
X-Originating-IP: [109.155.32.146]
X-OWM-Source-IP: 109.155.32.146 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddruddtgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepueeffeduffefteejveehtedvkeeuueevffdtgfekgfetgfekgeeiheevueehvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddtledrudehhedrfedvrddugeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudegiedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepohhmohhsnhgrtggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.146) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139452E08A6447D; Sun, 7 Nov 2021 14:21:06 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Add tests for sctp_socket transition rules
Date:   Sun,  7 Nov 2021 14:20:46 +0000
Message-Id: <20211107142047.32727-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch adds five tests for sctp_socket type_transition rules and
setsockcreatecon(3). More tests can be added however these test the basics.

Hopefully these will help testing the debated peeloff scenarios.

To be able to run these tests you must:
1) Build a new kernel with patches from [1] and [2]. These have been
build/tested using kernel 5.15.
2) Add patch [3] to the SELinux testsuite, and then this patch.

Note: When adding [3] to the testsuite, there will be a one line reject:
   patching file tests/sctp/test
   Hunk #1 FAILED at 33.
if using current git build. Just change line 36 to '$test_count = 85;' before
adding this patch.

[1] https://lore.kernel.org/selinux/163593840902.17756.9280314114933444317.git-patchwork-notify@kernel.org/T/#t
[2] https://lore.kernel.org/selinux/20211104195949.135374-1-omosnace@redhat.com/
[3] https://lore.kernel.org/selinux/20211021144543.740762-1-omosnace@redhat.com/

Richard Haines (1):
  testsuite sctp: Add tests for sctp_socket transition rules

 policy/test_sctp.te              | 57 ++++++++++++++++++++++++++++++++
 tests/sctp/sctp_client.c         | 19 +++++++++--
 tests/sctp/sctp_common.c         | 51 ++++++++++++++++++++++++++++
 tests/sctp/sctp_common.h         |  2 ++
 tests/sctp/sctp_peeloff_client.c | 21 +++++++++---
 tests/sctp/sctp_peeloff_server.c | 18 ++++++++--
 tests/sctp/sctp_server.c         | 18 ++++++++--
 tests/sctp/test                  | 57 +++++++++++++++++++++++++++++++-
 8 files changed, 231 insertions(+), 12 deletions(-)

-- 
2.33.1

