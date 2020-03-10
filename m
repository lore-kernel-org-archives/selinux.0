Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7DAC10F27
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08B720848
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 16:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="gRY4utHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCJQZJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:25:09 -0400
Received: from mailomta26-sa.btinternet.com ([213.120.69.32]:56591 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbgCJQZJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 12:25:09 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200310162505.CTVF23502.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 10 Mar 2020 16:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583857505; 
        bh=VaBlWbR+NGDS5H4DDCFQ35CpQxmQbPRV2Nsp2ir8I7k=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=gRY4utHCY3pSILRYs8GmnrCyUPRnYndZKIUKHOA16tfdsnr5M12ttdmEH9E17cGm7l5CDlPyxl0JGeYH6Xjs4UDNITiz5lCIYfz3EM1/xYXL0lMq9Z5r8f88d8WGE5GJriQsJCzZWW6YR1Q4Ahl7LrM5NAyECNavPwko0Fd8LAiZtcgwpfCIkwm05dZZJlly7T0lHSq93FmeQiGbq1RH4xtpsPUQEFwo2AMpYCRI1+mN9lxtL1H1WOlKOTMdXnUxqvOZIiKmocF2JJHM8pE54E0DnhCBQpmp5qHzRS3+YHUPlo97iIdJnXarm7Z9qqyAuArY3Ac0PqSGrPkHAdcqcQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.57.243]
X-OWM-Source-IP: 31.49.57.243 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrgeelrdehjedrvdegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheejrddvgeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.57.243) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A2411054C6F59; Tue, 10 Mar 2020 16:25:05 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     smayhew@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for tests
Date:   Tue, 10 Mar 2020 16:24:54 +0000
Message-Id: <20200310162456.32240-1-richard_c_haines@btinternet.com>
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

Not tested on travis.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
[2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/

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

 README.md                            |   10 +-
 defconfig                            |    6 +
 policy/test_filesystem.te            |   93 +-
 policy/test_filesystem_name_trans.te |    6 +
 policy/test_filesystem_notify.te     |   41 +-
 tests/filesystem/.gitignore          |    1 +
 tests/filesystem/Filesystem.pm       |  114 ++-
 tests/filesystem/Makefile            |    3 +-
 tests/filesystem/test                | 1205 +++++++++++++++---------
 tests/filesystem/xfs_quotas_test.c   |   96 ++
 tests/fs_filesystem/fsmount.c        |    5 +-
 tests/fs_filesystem/test             | 1306 ++++++++++++++++----------
 tests/nfs_filesystem/test            |  359 +++++++
 tests/nfsruntests.pl                 |    5 +
 tools/nfs.sh                         |  123 ++-
 15 files changed, 2374 insertions(+), 999 deletions(-)
 create mode 100644 tests/filesystem/xfs_quotas_test.c
 create mode 100755 tests/nfs_filesystem/test
 create mode 100755 tests/nfsruntests.pl

-- 
2.24.1

