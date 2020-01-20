Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D8C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAEB214AF
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="cdo7ZxpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgATLLT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:11:19 -0500
Received: from mailomta18-re.btinternet.com ([213.120.69.111]:28491 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726621AbgATLLT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 06:11:19 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20200120111116.LDHY8099.re-prd-fep-047.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Mon, 20 Jan 2020 11:11:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1579518676; 
        bh=73WREYlW5g7N0sJaqcSWVQcKnAUdY8BP13quZFR9W5U=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=cdo7ZxpZGiyqmGV1zSKUdFLJfsnKA+SYFNnxqUdlJTuWuV5i/SvEghwU/ZFiXgl3VXvH+yJvUST6MBTu7mdLcWdaE7+b9lRpBnV2O7RZS77IftSjiOBNOqCDbjkZHM3QbxEylLB3EXqRegTJFTuHn06yYFFXx7eKy3mfLiNa+blCRUf5ABbN8fCO4OPZYV2Ycr0rWNlWkhDvbqyev7Su+yKs5S/5CC1P7uLyHNrqXVJ3n7SYvdkMZq8Ap6MMmq1A7BwG4sPXBowe2dL7xoZL69ZzERzQkMEsR0Ebekd0QQW7s7nnm5zgWwjhoTRynmSH5LrC7Aw1XljZHgC+DOH7Uw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.56.209]
X-OWM-Source-IP: 31.49.56.209 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudehgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepfedurdegledrheeirddvtdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedrvddtledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.209) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE078D0731A0E8; Mon, 20 Jan 2020 11:11:16 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/2] selinux-testsuite: Add fs*(2) API filesystem tests
Date:   Mon, 20 Jan 2020 11:11:11 +0000
Message-Id: <20200120111113.23349-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches update the current tests/filesystem (see [1] if not already
installed) to share code (patch 1) with the fs*(2) API filesystem
tests (patch 2).

A test kernel with [2] installed tested selinux_move_mount(), see test
script for comments.

To test fanotify fs watch perm on 5.5+ read [1] first to install CIL module.

Not tested on travis.

[1] https://lore.kernel.org/selinux/20200119111740.61358-1-richard_c_haines@btinternet.com
[2] https://lore.kernel.org/selinux/20200117202407.12344-1-sds@tycho.nsa.gov

Richard Haines (2):
  selinux-testsuite: Prepare for adding fs*(2) API tests
  selinux-testsuite: Add fs*(2) API filesystem tests

 policy/test_filesystem.te        |  18 +-
 tests/Makefile                   |   6 +
 tests/filesystem/Filesystem.pm   | 166 ++++++
 tests/filesystem/test            | 219 ++------
 tests/fs_filesystem/.gitignore   |   3 +
 tests/fs_filesystem/Makefile     |  16 +
 tests/fs_filesystem/fs_common.c  | 110 ++++
 tests/fs_filesystem/fs_common.h  |  30 ++
 tests/fs_filesystem/fsmount.c    |  89 ++++
 tests/fs_filesystem/fspick.c     |  68 +++
 tests/fs_filesystem/move_mount.c |  76 +++
 tests/fs_filesystem/test         | 833 +++++++++++++++++++++++++++++++
 tools/check-syntax               |   2 +-
 13 files changed, 1453 insertions(+), 183 deletions(-)
 create mode 100644 tests/filesystem/Filesystem.pm
 create mode 100644 tests/fs_filesystem/.gitignore
 create mode 100644 tests/fs_filesystem/Makefile
 create mode 100644 tests/fs_filesystem/fs_common.c
 create mode 100644 tests/fs_filesystem/fs_common.h
 create mode 100644 tests/fs_filesystem/fsmount.c
 create mode 100644 tests/fs_filesystem/fspick.c
 create mode 100644 tests/fs_filesystem/move_mount.c
 create mode 100755 tests/fs_filesystem/test

-- 
2.24.1

