Return-Path: <SRS0=pblC=5K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830E8C43331
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 13:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE1A20772
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 13:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="smDemHdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCYNJI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:09:08 -0400
Received: from mailomta17-re.btinternet.com ([213.120.69.110]:24869 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727129AbgCYNJI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Mar 2020 09:09:08 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200325130905.VYFG26380.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 25 Mar 2020 13:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1585141745; 
        bh=UPjs4paBJ9cY6S7ZA1jOFexS8diJMA8xM0nXeD89Aw4=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=smDemHdPWFnVBKdVa701s9V638F/72us8UzR8j46CkA+vA94c+hSt9DzyFJ3jmiYSTa1MaGbvvChsRZfQoKepMIiNEE/+0Q13Bpih0Xc6efjwP9tkCzf+0TyAy+tJEcuLNOv7+XjAm0yAgqmoiH3PefIwWcIzW/ethFiX2LTzpQGlUt8rwDJy1g26yVMFwIXbimt2UEmwJE3HbK52NjEgPc95IGsJvLZDOYOGEsiNThxXqf0d4PmVBpCjidALFuubLVkKp2ObQOApk5scKkH/z47v1dexXgU30q1OtK1Tl5LWxexVJYf5b5SEESqdocSWGkqU1ZFhrmwwTVxx5CGwA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [213.122.112.51]
X-OWM-Source-IP: 213.122.112.51 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrdduvddvrdduuddvrdehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepvddufedruddvvddrudduvddrhedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (213.122.112.51) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A15B60796A1EB; Wed, 25 Mar 2020 13:09:05 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     smayhew@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 0/2] selinux-testsuite: Use native filesystem for tests
Date:   Wed, 25 Mar 2020 13:08:58 +0000
Message-Id: <20200325130900.15047-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If tested on the selinux-next kernel (that has the XFS patch [1]) with
the "NFS: Ensure security label is set for root inode" patch [2], then all
tests should pass. Anything else will give varying amounts of fails.

The filesystem types tested are: ext4, xfs, vfat and nfs4.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
[2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/

V2 Changes:
1) Add userdom_search_user_home_content(filesystemdomain) to policy
2) Add Makefile in nfs_filesystem for consistency.
3) Update nfs_filesystem/test text for kernel commit info.
4) Turn off -e flag once in 'function err_exit()' so each cmd completes.
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

2) Edit the following definitions in base.cil to add watch
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
 policy/test_filesystem.te            |   90 +-
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
 tests/nfs_filesystem/Makefile        |    2 +
 tests/nfs_filesystem/test            |  362 +++++++
 tests/nfsruntests.pl                 |    5 +
 tools/nfs.sh                         |  127 ++-
 18 files changed, 2371 insertions(+), 1003 deletions(-)
 create mode 100644 tests/filesystem/xfs_quotas_test.c
 create mode 100644 tests/nfs_filesystem/Makefile
 create mode 100755 tests/nfs_filesystem/test
 create mode 100755 tests/nfsruntests.pl

-- 
2.24.1

