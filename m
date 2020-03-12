Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51EEC10DCE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 11:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A46C20716
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 11:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="eCmxfj7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCLLgm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:36:42 -0400
Received: from mailomta28-re.btinternet.com ([213.120.69.121]:49170 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLLgm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 07:36:42 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200312113640.NWVE26380.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 12 Mar 2020 11:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1584013000; 
        bh=L4TXZd+BURbvuChOGKEwCwOId+0ENzKWA0U5zd9Pfww=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=eCmxfj7Kaz9zVx2YvLWDffd7t+vJbXtfZKhF/tFBIB0blChh+qVHeuA0JXNHxnI+3TbDx79242CJlhhrdLtDsTrUYv1DbYlgtX2fAEyG60PiJnb3uW8KCkRiIMZRSqdACwY4QT2BAiFMs1CzCWa729fu0FTFsJYNrFWUIIJjXNtYaiQQvQRv/pOzZXOwe0rELcOdNRt7ZJHXdXWLJGZauqnLO5/I47O4z3TFSArNKAqxze1wRFcZz1SiWy5ablsWKams+d+bWJT82edLk9SzjzFEgvikFic1RoGpD9kP5f+vQ6ByGx93IP2pUkH5snjuTHK3qxp62M01J/fgUIHLeQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.5.4]
X-OWM-Source-IP: 86.134.5.4 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrhedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdehrdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.5.4) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A147D0586A0D9; Thu, 12 Mar 2020 11:36:40 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     smayhew@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/2] selinux-testsuite: Use native filesystem for tests
Date:   Thu, 12 Mar 2020 11:36:35 +0000
Message-Id: <20200312113637.20355-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If you test on the selinux-next kernel (that has the XFS patch [1]) with
the "NFS: Ensure security label is set for root inode" patch [2], then all
tests should pass. Anything else will give varying amounts of fails.

The filesystem types tested are: ext4, xfs, vfat and nfs4.

I've revamped the nfs.sh to handle tests that require specific mount
options, these plus many more are now in tests/nfs_filesystem. This only
gets run by nfs.sh.

There are two minor workarounds involving multiple mounts returning EBUSY.
These are either bugs or features.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
[2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/

Changes from RFC V3:
1) Fixed question mark (?) as the total/planned number of tests (Fix: do not
   have print statements in BEGIN { }, or any subroutines that are called
   inside this).
2) nfs.sh now gives line number on all test fails.
3) Policy changes for NFS mnt_t and mounton
4) Added xfslibs-dev and uuid-dev for travis

To test fanotify fs watch perms on 5.4+ (will also include tests/notify):
1) Extract the base module (base.cil):
      semodule -c -E base

2) Backup, the edit the following definitions in base.cil to add watch
   permissions:

   (common file (ioctl read write ....))
Add:
   watch watch_mount watch_sb watch_with_perm watch_reads

   (class filesystem (mount remount ....))
Add:
   watch

3) Insert modified base module (inserts with default priority 400):
       semodule -i base.cil

4) Backup, then edit the following definitions in:
       /usr/share/selinux/devel/include/support/all_perms.spt

   define(`all_file_perms',`{ ioctl read write ....
Add:
   watch watch_mount watch_sb watch_with_perm watch_reads

   define(`all_dir_perms',`{ ioctl read write ....
Add:
   watch watch_mount watch_sb watch_with_perm watch_reads

   define(`all_filesystem_perms',`{ mount remount ....
Add:
   watch

5) 'make test' can now be run.

NOTE: Do NOT leave the new base.cil active after tests, as the system may
not reboot if in enforcing mode, as various watch permissions will be denied.
Revert to the original (priority 100) as follows:

semodule -r base
make clean
make -C policy unload

Finally restore the original:
/usr/share/selinux/devel/include/support/all_perms.spt

Richard Haines (2):
  selinux-testsuite: Use native filesystem for tests - Part 1
  selinux-testsuite: Use native filesystem for tests - Part 2

 .travis.yml                          |    2 +
 README.md                            |   15 +-
 defconfig                            |    6 +
 policy/test_filesystem.te            |   89 +-
 policy/test_filesystem_name_trans.te |    6 +
 policy/test_filesystem_notify.te     |   41 +-
 tests/filesystem/.gitignore          |    1 +
 tests/filesystem/Filesystem.pm       |  111 ++-
 tests/filesystem/Makefile            |    3 +-
 tests/filesystem/test                | 1199 +++++++++++++++---------
 tests/filesystem/xfs_quotas_test.c   |   96 ++
 tests/fs_filesystem/Makefile         |    3 -
 tests/fs_filesystem/fsmount.c        |    5 +-
 tests/fs_filesystem/test             | 1300 ++++++++++++++++----------
 tests/nfs_filesystem/test            |  358 +++++++
 tests/nfsruntests.pl                 |    5 +
 tools/nfs.sh                         |  125 ++-
 17 files changed, 2362 insertions(+), 1003 deletions(-)
 create mode 100644 tests/filesystem/xfs_quotas_test.c
 create mode 100755 tests/nfs_filesystem/test
 create mode 100755 tests/nfsruntests.pl

-- 
2.24.1

