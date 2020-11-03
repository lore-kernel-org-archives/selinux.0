Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A98C2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083992071E
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 11:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="oqxjjNBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgKCLBx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:01:53 -0500
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:64342 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727068AbgKCLBw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 06:01:52 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20201103110145.ETVZ30806.re-prd-fep-045.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 3 Nov 2020 11:01:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604401305; 
        bh=KwN9BB2P5GAsvhns1wp6UQgZ3tGaRZNZ3pdHAH30DJo=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=oqxjjNBrBBwY4Eetjr27RIPOf/v8QhO2Sp07nGaTrIcBsu6lHkbZ+8+NrvwrADdB8ey2PUE4WpHpC7kOtd6sLd2A/cJYo39phBQGARuXckMhLEo41UKLmZ41FE9nnWY0R5hxLgdDMUgkIqe7dHgV9t4hMN6WIlYXoxDjm3aEnXJwGxwRB0b26KeKpL26npiWXGqCe5gH4xS6mgJ8GNHji1yLTRNaZjjRydJaBHIbGyMSZSh/yF80zDCjHIKKNqCVZOM5GjBHl7VWnhAo4CMrFbaADFHz7tNNm/gTAMKQRI3z5S8cfWCS7fo9EzCp4KtorxXQq0wA22vRg3elqBrehg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C5061891693E
X-Originating-IP: [86.148.106.153]
X-OWM-Source-IP: 86.148.106.153 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtfedgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeufeefudfffeetjeevheetvdekueeuvefftdfgkefgtefgkeegieehveeuhedvffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudegkedruddtiedrudehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeekrddutdeirdduheefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.148.106.153) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C5061891693E; Tue, 3 Nov 2020 11:01:45 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 0/1] selinux-testsuite: Add btrfs support for filesystem tests
Date:   Tue,  3 Nov 2020 11:01:20 +0000
Message-Id: <20201103110121.53919-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch allows BTRFS filesystems to be tested.

The tests/filesystem all pass using './test -f btrfs' on Fedora 33.
The tests/fs_filesystem fail 42 of 57 using './test -f btrfs' on Fedora 33.

These fs_filesystem failures are caused by a bug when using the fsmount(2)
type calls that was reported in [1].

Note btrfs requires a much larger image size (min 115 MiB), and therefore
takes more than 2x longer to run tests than ext4.

[1] https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/

V2 changes:
1) Add btrfs-progs entries for README and travis.
2) Add CONFIG_BTRFS_FS=y to defconfig.
3) Support testing all valid filesystems.

Richard Haines (1):
  selinux-testsuite: Add btrfs support for filesystem tests

 README.md                      |  3 +++
 defconfig                      |  4 ++++
 tests/Makefile                 |  2 +-
 tests/filesystem/Filesystem.pm | 10 +++++++++-
 tests/filesystem/btrfs         |  1 +
 tests/filesystem/test          |  6 ++++++
 tests/fs_filesystem/btrfs      |  1 +
 tests/fs_filesystem/test       |  6 ++++++
 travis-ci/run-testsuite.sh     |  1 +
 9 files changed, 32 insertions(+), 2 deletions(-)
 create mode 120000 tests/filesystem/btrfs
 create mode 120000 tests/fs_filesystem/btrfs

-- 
2.28.0

