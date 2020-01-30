Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75F8C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645D720658
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Ln9IKhwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgA3THj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:07:39 -0500
Received: from mailomta4-re.btinternet.com ([213.120.69.97]:28950 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727482AbgA3THj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 14:07:39 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200130190736.HPBP20346.re-prd-fep-045.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 30 Jan 2020 19:07:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580411256; 
        bh=VFDwbcvrc/ZPvY5bhtLZTFtFY07B37pmGB3Y/Ev7T00=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Ln9IKhwaHMOEw7sQzCsGfyHuVitKbgntnkKjBJxe5WdDsBE6Xo00dAahFbxtUcGgOTalTxczqyFyMIr/g+114wRz/wrNO3jWbuaHh+1PTNsUIbsSu8OukRbYCbCPD0lvUnCyFfBERwhUQJwKYe8Pba1w2Sx5wQqy4vwNn1h6TKmqI65q37XL6aif3dDsD+kM2T/pCWrau+4wc73peLsaXiZAONe8wbVDzTx42LX1wQe/gD45g8lleDtlhD/u0flT/eJvtsUb+vDp7w2QyYA91IEht7Ibz2z/REFV5PEp7fbl8iZtLFyNrsgKoGU2ANwJM3uQIxTnlm7B0gDAwWLQ6Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.114]
X-OWM-Source-IP: 86.134.6.114 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrfeekgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirdduudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedruddugedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.114) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE078D08AF5F89; Thu, 30 Jan 2020 19:07:36 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/1] selinux-testsuite: Add watch_sb and watch_mount checks
Date:   Thu, 30 Jan 2020 19:07:31 +0000
Message-Id: <20200130190732.110012-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To test fanotify fs watch perms on 5.4+ (will also include tests/notify):

1) Extract the base module (base.cil):
      semodule -c -E base

2) Edit the following definitions in base.cil to add watch permissions:

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

5) 'make test' can now be run. tests/filesystem should run 81 tests, and
   tests/fs_filesystem should run 79 tests. However one test will fail on
   current kernels (fix in 5.7) with fs_filesystem because:
'Failed as kernel 5.x without "selinux: fix regression introduced by
move_mount(2) syscall" patch'

NOTE: Do NOT leave the new base.cil active after tests, as the system may
not reboot if in enforcing mode, as various watch permissions will be denied.
Revert to the original (priority 100) as follows:

semodule -r base
make clean
make -C policy unload

Finally restore the original:
/usr/share/selinux/devel/include/support/all_perms.spt

Richard Haines (1):
  selinux-testsuite: Add watch_sb and watch_mount checks

 policy/Makefile                  |  3 ++
 policy/test_filesystem.te        | 15 -------
 policy/test_filesystem_notify.te | 60 ++++++++++++++++++++++++++
 tests/filesystem/Filesystem.pm   |  6 +--
 tests/filesystem/fanotify_fs.c   | 18 ++++++--
 tests/filesystem/test            | 74 ++++++++++++++++++++++++++++++--
 tests/fs_filesystem/test         | 74 ++++++++++++++++++++++++++++++--
 7 files changed, 221 insertions(+), 29 deletions(-)
 create mode 100644 policy/test_filesystem_notify.te

-- 
2.24.1

