Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8863C2D0C0
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 10:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CF42467F
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 10:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="i+q3njnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTKLP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:11:15 -0500
Received: from mailomta21-sa.btinternet.com ([213.120.69.27]:18353 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727129AbfLTKLP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 05:11:15 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20191220101112.FMSY8432.sa-prd-fep-044.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 20 Dec 2019 10:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1576836672; 
        bh=BDonbzH9kX1fASusF8laYuT+VhGUXO7YxEAsKxEd46Y=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=i+q3njnUPuduazJ67DRXwOZcNrZVqcBXPmHxyXAyZj9MqPtyFL0AqCEu7U2v6Btp2PGiy7cMc/7ZhovBjdue3PkgzQN4PR5YMUydpKamoLTZz7WWguhlg89jXe9/6fDCWvYBWfcFhoaYyCjun1bL9kUCBFWUUqzh3SCR/roUwrXBe1usXFPg37dvZfUBCojIboBS9pfmrjz7WB1aVSt2efwP6BmEK212lNZK7AKwfyw1ceYSpZ0gYGzSWdr1W2O1B+lhCod9Q2vhG3H1F/t/vvikriGJMIqknWr4DWgB87q32AP4vAFbSlthMWaI/VQAtFstlArA4AFN0SkULJidjQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.246]
X-OWM-Source-IP: 86.134.6.246 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvddufedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirddvgeeinecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirddvgeeipdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.246) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DF93CE10066F3AD; Fri, 20 Dec 2019 10:11:12 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/1] selinux-testsuite: Add filesystem tests
Date:   Fri, 20 Dec 2019 10:11:03 +0000
Message-Id: <20191220101104.40865-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These tests should cover all the areas in selinux/hooks.c that touch
the 'filesystem' class. Each hooks.c function is listed in the 'test'
script as there are some permissions that are checked in multiple places.

Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).

To test fanotify fs watch perm on 5.5+:
1) Build the testsuite policy first:
make -C policy load

2) Add the following CIL statements to watch.cil and install:
semodule -i watch.cil

(common filesystem (watch))
(classcommon filesystem filesystem)
(allow test_filesystem_t self(filesystem (watch)))
; Until 'fs_watch_all_fs(test_filesystem_t)' in Policy use:
(allow test_filesystem_t fs_t (filesystem (watch)))
; Required if notify policy enabled
;(allow test_filesystem_t self (dir (watch_sb)))

3) Edit /usr/share/selinux/devel/include/support/all_perms.spt
   and insert the 'watch' permission at:

define(`all_filesystem_perms',`{ mount remount ..... watch }')

Changes from RFC Patch:
1) Rename mount to filesystem as it is testing the fs permissions
2) Add tests for context=, rootcontext=, fscontext= and defcontext=
3) Add setfscreatecon(3) tests
4) Add tests to build fanotify on 5.5 and travis (not tested)

Richard Haines (1):
  selinux-testsuite: Add filesystem tests

 defconfig                                     |   6 +
 policy/Makefile                               |   4 +
 policy/test_filesystem.te                     | 324 +++++++
 tests/Makefile                                |   7 +
 tests/filesystem/.gitignore                   |  11 +
 tests/filesystem/Makefile                     |  16 +
 tests/filesystem/check_file_context.c         |  75 ++
 tests/filesystem/check_mount_context.c        | 109 +++
 tests/filesystem/create_file.c                |  79 ++
 tests/filesystem/create_file_change_context.c | 143 +++
 tests/filesystem/fanotify_fs.c                |  79 ++
 tests/filesystem/fs_relabel.c                 |  72 ++
 tests/filesystem/grim_reaper.c                |  63 ++
 tests/filesystem/mount.c                      | 130 +++
 tests/filesystem/quotas_test.c                | 134 +++
 tests/filesystem/statfs_test.c                |  65 ++
 tests/filesystem/test                         | 830 ++++++++++++++++++
 tests/filesystem/umount.c                     |  84 ++
 18 files changed, 2231 insertions(+)
 create mode 100644 policy/test_filesystem.te
 create mode 100644 tests/filesystem/.gitignore
 create mode 100644 tests/filesystem/Makefile
 create mode 100644 tests/filesystem/check_file_context.c
 create mode 100644 tests/filesystem/check_mount_context.c
 create mode 100644 tests/filesystem/create_file.c
 create mode 100644 tests/filesystem/create_file_change_context.c
 create mode 100644 tests/filesystem/fanotify_fs.c
 create mode 100644 tests/filesystem/fs_relabel.c
 create mode 100644 tests/filesystem/grim_reaper.c
 create mode 100644 tests/filesystem/mount.c
 create mode 100644 tests/filesystem/quotas_test.c
 create mode 100644 tests/filesystem/statfs_test.c
 create mode 100755 tests/filesystem/test
 create mode 100644 tests/filesystem/umount.c

-- 
2.23.0

