Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F590C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7613F21A49
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="hOMHOpZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbfISRrD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:47:03 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:26985 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390262AbfISRrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 13:47:02 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20190919174659.CNKH23265.sa-prd-fep-045.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 19 Sep 2019 18:46:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1568915219; 
        bh=dPtBLljWFURb66MrFbfKno93MfnmSaq0GYOAMu0135Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=hOMHOpZf0AqKJqq/XdLrykuCRHsuDdaxrvYAhLp+jCNEgARdVMi9WQU64czLkWRe/7wiklYiVrO0c8wWlju0y7xDjyR2NEnGaUYYIz4WIDIwMvzcuPGRqwEITQch7MrGi7N6P50BQ0WBOmx/WIF26Wzz+6J5LAUcUY8Vu8K/6BqXaIVMC4H3+PUFzr07hhrc52Zj879xS1+hh3WupLBI4ixMDh/fyIc+t1B6sJBKcbx+v7gGZtH/HUS6sVI7D1w9bmSbg2YvFaqFXIE/XVfmkucM3hRDvSU/NBb/uGsWfcbaIDD2nTMQDy/zxZifxuP9cQr93+MH0d/bgP1p9nE2/g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.59.204]
X-OWM-Source-IP: 31.49.59.204 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrgeelrdehledrvddtgeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehledrvddtgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.59.204) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8362CD000C7E69; Thu, 19 Sep 2019 18:46:59 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V5 0/3] selinux-testsuite: Add BPF tests
Date:   Thu, 19 Sep 2019 18:46:52 +0100
Message-Id: <20190919174655.17348-1-richard_c_haines@btinternet.com>
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
V5 Changes - Update build BPF Linux version to 4.15, rework bpf_common.c
bpf_setrlimit() to use smaller RLIMIT_MEMLOCK limit.

Patch 2 Updates fdreceive to test BPF security_file_receive() path using
the common BPF code in tests/bpf.
V2 Change - Added to use tests/bpf/bpf_common.c for BPF tests.
V3 Changes - Run tests under tests/bpf not tests/fdreceive, fix typos.
V4 Changes - Update to work with changes in [1]
V5 Change - Remove check if fdreceive BPF enabled

Patch 3 - Updates Binder to test BPF path security_binder_transfer_file()
V4 Change - New patch
V5 Change - Remove check if Binder BPF enabled

[1] https://lore.kernel.org/selinux/19b043bc4d5efbf2f1994958c0a74709a34e3ad0.camel@btinternet.com/

Richard Haines (3):
  selinux-testsuite: Add BPF tests
  selinux-testsuite: Add BPF support to fdreceive test
  selinux-testsuite: Add BPF support to binder test

 README.md                       |   4 +-
 defconfig                       |   5 +
 policy/Makefile                 |   4 +
 policy/test_binder_bpf.te       |  73 +++++++++++++
 policy/test_bpf.te              |  77 +++++++++++++
 policy/test_fdreceive_bpf.te    |  60 ++++++++++
 tests/Makefile                  |   7 ++
 tests/binder/Makefile           |   5 +
 tests/binder/binder_common.c    |  10 +-
 tests/binder/binder_common.h    |  17 ++-
 tests/binder/client.c           |  28 ++++-
 tests/binder/manager.c          |   2 +-
 tests/binder/service_provider.c | 118 +++++++++++++++-----
 tests/bpf/.gitignore            |   2 +
 tests/bpf/Makefile              |  17 +++
 tests/bpf/bpf_common.c          |  69 ++++++++++++
 tests/bpf/bpf_common.h          |  34 ++++++
 tests/bpf/bpf_test.c            |  77 +++++++++++++
 tests/bpf/test                  | 187 ++++++++++++++++++++++++++++++++
 tests/fdreceive/Makefile        |  14 ++-
 tests/fdreceive/client.c        |  93 ++++++++++++++--
 21 files changed, 850 insertions(+), 53 deletions(-)
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

