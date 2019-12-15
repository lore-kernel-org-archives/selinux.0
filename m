Return-Path: <SRS0=eXnu=2F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF99C2D0CB
	for <selinux@archiver.kernel.org>; Sun, 15 Dec 2019 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9522253D
	for <selinux@archiver.kernel.org>; Sun, 15 Dec 2019 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="SlLMwHFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfLORG2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:06:28 -0500
Received: from mailomta21-re.btinternet.com ([213.120.69.114]:17825 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726292AbfLORG2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Dec 2019 12:06:28 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20191215170626.LCLO9262.re-prd-fep-045.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sun, 15 Dec 2019 17:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1576429586; 
        bh=w4V8ZK61UfZYaZZg+/+76ylTqxrj+/h+RnFzELokPeM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=SlLMwHFhON1IvD5+byyv2GWQN7hHVcUaZu/icwiWwtccT5ckSNvCUbqL0GStZHTtLKEaiPPF0bRDigcfdehSPQi3+m+RQox0cRPxIJFtqP+OHgwYFDn7NTrCVcSOACQlrk12xiv9ZDBarPV5omqYW3+aDqt5pINqCDC5cyu1WgXtkvg9gKapenK+W4whW/AB6qnirWYxmOjep79mAZzLXZW9scvhVbQ1XTuqumKktLpnU+kly8/uFxy36RLqlk2/BnV97/7H8RzEroTkznPQac5nwQzWZQqwgh5NrIrJ1V9OrSKGD09J9RLIO9rvm+IApRQaq4YobN29zaRVpVTY8w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.254]
X-OWM-Source-IP: 86.134.6.254 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvddtfedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrvdehgeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrvdehgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.254) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE4E82010BB08A; Sun, 15 Dec 2019 17:06:26 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Add filesystem tests
Date:   Sun, 15 Dec 2019 17:06:19 +0000
Message-Id: <20191215170620.73506-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These tests should cover all the areas in selinux/hooks.c that touch
the 'filesystem' class. I've listed each hooks.c function in the 'test'
script as there are some permissions that are checked in multiple places.

I've tested on Fedora 31 and Rawhide (for the new watch perm).

To test on kernels 5.5 and above install the watch.cil file in the
tests/mount directory as follows: semodule -i watch.cil. Then run the tests.

I'm not sure I've covered all possible scenarios, also the policy needs a
review.

While umount(2) unmounted the fs, some were moved to a resting place so
implemented the grim_reaper to clear them up.

Richard Haines (1):
  selinux-testsuite: Add filesystem tests

 defconfig                     |   6 +
 policy/Makefile               |   4 +
 policy/test_mount.te          | 235 ++++++++++++++
 tests/Makefile                |   4 +
 tests/mount/.gitignore        |   7 +
 tests/mount/Makefile          |   7 +
 tests/mount/fanotify_test.c   |  77 +++++
 tests/mount/grim_reaper.c     |  63 ++++
 tests/mount/may_create_test.c | 121 +++++++
 tests/mount/mount.c           | 130 ++++++++
 tests/mount/quotas_test.c     | 134 ++++++++
 tests/mount/statfs_test.c     |  65 ++++
 tests/mount/test              | 579 ++++++++++++++++++++++++++++++++++
 tests/mount/umount.c          |  85 +++++
 tests/mount/watch.cil         |   7 +
 15 files changed, 1524 insertions(+)
 create mode 100644 policy/test_mount.te
 create mode 100644 tests/mount/.gitignore
 create mode 100644 tests/mount/Makefile
 create mode 100644 tests/mount/fanotify_test.c
 create mode 100644 tests/mount/grim_reaper.c
 create mode 100644 tests/mount/may_create_test.c
 create mode 100644 tests/mount/mount.c
 create mode 100644 tests/mount/quotas_test.c
 create mode 100644 tests/mount/statfs_test.c
 create mode 100755 tests/mount/test
 create mode 100644 tests/mount/umount.c
 create mode 100644 tests/mount/watch.cil

-- 
2.23.0

