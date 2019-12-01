Return-Path: <SRS0=I7Nc=ZX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C87C432C0
	for <selinux@archiver.kernel.org>; Sun,  1 Dec 2019 14:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E05E2082E
	for <selinux@archiver.kernel.org>; Sun,  1 Dec 2019 14:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="mZyM79VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLAOwy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Dec 2019 09:52:54 -0500
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:55415 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbfLAOwy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Dec 2019 09:52:54 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20191201145251.THMX22185.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Sun, 1 Dec 2019 14:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1575211971; 
        bh=1OWX4/+TKXtWPv2E6YGZMn+LKdflgU8d50xHlvo6s2Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=mZyM79VLJ3DK2NvF8qakkOWjr46bGC2hoslwwzSJTFA4SRrA06VzMxQGF5vF3aFYDW/cg+9i9KBOyHGJU3jdv4tIeGtiogE4dcAoTdJ2yg+4JEk3X7D08JWmY9N9aQEHMdQvQliutGP8IMQ3pyaTooad/r1oq/G/2WZTIZC14bvQWUjKPVax+o536lI1MDOo01WbjRjIn06Li3OPFUjejsUAYN9NeaQitqrpqNLIa4hb78ZIcz3pcBn4XcKxhCej+fIDswANt2S+/icD9es4J01Z+ZW7/l+4EXewaV6Qq5Wcat2lRJ//FW45L2s0lFzHtV/MugOc6bCvVNWKMucFWA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.3.212]
X-OWM-Source-IP: 86.134.3.212 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudejfedgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrfedrvdduvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrfedrvdduvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.3.212) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8681A10CBC946F; Sun, 1 Dec 2019 14:52:51 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/1]  selinux-testsuite: Add perf_event tests
Date:   Sun,  1 Dec 2019 14:52:37 +0000
Message-Id: <20191201145238.265621-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was tested on kernel.org 'next-20191128' as Rawhide kernels
don't yet support the new perf_event hooks.

Note that the default .config enables the following that have been added
to defconfig:
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_EVENTS=y
CONFIG_TRACEPOINTS=y

To allow testing, the following steps are required to update Fedora
policy:

1) Using the diff below, add the perf_event class and its
   permissions to:
/usr/share/selinux/devel/include/support/all_perms.spt

--- a/all_perms.spt	2019-12-01 14:11:22.304013835 +0000
+++ b/all_perms.spt	2019-11-29 15:11:21.891680000 +0000
@@ -230,6 +230,7 @@
 	class smc_socket all_smc_socket_perms;
 	class bpf all_bpf_perms;
 	class xdp_socket all_xdp_socket_perms;
+	class perf_event { open cpu kernel tracepoint read write };
 ')
 
 define(`all_userspace_class_perms',`


2) Create a cil module 'test_perf.cil' that defines the class:

(class perf_event (open cpu kernel tracepoint read write))
(classorder (unordered perf_event))

Then insert into policy:
semodule -i test_perf.cil

Richard Haines (1):
  selinux-testsuite: Add perf_event tests

 defconfig                     |   6 ++
 policy/Makefile               |   4 +
 policy/test_perf_event.te     | 106 ++++++++++++++++++++
 tests/Makefile                |   4 +
 tests/perf_event/.gitignore   |   1 +
 tests/perf_event/Makefile     |   7 ++
 tests/perf_event/perf_event.c | 178 ++++++++++++++++++++++++++++++++++
 tests/perf_event/test         |  80 +++++++++++++++
 8 files changed, 386 insertions(+)
 create mode 100644 policy/test_perf_event.te
 create mode 100644 tests/perf_event/.gitignore
 create mode 100644 tests/perf_event/Makefile
 create mode 100644 tests/perf_event/perf_event.c
 create mode 100755 tests/perf_event/test

-- 
2.23.0

