Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18632C32771
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8C42071E
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 09:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="mD41DFwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgA0Jc6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:32:58 -0500
Received: from mailomta18-sa.btinternet.com ([213.120.69.24]:23003 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729506AbgA0Jc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 04:32:58 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200127093255.BXCS5239.sa-prd-fep-045.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 27 Jan 2020 09:32:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580117575; 
        bh=WcQ10koWjKZrNNOScxZdIo512lCgeMTiZTuNIAMY3Fo=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=mD41DFwH3YvKrE90DW//EyR0UgVqjwbDvAWFYKjTWsnVXTxE7P5yurprCq6eYFoFtULATrrtwoYkGgEYOIJAJ+3VemWI6mvyJMFyoQ9CBNvliqo3aUtvGFW1I98JtPE7ZDJCpj5i3XUP61C+imWTliSH9N1/pSO9a5posuIVZieFZUQn1HKKW2cbVe8Hj9R5X4G35pzWXuOKToEWV9S3Gfw8SF9vE0PmbcfUkNLgvCtpz08igG3LVqPAj2Z4l4K77evwhOXrHJqs6kl7Sv6r7DC5yaFP58oOzp0qbdekpJv1QIA9zfCUDW1kVzmtX+eYHAw5utp8fE8E20+LCzj9oA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.76]
X-OWM-Source-IP: 86.134.6.76 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddufeegrdeirdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirdejiedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.76) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E2B15E000673361; Mon, 27 Jan 2020 09:32:55 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 0/2] selinux-testsuite: Add fs*(2) API filesystem tests
Date:   Mon, 27 Jan 2020 09:32:47 +0000
Message-Id: <20200127093249.3143-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches update the current tests/filesystem to share code (patch 1)
with the fs*(2) API filesystem tests (patch 2).

V2 Changes:
1) If kernel patch [1] installed move_mount test for denying FILE__MOUNTON
   should pass. If not installed, display 'Failed as kernel 5.x without
   "selinux: fix regression introduced by move_mount(2) syscall" patch'
   (as there is a regression that should be fixed).
   Note: Kernels 5.2 - 5.5 will fail unless [1] backported. 5.6 is expected
   to have [1].
2) Move policy changes to patch 2.

[1] https://lore.kernel.org/selinux/20200117202407.12344-1-sds@tycho.nsa.gov

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
 tests/fs_filesystem/test         | 835 +++++++++++++++++++++++++++++++
 tools/check-syntax               |   2 +-
 13 files changed, 1455 insertions(+), 183 deletions(-)
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

