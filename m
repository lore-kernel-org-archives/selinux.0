Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C460C4CECD
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2371021852
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="dKt/oKbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfIQO4s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:56:48 -0400
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:61072 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727708AbfIQO4s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Sep 2019 10:56:48 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20190917145646.BWZ26482.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 17 Sep 2019 15:56:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1568732206; 
        bh=XM8MG5rvofStwvYxIznLaip8EnxqclBJ1v8yOE2SO8Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=dKt/oKbth9o36mA40NF+oPULsPeVPHeSIb8ECIzCC0IFoLqAzFdTp7rJwjkBRGBYdZay61jOe6XCBnZ4a7lJK6OZqcysja0obCAm3IsU2Dx10ytpd0aNplTMXGs+wcoUuk30FXAjlvvkY5EOMJPheYaCPPNG+Xwmn8iF9op+mCXJcTIyoC+E/gy0MWypuhSMm5p3GMOGw/aJnlTgSAW9wGN5Zs0Lqu2VHCL0umDyzJOAw5ZhDJfLw6tGpEo9U+JBVOCDHbeefeaTzRh/NTMD64cTkb0Foxdu5OkhwcURxwwPPaEgGTYWLYpkNWhBvrjx8IkTWobX9NlF3aWw0vGT8A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.116]
X-OWM-Source-IP: 86.134.6.116 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddufeegrdeirdduudeinecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirdduudeipdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.116) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D7F5CD800382C54; Tue, 17 Sep 2019 15:56:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V4 0/3] selinux-testsuite: Add BPF tests
Date:   Tue, 17 Sep 2019 15:56:37 +0100
Message-Id: <20190917145640.25629-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patch 1 Runs basic checks for BPF with map_create, map_read, map_write,
prog_load and prog_run permissions.
V2 Change - Split BPF code into bpf_common.c for others to use.
V3 Changes - Correct style, Fix typos
V4 Changes - Fixes as discussed in [1]

Patch 2 Updates fdreceive to test BPF security_file_receive() path using
the common BPF code in tests/bpf.
V2 Change - Added to use tests/bpf/bpf_common.c for BPF tests.
V3 Changes - Run tests under tests/bpf not tests/fdreceive, fix typos.
V4 Changes - Update to work with changes in [1]

Patch 3 - Updates Binder to test BPF path security_binder_transfer_file()
V4 Change - New patch

[1] https://lore.kernel.org/selinux/19b043bc4d5efbf2f1994958c0a74709a34e3ad0.camel@btinternet.com/

Richard Haines (3):
  selinux-testsuite: Add BPF tests
  selinux-testsuite: Add BPF support to fdreceive test
  selinux-testsuite: Add BPF support to binder test

 README.md                       |   4 +-
 defconfig                       |   5 +
 policy/Makefile                 |   4 +
 policy/test_binder_bpf.te       |  73 ++++++++++++
 policy/test_bpf.te              |  78 +++++++++++++
 policy/test_fdreceive_bpf.te    |  60 ++++++++++
 tests/Makefile                  |   7 ++
 tests/binder/Makefile           |   5 +
 tests/binder/binder_common.c    |  10 +-
 tests/binder/binder_common.h    |  17 ++-
 tests/binder/client.c           |  28 ++++-
 tests/binder/manager.c          |   2 +-
 tests/binder/service_provider.c | 118 ++++++++++++++-----
 tests/bpf/.gitignore            |   2 +
 tests/bpf/Makefile              |  17 +++
 tests/bpf/bpf_common.c          |  53 +++++++++
 tests/bpf/bpf_common.h          |  34 ++++++
 tests/bpf/bpf_test.c            |  77 ++++++++++++
 tests/bpf/test                  | 199 ++++++++++++++++++++++++++++++++
 tests/fdreceive/Makefile        |  14 ++-
 tests/fdreceive/client.c        |  93 +++++++++++++--
 21 files changed, 847 insertions(+), 53 deletions(-)
 create mode 100644 policy/test_binder_bpf.te
 create mode 100644 policy/test_bpf.te
 create mode 100644 policy/test_fdreceive_bpf.te
 create mode 100644 tests/bpf/.gitignore
 create mode 100644 tests/bpf/Makefile
 create mode 100644 tests/bpf/bpf_common.c
 create mode 100644 tests/bpf/bpf_common.h
 create mode 100644 tests/bpf/bpf_test.c
 create mode 100755 tests/bpf/test

-- 
2.21.0

