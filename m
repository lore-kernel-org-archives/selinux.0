Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F76EC2BA83
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C61222C2
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 16:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="IMrSnBx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBMQan (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:30:43 -0500
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:57223 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727788AbgBMQan (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 11:30:43 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20200213163040.VCRK16580.re-prd-fep-047.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 13 Feb 2020 16:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1581611440; 
        bh=snJYtufHwCei45lssCIMOG1tOFBFxjQMGD6cMnB54ig=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=IMrSnBx5PrvCvz6+8+US3zDeAd896reygVkfaSTF/H+kPffKl4BzwWNueJAaib51mxdjqYKQVisHlooKD2tD28980I3ayRKLpmz68uC7W+phKoEob4LdtVP1cwKXrdUw0DbBsi+A0JOy0U6u11UpjCW6euRI//LHfEhtLJQcDrbKMfcMASfYrzlLBWq5Ace7tQ2lNO4UBgaN9fA0kf6lQ37h89O0Do5Ld6/DTELO1r2Dwk3JrPOpo3upBFfZqP2L+RzISeCokxRl5Haio5yVcRDaSGMRDWjoYPFhk7O9LOPHkY2CGo/MzA/l/pUOFjMxT/KASYz++kjHaeIJY5s3tQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.61.33]
X-OWM-Source-IP: 31.49.61.33 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrieekgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeiuddrfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeiuddrfeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.61.33) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A195F015AD4A5; Thu, 13 Feb 2020 16:30:40 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Use native filesystem for fs tests
Date:   Thu, 13 Feb 2020 16:30:36 +0000
Message-Id: <20200213163037.14494-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a first attempt at running the filesystem and fs_filesystem tests
on the native filesystem.

It supports NFS when using the tools/nfs.sh script. NFS will support options
with rootcontext and fscontext, however due to the fsconfig(2) they bug will
not pass with these (see note in nfs.sh).

The filesystem types supported are: ext2, ext3, ext4, xfs, btrfs, hfsplus,
reiserfs, nfs4. If not in this list, tests are skipped. I'm not sure what
others need supporting, these seem reasonable and available on Fedora.

I've had to add a number of policy rules to support these types, however
I've made no attempt to consolidate them. Most are for supporting rootcontext
and fscontext on NFS. Rules for the 'context' option were many more so
decided not to add them - any views on this.

When testing btrfs, most tests will fail on tests/fs_filesystem due to
the fsconfig(2) bug.

I've had to finally disable udisk2(8) as it interferes with the tests. It
can be enabled locally with the -e flag. I'm sure there is a bug somewhere.

In the filesystem/test I've comments regarding quotas, as some fs require
different utilities to set them up. I've not tried these - any views.

This does need more testing, particularly on a 'real' NFS mounted system (not
tested). All feedback welcome.

Richard Haines (1):
  selinux-testsuite: Use native filesystem for fs tests

 policy/test_filesystem.te        | 122 ++++++-
 policy/test_filesystem_notify.te |  50 ++-
 tests/filesystem/Filesystem.pm   |  19 +-
 tests/filesystem/test            | 399 ++++++++++++---------
 tests/filesystem/test-nfs.pl     | 526 ++++++++++++++++++++++++++++
 tests/fs_filesystem/test         | 405 +++++++++++++---------
 tests/fs_filesystem/test-nfs.pl  | 576 +++++++++++++++++++++++++++++++
 tools/nfs.sh                     |  16 +
 8 files changed, 1795 insertions(+), 318 deletions(-)
 create mode 100755 tests/filesystem/test-nfs.pl
 create mode 100755 tests/fs_filesystem/test-nfs.pl

-- 
2.24.1

