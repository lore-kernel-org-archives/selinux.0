Return-Path: <SRS0=pl+I=WK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A407EC32753
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 09:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7864320843
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 09:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="e87+SvQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfHNJVU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:21:20 -0400
Received: from mailomta4-sa.btinternet.com ([213.120.69.10]:31261 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbfHNJVT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Aug 2019 05:21:19 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20190814092117.RDX8450.sa-prd-fep-043.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 14 Aug 2019 10:21:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1565774477; 
        bh=Y2kcVVWWPjTC4hIfhZSFlZlHUuzoVaV6Dm9+iw7z23E=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=e87+SvQ8F7MaixmIm7rYAuNi5RmKvQT0jK7NO7zda5oIz1Zxu4iYCh+xbqHtBdFUzyEIj/23lFqIf88y/1sR1UAS05pdon97NddsibqPnIxgWtPgfE/SfA71c5iT1s8aEetCo+/Ge9DRYpH4WUNtNTEPufPSjEwMW2RmIcgAJiHG8zhm2COJwFGeiaMphQr2jxPHt8xBkPE4Z30YqIiBI9/PPDdwKhHnj9qSyJ+l0t7j075BtV71lrDgAAkfdY8Bore46m9yk8IQxQ/qSxmZ5Qpg7TAXU+HP/MST/9eFUJmDkoZ8AtBSmxPzVwSqcK73/phSZUsKsEoSDIZf1RDhwA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.7.87]
X-OWM-Source-IP: 86.134.7.87 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddvkedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdejrdekjeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrjedrkeejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.7.87) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.335.01) (authenticated as richard_c_haines@btinternet.com)
        id 5D3F910201DF3614; Wed, 14 Aug 2019 10:21:16 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V3 0/2] selinux-testsuite: Add BPF tests
Date:   Wed, 14 Aug 2019 10:21:13 +0100
Message-Id: <20190814092113.3843-1-richard_c_haines@btinternet.com>
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

Patch 2 Updates fdreceive to test BPF security_file_receive() path using
the common BPF code in tests/bpf.
V2 Change - Added to use tests/bpf/bpf_common.c for BPF tests.
V3 Changes - Run tests under tests/bpf not tests/fdreceive, fix typos.

Richard Haines (2):
  selinux-testsuite: Add BPF tests
  selinux-testsuite: Add BPF support to fdreceive test

 README.md                    |   4 +-
 defconfig                    |   5 ++
 policy/Makefile              |   4 ++
 policy/test_bpf.te           |  77 +++++++++++++++++++++++++++
 policy/test_fdreceive_bpf.te |  60 +++++++++++++++++++++
 tests/Makefile               |   4 ++
 tests/bpf/.gitignore         |   2 +
 tests/bpf/Makefile           |  16 ++++++
 tests/bpf/bpf_common.c       |  97 +++++++++++++++++++++++++++++++++
 tests/bpf/bpf_test.c         |  82 ++++++++++++++++++++++++++++
 tests/bpf/test               | 100 +++++++++++++++++++++++++++++++++++
 tests/fdreceive/Makefile     |  18 ++++++-
 tests/fdreceive/client.c     |  72 +++++++++++++++++++++----
 13 files changed, 528 insertions(+), 13 deletions(-)
 create mode 100644 policy/test_bpf.te
 create mode 100644 policy/test_fdreceive_bpf.te
 create mode 100644 tests/bpf/.gitignore
 create mode 100644 tests/bpf/Makefile
 create mode 100644 tests/bpf/bpf_common.c
 create mode 100644 tests/bpf/bpf_test.c
 create mode 100755 tests/bpf/test

-- 
2.21.0

