Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A52C11D34
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3FF2072D
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 14:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="qR+9JlNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgBXOPb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:15:31 -0500
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:11672 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727489AbgBXOPb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 09:15:31 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200224141527.CBHF29268.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Mon, 24 Feb 2020 14:15:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582553727; 
        bh=NJrs46LqXfvmhlf+y4Ds/5rFHP/aWhOho6jSn93UZ9M=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=qR+9JlNNyoYq5IakYhPUphQ5ZOhZED7f01SzCqHaQsYMyc5NStty8ayBqBlW95hD01dCqQBJ3LF+vxlYvOYiQy543rqPJ9Vr0H4ngOzGa6xjI0uo5CDMG95Padpz6/7IfSl6fISkRHNgDojx1SzxeK8R+iPnSyiPv6ScJ4RXs+Rwn/LvNkoUbKXdLn6dm2PkKaX3IMQCKNnhqR1vinZ1mKqfqUzS5YnydnfOmq0hfcvFr1+H+mAI1qhkGyUD9QNN6S/HnNoyaxU47emZFFl1t9qqc8vmzGOY+9MVA5vgrBBdsqHJrQ2kMdPbn2LfmfgyMoDQ2Tn/UViEOGfaTR8SGQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.59.100]
X-OWM-Source-IP: 31.49.59.100 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrledtgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepfedurdegledrheelrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehledruddttddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.59.100) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A290C0309E315; Mon, 24 Feb 2020 14:15:27 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V2 PATCH 0/2] selinux-testsuite: Use native filesystem for tests
Date:   Mon, 24 Feb 2020 14:15:22 +0000
Message-Id: <20200224141524.407114-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I've split the patch as it never made it past vger last time.

This supports NFS when using the tools/nfs.sh script. NFS will support options
with rootcontext and fscontext, however due to the fsconfig(2) bug they will
not pass with these.

The filesystem types tested are: ext4, xfs, vfat and nfs4.

No support for btrfs or reiserfs as they require much larger filesystem size
and additional policy rules.

I've added tests for xfs quotas, however it does need a patch [1] for testing
filesystem quotaget/quotamod permissions. Also xfs does not call
security_quota_on(), therefore the 'file quotaon' permission is not
tested (see notes in test scripts).

Not tested on travis (xfs_quotas_test.c added that may cause issues)

How the system is configured will depend on how many tests are run (for
example 'watch/fanotify' adds 11 tests). Also there are a number of
bugs/features that will cause various errors. They include:
1) There is a kernel bug using fsconfig(2) with nfs if any *context=
   option is given.
2) There is an nfs kernel bug where the top-level mounted directory shows
   up with unlabeled_t initially, then later gets refreshed to a
   valid context. policy/test_filesystem.te contains allow rules to
   bypass this as the bug is marked as closed - not fixed.
3) Some XFS quotas will fail as described above.
4) udisks(8) is now disabled by default. This is because when running xfs,
   random failures occur as udisks(8) tries to be 'helpful'. It can be
   enabled locally with the -e flag.

RFC V2 Changes:
Probably all those in [2]

[1] https://lore.kernel.org/selinux/20200220153234.152426-1-richard_c_haines@btinternet.com/
[2] https://lore.kernel.org/selinux/186a0ca5-802d-44d8-7fbf-1fd918591fff@tycho.nsa.gov/

Richard Haines (2):
  selinux-testsuite: Use native filesystem for tests - Part 1
  selinux-testsuite: Use native filesystem for tests - Part 2

 README.md                          |   10 +-
 defconfig                          |    6 +
 policy/test_filesystem.te          |   78 +-
 policy/test_filesystem_notify.te   |   56 +-
 tests/filesystem/.gitignore        |    1 +
 tests/filesystem/Filesystem.pm     |  127 ++-
 tests/filesystem/Makefile          |    3 +-
 tests/filesystem/test              | 1184 ++++++++++++++++----------
 tests/filesystem/xfs_quotas_test.c |   96 +++
 tests/fs_filesystem/fsmount.c      |    5 +-
 tests/fs_filesystem/test           | 1275 ++++++++++++++++++----------
 tools/nfs.sh                       |   39 +-
 12 files changed, 1939 insertions(+), 941 deletions(-)
 create mode 100644 tests/filesystem/xfs_quotas_test.c

-- 
2.24.1

