Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2DC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A3520707
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="DT/UM1WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgHZMlR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:41:17 -0400
Received: from mailomta21-re.btinternet.com ([213.120.69.114]:40933 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729617AbgHZMlR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:41:17 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200826124115.LDHV13627.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 26 Aug 2020 13:41:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598445675; 
        bh=f/h0VLK9EDjqqzXbGCGLsAiUH94qr/emzTguMQAfw88=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=DT/UM1WX647unfB/sqyborckNRtEWWnTye2/jdPyg+DMN3r587pPCIywSuu+BSLnrJ2WpygfoErORLG0qWInik1M8P5U8VRddPDpuhgy95mc1p1Ful/u30S26jkD/hpdIk4EgxT+MOrk2Bgi5qVKHJsMznOVRmjUf0M6nejokOCYDpx1u/b8qxsNCVidE/vPZWQi8RZeLhJLtgE3ysQqyRRvEsZsTkCEtif5NO17H/25wl/wa+pHYGiFjF84MBl1L1EWa9WD5bD3tLNpmOaNWWM3pDmHR2KkbWLpR84hy3/vA2O2lr4DMNQrsaNJFStxZPeM04ln+hwRuXaTAZBDfg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.155.83.250]
X-OWM-Source-IP: 86.155.83.250 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeufeefudfffeetjeevheetvdekueeuvefftdfgkefgtefgkeegieehveeuhedvffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudehhedrkeefrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehhedrkeefrddvhedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.155.83.250) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC0DAFBE61; Wed, 26 Aug 2020 13:41:14 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V2 PATCH 0/2] selinux-testsuite: Run tests using remote server
Date:   Wed, 26 Aug 2020 13:40:52 +0100
Message-Id: <20200826124054.26302-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches have been tested on Fedora 31/32 WS and can be used to
test the 'Update SCTP asconf client/server' patch [1] (that must be
installed first).

See README.md - 'Remote System Testing' section on how to configure the
test servers.

Would these be a useful inclusion in the selinux-testsuite !!

[1] https://lore.kernel.org/selinux/20200826123719.26121-1-richard_c_haines@btinternet.com/

Richard Haines (2):
  selinux-testsuite: Run tests using remote server
  selinux-testsuite: Run SCTP tests using remote server

 README.md                                     | 156 ++++
 policy/test_inet_socket.te                    |   2 +
 policy/test_sctp.te                           |   3 +
 tests/inet_socket/calipso-load                |   3 +-
 tests/inet_socket/cipso-fl-load               |   2 +-
 .../inet_socket/{cipso-load-t1 => cipso-load} |   4 +-
 tests/inet_socket/cipso-load-t2               |  11 -
 tests/inet_socket/cipso-load-t5               |  11 -
 tests/inet_socket/ipsec-load                  |  22 +-
 tests/inet_socket/start_remote_svr            |   4 +
 tests/inet_socket/stop_remote_svr             |   3 +
 tests/inet_socket/test                        | 436 ++++++++---
 tests/sctp/calipso-load                       |   2 +-
 tests/sctp/{cipso-load-t2 => cipso-load}      |   4 +-
 tests/sctp/cipso-load-t1                      |   7 -
 tests/sctp/cipso-load-t5                      |   7 -
 tests/sctp/start_remote_svr                   |   4 +
 tests/sctp/stop_remote_svr                    |   3 +
 tests/sctp/test                               | 706 +++++++++++++-----
 tools/remote.sh                               | 121 +++
 tools/remote_cfg/client_cmds.sh               |  20 +
 tools/remote_cfg/remote.cfg                   |  22 +
 tools/remote_cfg/server_cmds.sh               |  13 +
 23 files changed, 1255 insertions(+), 311 deletions(-)
 rename tests/inet_socket/{cipso-load-t1 => cipso-load} (72%)
 delete mode 100644 tests/inet_socket/cipso-load-t2
 delete mode 100644 tests/inet_socket/cipso-load-t5
 create mode 100644 tests/inet_socket/start_remote_svr
 create mode 100644 tests/inet_socket/stop_remote_svr
 rename tests/sctp/{cipso-load-t2 => cipso-load} (58%)
 delete mode 100644 tests/sctp/cipso-load-t1
 delete mode 100644 tests/sctp/cipso-load-t5
 create mode 100644 tests/sctp/start_remote_svr
 create mode 100644 tests/sctp/stop_remote_svr
 create mode 100755 tools/remote.sh
 create mode 100755 tools/remote_cfg/client_cmds.sh
 create mode 100644 tools/remote_cfg/remote.cfg
 create mode 100755 tools/remote_cfg/server_cmds.sh

-- 
2.26.2

