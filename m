Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80740C33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB8320663
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 18:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="eqnu7xVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437076AbgAPSve (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:51:34 -0500
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:22898 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389885AbgAPSvd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 13:51:33 -0500
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200116185130.WSFY5239.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Thu, 16 Jan 2020 18:51:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1579200690; 
        bh=tChxw+h6AbJXe13kYl78AzgmM4C87fY/QN+6fa8sAVM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=eqnu7xVua+ZqJ6B9u4WlYm0C3IQDCRFu7OjXRP3eAIrjqfP8IGTDPrKF13xCAcViHYvCEP0iVdG53kjZa4C2EHGpDe6P+VwcVUqwnjrOHC7MDk46VSEA8Syp6azdqwJxEcHMBdaC9e0QHEHBghjqs8l7vf1uCw7h4FERCInnGipNPf3KCWs8zOFQbKl5l/X5Hz6PjghBqghE9x8IzJHGAFe679C47elclrNUJ91XvlDE8vBuqwjN6rylyaN3835zUFNENgnRLBC+2MVdEC8OIfZbHWS3QOB51Noo7GV4x2zlOdNTgUMfeLwltqGu257+jk948mj3VukzWipKzLFhmg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.91]
X-OWM-Source-IP: 86.134.6.91 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrtdehgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedriedrledunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirdeluddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.91) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E1A2CBA00E248D2; Thu, 16 Jan 2020 18:51:30 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V6 0/1] selinux-testsuite: Add filesystem tests
Date:   Thu, 16 Jan 2020 18:51:26 +0000
Message-Id: <20200116185127.169628-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
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
V6 Changes:
1) The name-based rules only apply to 'MOD_POL_VERS=>11 and POL_VERS=>25'
   This requires testing on RHEL-6
2) Tidy up the test script and policy regarding contexts. Should now be
   easier to distinguish where denials were generated in hooks.c.

V5 Change:
1) Correct name-based type transition rules.

V4 Changes:
1) Test non-name based type transition rule.
2) Test two different name-based type transition rules that only differ 
   in name.
3) Creating ext4 filesystems with inodes > 128 bytes using -I 256.
4) Use kernel_setsched() macro.

V3 Changes:
1) Lots of minor updates.
2) Add 'udevadm settle' as suggested by Ondrej to resolve udisks(8) issue.
3) Add stopping udisks(8) daemon as a '-d' option.
4) Add file quotaon test.
5) Add test for name type_transition rule.
6) Fix setfscreatecon(3) test to create a directory and check context.
7) Use kernel_dontaudit_setsched() as explained in [1].

[1] https://lore.kernel.org/selinux/f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com/

V2 Changes:
1) If udisks(8) daemon is running, stop then restart after tests. The tests
   run faster and stops the annoying habit of adding mounts to the 'files'
   app on the desktop. Supports /usr/bin/systemctl or /usr/sbin/service
   More importantly it stops interferance with the '*context=' tests as it
   can cause intermittent failures. Tested by running 'test' in a continuous
   loop with udisks enabled, and then again disabled.
   Loop 200 times, with udisks failed between 1 to 70 iterations, without
   udisks, no failures.
2) Add "#define QFMT_VFS_V0 2" to quotas_test.c to fix a RHEL/CentOS 7 and
   below build issue.
3) Build new file context based on the original in
   create_file_change_context.c
4) Use "runcon `id -Z` quotacheck ..." to resolve RHEL-6 test run issue.
5) Fix free() contexts in create_file_change_context.c and
   check_mount_context.c

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

Richard Haines (1):
  selinux-testsuite: Add filesystem tests

 defconfig                                     |   6 +
 policy/Makefile                               |   7 +
 policy/test_filesystem.te                     | 373 +++++++
 policy/test_filesystem_name_trans.te          |  20 +
 tests/Makefile                                |   7 +
 tests/filesystem/.gitignore                   |  11 +
 tests/filesystem/Makefile                     |  16 +
 tests/filesystem/check_file_context.c         |  75 ++
 tests/filesystem/check_mount_context.c        | 127 +++
 tests/filesystem/create_file.c                | 117 +++
 tests/filesystem/create_file_change_context.c | 146 +++
 tests/filesystem/fanotify_fs.c                |  79 ++
 tests/filesystem/fs_relabel.c                 | 138 +++
 tests/filesystem/grim_reaper.c                |  89 ++
 tests/filesystem/mount.c                      | 130 +++
 tests/filesystem/quotas_test.c                | 143 +++
 tests/filesystem/statfs_test.c                |  65 ++
 tests/filesystem/test                         | 966 ++++++++++++++++++
 tests/filesystem/umount.c                     |  84 ++
 19 files changed, 2599 insertions(+)
 create mode 100644 policy/test_filesystem.te
 create mode 100644 policy/test_filesystem_name_trans.te
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
2.24.1

