Return-Path: <SRS0=hBaa=DU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3977AC43457
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E6F2489E
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 14:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="lrctzPRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgJMOzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:55:04 -0400
Received: from mailomta32-re.btinternet.com ([213.120.69.125]:58026 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbgJMOzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Oct 2020 10:55:04 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20201013145459.ZHRX4599.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 13 Oct 2020 15:54:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1602600899; 
        bh=vqACFdui3W7u2c1zvYNHaHK8U31j+L973RQef33KOas=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=lrctzPROOqbTYmcnZSlQY6foitICjhH46H3WdfuoVfCLyCHtVErBNJhErUVlVNCEAwMXjXfP9KTj+0EbNfSzALXy97s2rSTB5mKWVLHPKkuW/xvcjoXT1JZRxbIug4xyM5FMPY7zOKSPR6hSvCaxntBm01r6+ik/j9Ru8bmh2Ke8u9qM6llFIkgEACk41ZPwY3Bn09PbP0TGe/E36k54Jt1SgoJifYwFvCob4cAORK6LRfDg7inAElozEK4GQACYRvizTGdKhrOgQBwp7vuL0egUSGEC+K5JmbCyq6M9/zt5vy6SUDcM5OMxiQOb43nYH417AdjYHZI2rN8I8h1vLw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [81.147.56.93]
X-OWM-Source-IP: 81.147.56.93 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheelgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepueeffeduffefteejveehtedvkeeuueevffdtgfekgfetgfekgeeiheevueehvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkedurddugeejrdehiedrleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudegjedrheeirdelfedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.56.93) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD15AD188D; Tue, 13 Oct 2020 15:54:59 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
Date:   Tue, 13 Oct 2020 15:54:55 +0100
Message-Id: <20201013145456.77253-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch allows BTRFS filesystems to be tested.

The tests/filesystem all pass using './test -f btrfs' on Fedora 32.
The tests/fs_filesystem fail 42 of 57 using './test -f btrfs' on Fedora 32.

As Fedora 33/Rawhide now defaults to using btrfs, running 'make test' will
fail 42 of 57 fs_filesystem tests (tested on Rawhide).

These fs_filesystem failures are caused by a bug when using the fsmount(2)
type calls that was reported in [1].

Note btrfs requires a much larger image size (min 115 MiB), and therefore
takes more than 2x longer to run tests than ext4.

[1] https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/

Richard Haines (1):
  selinux-testsuite: Add BTRFS support for filesystem tests

 tests/filesystem/Filesystem.pm | 10 +++++++++-
 tests/filesystem/test          |  6 ++++++
 tests/fs_filesystem/test       |  6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.26.2

