Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7092C2D0B1
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C032082E
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 14:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Gs0LIxj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBDOhM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:37:12 -0500
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:47237 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727250AbgBDOhM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 09:37:12 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200204143710.WTZG20346.re-prd-fep-045.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 4 Feb 2020 14:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580827030; 
        bh=YkXpsWpVm+9BTbJK+zn2Sx7aRb7vxIUHRvW1WrxboeU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Gs0LIxj+r+vpe1ceyjOepdbZMShqU9o1nPI/u4rlVWD3/izsGylVwo+KHwXiOWdIJV78oBAW9pxbMEXTtI189nxeC91th6468bx0Yp5Bq8ZwJNjBUGM2G1+cMVoGxCGoY1a0U2fM48Mkd7MZHFR7EkifXuEp3bTO72Hsdb0kgrjpqBVMf8B+bYawi97b9pMRZgxom3MJgdQlnWz1ZigqSJj3777nrrQ1DHAiSslASktVBz9EcWkD8Dyg7aQiCt38CWq+9aQ4rr/qehEnd0sNSLk78E6hibJbURRmWrMauz3ksJObmuavnbApqFtOZCPOp32EIgjYZzb5ge94aiLBjw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.56.10]
X-OWM-Source-IP: 31.49.56.10 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeelgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdehiedruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedruddtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.10) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E207A3302CE3040; Tue, 4 Feb 2020 14:37:10 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Test all mount option context types
Date:   Tue,  4 Feb 2020 14:37:06 +0000
Message-Id: <20200204143707.318337-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Not sure how useful these tests are but using them as a starter for running
tests on all supported filesystems (that I could find).

These test all the *context= mount options by reading /sbin/mkfs.* entries.
I've failed/passed tests based on what I have seen, however some could be
wrong.

Notes:
1) As I use fsconfig(2), the btrfs tests will always fail as there is a
   bug somewhere in the kernel (being investigated).
2) I have had to disable udisks as that interferes with the tests. You can
   keep it enabled by ./test -e.
   I think there is really a problem with udisks getting in the way as I
   rapidly fsopen(fd), fsconfig(2) close(fd) for each test (on my system
   this equals 48 times).

Richard Haines (1):
  selinux-testsuite: Test all mount option context types

 policy/test_filesystem.te      |  12 +++
 tests/Makefile                 |   2 +-
 tests/filesystem/Filesystem.pm |  19 +++-
 tests/fs_contexts/.gitignore   |   1 +
 tests/fs_contexts/Makefile     |  13 +++
 tests/fs_contexts/fsconfig.c   |  72 ++++++++++++++++
 tests/fs_contexts/test         | 153 +++++++++++++++++++++++++++++++++
 7 files changed, 268 insertions(+), 4 deletions(-)
 create mode 100644 tests/fs_contexts/.gitignore
 create mode 100644 tests/fs_contexts/Makefile
 create mode 100644 tests/fs_contexts/fsconfig.c
 create mode 100755 tests/fs_contexts/test

-- 
2.24.1

