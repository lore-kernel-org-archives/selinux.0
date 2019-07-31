Return-Path: <SRS0=SQk1=V4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DB8C433FF
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 17:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EE62067D
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 17:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="tNGQl8HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfGaRys (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:54:48 -0400
Received: from mailomta30-sa.btinternet.com ([213.120.69.36]:17118 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbfGaRys (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Jul 2019 13:54:48 -0400
X-Greylist: delayed 5304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2019 13:54:47 EDT
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20190731162621.DJRI23301.sa-prd-fep-045.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 31 Jul 2019 17:26:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1564590382; 
        bh=3YP5tL3EGWDFq5bW7q6OeCMcpewEnIp37EUqzLTiLto=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=tNGQl8HA4dvj9MaoxvQFApsoNzBZcOOtGMEjeWVhiUWT/EPhqUSdhecN4drsQgZvfspnssTpSewg26eU/Ifp30gt2kqA6KYik24i9GUem9W2RGopinFBAPWPf+Pz22pmJZQb1xFba/f+is+vWjCg55z21Rs8yZXoSQuTaXGjZQlPOphb2HzDpRaSTskmM4J6CYmbe/C26FqhMfUdTkLK6pEEU327sKOeeojQ/7tGEYuw6QWaccSX9OEF7dGp5cC6YBbaEvMyTutlqqvd9oQzB60asA+WcpXJuKWQyQ+lyD3Z4rlCr3Rm0ha2lH9bLi3YvejQOc6PaVCich66M2D+YA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.58.160]
X-OWM-Source-IP: 31.49.58.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdehkedrudeitdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehkedrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.58.160) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.335.01) (authenticated as richard_c_haines@btinternet.com)
        id 5D3F9102003034B7; Wed, 31 Jul 2019 17:26:21 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/1] selinux-testsuite: Add BPF tests
Date:   Wed, 31 Jul 2019 17:26:12 +0100
Message-Id: <20190731162612.16851-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This runs basic checks for BPF with map_create, map_read, map_write,
prog_load and prog_run permissions.

If this is okay, I'll do tests for checking the following:
tests/fdreceive - security_file_receive path
tests/binder - security_binder_transfer_file path

Richard Haines (1):
  selinux-testsuite: Add BPF tests

 README.md            |   4 +-
 defconfig            |   5 ++
 policy/Makefile      |   4 ++
 policy/test_bpf.te   |  77 +++++++++++++++++++++++++++
 tests/Makefile       |   4 ++
 tests/bpf/.gitignore |   1 +
 tests/bpf/Makefile   |   8 +++
 tests/bpf/bpf_insn.h |  20 +++++++
 tests/bpf/bpf_test.c | 124 +++++++++++++++++++++++++++++++++++++++++++
 tests/bpf/test       |  57 ++++++++++++++++++++
 tools/check-syntax   |   2 +-
 tools/chk_c_exclude  |   1 +
 12 files changed, 305 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_bpf.te
 create mode 100644 tests/bpf/.gitignore
 create mode 100644 tests/bpf/Makefile
 create mode 100644 tests/bpf/bpf_insn.h
 create mode 100644 tests/bpf/bpf_test.c
 create mode 100755 tests/bpf/test
 create mode 100644 tools/chk_c_exclude

-- 
2.21.0

